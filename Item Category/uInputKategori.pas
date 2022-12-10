unit uInputKategori;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, Data.DB, uEngine,
  MemDS, DBAccess, MyAccess;
type
  TFinputKategori = class(TForm)
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
  FinputKategori: TFinputKategori;


implementation
  uses
     uDataCategory, uInputProduct, uMarCon;


{$R *.dfm}

{ TFinputKategori }

procedure TFinputKategori.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin

     ExQry(Q1,'SELECT name FROM category WHERE name="'+Ekategori.Text+'"',True);

     if Q1.isEmpty = False then begin
        Error('Nama kategori Sudah digunakan');
        exit;
     end
     else begin

         ls := TStringList.Create;

         try
             addParam('name',    Ekategori.Text, ls, 'str');
             if id = 0 then
                ExeDB(Q1,'category',ls)
             else
                updatedb(Q1,'category',ls,'id',IntToStr(Id));

         
             TampilanAwal;
             if Assigned(FDataCategory) then
             FDataCategory.LoadData('',
             StrToIntDef(FDataCategory.cbEntries.Text,10),
             0);
             if Assigned(FinputBarang) then
             isiCmb(FinputBarang.Q1,'category',['id','name'],FinputBarang.cbKategori);
         finally
           ls.Free;
         end;
     end;

  end;

end;

procedure TFinputKategori.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputKategori.TampilanAwal;
begin
  ClearText(Self);
  id := 0;
 
end;

end.
