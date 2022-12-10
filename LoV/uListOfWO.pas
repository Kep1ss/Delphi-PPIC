unit uListOfWO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uEngine;


type
  TFDaftarWO = class(TForm)
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
    QM1: TZQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgWoDblClick(Sender: TObject);
    procedure sgWoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    yDB       : TYDb;
    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarWO: TFDaftarWO;


implementation



{$R *.dfm}

uses  uMarCon,uInputMaterialRelease;



{ TFinputMotif }

procedure TFDaftarWO.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (w.deskripsi LIKE "%'+Ecari.Text+'%")');
end;

procedure TFDaftarWO.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarWO.CreateGrid;
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

procedure TFDaftarWO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  yDB.Free;
end;

procedure TFDaftarWO.FormShow(Sender: TObject);
begin

  yDB := TYDb.Create(MariaCon.ZMy);
  QM1.Connection := yDB.Conn;
  TampilanAwal;
end;

procedure TFDaftarWO.LoadGrid(Filter: String);
var
  i : integer;


begin
  CreateGrid;
  yDB.SQL := getSQL('DaftarWorkOrder');
  yDB.ExQuery;

  for i := 0 to yDB.DataCount -1 do begin
    sgWo.Cells[0,i+1] := yDB.ValString('no_wo');
    sgWo.Cells[1,i+1] := yDB.ValString('no_container');
    sgWo.Cells[2,i+1] := yDB.ValString('deskripsi');
    sgWo.Cells[3,i+1] := yDB.ValString('id');
    yDB.NextRec;
  end;

end;

procedure TFDaftarWO.sgWoDblClick(Sender: TObject);


begin
  With FinputMaterialRelease do begin
       EnoWO.Text       := sgWo.Cells[0,sgWo.Row];
       EDeskripsi.Text  := sgWo.Cells[1,sgWo.Row];




  end;
  Close;
end;


procedure TFDaftarWO.sgWoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgWo.OnDblClick(Sender);

end;

procedure TFDaftarWO.TampilanAwal;
begin
  ClearText(Self);
  Fid := 0;
  LoadGrid(' ');


end;

end.
