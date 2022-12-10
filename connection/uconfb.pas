unit uconfb;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection;

type
  Tconfb = class(TDataModule)
    zfb: TZConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  confb: Tconfb;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
