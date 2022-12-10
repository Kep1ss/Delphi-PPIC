unit uSettingAkes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,System.StrUtils, Vcl.Menus, Vcl.StdCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, Vcl.ImgList, uEngine, AdvUtil, System.ImageList,
  AdvSmoothButton, AdvSmoothPanel, uComCtrl,AdvGlowButton, Data.DB, MemDS,
  DBAccess, MyAccess;

type
  TFsetingAkses = class(TForm)
    il1: TImageList;
    pnl1: TAdvSmoothPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    pnl2: TAdvSmoothPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    L1: TLabel;
    L2: TLabel;
    pnl3: TAdvSmoothPanel;
    sg1: TAdvStringGrid;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Euser: TEdit;
    Elevel: TEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    cAkses: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTutupClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cAksesClick(Sender: TObject);
  private

    Procedure CreateGrid;
    { Private declarations }
  public
    { Public declarations }
    idUser      : string;
  end;

var
  FsetingAkses: TFsetingAkses;


implementation

{$R *.dfm}

uses uMainMenu, uMarCon;

procedure TFsetingAkses.btnSimpanClick(Sender: TObject);
var
  i : integer;
  cView  : Boolean;
  aList : TStringList;
begin
  aList := TStringList.Create;

  try
      ExQry(Q1,'delete from uac where iduser="'+iduser+'"',False);
      for I := 1 to sg1.RowCount -1 do begin
        sg1.GetCheckBoxState(1,i,cView);
        addParam('iduser',idUser,aList,'str');
        addParam('menu',Copy(sg1.Cells[0,i],1,Length(sg1.Cells[0,i])),aList,'str');
        addParam('active',IntTostr(Integer(cView)),aList,'str');
        exeDb(Q1,'uac',aList);
      end;
      Informasi('Seting berhasil disimpan');
  finally
    aList.Free;
  end;
end;

procedure TFsetingAkses.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFsetingAkses.cAksesClick(Sender: TObject);
var
  i : integer;
begin

  for i := 1 to sg1.RowCount -1 do begin
     sg1.SetCheckBoxState(1,i,cAkses.Checked);

  end;
end;

procedure TFsetingAkses.CreateGrid;
begin
  with sg1 do begin
    ColCount := 2;
    Cells[0,0] :='Menu';
    Cells[1,0] :='Active';
    ColWidths[0] := 150;
    ColWidths[1] := 200;
    ColumnSize.StretchColumn := 0;
    ColumnSize.Stretch       := True;
    RowCOunt :=2;
  end;
end;

procedure TFsetingAkses.FormCreate(Sender: TObject);

begin
  CreateGrid;
end;

function getRow(str:string):Integer;
var
  i : integer;
begin
  for i := 1 to FsetingAkses.sg1.RowCount -1 do begin
    if Pos(str,FsetingAkses.sg1.Cells[0,i]) > 0 then begin
      Result := i;
      Break;
    end else
    Result := 0;

    end;
end;
procedure TFsetingAkses.FormShow(Sender: TObject);
var
  i , d   : integer;

  isActive : Boolean;
begin

  sg1.RowCount := 2;
  d := 1;
  for i := 0 to FmainMenu.ComponentCount -1 do begin
     if FmainMenu.Components[i] is TAdvGlowButton then begin
        sg1.Cells[0,d] := TAdvGlowButton(FmainMenu.Components[i]).Caption;
        sg1.AddCheckBox(1,d,false,false);

        inc(d);
        sg1.RowCount := sg1.RowCount + 1;
     end;
  end;


  ExQry(Q1,'SELECT * FROM uac where iduser="'+iduser+'"',True);
  if not Q1.IsEmpty then begin
     for I := 1 to sg1.RowCount -1 do begin
       isActive := Q1.FieldByName('active').AsInteger = 1;
       if (Trim(GetVal(Q1,'menu')) =
        Trim(Copy(sg1.Cells[0,i],1,Length(sg1.Cells[0,i])))) then
        sg1.SetCheckBoxState(1,i,isActive);

        Q1.Next;
     end;
  end;


end;

procedure TFsetingAkses.sg1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if ACol = 1 then
     sg1.Options := sg1.Options + [goEditing]
  else
    sg1.Options := sg1.Options - [goEditing];
end;

end.
