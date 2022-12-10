unit uPilihPeriode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFPilihPeriode = class(TForm)
    Label1: TLabel;
    dt1: TDateTimePicker;
    Label2: TLabel;
    dt2: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPilihPeriode: TFPilihPeriode;

implementation
uses
  uJadwalDivisi;

{$R *.dfm}

procedure TFPilihPeriode.Button1Click(Sender: TObject);
begin
  FJadwalDivisi.PrintReport := True;
  FJadwalDivisi.DtReport1 := dt1.Date;
  FJadwalDivisi.DtReport2 := dt2.Date;

  Close;
end;

procedure TFPilihPeriode.Button2Click(Sender: TObject);
begin
  FJadwalDivisi.PrintReport := False;
  Close;
end;

procedure TFPilihPeriode.FormShow(Sender: TObject);
begin
  dt1.Date := now;
  dt2.Date := now;

end;

end.
