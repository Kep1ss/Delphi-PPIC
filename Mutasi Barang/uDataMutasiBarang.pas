unit uDataMutasiBarang;

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
  TFDataMutasiBarang = class(TForm)
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
    DMutasiBarang: TDataSource;
    frxReport1: TfrxReport;
    frDetailMutasi: TfrxDBDataset;
    frMutasiBarang: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    QMutasiBarang: TMyQuery;
    QDetailMutasi: TMyQuery;
    Q: TMyQuery;
    Label2: TLabel;
    Label8: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    btnFilter: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    sgMutasi: TAdvStringGrid;
    pPagination: TAdvSmoothPanel;
    Lentries: TLabel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
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
    procedure sgMutasiGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgMutasiDblClick(Sender: TObject);
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
  FDataMutasiBarang: TFDataMutasiBarang;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputMutasiBarang;




procedure TFDataMutasiBarang.AdvSmoothButton1Click(Sender: TObject);
begin

  if (sgMutasi.Cells[0,sgMutasi.Row] = '') then begin
      Error('Silahkan pilih nomer mutasi');
      Exit;
  end else begin
    ExQry(QmutasiBarang,getSQL('TableMasterMutasi')+' WHERE code="'+sgMutasi.Cells[1,sgMutasi.Row]+'"',True);
    ExQry(QDetailMutasi,getSQL('TableDetailMutasi')+' WHERE code="'+sgMutasi.Cells[1,sgMutasi.Row]+'"',True);

    frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frMutasiBarang.fr3');
    frxReport1.ShowReport();
  end;

end;

procedure TFDataMutasiBarang.AdvSmoothButton2Click(Sender: TObject);
begin
  if sgMutasi.Cells[0,sgMutasi.Row] = '' then begin
     Error('Silahkan Pilih Nomer Master Job Oder dengan Benar');
     Exit
  end else begin

  if MessageDlg('Apakah yakin data '+sgMutasi.Cells[1,sgMutasi.Row]+' akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin

    ExQry(Q1,'SELECT d.qty,m.divisi_id_from,d.no_so,d.nomer_container,d.item_id FROM mutasi_produksi_detail d '+
    ' LEFT JOIN mutasi_produksi m ON d.code=m.code WHERE m.code="'+sgMutasi.Cells[1,sgMutasi.Row]+'"',True);

    while not Q1.Eof do begin
       ExQry(Q2,'UPDATE progress SET qty_out=qty_out-"'+GetVal(Q1,'qty')+'" '+
       ' WHERE no_so="'+GetVal(Q1,'no_so')+'" '+
       ' AND nomer_container="'+GetVal(Q1,'nomer_container')+'" '+
       ' AND item_id="'+GetVal(Q1,'item_id')+'" '+
       ' AND id_divisi="'+GetVal(Q1,'divisi_id_from')+'" ',False);
       Q1.Next;

    end;
    ExQry(Q,'DELETE FROM mutasi_produksi WHERE code="'+sgMutasi.Cells[1,sgMutasi.Row]+'"',False);
    ExQry(Q,'DELETE FROM mutasi_produksi_detail WHERE code="'+sgMutasi.Cells[1,sgMutasi.Row]+'"',False);
    LoadData(' WHERE m.tgl >="'+Tanggal(dt1.date)+'" '+
              'AND m.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);
    Pagination(0);
  end;
  end;
end;

procedure TFDataMutasiBarang.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Job Order.xls');
end;

procedure TFDataMutasiBarang.AdvSmoothButton4Click(Sender: TObject);
var
  i  : integer;
  SisaManHour : Integer;
  ItemPermenit: Integer;
  Manhour     : Integer;
  TotalAlokasi: Integer;
  Target      : Integer;
begin
  if  Assigned(FInputMutasiBarang) then
        FreeAndNil(FInputMutasiBarang);
   Application.CreateForm(TFInputMutasiBarang,FInputMutasiBarang);

   FInputMutasiBarang.Parent      := FMainMenu.pg;
   FInputMutasiBarang.Align       := AlClient;
   FInputMutasiBarang.BorderStyle := bsNone;
   FInputMutasiBarang.Position    := poOwnerFormCenter ;
   FInputMutasiBarang.visible     := True;
   FInputMutasiBarang.GridWo;
   FInputMutasiBarang.TampilanAwal;

  with FInputMutasiBarang do begin
      isiCmb(Q1,'divisi where is_active=true ORDER BY divno ASC ',['id','name'],FInputMutasiBarang.cbDivisiAwal);
      isiCmb(Q1,'divisi where is_active=true ORDER BY divno ASC ',['id','name'],FInputMutasiBarang.cbDivisiAkhir);
      ExQry(Q,getSQL('TableMasterMutasi')+' WHERE code="'+sgMutasi.Cells[1,sgMutasi.Row]+'"',True);
      Enomer.Text     := GetVal(Q,'code');
      Edeskripsi.Text := GetVal(Q,'keterangan');
      dtMulai.Date    := GetValDate(Q,'tgl');
      cbDivisiAwal.ItemIndex := idxCmb(cbDivisiAwal,GetValInt(Q,'divisi_id_from'));
      cbDivisiAkhir.ItemIndex := idxCmb(cbDivisiAwal,GetValInt(Q,'divisi_id_to'));
      cbJenisMutasi.ItemIndex := cbJenisMutasi.Items.IndexOf(GetVal(Q,'jenis_mutasi'));


         ExQry(Q1,getSQL('TableDetailMutasi')+' WHERE d.code="'+Getval(QmutasiBarang,'code')+'"',True);

          i    := 0;
          FInputMutasiBarang.sg.RowCount := Q1.RecordCount + 1;
          while not Q1.Eof do begin

             sg.Cells[0,sg.RowCount -1] := IntToStr(i+1);
             sg.Cells[1,sg.RowCount -1] := GetVal(Q1,'nomer_container');
             sg.Cells[2,sg.RowCount -1] := GetVal(Q1,'no_so');
             sg.Cells[3,sg.RowCount -1] := GetVal(Q1,'itemno');
             sg.Cells[4,sg.RowCount -1] := GetVal(Q1,'description');
             ExQry(Q3,' SELECT                               '+
             '     SUM(p.qty - p.qty_out) AS qty_sisa        '+
             '   FROM                                        '+
             '     progress p                                '+
             '     LEFT JOIN item i                          '+
             '       ON i.`id` = p.`item_id`                 '+
             '     LEFT JOIN divisi d                        '+
             '       ON d.`id` = p.`id_divisi`               '+
             '     WHERE p.item_id="'+GetVal(Q1,'item_id')+'" '+
             '       AND p.no_so="'+GetVal(Q1,'no_so')+'"     '+
             '       AND p.nomer_container="'+GetVal(Q1,'nomer_container')+'" '+
             '       AND p.id_divisi="'+GetVal(Q,'divisi_id_from')+'" '+
             '   GROUP BY p.`item_id`,                       '+
             '     p.`no_so`,                                '+
             '     p.`nomer_container`,                      '+
             '     p.`id_divisi` ',True);
             sg.Cells[5,sg.RowCount -1] := FloatToStr(GetValF(Q3,'qty_sisa') + GetValF(Q1,'qty'));
             sg.Cells[6,sg.RowCount -1] := GetVal(Q1,'qty');
             sg.Cells[7,sg.RowCount -1] := GetVal(Q1,'keterangan');
             sg.Cells[8,sg.RowCount -1] := GetVal(Q1,'item_id');
             sg.RowCount := sg.RowCount + 1;
             sg.Row      := sg.RowCount -1;
             sg.SetFocus;
             sg.Col    := 1;

            Q1.Next;
            Inc(i);


          end;
  end;

end;
procedure TFDataMutasiBarang.btnAddClick(Sender: TObject);
begin
    if  Assigned(FInputMutasiBarang) then
        FreeAndNil(FInputMutasiBarang);
   Application.CreateForm(TFInputMutasiBarang,FInputMutasiBarang);
   isiCmb(Q1,'divisi WHERE is_active=true ORDER BY divno ASC ',['id','name'],FInputMutasiBarang.cbDivisiAwal);
   isiCmb(Q1,'divisi WHERE is_active=true ORDER BY divno ASC ',['id','name'],FInputMutasiBarang.cbDivisiAkhir);
   FInputMutasiBarang.Parent      := FMainMenu.pg;
   FInputMutasiBarang.Align       := AlClient;
   FInputMutasiBarang.BorderStyle := bsNone;
   FInputMutasiBarang.Position    := poOwnerFormCenter ;
   FInputMutasiBarang.visible     := True;
   FInputMutasiBarang.GridWo;
   FInputMutasiBarang.TampilanAwal;
end;

procedure TFDataMutasiBarang.btnFilterClick(Sender: TObject);
begin
  LoadData(
  ' WHERE m.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND m.tgl <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

   Pagination(0);
end;


procedure TFDataMutasiBarang.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData(' WHERE m.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND m.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,0),varisPages );
  end;
end;

procedure TFDataMutasiBarang.cbEntriesChange(Sender: TObject);
begin
  LoadData(
  ' WHERE m.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND m.tgl <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;


procedure TFDataMutasiBarang.CreateGrid;
begin
  with sgMutasi do begin
     ClearAll;

     ColCount   := 8;
     RowCount   := 2;
     FixedRows  := 1;
     FixedCols  := 0;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Code';
     Cells[2,0] := 'No SO';
     Cells[3,0] := 'Nomer Container ';
     Cells[4,0] := 'Item No';
     Cells[5,0] := 'Description';
     Cells[6,0] := 'Qty';
     Cells[7,0] := 'keterangan';

     ColWidths[0] := 30;
     ColWidths[1] := 100;
     ColWidths[2] := 100;
     ColWidths[3] := 100;
     ColWidths[4] := 100;
     ColWidths[5] := 200;
     ColWidths[6] := 50;
     ColWidths[7] := 100;


     ColumnSize.StretchColumn := 7;
     ColumnSize.Stretch       := True;
     MergeCells(0,0,1,2);
     MergeCells(1,0,1,2);
     MergeCells(2,0,1,2);
     MergeCells(3,0,1,2);
     MergeCells(4,0,1,2);
     MergeCells(5,0,1,2);
     MergeCells(6,0,1,2);
     MergeCells(7,0,1,2);
  end;
end;

procedure TFDataMutasiBarang.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
      LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
      'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);
  end;


end;

procedure TFDataMutasiBarang.FormCreate(Sender: TObject);
begin
  FDataMutasiBarang:= Self;
  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));
  Ecari.isCari := True;
  cbEntries.ItemIndex := 1;
end;

procedure TFDataMutasiBarang.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),1);
  dt2.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),DayOf(EndOfTheMonth(dt1.Date)));

  LoadData(' WHERE m.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND m.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

end;

procedure TFDataMutasiBarang.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
var
  i , j , x,urut: integer;
begin

  CreateGrid;

  ExQry(QmutasiBarang,getSQL('TableMasterMutasi')+ isCari+ ' ORDER BY tgl ASC '+
  ' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);
  i := 2;
  urut := 1;
  sgMutasi.BeginUpdate;
  while not QmutasiBarang.Eof do begin
     sgMutasi.Cells[0,i] := IntToStr(urut);
     sgMutasi.Cells[1,i] := GetVal(QmutasiBarang,'code');
     sgMutasi.Cells[2,i] := GetVal(QmutasiBarang,'tgl');
     sgMutasi.Cells[3,i] := 'Dari Divisi : '+GetVal(QmutasiBarang,'divisifrom');
     sgMutasi.Cells[5,i] := 'Ke Divisi : '+GetVal(QmutasiBarang,'divisito');
     sgMutasi.Cells[7,i] :=  GetVal(QmutasiBarang,'jenis_mutasi');
     sgMutasi.MergeCells(3,i,2,1);
     sgMutasi.MergeCells(5,i,2,1);

     ExQry(Q1,getSQL('TableDetailMutasi')+' '+
     ' WHERE d.code="'+GetVal(QmutasiBarang,'code')+'" ',True);

     for x := 0 to sgMutasi.ColCount -1 do
     begin
       sgMutasi.Colors[x,i] := clSilver;
       sgMutasi.ColorsTo[x,i] := clSilver;
     end;

     j := i +1;
     while  not Q1.Eof do begin
        sgMutasi.RowCount := sgMutasi.RowCount + 1;
        sgMutasi.Cells[1,j] := IntToStr(Q1.RecNo);
        sgMutasi.Cells[2,j] := GetVal(Q1,'no_so');
        sgMutasi.Cells[3,j] := GetVal(Q1,'nomer_container');
        sgMutasi.Cells[4,j] := GetVal(Q1,'itemno');
        sgMutasi.Cells[5,j] := GetVal(Q1,'description');
        sgMutasi.Cells[6,j] := GetValR(Q1,'qty');
        sgMutasi.Cells[7,j] := GetVal(Q1,'keterangan');
        inc(j);
        Q1.Next;
     end;

     i := j;
     inc(urut);
     QmutasiBarang.Next;
     sgMutasi.RowCount := sgMutasi.RowCount + 1;

  end;
  sgMutasi.EndUpdate;

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;

procedure TFDataMutasiBarang.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM mutasi_produksi   '+
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
       Lentries.Caption := 'Showing '+IntToStr(QmutasiBarang.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

procedure TFDataMutasiBarang.sgMutasiDblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataMutasiBarang.sgMutasiGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
    if ACOl = 10 then begin
     HAlign := taCenter;
     VAlign := vtaCenter;
  end;
end;

end.
