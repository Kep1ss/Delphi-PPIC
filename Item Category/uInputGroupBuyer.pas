unit uInputGroupBuyer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, Data.DB, uEngine,
  MemDS, DBAccess, MyAccess;
type
  TFinputGroupBuyer = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    Label10: TLabel;
    EKategori: TAdvEdit;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
  private


    { Private declarations }
  public
    id : Integer;
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FinputGroupBuyer: TFinputGroupBuyer;


implementation
  uses
     uDataBuyer, uInputProduct, uMarCon;


{$R *.dfm}

{ TFinputKategori }

procedure TFinputGroupBuyer.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin

     ExQry(Q1,'SELECT buyer_name FROM category_buyer WHERE buyer_name="'+Ekategori.Text+'"',True);

     if Q1.isEmpty = False then begin
        Error('Nama Buyer Sudah digunakan');
        exit;
     end
     else begin

         ls := TStringList.Create;

         try
             addParam('buyer_name',    Ekategori.Text, ls, 'str');
             if id = 0 then
                ExeDB(Q1,'category_buyer',ls)
             else
                updatedb(Q1,'category_buyer',ls,'id',IntToStr(Id));

         
             TampilanAwal;
             if Assigned(FDataBuyer) then
             FDataBuyer.LoadData('',
             StrToIntDef(FDataBuyer.cbEntries.Text,10),
             0);
             if Assigned(FinputBarang) then
             isiCmb(FinputBarang.Q1,'category_buyer',['id','buyer_name'],FinputBarang.cbBuyer);
         finally
           ls.Free;
         end;
     end;

  end;

end;

procedure TFinputGroupBuyer.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputGroupBuyer.TampilanAwal;
begin
  ClearText(Self);
  id := 0;
 
end;

end.
