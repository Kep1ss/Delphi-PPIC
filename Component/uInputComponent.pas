unit uInputComponent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, MemDS, DBAccess, MyAccess;
type
  TFinputComponent = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EnoBarang: TAdvEdit;
    EnamaBarang: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
  private






    { Private declarations }
  public

      procedure TampilanAwal;
    { Public declarations }
  end;

var
  FinputComponent: TFinputComponent;


implementation
  uses
    uDataComponent,uInputKategori, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputComponent.AdvSmoothButton3Click(Sender: TObject);
begin
  FinputKategori.ShowModal;
end;

procedure TFinputComponent.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin
     ls := TStringList.Create;

     try

       AddParam('itemno', EnoBarang.Text, ls ,'str');
       AddParam('description', EnamaBarang.Text, ls ,'str');
       AddParam('item_type', '0', ls ,'str');
       AddParam('item_category', '140', ls ,'str');
       ExQry(Q2,'SELECT id FROM item WHERE itemno="'+ENoBarang.Text+'"',True);

       if Q2.IsEmpty then
          ExeDb(Q1,'item',ls)
       else
          UpdateDB(Q1,'item',ls,'id',GetVal(Q2,'id'));

       TampilanAwal;
       if Assigned(FDataComponent) then
       FDataComponent.LoadData('',
       StrToIntDef(FDataComponent.cbEntries.Text,10),
       0);
     finally
       ls.Free;
     end;


  end;
end;

procedure TFinputComponent.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputComponent.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputComponent.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputComponent.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputComponent.TampilanAwal;
begin
  ClearText(Self);
  ENoBarang.Text :=  GetCode(Q1,'item','itemno','CM');
end;

end.
