unit uDataDivisiPengerjaan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel, DBAccess, MyAccess,
  MemDS, DBAdvGrid, Data.DB;

type
  TFDataDivisiPengerjaan = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
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
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    AdvGridExcelIO1: TAdvGridExcelIO;
    DBAdvGrid1: TDBAdvGrid;
    Q1: TMyQuery;
    QDivisi: TMyQuery;
    DDivisi: TMyDataSource;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    Lentries: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrivClick(Sender: TObject);
    procedure DBAdvGrid1GetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure DBAdvGrid1DblClick(Sender: TObject);
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
  FDataDivisiPengerjaan: TFDataDivisiPengerjaan;

implementation

{$R *.dfm}

uses uInputDivisi, uInpuDivisiPengerjaan;




procedure TFDataDivisiPengerjaan.AdvSmoothButton2Click(Sender: TObject);
begin
   if MessageDlg('Apakah yakin data akan dihapus?',mtConfirmation,[MbYes,Mbno],0) = MrYes then
  begin
    ExQry(Q1,'DELETE FROM divisi_pengerjaan WHERE id="'+DBAdvGrid1.Cells[1,DBAdvGrid1.Row]+'"',False);
    LoadData('',StrToIntDef(cbEntries.Text,1),1);
  end;
end;

procedure TFDataDivisiPengerjaan.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Devisi.xls');
end;

procedure TFDataDivisiPengerjaan.AdvSmoothButton4Click(Sender: TObject);
var
  idDivisi : String;
begin

  with FinputDivisiPengerjaan do begin
      idDivisi             := DBAdvGrid1.Cells[1,DBAdvGrid1.Row];
      id                   := idDivisi;
      QDivisi.Locate('id',idDivisi,[]);
      EDeskripsi.Text     := GetVal(Qdivisi,'name');
      ETenagaKerja.Text   := GetVal(QDivisi,'jml_karyawan');
      Egaji.Text          := GetVal(QDivisi,'gaji_karyawan');
      ShowModal;
  end;
end;

procedure TFDataDivisiPengerjaan.btnAddClick(Sender: TObject);
begin

  FinputDivisiPengerjaan.TampilanAwal;
  FinputDivisiPengerjaan.ShowModal;
end;

procedure TFDataDivisiPengerjaan.btnNextClick(Sender: TObject);
begin
  QDivisi.Next;
end;

procedure TFDataDivisiPengerjaan.btnPrivClick(Sender: TObject);
begin
  QDivisi.Prior;
end;

procedure TFDataDivisiPengerjaan.ButtonPage(Sender: TObject);
var

varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData('',StrToIntDef(cbEntries.Text,1),varisPages );

  end;
end;

procedure TFDataDivisiPengerjaan.cbEntriesChange(Sender: TObject);
begin
  LoadData('',StrToIntDef(cbEntries.Text,1),1);
  Pagination(0);
end;


procedure TFDataDivisiPengerjaan.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataDivisiPengerjaan.DBAdvGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ACol = 5) and (Arow > 0) then begin
     ABrush.Color := StrToIntDef(DBAdvGrid1.Cells[ACol,Arow],0);

  end;

end;

procedure TFDataDivisiPengerjaan.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LoadData(' AND name LIKE "%'+ECari.Text+'%" ',StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataDivisiPengerjaan.FormCreate(Sender: TObject);
begin
  FDataDivisiPengerjaan := Self;

end;

procedure TFDataDivisiPengerjaan.FormShow(Sender: TObject);
begin
  LoadData('',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataDivisiPengerjaan.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
  ExQry(Qdivisi,'SELECT * FROM divisi_pengerjaan '+isCari ,True);

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataDivisiPengerjaan.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    totalWidht : integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM divisi_pengerjaan ',True);
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
  end;
  btnPriv.Align := alRight;

  if varIsLimit > TotalData then
          RowOf := TotalData else RowOf := varIsLimit;
       Lentries.Caption := 'Showing '+IntToStr(Qdivisi.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

procedure TFDataDivisiPengerjaan.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol in [0..6]) and (aRow = 0) then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
