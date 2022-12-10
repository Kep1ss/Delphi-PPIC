unit uDataBeritaAcara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet,DateUtils,
  DBAdvGrid, DBAccess, MyAccess, MemDS, Vcl.ComCtrls;

type
  TFDataBa = class(TForm)
    Label1: TLabel;
    btnAdd: TAdvSmoothButton;
    P1: TAdvSmoothPanel;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbEntries: TAdvComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Ecari: TAdvEdit;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton1: TAdvSmoothButton;
    frxReport1: TfrxReport;
    frHasilKerja: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    Q1: TMyQuery;
    QHasilKerja: TMyQuery;
    DHasilKerja: TMyDataSource;
    DBAdvGrid1: TDBAdvGrid;
    Label2: TLabel;
    Label8: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    btnFilter: TAdvSmoothButton;
    pPagination: TAdvSmoothPanel;
    Lentries: TLabel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    QberitaAcara: TMyQuery;
    frBeritaAcara: TfrxDBDataset;
    Q2: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure AdvSmoothButton5Click(Sender: TObject);
  private
    { Private declarations }

    varIsLimit : Integer;
    varIsPage  : Integer;
    procedure ButtonPage(Sender: TObject);
    procedure Pagination(RowStart:Integer);


  public
    { Public declarations }
    procedure LoadData(isCari:String;isLimit : Integer;isOffSet:integer);

  end;



var
  FDataBa: TFDataBa;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputHasilBeritaAcara;




procedure TFDataBa.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QhasilKerja,GetSQL('TableHasilKerja')+' WHERE nomer="'+GetVal(QHasilKerja,'nomer')+'"',True);
  ExQry(QberitaAcara,getSQL('TableBeritaAcara')+' WHERE ba.nomer_hasil_kerja="'+GetVal(QHasilKerja,'nomer')+'" AND qty>0 ',True);


  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frHasilKerja.fr3');
  frxReport1.ShowReport();



  LoadData(
  ' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.id_divisi is null ',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataBa.AdvSmoothButton2Click(Sender: TObject);
var
  idRencanaKerja : String;
begin
  if MessageDLg('Apakah yakin data akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin

    ExQry(Q1,'DELETE FROM hasil_kerja WHERE nomer="'+GetVal(QHasilKerja,'nomer')+'"',False);
    LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
    'AND r.tgl <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,10),0);

    ExQry(Q1,'DELETE FROM progress WHERE nobukti="'+GetVal(QHasilKerja,'nomer')+'"',False);
    Pagination(0);
  end;
end;

procedure TFDataBa.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Hasil Kerja.xls');
end;

procedure TFDataBa.AdvSmoothButton4Click(Sender: TObject);
var
  ls : TStringList;
begin
  if  Assigned(FInputHasilBeritaAcara) then
        FreeAndNil(FInputHasilBeritaAcara);
   Application.CreateForm(TFInputHasilBeritaAcara,FInputHasilBeritaAcara);
   FInputHasilBeritaAcara.Parent      := FMainMenu.pg;
   FInputHasilBeritaAcara.Align       := AlClient;
   FInputHasilBeritaAcara.BorderStyle := bsNone;
   FInputHasilBeritaAcara.Position    := poOwnerFormCenter ;
   FInputHasilBeritaAcara.visible     := True;

   ExQry(QHasilKerja,getSQL('TableHasilKerja')+' WHERE nomer="'+GetVal(QHasilKerja,'nomer')+'"',True);


   FInputHasilBeritaAcara.id                   := GetVal(QHasilKerja,'id');
   FInputHasilBeritaAcara.cbDivisiPengerjaan.ItemIndex    := idxCmb(FInputHasilBeritaAcara.cbDivisiPengerjaan,GetValInt(QHasilKerja,'divisi_process'));
   FInputHasilBeritaAcara.dt1.Date              := GetValDate(QHasilKerja,'tgl');
   FInputHasilBeritaAcara.Enomer.Text           := GetVal(QHasilKerja,'nomer');
   FInputHasilBeritaAcara.EjmlTenagaKerja.Text  := GetVal(QHasilKerja,'jml_tenaga_kerja');
   FInputHasilBeritaAcara.EHasilKerja.Text      := GetValR(QHasilKerja,'hasil_kerja');
   FInputHasilBeritaAcara.Egaji.Text            := GetValR(QHasilKerja,'gaji');
   FInputHasilBeritaAcara.EjmlTenagaKerjaChange(Sender);

   FInputHasilBeritaAcara.GridBA;
end;

procedure TFDataBa.AdvSmoothButton5Click(Sender: TObject);
begin


   ExQry(QHasilKerja,getSQL('TableHasilKerja')+' WHERE r.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" '+
   ' AND r.divisi_process="'+GetVal(QHasilKerja,'divisi_process')+'" AND r.id_divisi is null ',True);

   ExQry(QberitaAcara,getSQL('TableBeritaAcara')+' WHERE ba.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" '+
   ' AND ba.id_divisi="'+getVal(QHasilKerja,'divisi_process')+'" AND r.id_divisi is null',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frCompare.fr3');
  frxReport1.ShowReport();
end;

procedure TFDataBa.btnAddClick(Sender: TObject);
begin
    if  Assigned(FInputHasilBeritaAcara) then
        FreeAndNil(FInputHasilBeritaAcara);
   Application.CreateForm(TFInputHasilBeritaAcara,FInputHasilBeritaAcara);

   FInputHasilBeritaAcara.Parent      := FMainMenu.pg;
   FInputHasilBeritaAcara.Align       := AlClient;
   FInputHasilBeritaAcara.BorderStyle := bsNone;
   FInputHasilBeritaAcara.Position    := poOwnerFormCenter ;
   FInputHasilBeritaAcara.visible     := True;
end;

procedure TFDataBa.btnFilterClick(Sender: TObject);
begin
  LoadData(
  ' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.id_divisi is null',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataBa.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.id_divisi is null ',StrToIntDef(cbEntries.Text,0),varisPages );
  end;
end;

procedure TFDataBa.cbEntriesChange(Sender: TObject);
begin

LoadData(
  ' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.id_divisi is null ',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataBa.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ecari.Text <> '' then
  LoadData(' WHERE (d.name LIKE "%'+ECari.Text+'%" ) AND r.id_divisi is null',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" AND r.id_divisi is null'+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataBa.FormCreate(Sender: TObject);
begin
  FDataBa:= Self;

  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));
end;

procedure TFDataBa.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),1);
  dt2.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),DayOf(EndOfTheMonth(dt1.Date)));

  LoadData(' WHERE  tgl >="'+Tanggal(dt1.date)+'" '+
  'AND tgl <="'+Tanggal(dt2.date)+'" AND id_divisi is null ',StrToIntDef(cbEntries.Text,10),0);
  pagination(0);
end;

procedure TFDataBa.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
   ExQry(QHasilKerja,getSQL('TableHasilKerja')+ isCari+' '+
  ' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataBa.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM hasil_kerja   '+
  ' WHERE  tgl >="'+Tanggal(dt1.date)+'" '+
  'AND tgl <="'+Tanggal(dt2.date)+'"',True);
  TotalData := GetValInt(Q1,'totaldata');
  jmlPage := TotalData div varIsLimit;
  jmlPage := jmlPage + 1;
  pPagination.Visible := False;
  btnPriv             := FindComponent('btnPriv') as TAdvSmoothButton;

  if btnPriv <> nil then

  btnPriv.Align       := alLeft ;

  for i := pPagination.ComponentCount -1 Downto 0 do begin
      if pPagination.Components[i] is TAdvSmoothButton then
      TAdvSmoothButton(pPagination.Components[i]).Free;
  end;

  for i := jmlPage  Downto 1  do  begin

          btn := TAdvSmoothButton.Create(pPagination);
          btn.Parent := pPagination;
          btn.Height := 28;
          btn.Width  := 30;
          btn.Name   := 'btn'+IntToStr(i);
          btn.Align  := alRight;
          btn.Caption := IntToStr(i);
          btn.Color   :=  $003B3B3B;
          btn.AlignWithMargins  :=  True;
          btn.Appearance.SimpleLayout := True;
          btn.Appearance.Rounding     := 3;
          btn.AlignWithMargins        := True;
          btn.Appearance.Font.Color   := $009A9A9A;
          btn.Margins.Top             := 0;
          btn.Margins.Bottom          := 0;
          btn.Margins.Left            := 1;
          btn.Margins.Right           := 1;
          btn.OnClick                 := ButtonPage;
       //   pPagination.Width           := pPagination.Width + btn.Width;
       //   pPagination.Left            := pPagination.Left - btn.Width;

  end;
  btnPriv.Align := alRight;

  if varIsLimit > TotalData then
          RowOf := TotalData else RowOf := varIsLimit;
       Lentries.Caption := 'Showing '+IntToStr(QHasilKerja.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

end.
