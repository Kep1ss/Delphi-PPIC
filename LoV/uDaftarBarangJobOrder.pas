unit uDaftarBarangJobOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, DBAccess, MyAccess, MemDS, DBAdvGrid;


type
  TFDaftarBarangJobOrder = class(TForm)
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
    DLoV: TMyDataSource;
    QLoV: TMyQuery;
    DBAdvGrid1: TDBAdvGrid;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBAdvGrid1DblClick(Sender: TObject);
    procedure DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private


    procedure TampilanAwal;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarBarangJobOrder: TFDaftarBarangJobOrder;


implementation



{$R *.dfm}

uses  uMarCon, uEngine, uInputJobOrder;

{ TFinputMotif }

procedure TFDaftarBarangJobOrder.btnFindClick(Sender: TObject);
begin
  ExQry(QLov,getSQL('TableProduct')+' WHERE (description LIKE "%'+Ecari.Text+'%" '+
  ' OR itemno LIKE "%'+Ecari.Text+'%" ) AND inventory_group=3',True);
end;

procedure TFDaftarBarangJobOrder.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFDaftarBarangJobOrder.DBAdvGrid1DblClick(Sender: TObject);
begin
  with FinputJobOrder do begin
     sg.Cells[0,sg.RowCount -1] := GetVal(QLov,'itemno');
     sg.Cells[1,sg.RowCount -1] := GetVal(QLov,'description');
     sg.Cells[2,sg.RowCount -1] := 'Unit';
     sg.Cells[3,sg.RowCount -1] := '1';
     ExQry(Q1,'SELECT SUM(cost)as totalcost FROM setting_process WHERE item_id="'+GetVal(QLov,'id')+'"',True);
     sg.Cells[4,sg.RowCount -1] := Format('%.2n',[GetValF(Q1,'totalcost')]);
     sg.Cells[5,sg.RowCount -1] := Format('%.2n',[GetValF(Q1,'totalcost') * CellF(sg.Cells[3,sg.RowCount -1])]);
     sg.Cells[6,sg.RowCount -1] := '';
     sg.Cells[7,sg.RowCount -1] := GetVal(QLov,'id');
     sg.Cells[8,sg.RowCount -1] := '0';

     sg.SetFocus;
     sg.RowCount        := sg.RowCount + 1;

  end;

  Close;
end;

procedure TFDaftarBarangJobOrder.DBAdvGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13  then
     DBAdvGrid1DblClick(Sender);
end;

procedure TFDaftarBarangJobOrder.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
     btnFind.Click;

  end;
end;

procedure TFDaftarBarangJobOrder.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;

end;

procedure TFDaftarBarangJobOrder.FormShow(Sender: TObject);
begin
  TampilanAwal;

end;

procedure TFDaftarBarangJobOrder.LoadGrid(Filter: String);

begin
  ExQry(QLov,getSQL('TableProduct')+' '+Filter,True);

end;

procedure TFDaftarBarangJobOrder.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' WHERE inventory_group=3 LIMIT 500');

end;

end.
