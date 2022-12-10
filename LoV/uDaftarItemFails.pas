unit uDaftarItemFails;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarItemFails = class(TForm)
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
  FDaftarItemFails: TFDaftarItemFails;


implementation



{$R *.dfm}

uses uInputHasilBeritaAcara, uMarCon;



{ TFinputMotif }

procedure TFDaftarItemFails.btnFindClick(Sender: TObject);
begin
  LoadGrid(' AND (f.no_so LIKE "%'+Ecari.Text+'%" '+
  ' OR i.itemno LIKE "%'+Ecari.Text+'%" OR '+
  ' i.description LIKE "%'+Ecari.Text+'%" OR '+
  ' f.nomer_container LIKE "%'+ECari.Text+'%") '+
  ' AND f.qty_failed > 0');
end;

procedure TFDaftarItemFails.btnPilihClick(Sender: TObject);
var
  order , MH , Cost : real;
  qty_component : real;
  total_component : real;
  i , x , c : integer;
  isCheck : boolean;
begin

  for  c := 0 to sgBarang.RowCount -1 do begin
      sgBarang.GetCheckBoxState(7,c,isCheck);

      if isCheck then begin

        With FInputHasilBeritaAcara do begin


           sgBa.Cells[0,sgBa.RowCount -1] := IntToStr(sgBa.RowCount -1);
           sgBa.Cells[1,sgBa.RowCount -1] := sgBarang.Cells[1,c];
           sgBa.Cells[2,sgBa.RowCount -1] := sgBarang.Cells[2,c];
           sgBa.Cells[3,sgBa.RowCount -1] := sgBarang.Cells[3,c];
           sgBa.Cells[4,sgBa.RowCount -1] := '';
           sgBa.Cells[5,sgBa.RowCount -1] := sgBarang.Cells[4,c];
           sgBa.Cells[6,sgBa.RowCount -1] := '';
           sgBa.Cells[7,sgBa.RowCount -1] := '';
           sgBa.Cells[8,sgBa.RowCount -1] := '';
           sgBa.Cells[9,sgBa.RowCount -1] := sgBarang.Cells[6,c];
           sgBa.RowCount := sgBa.RowCount + 1;
           sgBa.Row      := sgBa.RowCount -1;
           sgBa.SetFocus;
           sgBa.Col    := 1;

        end;
      end;
  end;
  Close;
end;

procedure TFDaftarItemFails.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarItemFails.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 8;
    RowCount := 2;

    Cells[0,0] := 'Tgl';
    Cells[1,0] := 'No SO';
    Cells[2,0] := 'No Container';
    Cells[3,0] := 'Item';
    Cells[4,0] := 'Qty';
    Cells[5,0] := 'Keterangan';
    Cells[6,0] := 'item_Id';
    Cells[7,0] := 'Pilih';

    ColWidths[0] := 100;
    ColWidths[1] := 100;
    ColWidths[2] := 100;
    ColWidths[3] := 200;
    ColWidths[4] := 50;
    ColWidths[5] := 150;
    ColWidths[6] := 0;
    ColWidths[7] := 30;

    ColumnSize.StretchColumn := 5;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarItemFails.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin

    btnFind.Click;
  end;
end;

procedure TFDaftarItemFails.FormShow(Sender: TObject);
begin


  TampilanAwal;
  LoadGrid(' WHERE f.qty_failed > 0 ');
end;

procedure TFDaftarItemFails.LoadGrid(Filter: String);
var
  i : integer;

begin
  CreateGrid;
    ExQry(Q1,getSQL('TableItemFails')+Filter+'',True);
      i := 0;
      sgBarang.RowCount := Q1.RecordCount + 1;
      while not Q1.Eof do begin
        with sgBarang do begin
             Cells[0,i+1] := GetVal(Q1,'tgl');
             Cells[1,i+1] := GetVal(Q1,'no_so');
             Cells[2,i+1] := GetVal(Q1,'nomer_container');
             Cells[3,i+1] := GetVal(Q1,'description');
             Cells[4,i+1] := GetValR(Q1,'qty_failed');

             Cells[5,i+1] := GetVal(Q1,'keterangan');
             Cells[6,i+1] := GetVal(Q1,'item_id');
             AddCheckBox(7,i+1,False,false);
             Inc(i);
           end;

           Q1.Next;


        end;


end;

procedure TFDaftarItemFails.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 7
end;

procedure TFDaftarItemFails.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarItemFails.TampilanAwal;
begin
  ClearText(Self);



end;

end.
