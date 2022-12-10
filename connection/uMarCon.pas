unit uMarCon;

interface

uses
  System.SysUtils,Windows, System.Classes, uEngine, Memdata,Data.DB, DBAccess, MyAccess,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type
  TMariaCon = class(TDataModule)
    con: TMyConnection;
    QCon: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MariaCon: TMariaCon;
  RetryCount: Integer;
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TMariaCon.DataModuleCreate(Sender: TObject);
begin
   SetKoneksi(MariaCon.Con);
   QCon.Params.DriverID := 'SQLite';
   QCon.Params.Database := ExtractFilePath(ParamStr(0))+'jadwal.db';
end;

end.
