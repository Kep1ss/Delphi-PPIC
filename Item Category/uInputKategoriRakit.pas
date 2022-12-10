unit uInputKategoriRakit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, Data.DB, uEngine,
  MemDS, DBAccess, MyAccess;
type
  TFinputKategoriRakit = class(TForm)
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
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FinputKategoriRakit: TFinputKategoriRakit;


implementation
  uses
      uInputProduct, uMarCon, uDataCategoryRakit;


{$R *.dfm}

{ TFinputKategori }

procedure TFinputKategoriRakit.btnSimpanClick(Sender: TObject);

begin
  if not CheckEdit(Self) then begin
      ExQry(Q1,'SELECT deskripsi FROM category_rakit WHERE nama_category="'+Ekategori.Text+'"',True);
     if Q1.IsEmpty = False then begin
        Error('Nama kategori Sudah digunakan');
        exit;
     end
     else begin
         ExQry(Q2,'INSERT INTO category_rakit (deskripsi) '+
         ' VALUES("'+Ekategori.Text+'"',False);
         TampilanAwal;


         if Assigned(FDataCategoryRakit) then
         FDataCategoryRakit.LoadData('',
         StrToIntDef(FDataCategoryRakit.cbEntries.Text,10),
         0);

     end;

  end;

end;

procedure TFinputKategoriRakit.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputKategoriRakit.TampilanAwal;
begin
  ClearText(Self);
 
end;

end.
