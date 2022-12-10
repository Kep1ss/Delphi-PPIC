unit uDaftarSalesOrderInspect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarSalesOrderInspect = class(TForm)
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
    Q2: TMyQuery;
    btnPilih: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPilihClick(Sender: TObject);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private

    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    idDivisi : String;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarSalesOrderInspect: TFDaftarSalesOrderInspect;


implementation



{$R *.dfm}

uses UinputRencanaKerja, uMarCon, uInputInspect;



{ TFinputMotif }

procedure TFDaftarSalesOrderInspect.btnFindClick(Sender: TObject);
begin
  LoadGrid(' AND (s.nomer_sales_order LIKE "%'+Ecari.Text+'%" '+
  ' OR i.itemno LIKE "%'+Ecari.Text+'%" OR '+
  ' i.description LIKE "%'+Ecari.Text+'%" OR '+
  ' s.nomer_container LIKE "%'+ECari.Text+'%") '+
  ' ');
end;

procedure TFDaftarSalesOrderInspect.btnPilihClick(Sender: TObject);
var
  i : integer;
  isCheck : Boolean;

begin

  for i := 1 to sgBarang.RowCount -1 do begin
     sgBarang.GetCheckBoxState(6,i,isCheck);

     if isCheck = True then begin
        with FinputInspect do begin
          sg.Cells[0,sg.RowCount -1] := sgBarang.Cells[0,i];
          sg.Cells[1,sg.RowCount -1] := sgBarang.Cells[1,i];
          sg.Cells[2,sg.RowCount -1] := sgBarang.Cells[7,i];
          sg.Cells[3,sg.RowCount -1] := sgBarang.Cells[2,i];
          sg.Cells[4,sg.RowCount -1] := 'SET';
          sg.Cells[5,sg.RowCount -1] := sgBarang.Cells[3,i];
          sg.Cells[6,sg.RowCount -1] := sgBarang.Cells[4,i];
          sg.Cells[7,sg.RowCount -1] := '';
          sg.Cells[8,sg.RowCount -1] := sgBarang.Cells[5,i];
          sg.RowCount                := sg.RowCount + 1;
        end;
     end;

  end;


  Close;
end;

procedure TFDaftarSalesOrderInspect.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarSalesOrderInspect.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 8;
    RowCount := 2;

    Cells[0,0] := 'No So';
    Cells[1,0] := 'Nomer Container';
    Cells[2,0] := 'Item';
    Cells[3,0] := 'Qty Order';
    Cells[4,0] := 'Qty Ready';
    Cells[5,0] := 'item_Id';
    Cells[6,0] := 'Pilih';
    Cells[7,0] := 'itemno';

    ColWidths[0] := 100;
    ColWidths[1] := 100;
    ColWidths[2] := 100;
    ColWidths[3] := 100;
    ColWidths[4] := 150;
    ColWidths[5] := 0;
    ColWidths[6] := 50;
    ColWidths[7] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarSalesOrderInspect.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin

    btnFind.Click;
  end;
end;

procedure TFDaftarSalesOrderInspect.FormShow(Sender: TObject);
begin


  TampilanAwal;
end;

procedure TFDaftarSalesOrderInspect.LoadGrid(Filter: String);
var
  i : integer;

begin
  CreateGrid;
    ExQry(Q1,' SELECT                            '+
             '     s.customer,                   '+
             '     s.no_sales_order,             '+
             '     s.nomer_container,            '+
             '     d.item_id,                    '+
             '     i.description,                '+
             '     i.itemno,                     '+
             '     d.jumlah,                     '+
             '     fc_qtyreadypacking(d.item_id,s.no_sales_order,s.nomer_container) as qtyready,'+
             '     d.shipped                     '+
             '   FROM                            '+
             '     sales_order s                 '+
             '     LEFT JOIN detail_sales_order d  '+
             '       ON s.`no_input` = d.`no_input` '+
             '     LEFT JOIN item i                 '+
             '       ON i.`id` = d.`item_id`  '+
             ' '+Filter+'',True);
      i := 1;
      sgBarang.RowCount := Q1.RecordCount + 1;
      while not Q1.Eof do begin
        with sgBarang do begin
             Cells[0,i] := GetVal(Q1,'no_sales_order');
             Cells[1,i] := GetVal(Q1,'nomer_container');
             Cells[2,i] := GetVal(Q1,'description');
             Cells[3,i] := GetVal(Q1,'jumlah');
             Cells[4,i] := GetVal(Q1,'qtyready');

             Cells[5,i] := GetVal(Q1,'item_id');
             AddCheckBox(6,i,False,false);
             Cells[7,i] := GetVal(Q1,'itemno');
             Inc(i);
           end;

           Q1.Next;


        end;


end;

procedure TFDaftarSalesOrderInspect.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 6
end;

procedure TFDaftarSalesOrderInspect.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarSalesOrderInspect.TampilanAwal;
begin
  ClearText(Self);



end;

end.
