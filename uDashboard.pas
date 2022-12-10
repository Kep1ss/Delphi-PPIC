unit uDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, acPNG, Vcl.ExtCtrls, Vcl.StdCtrls,
  AdvSmoothPanel, VclTee.TeeGDIPlus, Data.DB, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, uEngine, uComCtrl, MemDS,
  DBAccess, MyAccess,DateUtils, AdvScrollBox;

type
  TFDashboard = class(TForm)
    Gp: TGridPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    AdvSmoothPanel4: TAdvSmoothPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    AdvSmoothPanel5: TAdvSmoothPanel;
    AdvSmoothPanel7: TAdvSmoothPanel;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    QworkPlans: TMyQuery;
    DchartWorkPlans: TMyDataSource;
    Q4: TMyQuery;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Lorders: TLabel;
    Lfinished: TLabel;
    Lprogress: TLabel;
    Label10: TLabel;
    LjobOrders: TLabel;
    Lplanned: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Lunplanned: TLabel;
    Label8: TLabel;
    LworkPlans: TLabel;
    LworkFinish: TLabel;
    LworkFinishss: TLabel;
    LworkProgressss: TLabel;
    LworkProgress: TLabel;
    Label9: TLabel;
    LwrTotalSalry: TLabel;
    LwrWorkResult: TLabel;
    LwrPlusminus: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    QworkResult: TMyQuery;
    DworkResult: TMyDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadDashboard;
  end;

var
  FDashboard: TFDashboard;

implementation

{$R *.dfm}

uses uMarCon;

procedure TFDashboard.FormCreate(Sender: TObject);
begin
  FDashboard := Self;
end;

procedure TFDashboard.FormShow(Sender: TObject);
begin
  LoadDashboard;
end;

procedure TFDashboard.LoadDashboard;
var
  varOrders , varFinished, varProgress : Real;
  varJobOrder , varPlanned, varUnPlanned : Real;
  varTotalSalary, varWorkResult, varPlusMinus : Real;
begin
  ExQry(Q1,'SELECT SUM(jumlah) as varOders FROM detail_sales_order',True);
  varOrders := GetValF(Q1,'varOders');
  ExQry(Q1,'SELECT SUM(jumlah) as varFinished FROM detail_sales_order '+
  ' WHERE shipped=true',True);
  varFinished := GetValF(Q1,'varFinished');

  varProgress := varOrders - varFinished;

  Lorders.Caption := Format('%.0n',[varOrders]);
  Lprogress.Caption := Format('%.0n',[varProgress]);
  Lfinished.Caption := Format('%.0n',[varFinished]);

  ExQry(Q1,'SELECT COUNT(id) as varJobOrder FROM master_job_order',True);
  varJobOrder := GetValF(Q1,'varJobOrder');
  ExQry(Q1,'SELECT                         '+
           '     COUNT(id) as varUnPlanned                 '+
           '   FROM                        '+
           '     master_job_order          '+
           '   WHERE no_input NOT IN       '+
           '     (SELECT                   '+
           '       no_job_order             '+
           '     FROM                       '+
           '       rencana_kerja_detail)',True);
  varUnPlanned := GetValF(Q1,'varUnPlanned');

  varPlanned := varJobOrder - varUnPlanned;

  LjobOrders.Caption := Format('%.0n',[varJobOrder]);
  Lunplanned.Caption := Format('%.0n',[varUnPlanned]);
  Lplanned.Caption := Format('%.0n',[varPlanned]);

  ExQry(Q1,'SELECT                                             '+
           '     SUM(                                          '+
           '       ((gaji / 200) * jml_tenaga_kerja) + lembur  '+
           '     ) as varTotalSalary,                          '+
           '    SUM(hasil_kerja/200) as varWorkResult,         '+
           '    SUM(plus_minus/200) as  varPlusMinus           '+
           '   FROM                                            '+
           '     rencana_kerja                                 '+
           '   WHERE MONTH(tgl) = MONTH(CURDATE())             '+
           '     AND YEAR(tgl) = YEAR(CURDATE()) ',True);
  varTotalSalary := GetValF(Q1,'varTotalSalary');
  varWorkResult  := GetValF(Q1,'varWorkResult');
  varPlusMinus   := GetValF(Q1,'varPlusMinus');

  LworkPlans.Caption := Format('%.0n',[varTotalSalary]);
  LworkFinish.Caption := Format('%.0n',[varWorkResult]);
  LworkProgress.Caption := Format('%.0n',[varPlusMinus]);



  ExQry(Q1,'SELECT                                             '+
           '     SUM(                                          '+
           '       ((gaji / 200) * jml_tenaga_kerja) + lembur  '+
           '     ) as varTotalSalary,                          '+
           '    SUM(hasil_kerja/200) as varWorkResult,         '+
           '    SUM(plus_minus/200) as  varPlusMinus           '+
           '   FROM                                            '+
           '     hasil_kerja                                 '+
           '   WHERE MONTH(tgl) = MONTH(CURDATE())             '+
           '     AND YEAR(tgl) = YEAR(CURDATE()) ',True);
  varTotalSalary := GetValF(Q1,'varTotalSalary');
  varWorkResult  := GetValF(Q1,'varWorkResult');
  varPlusMinus   := GetValF(Q1,'varPlusMinus');

  LwrTotalSalry.Caption := Format('%.0n',[varTotalSalary]);
  LwrWorkResult.Caption := Format('%.0n',[varWorkResult]);
  LwrPlusminus.Caption  := Format('%.0n',[varPlusMinus]);

  ExQry(QworkResult,'SELECT                                            '+
                    '      tgl,                                        '+
                    '      SUM(hasil_kerja / 200) AS varWorkResult     '+
                    '    FROM                                          '+
                    '      hasil_kerja                                 '+
                    '    WHERE MONTH(tgl) = MONTH(CURDATE())           '+
                    '      AND YEAR(tgl) = YEAR(CURDATE()) GROUP BY tgl ',True);

  ExQry(QworkPlans,'SELECT                                            '+
                    '      tgl,                                        '+
                    '      SUM(hasil_kerja / 200) AS varWorkResult     '+
                    '    FROM                                          '+
                    '      rencana_kerja                                 '+
                    '    WHERE MONTH(tgl) = MONTH(CURDATE())           '+
                    '      AND YEAR(tgl) = YEAR(CURDATE()) GROUP BY tgl ',True);


end;

end.
