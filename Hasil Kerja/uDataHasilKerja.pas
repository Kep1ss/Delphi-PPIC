unit uDataHasilKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet,DateUtils,
  DBAdvGrid, DBAccess, MyAccess, MemDS, Vcl.ComCtrls, frxExportBaseDialog,
  frxExportImage;

type
  TFDataHasilKerja = class(TForm)
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
    frDetailHasilKerja: TfrxDBDataset;
    frHasilKerja: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    Q1: TMyQuery;
    QHasilKerja: TMyQuery;
    QDetailHasilKerja: TMyQuery;
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
    AdvSmoothButton5: TAdvSmoothButton;
    frCompare: TfrxDBDataset;
    QCompare: TMyQuery;
    DCompare: TDataSource;
    QberitaAcara: TMyQuery;
    frBeritaAcara: TfrxDBDataset;
    QRencanaKerja: TMyQuery;
    QDetailRencanaKerja: TMyQuery;
    DRencanaKerja: TMyDataSource;
    frRencanaKerja: TfrxDBDataset;
    frDetailRencanaKerja: TfrxDBDataset;
    Q2: TMyQuery;
    QBARencanaKerja: TMyQuery;
    frBARencanaKerja: TfrxDBDataset;
    GDivisi: TAdvStringGrid;
    frxJPEGExport1: TfrxJPEGExport;
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
  FDataHasilKerja: TFDataHasilKerja;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputHasilKerja;




procedure TFDataHasilKerja.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QhasilKerja,GetSQL('TableHasilKerja')+' WHERE nomer="'+GetVal(QHasilKerja,'nomer')+'"',True);
  ExQry(QDetailHasilKerja,GetSQL('TableHasilKerjaDetail')+' WHERE rk.nomer="'+GetVal(QHasilKerja,'nomer')+'" '+
  ' AND qty > 0 GROUP BY rk.item_id,rk.id_divisi,rk.no_so,rk.no_po,rk.no_container',True);
  ExQry(QberitaAcara,getSQL('TableBeritaAcara')+' WHERE ba.nomer_hasil_kerja="'+GetVal(QHasilKerja,'nomer')+'" AND qty>0 ',True);


  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frHasilKerja.fr3');
  frxReport1.ShowReport();



  LoadData(
  ' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataHasilKerja.AdvSmoothButton2Click(Sender: TObject);
var
  idRencanaKerja : String;
begin
  if MessageDLg('Apakah yakin data akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin

    ExQry(Q1,'SELECT DISTINCT rencana_id,no_so,no_container,item_id FROM detail_hasil_kerja WHERE nomer="'+GetVal(QHasilKerja,'nomer')+'" ',True);

    while not Q1.Eof do begin
      idRencanaKerja := idRencanaKerja +GetVal(Q1,'rencana_id')+',';
      ExQry(Q2,'DELETE FROM item_finished WHERE '+
      ' nomer_container="'+GetVal(Q1,'no_container')+'" '+
      ' AND no_so="'+GetVal(Q1,'no_so')+'" '+
      ' AND item_id="'+GetVal(Q1,'item_id')+'"',False);
      Q1.Next;
      ExQry(Q1,'UPDATE rencana_kerja SET is_proses=false WHERE id="'+GetVal(Q1,'rencana_id')+'"',False);

    end;
    Delete(idRencanaKerja,length(idRencanaKerja),1);


    ExQry(Q1,'DELETE FROM hasil_kerja WHERE nomer="'+GetVal(QHasilKerja,'nomer')+'"',False);
    LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
    'AND r.tgl <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,50),0);

    ExQry(Q1,'DELETE FROM progress WHERE nobukti="'+GetVal(QHasilKerja,'nomer')+'"',False);

    Pagination(0);
  end;
end;

procedure TFDataHasilKerja.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Hasil Kerja.xls');
end;

procedure TFDataHasilKerja.AdvSmoothButton4Click(Sender: TObject);
var
  ls : TStringList;
begin
  if  Assigned(FinputHasilKerja) then
        FreeAndNil(FinputHasilKerja);
   Application.CreateForm(TFinputHasilKerja,FinputHasilKerja);
   FinputHasilKerja.Parent      := FMainMenu.pg;
   FinputHasilKerja.Align       := AlClient;
   FinputHasilKerja.BorderStyle := bsNone;
   FinputHasilKerja.Position    := poOwnerFormCenter ;
   FinputHasilKerja.visible     := True;



   ExQry(QHasilKerja,getSQL('TableHasilKerja')+' WHERE r.nomer="'+GetVal(QHasilKerja,'nomer')+'"',True);

   ExQry(QDetailHasilKerja,GetSQL('TableHasilKerjaDetail')+' WHERE rk.nomer="'+GetVal(QHasilKerja,'nomer')+'" '+
   ' GROUP BY rk.item_id,rk.no_so,rk.no_container,rk.qty,rk.id_pekerjaan',True);
   FinputHasilKerja.id                    := GetVal(QHasilKerja,'id');
   FinputHasilKerja.cbDivisi.ItemIndex    := idxCmb(FinputHasilKerja.cbDivisi,GetValInt(QHasilKerja,'id_divisi'));
   FinputHasilKerja.cbDivisiChange(Sender);
   FinputHasilKerja.cbDivisiPengerjaan.ItemIndex    := idxCmb(FinputHasilKerja.cbDivisiPengerjaan,GetValInt(QHasilKerja,'divisi_process'));
   FinputHasilKerja.cbSubdivisi.ItemIndex := idxCmb(FinputHasilKerja.cbSubdivisi,GetValInt(QHasilKerja,'id_sub_divisi'));
   FinputHasilKerja.dt1.Date              := GetValDate(QHasilKerja,'tgl');
   FinputHasilKerja.Enomer.Text           := GetVal(QHasilKerja,'nomer');
   FinputHasilKerja.EjmlTenagaKerja.Text  := GetVal(QHasilKerja,'jml_tenaga_kerja');
   FinputHasilKerja.EHasilKerja.Text      := GetValR(QHasilKerja,'hasil_kerja');
   FinputHasilKerja.Egaji.Text            := GetValR(QHasilKerja,'gaji');
   FinputHasilKerja.Elembur.Text          := GetValR(QHasilKerja,'lembur');
   FinputHasilKerja.EjmlTenagaKerjaChange(Sender);

   FinputHasilKerja.GridHasilKerja;
   while QDetailHasilKerja.Eof = False do begin

      FinputHasilKerja.sg.Cells[0,FinputHasilKerja.sg.RowCount -1]  := GetVal(QDetailHasilKerja,'no_so');
      FinputHasilKerja.sg.Cells[1,FinputHasilKerja.sg.RowCount -1]  := GetVal(QDetailHasilKerja,'no_container');
      FinputHasilKerja.sg.Cells[2,FinputHasilKerja.sg.RowCount -1]  := GetVal(QDetailHasilKerja,'itemno');
      FinputHasilKerja.sg.Cells[3,FinputHasilKerja.sg.RowCount -1]  := GetVal(QDetailHasilKerja,'description');
      FinputHasilKerja.sg.Cells[4,FinputHasilKerja.sg.RowCount -1]  := GetVal(QDetailHasilKerja,'qty_rencana');
      FinputHasilKerja.sg.Cells[5,FinputHasilKerja.sg.RowCount -1]  := GetValR(QDetailHasilKerja,'qty');
      FinputHasilKerja.sg.Cells[6,FinputHasilKerja.sg.RowCount -1]  := GetValR(QDetailHasilKerja,'mh');
      FinputHasilKerja.sg.Cells[7,FinputHasilKerja.sg.RowCount -1]  := GetValR(QDetailHasilKerja,'harga_satuan');
      FinputHasilKerja.sg.Cells[8,FinputHasilKerja.sg.RowCount -1]  := GetValR(QDetailHasilKerja,'subtotal');
      FinputHasilKerja.sg.Cells[9,FinputHasilKerja.sg.RowCount -1]  := GetVal(QDetailHasilKerja,'jenis');
      FinputHasilKerja.sg.Cells[10,FinputHasilKerja.sg.RowCount -1] := GetVal(QDetailHasilKerja,'item_id');
      FinputHasilKerja.sg.Cells[11,FinputHasilKerja.sg.RowCount -1] := GetVal(QDetailHasilKerja,'parent_name');
      FinputHasilKerja.sg.Cells[12,FinputHasilKerja.sg.RowCount -1] := GetVal(QDetailHasilKerja,'parent_id');
      FinputHasilKerja.sg.Cells[13,FinputHasilKerja.sg.RowCount -1] := GetVal(QDetailHasilKerja,'rencana_id');
      FinputHasilKerja.sg.Cells[14,FinputHasilKerja.sg.RowCount -1] := GetVal(QDetailHasilKerja,'id_divisi');
      FinputHasilKerja.sg.Cells[15,FinputHasilKerja.sg.RowCount -1] := GetVal(QDetailHasilKerja,'id_pekerjaan');
      QDetailHasilKerja.Next;
      FinputHasilKerja.sg.RowCount                                   := FinputHasilKerja.sg.RowCount + 1;

   end;

   FinputHasilKerja.isEdit := True;
   FinputHasilKerja.GridBA;

   ls := TStringLIst.Create;
     try
      ExQry(Q1,'DELETE FROM temp_by_accident WHERE nomer_hasil_kerja="'+GetVal(QHasilKerja,'nomer')+'"',False);
      ExQry(Q2,'SELECT * FROM by_accident WHERE nomer_hasil_kerja="'+GetVal(QHasilKerja,'nomer')+'"',True);

      while not Q2.Eof do begin

        addParam('nomer_hasil_kerja', GetVal(Q2,'nomer_hasil_kerja'),ls,'str');
        addParam('description', GetVal(Q2,'description'),ls,'str');
        addParam('qty', GetVal(Q2,'qty'),ls,'str');
        addParam('mh', GetVal(Q2,'mh'),ls,'str');
        addParam('cost', GetVal(Q2,'cost'),ls,'str');
        addParam('total_cost', GetVal(Q2,'total_cost'),ls,'str');
        exeDb(Q1,'temp_by_accident',ls);
        Q2.Next;
      end;
      FinputHasilKerja.LoadBA;
     finally
       ls.Free;
     end;



end;

procedure TFDataHasilKerja.AdvSmoothButton5Click(Sender: TObject);
begin
   ExQry(QRencanaKerja,getSQL('TableRencanaKerja')+' WHERE r.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" AND '+
   ' r.divisi_planned="'+GetVal(QhasilKerja,'divisi_process')+'" ',True);

   ExQry(QDetailRencanaKerja,getSQL('TableRencanaKerjaDetail')+' '+
   ' LEFT JOIN rencana_kerja r ON r.nomer=rk.nomer '+
   ' WHERE r.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" AND '+
   ' r.divisi_planned="'+GetVal(QhasilKerja,'divisi_process')+'" AND rk.is_parent=false '+
   ' AND rk.qty>0',True);


   ExQry(QHasilKerja,getSQL('TableHasilKerja')+' WHERE r.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" '+
   ' AND r.divisi_process="'+GetVal(QHasilKerja,'divisi_process')+'" ',True);


   ExQry(QDetailHasilKerja,getSQL('TableHasilKerjaDetail')+' '+
   ' LEFT JOIN hasil_kerja r ON r.nomer=rk.nomer '+
   ' WHERE r.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" AND '+
   ' r.divisi_process="'+GetVal(QhasilKerja,'divisi_process')+'" AND '+
   ' rk.qty>0 GROUP BY rk.item_id,rk.id_divisi,rk.no_so,rk.no_po,rk.no_container ',True);
   ExQry(QberitaAcara,getSQL('TableBeritaAcara')+' WHERE ba.tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" '+
   ' AND ba.id_divisi="'+getVal(QHasilKerja,'divisi_process')+'"',True);

   ExQry(QBARencanaKerja,'SELECT * FROM rencana_berita_acara WHERE tgl="'+Tanggal(GetValDate(QHasilKerja,'tgl'))+'" '+
   ' AND id_divisi="'+getVal(QHasilKerja,'divisi_process')+'" ',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frCompare.fr3');
  frxReport1.ShowReport();
end;

procedure TFDataHasilKerja.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputHasilKerja) then
        FreeAndNil(FinputHasilKerja);
   Application.CreateForm(TFinputHasilKerja,FinputHasilKerja);

   FinputHasilKerja.Parent      := FMainMenu.pg;
   FinputHasilKerja.Align       := AlClient;
   FinputHasilKerja.BorderStyle := bsNone;
   FinputHasilKerja.Position    := poOwnerFormCenter ;
   FinputHasilKerja.visible     := True;
end;

procedure TFDataHasilKerja.btnFilterClick(Sender: TObject);
begin
    if GDivisi.Row > 1 then

  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.divisi_process="'+GDivisi.Cells[1,GDivisi.Row]+'" ',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,50),0);

  pagination(0);
end;

procedure TFDataHasilKerja.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,50),varisPages );
  end;
end;

procedure TFDataHasilKerja.cbEntriesChange(Sender: TObject);
var
  isFilterDivisi : String;
begin
  if GDivisi.Row > 1 then
     isFilterDivisi := ' AND d.name="'+GDivisi.Cells[0,GDivisi.Row]+'" ' else
     isFilterDivisi := '';

  LoadData(
  ' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" '+isFilterDivisi+' ',StrToIntDef(cbEntries.Text,50),0);

  Pagination(0);
end;

procedure TFDataHasilKerja.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataHasilKerja.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ecari.Text <> '' then
  LoadData(' WHERE (d.name LIKE "%'+ECari.Text+'%" )',StrToIntDef(cbEntries.Text,50),0)
  else
  LoadData(' WHERE r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataHasilKerja.FormCreate(Sender: TObject);
begin
  FDataHasilKerja:= Self;

end;

procedure TFDataHasilKerja.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));
  GridDivisi;

  cbEntries.ItemIndex := 2;

  LoadData(' WHERE  tgl >="'+Tanggal(dt1.date)+'" '+
  'AND tgl <="'+Tanggal(dt2.date)+'" AND d.name="'+GDivisi.Cells[0,2]+'" ',StrToIntDef(cbEntries.Text,10),0);
  pagination(0);
end;

procedure TFDataHasilKerja.GDivisiClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if GDivisi.Row > 1 then

  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" AND r.divisi_process="'+GDivisi.Cells[1,GDivisi.Row]+'" ',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE  r.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND r.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,50),0);

  pagination(0);
end;

procedure TFDataHasilKerja.GridDivisi;
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

procedure TFDataHasilKerja.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
   ExQry(QHasilKerja,getSQL('TableHasilKerja')+ isCari+' ORDER BY tgl ASC '+
  ' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataHasilKerja.Pagination(RowStart: Integer);
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
