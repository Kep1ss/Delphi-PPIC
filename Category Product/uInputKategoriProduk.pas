unit uInputKategoriProduk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, Data.DB, uEngine, MemDS, DBAccess,
  MyAccess;
type
  TFInputKategoriProduct = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    Label10: TLabel;
    EKategori: TAdvEdit;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
  private



    { Private declarations }
  public
     id : integer;
     procedure TampilanAwal;

    { Public declarations }
  end;

var
  FInputKategoriProduct: TFInputKategoriProduct;


implementation
  uses
     uDataCategoryProduct, uInputProduct, uMarCon;


{$R *.dfm}

{ TFinputKategori }

procedure TFInputKategoriProduct.btnSimpanClick(Sender: TObject);

begin
  if not CheckEdit(Self) then begin
     ExQry(Q1,'SELECT nama_category FROM category_product WHERE nama_category="'+Ekategori.Text+'"',True);
     if Q1.IsEmpty = False then begin
        Error('Nama kategori Sudah digunakan');
        exit;
     end
     else begin
         if id = 0 then
         ExQry(Q2,'INSERT INTO category_product (nama_category) '+
         ' VALUES("'+Ekategori.Text+'"',False)
         else
         ExQry(Q2,'UPDATE category_product SET nama_category="'+EKategori.Text+'" '+
         ' WHERE id="'+IntToStr(id)+'"',False);
         TampilanAwal;
         if Assigned(FDataCategoryProduct) then
         FDataCategoryProduct.LoadData('',
         StrToIntDef(FDataCategoryProduct.cbEntries.Text,10),
         0);
         if Assigned(FinputBarang) then
         isiCmb(FinputBarang.Q1,'category_product',['id','nama_category'],FinputBarang.cbKategori);
     end;

  end;

end;

procedure TFInputKategoriProduct.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFInputKategoriProduct.TampilanAwal;
begin
  ClearText(Self);
  id := 0;
end;

end.
