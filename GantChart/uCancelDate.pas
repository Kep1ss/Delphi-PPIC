unit uCancelDate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothButton, Vcl.ComCtrls,
  Vcl.StdCtrls, AdvEdit, AdvSmoothPanel, Data.DB, MemDS, DBAccess, MyAccess;

type
  TFCancelDate = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    EGCCode: TAdvEdit;
    Label4: TLabel;
    DtCancel: TDateTimePicker;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnSimpanClick(Sender: TObject);
    procedure btnTutupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCancelDate: TFCancelDate;

implementation

{$R *.dfm}

uses uMarCon, uComCtrl, uScheduleChart;

procedure TFCancelDate.btnSimpanClick(Sender: TObject);
begin
  with Q1 do begin
    Close;
    SQL.Text := 'UPDATE gantt_chart SET cancel_date="'+Tanggal(DtCancel.Date)+'" '+
    ' WHERE code="'+EGCCode.Text+'"';
    ExecSQL;
  end;

  FGrafikJadwal.CreateGrid;
  FGrafikJadwal.CreateChart(StrToIntDef(FGrafikJadwal.cbPage.Text,0));;;
end;

procedure TFCancelDate.btnTutupClick(Sender: TObject);
begin
  Close;
end;

end.
