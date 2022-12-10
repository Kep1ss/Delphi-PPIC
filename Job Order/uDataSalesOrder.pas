unit uDataSalesOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel, AnnabaDB,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid,uDatatables, AdvCombo, tmsAdvGridExcel,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, frxClass, frxDBSet,
  uPatchForm;

type
  TFDataSalesOrder = class(TForm)
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
    Lentries: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    sg: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    QFB1: TZQuery;
    AdvSmoothButton1: TAdvSmoothButton;
    QMasterWO: TZQuery;
    QDetailWO: TZQuery;
    DmasterWO: TDataSource;
    frxReport1: TfrxReport;
    frDetailWO: TfrxDBDataset;
    frMasterWO: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
  private
    { Private declarations }

    procedure CreateGrid;

  public
    { Public declarations }
    procedure LoadData(isLimit : Integer;isOffSet:integer);

  end;



var
  FDataSalesOrder: TFDataSalesOrder;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputSalesOrder;




procedure TFDataSalesOrder.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QMasterWO,getSQL('TableSO')+' WHERE no_so="'+sg.Cells[0,sg.Row]+'"',True);


  QDetailWO.Active := False;
  QDetailWO.Active := True;

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frJobOrder.fr3');
  frxReport1.ShowReport();

end;

procedure TFDataSalesOrder.AdvSmoothButton2Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    ExQry(Q,'DELETE FROM master_so WHERE no_so="'+sg.Cells[0,sg.Row]+'"',False);
    LoadData(StrToIntDef(cbEntries.Text,10),0);
  end;
end;

procedure TFDataSalesOrder.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Job Order.xls');
end;

procedure TFDataSalesOrder.AdvSmoothButton4Click(Sender: TObject);
var
  i , ii , Urut: integer;
  yDB : TYDb;
begin
  if  Assigned(FinputSo) then
        FreeAndNil(FinputSo);
   Application.CreateForm(TFinputSo,FinputSo);

   FinputSo.Parent      := FMainMenu.pg;
   FinputSo.Align       := AlClient;
   FinputSo.BorderStyle := bsNone;
   FinputSo.Position    := poOwnerFormCenter ;
   FinputSo.visible     := True;
   FinputSo.GridWo;
   FinputSo.TampilanAwal;
  yDB := TYDb.Create(MariaCon.ZMy);

  try
  with FinputSo do begin

      ExQry(Q,getSQL('TableSO')+' WHERE no_so="'+FDataSalesOrder.sg.Cells[0,sg.Row]+'"',True);
      Enomer.Text     := GetVal(Q,'no_so');
      EContainer.Text := GetVal(Q,'no_container');
      Ecustomer.Text  := GetVal(Q,'customer');
      EPIC.Text       := GetVal(Q,'pic');
      Edeskripsi.Text := GetVal(Q,'keterangan');
      dtMulai.Date    := GetValDate(Q,'tgl_input');


         yDB.SQL := getSQL('TableDetailSO')+' WHERE dso.no_so="'+FDataSalesOrder.sg.Cells[0,sg.Row]+'"';
         yDB.ExQuery;


          i    := 0;
          FinputSo.sg.RowCount := yDB.DataCount + 2;
          while i <= yDb.DataCount -1  do begin

                FinputSo.sg.Cells[0,i+1] := yDB.ValString('itemno');
                FinputSo.sg.Cells[1,i+1] := yDB.ValString('description');
                FinputSo.sg.Cells[2,i+1] := yDB.ValString('unit');
                FinputSo.sg.Cells[3,i+1] := yDB.ValString('jumlah');
                FinputSo.sg.Cells[4,i+1] := yDB.ValString('harga');
                FinputSo.sg.Cells[5,i+1] := yDB.ValString('subtotal');
                FinputSo.sg.Cells[6,i+1] := yDB.ValString('no_po');
                FinputSo.sg.Cells[7,i+1] := yDB.ValString('item_id');
            yDB.NextRec;
            Inc(i);


          end;
  end;
  finally
    yDB.Free;
  end;

end;
procedure TFDataSalesOrder.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputSo) then
        FreeAndNil(FinputSo);
   Application.CreateForm(TFinputSo,FinputSo);

   FinputSo.Parent      := FMainMenu.pg;
   FinputSo.Align       := AlClient;
   FinputSo.BorderStyle := bsNone;
   FinputSo.Position    := poOwnerFormCenter ;
   FinputSo.visible     := True;
   FinputSo.GridWo;
   FinputSo.TampilanAwal;
end;

procedure TFDataSalesOrder.cbEntriesChange(Sender: TObject);
begin
  LoadData(StrToIntDef(cbEntries.Text,1),1);
end;

procedure TFDataSalesOrder.CreateGrid;

begin
  with sg do begin
     ClearAll;
     ColCount   := 7;
     RowCount   := 2;
     FixedRows  := 1;


     Cells[0,0] := 'Nomer';
     Cells[1,0] := 'Tgl Input';
     Cells[2,0] := 'No Container';
     Cells[3,0] := 'Customer';
     Cells[4,0] := 'PIC';
     Cells[5,0] := 'Keterangan';
     Cells[6,0] := 'id';

     ColWidths[0] := 100;
     ColWidths[1] := 100;
     ColWidths[2] := 150;
     ColWidths[3] := 120;
     ColWidths[4] := 120;
     ColWidths[5] := 300;
     ColWidths[6] := 0;


     ColumnSize.StretchColumn := 5;
     ColumnSize.Stretch       := True;
  end;
end;

procedure TFDataSalesOrder.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  sg.LoadContent(' (so.customer LIKE "%'+ECari.Text+'%" or so.no_container LIKE "%'+Ecari.Text+'%")');
end;

procedure TFDataSalesOrder.FormCreate(Sender: TObject);
begin
  FDataSalesOrder:= Self;

end;

procedure TFDataSalesOrder.FormShow(Sender: TObject);
begin

  CreateGrid;

  sg.AutoBuilHeader := False;
  sg.ButtonCount    := 0;
  sg.RowStart       := 1;
  sg.SQL            := getSQL('TableSO');
  sg.ActSQL         := asSQL;
  sg.StatPagination := True;
  LoadData(StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataSalesOrder.LoadData(isLimit : Integer;isOffSet:integer);
begin
  CreateGrid;
  sg.Limit        := isLimit;
  sg.Offset       := isOffSet;
  sg.SQL            := getSQL('TableSO');
  sg.ActSQL         := asSQL;
  sg.LoadContent('');
  sg.Pagination(pPagination,1);
  Lentries.Caption := sg.FLentris;
end;


end.
