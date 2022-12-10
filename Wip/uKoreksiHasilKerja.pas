unit uKoreksiHasilKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uComCtrl,uEngine, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxButtons, AdvEdit, Data.DB, MemDS,
  DBAccess, MyAccess;

type
  TFKoreksiInputHasilKerja = class(TForm)
    EQtyLama: TAdvEdit;
    Label1: TLabel;
    EQtyBaru: TAdvEdit;
    Label2: TLabel;
    btnSimpan: TcxButton;
    cxButton1: TcxButton;
    Q1: TMyQuery;
    procedure btnSimpanClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idDetail : String;
  end;

var
  FKoreksiInputHasilKerja: TFKoreksiInputHasilKerja;

implementation

uses

  uDataWip,uMarCon;
{$R *.dfm}

procedure TFKoreksiInputHasilKerja.btnSimpanClick(Sender: TObject);
begin
  ExQry(Q1,'UPDATE detail_hasil_kerja SET qty="'+StrToDecimal(EQtyBaru.Text)+'" '+
  ' WHERE id="'+idDetail+'"',False);

  if Assigned(FDataWIP) then begin
    FDataWIP.sg1DblClick(Sender);
    FDataWIP.sgDblClick(Sender);
  end;

  Informasi('Data Berhasil diupdate');
  idDetail := '';
  ClearText(Self);
  Close;

end;

procedure TFKoreksiInputHasilKerja.cxButton1Click(Sender: TObject);
begin
  idDetail := '';
  ClearText(Self);
  CLose;
end;

end.
