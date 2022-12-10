unit uDataRencanaKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet,DateUtils,
  DBAccess, MyAccess, MemDS, DBAdvGrid, Vcl.ComCtrls, frxExportBaseDialog,
  frxExportImage;

type
  TFDataRencanaKerja = class(TForm)
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
    frDetailRencanaKerja: TfrxDBDataset;
    frRencanaKerja: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    DBAdvGrid1: TDBAdvGrid;
    QRencanaKerja: TMyQuery;
    QDetailRencanaKerja: TMyQuery;
    DRencanaKerja: TMyDataSource;
    Q1: TMyQuery;
    Label2: TLabel;
    Label8: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    btnFilter: TAdvSmoothButton;
    pPagination: TAdvSmoothPanel;
    Lentries: TLabel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    QBeritaAcara: TMyQuery;
    frBeritaAcara: TfrxDBDataset;
    Q2: TMyQuery;
    GDivisi: TAdvStringGrid;
    frxJPEGExport1: TfrxJPEGExport;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure GDivisiClickCell(Sender: TObject; ARow, ACol: Integer);
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
    procedure GridDivisi;

  end;



var
  FDataRencanaKerja: TFDataRencanaKerja;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputRencanaKerja;




procedure TFDataRencanaKerja.AdvSmoothButton1Click(Sender: TObject);
var
  nomer : String;
begin
  Nomer := GetVal(QRencanaKerja,'nomer');
  ExQry(QRencanaKerja,GetSQL('TableRencanaKerja')+' WHERE nomer="'+Nomer+'"',True);
  ExQry(QDetailRencanaKerja,GetSQL('TableRencanaKerjaDetail')+' WHERE nomer="'+Nomer+'" AND qty>0',True);
  ExQry(QBeritaAcara,'SELECT * FROM rencana_berita_acara WHERE nomer_rencana_kerja="'+NOmer+'" ',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frRencanaKerja.fr3');
  frxReport1.ShowReport();



  LoadData(
  ' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);

end;

procedure TFDataRencanaKerja.AdvSmoothButton2Click(Sender: TObject);
var
  nomer : String;
  i : integer;
  Ls : TStringList;
begin

  if  Assigned(FinputRencanaKerja) then
        FreeAndNil(FinputRencanaKerja);
   Application.CreateForm(TFinputRencanaKerja,FinputRencanaKerja);
   FinputRencanaKerja.Parent      := FMainMenu.pg;
   FinputRencanaKerja.Align       := AlClient;
   FinputRencanaKerja.BorderStyle := bsNone;
   FinputRencanaKerja.Position    := poOwnerFormCenter ;
   FinputRencanaKerja.visible     := True;
   Nomer := GetVal(QRencanaKerja,'nomer');
   ExQry(QRencanaKerja,getSQL('TableRencanaKerja')+' WHERE nomer="'+Nomer+'"',True);

   ExQry(QDetailRencanaKerja,GetSQL('TableRencanaKerjaDetail')+' WHERE nomer="'+Nomer+'"',True);
   FinputRencanaKerja.isEdit                := True;
   FinputRencanaKerja.id                    := GetVal(QRencanaKerja,'id');
   FinputRencanaKerja.cbDivisi.ItemIndex    := idxCmb(FinputRencanaKerja.cbDivisi,GetValInt(QRencanaKerja,'id_divisi'));
   FinputRencanaKerja.cbDivisiPlan.ItemIndex    := idxCmb(FinputRencanaKerja.cbDivisiPlan,GetValInt(QRencanaKerja,'divisi_planned'));
   FinputRencanaKerja.dt1.Date              := GetValDate(QRencanaKerja,'tgl');
   FinputRencanaKerja.Enomer.Text           := GetVal(QRencanaKerja,'nomer');
   FinputRencanaKerja.EjmlTenagaKerja.Text  := GetVal(QRencanaKerja,'jml_tenaga_kerja');
   FinputRencanaKerja.Egaji.Text            := GetVal(QRencanaKerja,'gaji');
   FinputRencanaKerja.Elembur.Text          := GetVal(QRencanaKerja,'lembur');
   FinputRencanaKerja.EtotalGaji.Text       := GetValR(QRencanaKerja,'total_gaji');
   FinputRencanaKerja.EHasilKerja.Text      := GetValR(QRencanaKerja,'hasil_kerja');
   FinputRencanaKerja.EPlusmin.Text         := GetValR(QRencanaKerja,'plus_minus');
   FinputRencanaKerja.Eprosentase.Text      := GetValR(QRencanaKerja,'prosentase');

   FinputRencanaKerja.GridRencanaKerja;
   while QDetailRencanaKerja.Eof = False do begin

      FinputRencanaKerja.sg.Cells[0,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'no_job_order');
      FinputRencanaKerja.sg.Cells[1,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'no_so');
      FinputRencanaKerja.sg.Cells[2,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'no_container');
      FinputRencanaKerja.sg.Cells[3,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'itemno');
      FinputRencanaKerja.sg.Cells[4,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'description');
      FinputRencanaKerja.sg.Cells[5,FinputRencanaKerja.sg.RowCount -1] := GetValR(QDetailRencanaKerja,'qty_order');
      FinputRencanaKerja.sg.Cells[6,FinputRencanaKerja.sg.RowCount -1] := GetValR(QDetailRencanaKerja,'qty');
      FinputRencanaKerja.sg.Cells[7,FinputRencanaKerja.sg.RowCount -1] := GetValR(QDetailRencanaKerja,'mh');
      FinputRencanaKerja.sg.Cells[8,FinputRencanaKerja.sg.RowCount -1] := GetValR(QDetailRencanaKerja,'harga_satuan');
      FinputRencanaKerja.sg.Cells[9,FinputRencanaKerja.sg.RowCount -1] := GetValR(QDetailRencanaKerja,'subtotal');
      FinputRencanaKerja.sg.Cells[10,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'no_so');
      FinputRencanaKerja.sg.Cells[11,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'jenis');
      FinputRencanaKerja.sg.Cells[12,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'item_id');
      FinputRencanaKerja.sg.Cells[13,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'is_parent');
      FinputRencanaKerja.sg.Cells[14,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'parent_id');
      FinputRencanaKerja.sg.Cells[15,FinputRencanaKerja.sg.RowCount -1] := GetVal(QDetailRencanaKerja,'id_divisi');
      QDetailRencanaKerja.Next;
      if FinputRencanaKerja.sg.Cells[13,FinputRencanaKerja.sg.RowCount -1] = 'True' then begin
        for i := 0 to FinputRencanaKerja.sg.ColCount-1 do begin
           FinputRencanaKerja.sg.FontStyles[i,FinputRencanaKerja.sg.RowCount-1] := FinputRencanaKerja.sg.FontStyles[i,FinputRencanaKerja.sg.RowCount-1] + [fsBold];

        end;
      end;
      FinputRencanaKerja.sg.RowCount                                   := FinputRencanaKerja.sg.RowCount + 1;

   end;

   FinputRencanaKerja.GridBA;

   ls := TStringLIst.Create;
     try
      ExQry(Q2,'SELECT * FROM rencana_berita_acara WHERE nomer_rencana_kerja="'+GetVal(QRencanaKerja,'nomer')+'"',True);

      while not Q2.Eof do begin

        addParam('nomer_rencana_kerja', GetVal(Q2,'nomer_rencana_kerja'),ls,'str');
        addParam('description', GetVal(Q2,'description'),ls,'str');
        addParam('qty', GetVal(Q2,'qty'),ls,'str');
        addParam('mh', GetVal(Q2,'mh'),ls,'str');
        addParam('cost', GetVal(Q2,'cost'),ls,'str');
        addParam('total_cost', GetVal(Q2,'total_cost'),ls,'str');
        exeDb(Q1,'temp_rencana_berita_acara',ls);
        Q2.Next;
      end;
      FinputRencanaKerja.LoadBA;
     finally
       ls.Free;
     end;



end;

procedure TFDataRencanaKerja.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Rencana Kerja.xls');
end;

procedure TFDataRencanaKerja.AdvSmoothButton4Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin akan menghapus data?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    ExQry(Q1,'DELETE FROM rencana_kerja WHERE nomer="'+GetVal(QRencanaKerja,'nomer')+'"',False);

    LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

    Pagination(0);
  end;
end;

procedure TFDataRencanaKerja.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputRencanaKerja) then
        FreeAndNil(FinputRencanaKerja);
   Application.CreateForm(TFinputRencanaKerja,FinputRencanaKerja);

   FinputRencanaKerja.Parent      := FMainMenu.pg;
   FinputRencanaKerja.Align       := AlClient;
   FinputRencanaKerja.BorderStyle := bsNone;
   FinputRencanaKerja.Position    := poOwnerFormCenter ;
   FinputRencanaKerja.visible     := True;
end;

procedure TFDataRencanaKerja.btnFilterClick(Sender: TObject);
begin
  if GDivisi.Row > 1 then

  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.divisi_planned="'+GDivisi.Cells[1,GDivisi.Row]+'" ',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);

  pagination(0);
end;

procedure TFDataRencanaKerja.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;
     if GDivisi.Row > 1 then
      LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
      'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.divisi_planned="'+GDivisi.Cells[1,GDivisi.Row]+'" ',StrToIntDef(cbEntries.Text,10),0)
      else
      LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
      'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);

  end;
end;

procedure TFDataRencanaKerja.cbEntriesChange(Sender: TObject);
begin

if GDivisi.Row > 1 then

  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.divisi_planned="'+GDivisi.Cells[1,GDivisi.Row]+'" ',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);

  pagination(0);
end;


procedure TFDataRencanaKerja.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton2.Click;
end;

procedure TFDataRencanaKerja.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ecari.Text <> '' then
  LoadData(' WHERE (d.name LIKE "%'+ECari.Text+'%" )',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataRencanaKerja.FormCreate(Sender: TObject);
begin
  FDataRencanaKerja:= Self;
  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));
  cbEntries.ItemIndex := 2;
end;

procedure TFDataRencanaKerja.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),1);
  dt2.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),DayOf(EndOfTheMonth(dt1.Date)));

  GridDivisi;

  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  ' AND r.tgl <="'+Tanggal(dt2.date)+'" AND '+
  ' r.divisi_planned="'+GDivisi.Cells[1,2]+'" ',StrToIntDef(cbEntries.Text,10),0);
  pagination(0);
end;

procedure TFDataRencanaKerja.GDivisiClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if GDivisi.Row > 1 then

  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.divisi_planned="'+GDivisi.Cells[1,GDivisi.Row]+'" ',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);

  pagination(0);
end;

procedure TFDataRencanaKerja.GridDivisi;
var
   i : integer;
begin
  with GDivisi do begin

    ClearAll;
    ColCount  := 2;
    FixedCols := 0;

    RowCount  := 2;
    Cells[0,0] := 'Divisi';
    Cells[1,0] := 'Id';

    ColWidths[0] := 150;
    ColWidths[1] := 0;

    ColumnSize.StretchColumn := 0;
    ColumnSize.Stretch       := True;

    ExQry(Q1,'SELECT * FROM divisi_pengerjaan ORDER BY name ASC',True);

    RowCount   := Q1.RecordCount + 2;
    Cells[0,1] := '-- ALL DIVISI --';

    i := 2;
    while not Q1.Eof do begin
      Cells[0,i] := GetVal(Q1,'name');
      Cells[1,i] := GetVal(Q1,'id');
      Q1.Next;
      Inc(i);
    end;

  end;
end;

procedure TFDataRencanaKerja.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
  ExQry(QRencanaKerja,getSQL('TableRencanaKerja')+ isCari+' ORDER BY tgl ASC'+
  ' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+'  ',True);

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataRencanaKerja.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM rencana_kerja  '+
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
       Lentries.Caption := 'Showing '+IntToStr(QRencanaKerja.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

end.
