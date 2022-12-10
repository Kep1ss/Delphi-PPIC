unit uDataWOWip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDataWOWip = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgWo: TAdvStringGrid;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgWoDblClick(Sender: TObject);
    procedure sgWoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
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
  FDataWOWip: TFDataWOWip;


implementation



{$R *.dfm}

uses  uMarCon,uInputWIP;



{ TFinputMotif }

procedure TFDataWOWip.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (w.deskripsi LIKE "%'+Ecari.Text+'%")');
end;

procedure TFDataWOWip.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDataWOWip.CreateGrid;
begin
  with sgWo do begin
    ClearAll;

    ColCount := 4;
    RowCount := 2;

    Cells[0,0] := 'NO WO';
    Cells[1,0] := 'Container';
    Cells[2,0] := 'Keterangan';
    Cells[3,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 100;
    ColWidths[2] := 200;
    ColWidths[3] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDataWOWip.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;

procedure TFDataWOWip.LoadGrid(Filter: String);
var
  i : integer;


begin
  CreateGrid;
  Exqry(Q1, getSQL('DaftarWorkOrder'),True);
  sgWO.RowCount := Q1.RecordCount + 1;
  for i := 0 to Q1.RecordCount -1 do begin
    sgWo.Cells[0,i+1] := GetVal(Q1,'no_wo');
    sgWo.Cells[1,i+1] := GetVal(Q1,'no_container');
    sgWo.Cells[2,i+1] := GetVal(Q1,'deskripsi');
    sgWo.Cells[3,i+1] := GetVal(Q1,'id');
    Q1.Next;
  end;

end;

procedure TFDataWOWip.sgWoDblClick(Sender: TObject);
var
  i : integer;
begin
  With FinputProgress do begin
       EnoWO.Text       := sgWo.Cells[0,sgWo.Row];
       Econtainer.Text  := sgWo.Cells[1,sgWo.Row];

       ExQry(Q1, getSQL('DaftarJOBSWo')+' WHERE wj.id_wo="'+sgWo.Cells[3,sgWo.Row]+'"',True);

       cbNoSo.Items.Clear;

       for I := 0 to Q1.RecordCount -1 do begin
          cbNoSo.Items.Add(GetVal(Q1,'so_no'));
          Q1.Next;
       end;
       cbNoSo.ItemIndex := 0;
       cbNoSo.OnChange(Sender);

  end;
  Close;
end;


procedure TFDataWOWip.sgWoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgWo.OnDblClick(Sender);

end;

procedure TFDataWOWip.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' ');


end;

end.
