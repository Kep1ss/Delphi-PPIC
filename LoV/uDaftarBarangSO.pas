unit uDaftarBarangSO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, DBAdvGrid, DBAccess, MyAccess, MemDS;


type
  TFDaftarBarangSO = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    QLoV: TMyQuery;
    DLoV: TMyDataSource;
    sg: TAdvStringGrid;
    btnPilih: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPilihClick(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private


    procedure TampilanAwal;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
    procedure CreateGrid;
  end;

var
  FDaftarBarangSO: TFDaftarBarangSO;


implementation



{$R *.dfm}

uses  uMarCon, uEngine, uInputSalesOrder;

{ TFinputMotif }

procedure TFDaftarBarangSO.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (description LIKE "%'+Ecari.Text+'%" '+
  ' OR itemno LIKE "%'+Ecari.Text+'%" ) AND inventory_group=3 '+
  ' AND buyer_id="'+GetIdCmb(FinputSalesOrder.cbCustomer)+'" ');
end;

procedure TFDaftarBarangSO.btnPilihClick(Sender: TObject);
var
  i : integer;
  isCheck : Boolean;
begin

  for i := 1 to sg.RowCount -1 do begin
    sg.GetCheckBoxState(3,i,isCheck);

      if isCheck then begin

         FinputSalesOrder.sg.Cells[0,FinputSalesOrder.sg.RowCount -1] := sg.Cells[1,i];
         FinputSalesOrder.sg.Cells[1,FinputSalesOrder.sg.RowCount -1] := sg.Cells[2,i];
         FinputSalesOrder.sg.Cells[2,FinputSalesOrder.sg.RowCount -1] := 'Unit';
         FinputSalesOrder.sg.Cells[3,FinputSalesOrder.sg.RowCount -1] := '1';
         FinputSalesOrder.sg.Cells[4,FinputSalesOrder.sg.RowCount -1] := sg.Cells[4,i];

         FinputSalesOrder.sg.SetFocus;
         FinputSalesOrder.sg.RowCount        := FinputSalesOrder.sg.RowCount + 1;

      end;

  end;
  Close;
end;

procedure TFDaftarBarangSO.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarBarangSO.CreateGrid;
begin
  with sg do begin
    ClearAll;

    ColCount := 5;
    RowCount := 2;

    Cells[0,0] := 'No';
    Cells[1,0] := 'Item NO';
    Cells[2,0] := 'Description';
    Cells[3,0] := 'Pilih';
    Cells[4,0] := 'id';

    ColWidths[0] := 30;
    ColWidths[1] := 100;
    ColWidths[2] := 200;
    ColWidths[3] := 30;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarBarangSO.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
     btnFind.Click;

  end;
end;

procedure TFDaftarBarangSO.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;

end;

procedure TFDaftarBarangSO.FormShow(Sender: TObject);
begin
  TampilanAwal;

end;

procedure TFDaftarBarangSO.LoadGrid(Filter: String);

var
  i : integer;
begin
  CreateGrid;
  ExQry(QLov,getSQL('TableProduct')+' '+Filter,True);

  sg.RowCount := QLoV.RecordCount + 1;
  i := 1;
  while not QLoV.Eof do begin
     sg.Cells[0,i] := IntToStr(i);
     sg.Cells[1,i] := GetVal(QLoV,'itemno');
     sg.Cells[2,i] := GetVal(QLoV,'description');
     sg.Cells[4,i] := GetVal(QLoV,'id');
     sg.AddCheckBox(3,i,false,false);
     Inc(i);
     QLoV.Next;

  end;

end;

procedure TFDaftarBarangSO.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol = 3;
end;

procedure TFDaftarBarangSO.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' WHERE inventory_group=3 LIMIT 500');

end;

end.
