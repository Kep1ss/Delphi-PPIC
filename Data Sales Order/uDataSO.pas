unit uDataSO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB,  frxClass, frxDBSet,DateUtils,
  DBAdvGrid, DBAccess, MyAccess, MemDS, Vcl.ComCtrls, frxExportBaseDialog,
  frxExportImage;

type
  TFDataSO = class(TForm)
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
    frDetailSalesOrder: TfrxDBDataset;
    frSalesOrder: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    QDetailSalesOrder: TMyQuery;
    QsalesOrder: TMyQuery;
    Q1: TMyQuery;
    DSalesOrder: TMyDataSource;
    DBAdvGrid1: TDBAdvGrid;
    Q2: TMyQuery;
    Label2: TLabel;
    dt1: TDateTimePicker;
    Label8: TLabel;
    dt2: TDateTimePicker;
    btnFilter: TAdvSmoothButton;
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    Lentries: TLabel;
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
  FDataSO: TFDataSO;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputSalesOrder;




procedure TFDataSO.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QSalesOrder,getSQL('TableSalesOrder')+' WHERE no_input="'+GetVal(QSalesOrder,'no_input')+'"',True);


  QDetailSalesOrder.Active := False;
  QDetailSalesOrder.Active := True;

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frSalesOrder.fr3');
  frxReport1.ShowReport();

  btnFilter.Click;

end;

procedure TFDataSO.AdvSmoothButton2Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    ExQry(Q1,'DELETE FROM sales_order WHERE no_input="'+GetVal(QSalesOrder,'no_input')+'"',False);
    LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
    Pagination(0);
  end;
end;

procedure TFDataSO.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Sales Order.xls');
end;

procedure TFDataSO.AdvSmoothButton4Click(Sender: TObject);
var
  i  : integer;
begin
  if  Assigned(FinputSalesOrder) then
        FreeAndNil(FinputSalesOrder);
   Application.CreateForm(TFinputSalesOrder,FinputSalesOrder);

   FinputSalesOrder.Parent      := FMainMenu.pg;
   FinputSalesOrder.Align       := AlClient;
   FinputSalesOrder.BorderStyle := bsNone;
   FinputSalesOrder.Position    := poOwnerFormCenter ;
   FinputSalesOrder.visible     := True;
   FinputSalesOrder.GridWo;
   FinputSalesOrder.TampilanAwal;

  with FinputSalesOrder do begin
      isiCmb(Q1,'category_buyer',['id','buyer_name'],cbCustomer);
      ExQry(Q1,getSQL('TableSalesOrder')+' WHERE no_input="'+GetVal(QSalesOrder,'no_input')+'"',True);
      Enomer.Text       := GetVal(Q1,'no_input');
      EnoSo.Text        := GetVal(Q1,'no_sales_order');
      ENoContainer.Text := GetVal(Q1,'nomer_container');
      cbCustomer.ItemIndex   :=  cbCustomer.Items.IndexOf(GetVal(Q1,'customer'));
      Edeskripsi.Text   := GetVal(Q1,'keterangan');
      dtMulai.Date      := GetValDate(Q1,'tgl_input');
      id                := GetVal(Q1,'id');


         ExQry(Q2,getSQL('TableDetailSalesOrder')+' WHERE dso.no_input="'+GetVal(QSalesOrder,'no_input')+'"',True);

          i    := 0;
          FinputSalesOrder.sg.RowCount := Q2.RecordCount + 2;
          while not Q2.Eof  do begin

                FinputSalesOrder.sg.Cells[0,i+1] := GetVal(Q2,'itemno');
                FinputSalesOrder.sg.Cells[1,i+1] := GetVal(Q2,'description');
                FinputSalesOrder.sg.Cells[2,i+1] := GetVal(Q2,'unit');
                FinputSalesOrder.sg.Cells[3,i+1] := GetVal(Q2,'jumlah');
                FinputSalesOrder.sg.Cells[4,i+1] := GetVal(Q2,'item_id');
            Q2.Next;
            Inc(i);


          end;
  end;

end;
procedure TFDataSO.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputSalesOrder) then
        FreeAndNil(FinputSalesOrder);
   Application.CreateForm(TFinputSalesOrder,FinputSalesOrder);


   FinputSalesOrder.Parent      := FMainMenu.pg;
   FinputSalesOrder.Align       := AlClient;
   FinputSalesOrder.BorderStyle := bsNone;
   FinputSalesOrder.Position    := poOwnerFormCenter ;
   FinputSalesOrder.visible     := True;
   FinputSalesOrder.GridWo;
   FinputSalesOrder.TampilanAwal;
end;

procedure TFDataSO.btnFilterClick(Sender: TObject);
begin
  LoadData(
  ' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataSO.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,0),varisPages );
  end;
end;

procedure TFDataSO.cbEntriesChange(Sender: TObject);
begin
  LoadData(
  ' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;


procedure TFDataSO.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataSO.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ecari.Text <> '' then
  LoadData(' WHERE (so.customer LIKE "%'+ECari.Text+'%"  OR '+
  ' so.nomer_container LIKE "%'+Ecari.Text+'%") ',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataSO.FormCreate(Sender: TObject);
begin
  FDataSO:= Self;

  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));

end;

procedure TFDataSO.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),1);
  dt2.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),DayOf(EndOfTheMonth(dt1.Date)));

  LoadData(' WHERE so.tgl_input >="'+Tanggal(dt1.date)+'" '+
  'AND so.tgl_input <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);

  Pagination(0);
end;

procedure TFDataSO.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
  ExQry(QsalesOrder,getSQL('TableSalesOrder')+ isCari+ ' LIMIT '+IntToStr(isLimit)+
  ' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);


  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataSO.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM sales_order '+
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
       Lentries.Caption := 'Showing '+IntToStr(QsalesOrder.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

end.
