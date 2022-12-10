unit uInputUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, Data.DB, uEngine,
  MemDS, DBAccess, MyAccess;
type
  TFinputUser = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    Label10: TLabel;
    EuserName: TAdvEdit;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    Label1: TLabel;
    cbLevel: TAdvComboBox;
    Label2: TLabel;
    EPassword: TAdvEdit;
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
  FinputUser: TFinputUser;


implementation
  uses
      uMarCon, uDataUser;


{$R *.dfm}

{ TFinputKategori }

procedure TFinputUser.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin

     if id = 0 then begin

       ExQry(Q1,'SELECT user_name FROM user_login WHERE user_name="'+EuserName.Text+'"',True);

       if Q1.isEmpty = False then begin
          Error('Nama user_name Sudah digunakan');
          exit;
       end
     end ;


         ls := TStringList.Create;

         try
             addParam('user_name',    EuserName.Text, ls, 'str');
             addParam('user_level',    cbLevel.Text, ls, 'str');
             addParam('password',    EPassword.Text, ls, 'pwd');
             if id = 0 then
                ExeDB(Q1,'user_login',ls)
             else
                updatedb(Q1,'user_login',ls,'id',IntToStr(Id));

         
             TampilanAwal;
             if Assigned(FDataUser) then
             FDataUser.LoadData('',
             StrToIntDef(FDataUser.cbEntries.Text,10),
             0);

         finally
           ls.Free;
         end;


  end;

end;

procedure TFinputUser.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputUser.TampilanAwal;
begin
  ClearText(Self);
  id := 0;
 
end;

end.
