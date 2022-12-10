unit uDataJobOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB,frxClass, frxDBSet,DateUtils,
  MemDS, DBAccess, MyAccess, DBAdvGrid, Vcl.ComCtrls, frxExportBaseDialog,
  frxExportImage;

type
  TFDataJobOrder = class(TForm)
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
    DMasterJobOrder: TDataSource;
    frxReport1: TfrxReport;
    frDetailJobOrder: TfrxDBDataset;
    frMasterJobOrder: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    QMasterJobOrder: TMyQuery;
    QDetailJobOrder: TMyQuery;
    Q: TMyQuery;
    Label2: TLabel;
    Label8: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    btnFilter: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    sg: TAdvStringGrid;
    pPagination: TAdvSmoothPanel;
    Lentries: TLabel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    frxJPEGExport1: TfrxJPEGExport;
    AdvSmoothButton5: TAdvSmoothButton;
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
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgDblClick(Sender: TObject);
    procedure AdvSmoothButton5Click(Sender: TObject);
  private
    { Private declarations }

    varIsLimit : Integer;
    varIsPage  : Integer;
    procedure ButtonPage(Sender: TObject);
    procedure Pagination(RowStart: Integer);


  public
    { Public declarations }
    procedure LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
    procedure CreateGrid;


  end;



var
  FDataJobOrder: TFDataJobOrder;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputJobOrder, uGenerateJobOrders;




procedure TFDataJobOrder.AdvSmoothButton1Click(Sender: TObject);
begin

  if (sg.Cells[0,sg.Row] = '') then begin
      Error('Silahkan pilih nomer job order');
      Exit;
  end else begin
    ExQry(QMasterJobOrder,getSQL('TableJobOrder')+' WHERE no_input="'+sg.Cells[1,sg.Row]+'"',True);


    QDetailJobOrder.Active := False;
    QDetailJobOrder.Active := True;

    frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frJobOrder.fr3');
    frxReport1.ShowReport();
  end;

end;

procedure TFDataJobOrder.AdvSmoothButton2Click(Sender: TObject);
begin
  if sg.Cells[0,sg.Row] = '' then begin
     Error('Silahkan Pilih Nomer Master Job Oder dengan Benar');
     Exit
  end else begin

  if MessageDlg('Apakah yakin data '+sg.Cells[1,sg.Row]+' akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin

    ExQry(Q,'DELETE FROM detail_job_order WHERE no_input="'+sg.Cells[1,sg.Row]+'"',False);
    ExQry(Q,'DELETE FROM master_job_order WHERE no_input="'+sg.Cells[1,sg.Row]+'"',False);
    LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
              'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);
    Pagination(0);
  end;
  end;
end;

procedure TFDataJobOrder.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Job Order.xls');
end;

procedure TFDataJobOrder.AdvSmoothButton4Click(Sender: TObject);
var
  i  : integer;
  SisaManHour : Integer;
  ItemPermenit: Integer;
  Manhour     : Integer;
  TotalAlokasi: Integer;
  Target      : Integer;
begin
  if  Assigned(FinputJobOrder) then
        FreeAndNil(FinputJobOrder);
   Application.CreateForm(TFinputJobOrder,FinputJobOrder);

   FinputJobOrder.Parent      := FMainMenu.pg;
   FinputJobOrder.Align       := AlClient;
   FinputJobOrder.BorderStyle := bsNone;
   FinputJobOrder.Position    := poOwnerFormCenter ;
   FinputJobOrder.visible     := True;
   FinputJobOrder.GridWo;
   FinputJobOrder.TampilanAwal;

  with FinputJobOrder do begin
      isiCmb(Q1,'divisi where is_active=true ORDER BY divno ASC ',['id','name'],FinputJobOrder.CbDivisi);
      ExQry(Q,getSQL('TableJobOrder')+' WHERE no_input="'+Getval(QMasterJobOrder,'no_input')+'"',True);
      Enomer.Text     := GetVal(Q,'no_input');
      Edeskripsi.Text := GetVal(Q,'keterangan');
      dtMulai.Date    := GetValDate(Q,'tgl_input');
      CbDivisi.ItemIndex := idxCmb(CbDivisi,GetValInt(Q,'id_divisi'));


         ExQry(Q1,getSQL('TableDetailJobOrder')+' WHERE dso.no_input="'+Getval(QMasterJobOrder,'no_input')+'"',True);

          i    := 0;
          FinputJobOrder.sg.RowCount := Q1.RecordCount + 2;
          while not Q1.Eof do begin

             sg.Cells[0,i+2] := IntToStr(sg.RowCount -2);
             sg.Cells[1,i+2] := GetVal(Q1,'nomer_container');
             sg.Cells[2,i+2] := GetVal(Q1,'itemno');
             sg.Cells[3,i+2] := GetVal(Q1,'description');
             sg.Cells[4,i+2] := GetVal(Q1,'qty_order');
             sg.Cells[5,i+2] := Format('%.0n',[GetValF(Q1,'alokasi_per_menit')]);
             sg.Cells[6,i+2] := GetValR(Q1,'total_alokasi');
             sg.Cells[7,i+2] := GetVal(Q1,'jml_karyawan');
             sg.Cells[8,i+2] := Format('%.0n',[GetValF(Q1,'total_alokasi_perhari')]) ;


             sg.Cells[9,i+2]  := GetValR(Q1,'target_perolehan');
             sg.Cells[10,i+2] := GetVal(Q1,'tgl_mulai');
             sg.Cells[11,i+2] := GetVal(Q1,'tgl_akhir');
             sg.Cells[12,i+2] := GetVal(Q1,'item_id');
             sg.Cells[13,i+2] := GetVal(Q1,'no_so');
             sg.RowCount := sg.RowCount + 1;
             sg.Row      := sg.RowCount -1;
             sg.SetFocus;
             sg.Col    := 1;

            Q1.Next;
            Inc(i);


          end;
  end;

end;
procedure TFDataJobOrder.AdvSmoothButton5Click(Sender: TObject);
begin
  FGenerateJobOrders.ShowModal;
end;

procedure TFDataJobOrder.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputJobOrder) then
        FreeAndNil(FinputJobOrder);
   Application.CreateForm(TFinputJobOrder,FinputJobOrder);
   isiCmb(Q1,'divisi WHERE is_active=true ORDER BY divno ASC ',['id','name'],FinputJobOrder.CbDivisi);
   FinputJobOrder.Parent      := FMainMenu.pg;
   FinputJobOrder.Align       := AlClient;
   FinputJobOrder.BorderStyle := bsNone;
   FinputJobOrder.Position    := poOwnerFormCenter ;
   FinputJobOrder.visible     := True;
   FinputJobOrder.GridWo;
   FinputJobOrder.TampilanAwal;
end;

procedure TFDataJobOrder.btnFilterClick(Sender: TObject);
begin
  LoadData(
  ' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

   Pagination(0);
end;


procedure TFDataJobOrder.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,0),varisPages );
  end;
end;

procedure TFDataJobOrder.cbEntriesChange(Sender: TObject);
begin
  LoadData(
  ' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;


procedure TFDataJobOrder.CreateGrid;
begin
  with sg do begin
    ClearAll;

    ColCount := 13;
     RowCount := 3;
     FixedRows := 2;
     FixedCols := 0;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Code Container';
     Cells[2,0] := 'Item No';
     Cells[3,0] := 'Description ';
     Cells[4,0] := 'Jml Order';
     Cells[5,0] := 'Alokasi Waktu Per Set (Menit)';
     Cells[6,0] := 'Total Alokasi Waktu (Menit)';
     Cells[7,0] := 'Jml Kary';
     Cells[8,0] := 'Total Alokasi Waktu Per Hari';
     Cells[9,0] := 'Target Perolehan Per Hari';
     Cells[10,0] := 'Target Tgl Selesai';
     Cells[10,1] := 'Tgl Mulai';
     Cells[11,1] := 'Tgl Selesai';
     Cells[12,0] := 'Status';


     ColWidths[0] := 30;
     ColWidths[1] := 100;
     ColWidths[2] := 100;
     ColWidths[3] := 80;
     ColWidths[4] := 80;
     ColWidths[5] := 50;
     ColWidths[6] := 50;
     ColWidths[7] := 50;
     ColWidths[8] := 60;
     ColWidths[9] := 65;
     ColWidths[10] := 100;
     ColWidths[11] := 100;
     ColWidths[12] := 100;


     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;
     MergeCells(0,0,1,2);
     MergeCells(1,0,1,2);
     MergeCells(2,0,1,2);
     MergeCells(3,0,1,2);
     MergeCells(4,0,1,2);
     MergeCells(5,0,1,2);
     MergeCells(6,0,1,2);
     MergeCells(7,0,1,2);
     MergeCells(8,0,1,2);
     MergeCells(9,0,1,2);
     MergeCells(10,0,2,1);
     MergeCells(12,0,1,2);
  end;
end;

procedure TFDataJobOrder.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin

        if Ecari.Text <> '' then
      LoadData(' LEFT JOIN detail_job_order dj ON dj.no_input=so.no_input '+
      ' LEFT JOIN item i ON i.id=dj.item_id '+
      ' WHERE (d.name LIKE "%'+ECari.Text+'%" OR dj.nomer_container LIKE "%'+Ecari.Text+'%" '+
      ' OR i.description LIKE "%'+Ecari.Text+'%") GROUP by so.no_input',StrToIntDef(cbEntries.Text,1),0)
      else
      LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
      'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);
  end;


end;

procedure TFDataJobOrder.FormCreate(Sender: TObject);
begin
  FDataJobOrder:= Self;
  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));
  Ecari.isCari := True;
  cbEntries.ItemIndex := 1;
end;

procedure TFDataJobOrder.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),1);
  dt2.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),DayOf(EndOfTheMonth(dt1.Date)));

  LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

end;

procedure TFDataJobOrder.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
var
  i , j , x,urut: integer;
begin

  CreateGrid;

  ExQry(QMasterJobOrder,getSQL('TableJobOrder')+ isCari+ ' ORDER BY tgl_input ASC '+
  ' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);
  i := 2;
  urut := 1;
  sg.BeginUpdate;
  while not QMasterJobOrder.Eof do begin
     sg.Cells[0,i] := IntToStr(urut);
     sg.Cells[1,i] := GetVal(QMasterJobOrder,'no_input');
     sg.Cells[2,i] := GetVal(QMasterJobOrder,'tgl_input');
     sg.Cells[3,i] := 'Divisi : '+GetVal(QMasterJobOrder,'name');
     sg.MergeCells(4,i,5,1);
     sg.Cells[12,i] := 'Belum Selesai';

     ExQry(Q1,getSQL('TableDetailJobOrder')+' '+
     ' WHERE dso.no_input="'+GetVal(QMasterJobOrder,'no_input')+'" ',True);

     for x := 0 to sg.ColCount -1 do
     begin
       sg.Colors[x,i] := clSilver;
       sg.ColorsTo[x,i] := clSilver;
     end;

     j := i +1;
     while  not Q1.Eof do begin
        sg.RowCount := sg.RowCount + 1;
        sg.Cells[1,j] := GetVal(Q1,'nomer_container');
        sg.Cells[2,j] := GetVal(Q1,'itemno');
        sg.Cells[3,j] := GetVal(Q1,'description');
        sg.Cells[4,j] := GetValR(Q1,'qty_order');
        sg.Cells[5,j] := Format('%.0n',[GetValF(Q1,'total_alokasi') / GetValF(Q1,'qty_order')]);;
        sg.Cells[6,j] := GetValR(Q1,'total_alokasi');
        sg.Cells[7,j] := GetValR(Q1,'jml_karyawan');
        sg.Cells[8,j] := GetValR(Q1,'total_alokasi_perhari');
        sg.Cells[9,j] := GetValR(Q1,'target_perolehan');
        sg.Cells[10,j] := GetVal(Q1,'tgl_mulai');
        sg.Cells[11,j] := GetVal(Q1,'tgl_akhir');
        sg.Cells[12,j] := GetVal(Q1,'no_so');
        inc(j);
        Q1.Next;
     end;

     i := j;
     inc(urut);
     QMasterJobOrder.Next;
     sg.RowCount := sg.RowCount + 1;

  end;
  sg.EndUpdate;

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;

procedure TFDataJobOrder.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM master_job_order   '+
  ' WHERE  tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND tgl_input <="'+Tanggal(dt2.date)+'"',True);
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
       Lentries.Caption := 'Showing '+IntToStr(QMasterJobOrder.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

procedure TFDataJobOrder.sgDblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataJobOrder.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
    if ACOl = 10 then begin
     HAlign := taCenter;
     VAlign := vtaCenter;
  end;
end;

end.
