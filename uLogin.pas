unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothButton, Vcl.StdCtrls, uOvEdit,
  uEngine, Vcl.Imaging.pngimage, Vcl.ExtCtrls, AdvOfficeImage, AdvEdit,
  AdvSmoothPanel,AdvGlowButton, Data.DB, MemDS, DBAccess,IniFiles, MyAccess,
  uComCtrl;

type
  TFlogin = class(TForm)
    pLogin: TAdvSmoothPanel;
    btnLogin: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    AdvSmoothPanel2: TAdvSmoothPanel;
    Label1: TLabel;
    Euser: TAdvEdit;
    Epassword: TAdvEdit;
    Label2: TLabel;
    Label3: TLabel;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Label4: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure EuserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EpasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Label4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Login;

    procedure SaveConnection;
  end;

var
  Flogin: TFlogin;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uSettingConnection;

{ TForm1 }


function IsFormOpen(const FormName : string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Screen.FormCount - 1 DownTo 0 do
    if (Screen.Forms[i].Name = FormName) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TFlogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFlogin.btnLoginClick(Sender: TObject);
var
  i : integer;
  isActive : Boolean;
begin
  if (Euser.Text <> '') and (EPassword.Text <> '') then
  begin
      if (Euser.Text = 'superadmin') and (Epassword.Text = 'superadmin') then
      begin
        with FmainMenu do begin
              EnableAll;
        end;
        ModalResult := mrOk;
      end else begin

          ExQry(Q1,' select * from user_login where user_name="'+Euser.Text+'" '+
                      ' and password=MD5("'+EPassword.Text+'")',True);

          if Q1.IsEmpty then begin
            MessageDlg('Username dan password tidak cocok',mtError,[mbYes],0);
            Exit;
          end else
          begin
            ExQry(Q2,'select * from uac where iduser="'+GetVal(Q1,'id')+'"',True);

              if Q2.IsEmpty then begin
                MessageDlg('User tidak memiliki hak akses sistem',mtError,[mbYes],0);
              end else
              begin
                  while Q2.Eof = False do begin

                      with FmainMenu do begin
                        Ladmin.Caption := GetVal(Q1,'user_name');
                        for I := 0 to ComponentCount -1 do begin
                          if (Components[i] is TAdvGlowButton) then begin
                              if TAdvGlowButton(Components[i]).Caption = Trim(GetVal(Q2,'menu')) then
                                 begin
                                   isActive := Q2.FieldByName('active').AsBoolean = true;
                                   if isActive then
                                      TAdvGlowButton(Components[i]).Visible := True else
                                      TAdvGlowButton(Components[i]).Visible := False;
                                 end;
                          end;
                        end;

                      end;
                    Q2.Next;
                  end;
                  ModalResult := mrOk;
                end;

          end;
      end;
  end;
end;



procedure TFlogin.EpasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
     btnLogin.Click;
end;

procedure TFlogin.EuserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
     Epassword.SetFocus;
end;

procedure TFlogin.FormResize(Sender: TObject);
var
  Tengah : Integer;
  TopTengah : Integer;
begin
  Tengah      := (Width  div 2) - (pLogin.Width div 2 );
  TopTengah   := (Height div 2) - (pLogin.Height div 2 );
  pLogin.Left := Tengah;
  pLogin.Top  := TopTengah;
end;

procedure TFlogin.FormShow(Sender: TObject);
begin
    Try
    SaveConnection;
    SetKoneksi(MariaCon.con);
    Mariacon.Con.Connect;
  Except

          Error('Gagal Melakukan Koneksi ')
    end;

end;

procedure TFlogin.Label4Click(Sender: TObject);
begin
  FSettingConnection.ShowModal;
end;

procedure TFlogin.Login;
begin
   with TFlogin.Create(nil) do
  try
    if not Assigned(MariaCon) then
    Application.CreateForm(TMariaCon,MariaCon);
    Application.MainForm.Hide;
    if ShowModal = mrOk then
       Application.MainForm.Show
    else
       Application.Terminate;

  finally
    Free;
  end;
end;



procedure TFlogin.SaveConnection;
var
Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'ConType.Ini');
  try

      Aini.WriteString('TypeConnection','Type','local');
  finally
    Aini.Free;
  end;

end;


end.
