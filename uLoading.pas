unit uLoading;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothProgressBar, AdvSmoothPanel,
  Vcl.StdCtrls;

type
  TFloading = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    pgbar: TAdvSmoothProgressBar;
    Lprocess: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Floading: TFloading;

implementation

{$R *.dfm}

end.
