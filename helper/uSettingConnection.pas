unit uSettingConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine, IniFIles,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, MemDS, DBAccess, MyAccess, AdvOfficeButtons;
type
  TFSettingConnection = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    rbLocal: TAdvOfficeRadioButton;
    rbOnline: TAdvOfficeRadioButton;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private





    { Private declarations }
  public
    procedure TampilanAwal;
    procedure SaveConnection;

    { Public declarations }
  end;

var
  FSettingConnection: TFSettingConnection;


implementation
  uses
    uDataDivisi, uMarCon;


{$R *.dfm}

{ TFInputSupplier }




procedure TFSettingConnection.btnSimpanClick(Sender: TObject);


begin
  Try
    SaveConnection;
    SetKoneksi(MariaCon.con);
    Mariacon.Con.Connect;
    ShowMessage('Koneksi Berhasil');
  Except
    begin
       if RbLocal.Checked then
          Error('Gagal Melakukan Koneksi '+RbLocal.Caption)
       else
          Error('Gagal Melakukan Koneksi '+RbOnline.Caption);
    end;

  End;
end;

procedure TFSettingConnection.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFSettingConnection.FormShow(Sender: TObject);
begin
  rbLocal.Checked  := ConnectionType = 'local';
  rbOnline.Checked := ConnectionType = 'online';

end;

procedure TFSettingConnection.SaveConnection;
var
Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'ConType.Ini');
  try
      if rbLocal.Checked then

      Aini.WriteString('TypeConnection','Type','local') else
      Aini.WriteString('TypeConnection','Type','online')
  finally
    Aini.Free;
  end;

end;

procedure TFSettingConnection.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFSettingConnection.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFSettingConnection.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFSettingConnection.TampilanAwal;
begin
  ClearText(Self);
end;

end.
