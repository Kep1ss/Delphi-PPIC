unit uInputMaterial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, MemDS, DBAccess, MyAccess;
type
  TFinputMaterial = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EnoBarang: TAdvEdit;
    EnamaBarang: TAdvEdit;
    cbKategori: TAdvComboBox;
    AdvSmoothButton3: TAdvSmoothButton;
    EHargaJual: TAdvEdit;
    EDiskon: TAdvEdit;
    Label12: TLabel;
    EhargaPokok: TAdvEdit;
    Label13: TLabel;
    Estok: TAdvEdit;
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

    id : String;
    procedure TampilanAwal;
    { Public declarations }
  end;

var
  FinputMaterial: TFinputMaterial;


implementation
  uses
    uInputKategori, uDataMaterial, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputMaterial.AdvSmoothButton3Click(Sender: TObject);
begin
  FinputKategori.ShowModal;
end;

procedure TFinputMaterial.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;

begin
  if not CheckEdit(Self) then begin

       ls := TStringList.Create;

       try

           addParam('itemno', EnoBarang.Text,ls,'str');
           addParam('description', EnamaBarang.Text,ls,'str');
           addParam('item_type', '0',ls,'str');
           if cbKategori.ItemIndex <> - 1 then
           addParam('item_category', GetIdcmb(cbKategori),ls,'str');
           addParam('stok', StrToDecimal(Estok.Text),ls,'str');
           addParam('unit_price', StrToDecimal(EHargaJual.Text),ls,'str');
           addParam('cost', StrToDecimal(EhargaPokok.Text),ls,'str');
           addParam('discount', StrToDecimal(EDiskon.Text),ls,'str');
           addParam('inventory_group', '0',ls,'str');

           ExQry(Q1,'SELECT id FROM item WHERE id="'+id+'"',True);

           if Q1.IsEmpty then
            ExeDB(Q1,'item',ls)
           else
            UpdateDB(Q2,'item',ls,'id',GetVal(Q1,'id'));


         TampilanAwal;
         if Assigned(FDataMaterial) then
         FDataMaterial.LoadData('',
         StrToIntDef(FDataMaterial.cbEntries.Text,10),
         0);
       finally
         ls.Free;
       end;
  end;
end;

procedure TFinputMaterial.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputMaterial.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputMaterial.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputMaterial.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputMaterial.TampilanAwal;
begin
  ClearText(Self);
  id := '';

end;

end.
