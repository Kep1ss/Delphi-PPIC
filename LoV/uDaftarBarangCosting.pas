unit uDaftarBarangCosting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, MemDS, DBAccess, MyAccess;


type
  TFDaftarBarangCosting = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgBarang: TAdvStringGrid;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangDblClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
  private


    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarBarangCosting: TFDaftarBarangCosting;


implementation



{$R *.dfm}

uses uInputBom, uInputProduct, uMarCon, uEngine, uDataTableCostingProduk;

{ TFinputMotif }

procedure TFDaftarBarangCosting.btnAddClick(Sender: TObject);
begin
  FinputBarang.ShowModal;
end;

procedure TFDaftarBarangCosting.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (description LIKE "%'+Ecari.Text+'%" '+
  ' OR itemno LIKE "%'+Ecari.Text+'%" ) AND inventory_group=3');
end;

procedure TFDaftarBarangCosting.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarBarangCosting.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 3;
    RowCount := 2;

    Cells[0,0] := 'Item No';
    Cells[1,0] := 'Deskripsi';
    Cells[2,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarBarangCosting.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
     btnFind.Click;

  end;
end;

procedure TFDaftarBarangCosting.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;

end;

procedure TFDaftarBarangCosting.FormShow(Sender: TObject);
begin
  TampilanAwal;

end;

procedure TFDaftarBarangCosting.LoadGrid(Filter: String);
var
  i : integer;
begin
  CreateGrid;
  ExQry(Q1,getSQL('TableProduct')+ Filter,True);

      for I := 0 to Q1.RecordCount -1 do begin
        sgBarang.RowCount     := sgBarang.RowCount + 1;
        sgBarang.Cells[0,i+1] := GetVal(Q1,'itemno');
        sgBarang.Cells[1,i+1] := GetVal(Q1,'description');
        sgBarang.Cells[3,i+1] := GetVal(Q1,'id');
        Q1.Next;
      end;

end;

procedure TFDaftarBarangCosting.sgBarangDblClick(Sender: TObject);
begin
  with  FDataTableCostingProduct do begin
    EitemNo.Text      :=  sgBarang.Cells[0,sgBarang.Row];
    ENamaProduk.Text  :=  sgBarang.Cells[1,sgBarang.Row];


    LoadDivisi;
    if pg.PageCount > 0 then
    pgChange(Sender) else
    MessageDlg('Proses produksi produk belum di inputkan',mtInformation,[mbOK],0);

  end;
  Close;
end;


procedure TFDaftarBarangCosting.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarBarangCosting.TampilanAwal;
begin
  ClearText(Self);

  LoadGrid(' WHERE inventory_group=3 LIMIT 500');

end;

end.
