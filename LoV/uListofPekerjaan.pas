unit uListofPekerjaan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarPekerjaan = class(TForm)
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
  private


    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isForm : integer;
    procedure LoadGrid(Filter:String);
    procedure TampilanAwal;
  end;

var
  FDaftarPekerjaan: TFDaftarPekerjaan;


implementation



{$R *.dfm}

uses uInputBom, uMarCon;

{ TFinputMotif }

procedure TFDaftarPekerjaan.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (deskripsi LIKE "%'+Ecari.Text+'%" and '+
  ' id_divisi="'+IntToStr(FinputBom.lb1.Items[FinputBom.lb1.SelectedItemIndex].indent)+'")');
end;

procedure TFDaftarPekerjaan.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarPekerjaan.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 5;
    RowCount := 2;

    Cells[0,0] := 'No';
    Cells[1,0] := 'Divisi';
    Cells[2,0] := 'Pekerjaan';
    Cells[3,0] := 'Biaya';
    Cells[4,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 120;
    ColWidths[2] := 250;
    ColWidths[3] := 80;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarPekerjaan.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;

procedure TFDaftarPekerjaan.LoadGrid(Filter: String);
var
  i : integer;
begin
  CreateGrid;

      ExQry(Q1,getSQL('TableJobs')+ Filter,True);

      for I := 0 to Q1.RecordCount -1 do begin
        sgBarang.RowCount     := sgBarang.RowCount + 1;
        sgBarang.Cells[0,i+1] := IntToStr(i+1);
        sgBarang.Cells[1,i+1] := GetVal(Q1,'name');
        sgBarang.Cells[2,i+1] := GetVal(Q1,'deskripsi');
        sgBarang.Cells[3,i+1] := GetValR(Q1,'biaya');
        sgBarang.Cells[4,i+1] := GetVal(Q1,'id');
        Q1.Next;
      end;

end;

procedure TFDaftarPekerjaan.sgBarangDblClick(Sender: TObject);

begin

  case isForm of
  1 : begin
        With FinputBom do begin
         sgPekerjaan.Cells[0,sgPekerjaan.RowCount -1] := sgBarang.Cells[2,sgBarang.Row];
         sgPekerjaan.Cells[1,sgPekerjaan.RowCount -1] := '1';
         sgPekerjaan.Cells[2,sgPekerjaan.RowCount -1] := 'Set';
         sgPekerjaan.Cells[3,sgPekerjaan.RowCount -1] := sgBarang.Cells[3,sgBarang.Row];
         sgPekerjaan.Cells[4,sgPekerjaan.RowCount -1] := sgBarang.Cells[3,sgBarang.Row];
         sgPekerjaan.Cells[5,sgPekerjaan.RowCount -1] := sgBarang.Cells[4,sgBarang.Row];

         sgPekerjaan.SetFocus;
         sgPekerjaan.Col    := 1;

        end;
      end;
  end;

  Close;
end;


procedure TFDaftarPekerjaan.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarPekerjaan.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' ');

end;

end.
