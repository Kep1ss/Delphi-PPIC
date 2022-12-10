unit uLapHasilKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB,  frxClass, frxDBSet, frxPreview, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;

type
  TFLapHasilKerja = class(TForm)
    Label1: TLabel;
    P1: TAdvSmoothPanel;
    DHasilKerja: TDataSource;
    frxReport1: TfrxReport;
    frHasilKerja: TfrxDBDataset;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label2: TLabel;
    dt1: TDateTimePicker;
    Label3: TLabel;
    dt2: TDateTimePicker;
    Label4: TLabel;
    cbDivisi: TAdvComboBox;
    AdvSmoothButton4: TAdvSmoothButton;
    frxPreview1: TfrxPreview;
    AdvSmoothButton1: TAdvSmoothButton;
    QHasilKerja: TMyQuery;
    Q1: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }


  end;



var
  FLapHasilKerja: TFLapHasilKerja;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputRencanaKerja;




procedure TFLapHasilKerja.AdvSmoothButton1Click(Sender: TObject);
var
  FilterDivisi : String;
begin

  if cbDivisi.ItemIndex = -1 then begin
     Error('Divisi belum dipilih');
     Exit
  end;

  if cbDivisi.ItemIndex >= 1 then
     FilterDivisi := ' AND r.divisi_process="'+GetIdcmb(cbDivisi)+'" '
  else
     FilterDivisi := '';
  ExQry(QHasilKerja,'SELECT * FROM (SELECT                                                   '+
                    '            `r`.`tgl` AS `tgl`,                                         '+
                    '            `r`.`nomer` AS `nomer`,                                     '+
                    '            `r`.`id_divisi` AS `id_divisi`,                             '+
                    '            `d`.`name` AS `divisi_process`,                             '+
                    '            SUM(`r`.`jml_tenaga_kerja`) AS `jml_tenaga_kerja`,          '+
                    '            SUM(`r`.`gaji`) AS `gaji`,                                  '+
                    '            SUM(`r`.`lembur`) AS `lembur`,                              '+
                    '            SUM(`r`.`total_gaji`) AS `total_gaji`,                      '+
                    '            SUM(`r`.`hasil_kerja`) AS `hasil_kerja`,                    '+
                    '            SUM(r.hasil_kerja - r.total_gaji) AS `plus_minus`,          '+
                    '            SUM(                                                        '+
                    '              (`r`.hasil_kerja - r.total_gaji) / `r`.`total_gaji`       '+
                    '            ) AS `prosentase`,                                          '+
                    '            `r`.`divisi_process` AS `divisi_pengerjaan`,                '+
                    '            `dp`.`name` AS `name`,                                      '+
                    '            `rk`.`no_so` AS `no_so`,                                    '+
                    '            `rk`.`no_container` AS `no_container`,                      '+
                    '            `rk`.`item_id` AS `item_id`,                                '+
                    '           `i`.`itemno` AS `itemno`,                                    '+
                    '            `i`.`description` AS `description`,                         '+
                    '            SUM(`rk`.`qty`) AS `qty`,                                   '+
                    '            SUM(`rk`.`mh`) AS `mh`,                                     '+
                    '            SUM(`rk`.`harga_satuan`) AS `harga_satuan`,                 '+
                    '            SUM(`rk`.`subtotal`) AS `subtotal`,                         '+
                    '            `rk`.`id_divisi` AS `id_divisi_process`,                     '+
                    '            IFNULL(fc_indikator_hasil(r.tgl,`rk`.`no_container`,`rk`.`no_so`,`rk`.`item_id`,`rk`.`id_divisi`),0) AS indikator, '+
                    '            IFNULL(fc_balance(rk.`item_id`,`rk`.`no_so`,`rk`.`no_container`,`rk`.`id_divisi`),0) AS balance '+
                    '          FROM                                                          '+
                    '            `hasil_kerja` `r`                                           '+
                    '            JOIN `detail_hasil_kerja` `rk`                              '+
                    '              ON `r`.`nomer` = `rk`.`nomer`                             '+
                    '            JOIN `item` `i`                                             '+
                    '              ON `i`.`id` = `rk`.`item_id`                              '+
                    '            JOIN `divisi` `d`                                           '+
                    '              ON `d`.`id` = `r`.`id_divisi`                             '+
                    '            JOIN `divisi_pengerjaan` `dp`                               '+
                    '              ON `dp`.`id` = `r`.`divisi_process`                       '+
                    '        WHERE r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" '+
                    '        '+FilterDivisi+'                                         '+
                    '          GROUP BY   r.divisi_process,rk.no_so,                         '+
                    '             rk.no_container,                                           '+
                    '             rk.item_id                                                 '+
                    '          UNION ALL                                                     '+
                    '          SELECT                                                        '+
                    '            `r`.`tgl` AS `tgl`,                                         '+
                    '           `r`.`nomer` AS `nomer`,                                      '+
                    '            `r`.`id_divisi` AS `id_divisi`,                             '+
                    '            `d`.`name` AS `divisi_process`,                             '+
                    '            `r`.`jml_tenaga_kerja` AS `jml_tenaga_kerja`,               '+
                    '            `r`.`gaji` AS `gaji`,                                       '+
                    '            `r`.`lembur` AS `lembur`,                                   '+
                    '            `r`.`total_gaji` AS `total_gaji`,                           '+
                    '            `r`.`hasil_kerja` AS `hasil_kerja`,                         '+
                    '            r.hasil_kerja - r.total_gaji AS `plus_minus`,               '+
                    '              (`r`.hasil_kerja - r.total_gaji) / `r`.`total_gaji`       '+
                    '             AS `prosentase`,                                           '+
                    '            `r`.`divisi_process` AS `divisi_pengerjaan`,                '+
                    '            `dp`.`name` AS `name`,                                      '+
                    '            "-" AS `no_so`,                                             '+
                    '            "-" AS `no_container`,                                      '+
                    '            "-" AS `item_id`,                                           '+
                    '            "Z-BA" AS `itemno`,                                         '+
                    '            `rk`.`description` AS `description`,                        '+
                    '            SUM(`rk`.`qty`) AS `qty`,                                   '+
                    '            SUM(`rk`.`mh`) AS `mh`,                                     '+
                    '            SUM(`rk`.`cost`) AS `harga_satuan`,                         '+
                    '            SUM(`rk`.`total_cost`) AS `subtotal`,                       '+
                    '            `rk`.`id_divisi` AS `id_divisi_process`,                    '+
                    '            "0" AS indikator,                                           '+
                    '            "0" AS balance                                               '+
                    '          FROM                                                          '+
                    '            hasil_kerja r                                               '+
                    '            JOIN by_accident rk                                         '+
                    '            ON rk.nomer_hasil_kerja = r.nomer JOIN `divisi` `d`         '+
                    '              ON `d`.`id` = `r`.`id_divisi`                             '+
                    '            JOIN `divisi_pengerjaan` `dp`                               '+
                    '              ON `dp`.`id` = `r`.divisi_process                         '+
                    '        WHERE r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" '+
                    '        '+FilterDivisi+'                                         '+
                    '                 GROUP BY                                               '+
                    '            r.divisi_process,rk.description) a ORDER BY divisi_pengerjaan,itemno ASC',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frLapHasilKerja.fr3');
  FMemo(frxReport1,'Lperiode').Text :='Periode : '+FormatDateTime('dd mmmm yy',dt1.Date)+' s/d '+FormatDateTime('dd mmmm yy',dt2.Date);
  frxReport1.Preview := nil;
  frxReport1.PrepareReport();
  frxReport1.ShowReport();
end;

procedure TFLapHasilKerja.AdvSmoothButton4Click(Sender: TObject);
var
  FilterDivisi : String;
begin

  if cbDivisi.ItemIndex = -1 then begin
     Error('Divisi belum dipilih');
     Exit
  end;

  if cbDivisi.ItemIndex >= 1 then
     FilterDivisi := ' AND r.divisi_process="'+GetIdcmb(cbDivisi)+'" '
  else
     FilterDivisi := '';
  ExQry(QHasilKerja,'SELECT * FROM (SELECT                                                   '+
                    '            `r`.`tgl` AS `tgl`,                                         '+
                    '            `r`.`nomer` AS `nomer`,                                     '+
                    '            `r`.`id_divisi` AS `id_divisi`,                             '+
                    '            `d`.`name` AS `divisi_process`,                             '+
                    '            SUM(`r`.`jml_tenaga_kerja`) AS `jml_tenaga_kerja`,          '+
                    '            SUM(`r`.`gaji`) AS `gaji`,                                  '+
                    '            SUM(`r`.`lembur`) AS `lembur`,                              '+
                    '            SUM(`r`.`total_gaji`) AS `total_gaji`,                      '+
                    '            SUM(`r`.`hasil_kerja`) AS `hasil_kerja`,                    '+
                    '            SUM(r.hasil_kerja - r.total_gaji) AS `plus_minus`,          '+
                    '            SUM(                                                        '+
                    '              (`r`.hasil_kerja - r.total_gaji) / `r`.`total_gaji`       '+
                    '            ) AS `prosentase`,                                          '+
                    '            `r`.`divisi_process` AS `divisi_pengerjaan`,                '+
                    '            `dp`.`name` AS `name`,                                      '+
                    '            `rk`.`no_so` AS `no_so`,                                    '+
                    '            `rk`.`no_container` AS `no_container`,                      '+
                    '            `rk`.`item_id` AS `item_id`,                                '+
                    '           `i`.`itemno` AS `itemno`,                                    '+
                    '            `i`.`description` AS `description`,                         '+
                    '            SUM(`rk`.`qty`) AS `qty`,                                   '+
                    '            SUM(`rk`.`mh`) AS `mh`,                                     '+
                    '            SUM(`rk`.`harga_satuan`) AS `harga_satuan`,                 '+
                    '            SUM(`rk`.`subtotal`) AS `subtotal`,                         '+
                    '            `rk`.`id_divisi` AS `id_divisi_process`,                     '+
                    '            IFNULL(fc_indikator_hasil(r.tgl,`rk`.`no_container`,`rk`.`no_so`,`rk`.`item_id`,`rk`.`id_divisi`),0) AS indikator, '+
                    '            IFNULL(fc_balance(rk.`item_id`,`rk`.`no_so`,`rk`.`no_container`,`rk`.`id_divisi`),0) AS balance '+
                    '          FROM                                                          '+
                    '            `hasil_kerja` `r`                                           '+
                    '            JOIN `detail_hasil_kerja` `rk`                              '+
                    '              ON `r`.`nomer` = `rk`.`nomer`                             '+
                    '            JOIN `item` `i`                                             '+
                    '              ON `i`.`id` = `rk`.`item_id`                              '+
                    '            JOIN `divisi` `d`                                           '+
                    '              ON `d`.`id` = `r`.`id_divisi`                             '+
                    '            JOIN `divisi_pengerjaan` `dp`                               '+
                    '              ON `dp`.`id` = `r`.`divisi_process`                       '+
                    '        WHERE r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" '+
                    '        '+FilterDivisi+'                                         '+
                    '          GROUP BY   r.divisi_process,rk.no_so,                         '+
                    '             rk.no_container,                                           '+
                    '             rk.item_id                                                 '+
                    '          UNION ALL                                                     '+
                    '          SELECT                                                        '+
                    '            `r`.`tgl` AS `tgl`,                                         '+
                    '           `r`.`nomer` AS `nomer`,                                      '+
                    '            `r`.`id_divisi` AS `id_divisi`,                             '+
                    '            `d`.`name` AS `divisi_process`,                             '+
                    '            `r`.`jml_tenaga_kerja` AS `jml_tenaga_kerja`,               '+
                    '            `r`.`gaji` AS `gaji`,                                       '+
                    '            `r`.`lembur` AS `lembur`,                                   '+
                    '            `r`.`total_gaji` AS `total_gaji`,                           '+
                    '            `r`.`hasil_kerja` AS `hasil_kerja`,                         '+
                    '            r.hasil_kerja - r.total_gaji AS `plus_minus`,               '+
                    '              (`r`.hasil_kerja - r.total_gaji) / `r`.`total_gaji`       '+
                    '             AS `prosentase`,                                           '+
                    '            `r`.`divisi_process` AS `divisi_pengerjaan`,                '+
                    '            `dp`.`name` AS `name`,                                      '+
                    '            "-" AS `no_so`,                                             '+
                    '            "-" AS `no_container`,                                      '+
                    '            "-" AS `item_id`,                                           '+
                    '            "Z-BA" AS `itemno`,                                         '+
                    '            `rk`.`description` AS `description`,                        '+
                    '            SUM(`rk`.`qty`) AS `qty`,                                   '+
                    '            SUM(`rk`.`mh`) AS `mh`,                                     '+
                    '            SUM(`rk`.`cost`) AS `harga_satuan`,                         '+
                    '            SUM(`rk`.`total_cost`) AS `subtotal`,                       '+
                    '            `rk`.`id_divisi` AS `id_divisi_process`,                    '+
                    '            "0" AS indikator,                                           '+
                    '            "0" AS balance                                               '+
                    '          FROM                                                          '+
                    '            hasil_kerja r                                               '+
                    '            JOIN by_accident rk                                         '+
                    '            ON rk.nomer_hasil_kerja = r.nomer JOIN `divisi` `d`         '+
                    '              ON `d`.`id` = `r`.`id_divisi`                             '+
                    '            JOIN `divisi_pengerjaan` `dp`                               '+
                    '              ON `dp`.`id` = `r`.divisi_process                         '+
                    '        WHERE r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" '+
                    '        '+FilterDivisi+'                                         '+
                    '                 GROUP BY                                               '+
                    '            r.divisi_process,rk.description) a ORDER BY divisi_pengerjaan,itemno ASC',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frLapHasilKerja.fr3');
  FMemo(frxReport1,'Lperiode').Text :='Periode : '+FormatDateTime('dd mmmm yy',dt1.Date)+' s/d '+FormatDateTime('dd mmmm yy',dt2.Date);
  frxReport1.Preview := frxPreview1;
  frxReport1.ShowReport();
end;

procedure TFLapHasilKerja.FormCreate(Sender: TObject);
begin
  FLapHasilKerja:= Self;
  dt1.Date := now;
  dt2.Date := now;


end;

procedure TFLapHasilKerja.FormShow(Sender: TObject);
begin
  cbDivisi.Items.Clear;
  cbDivisi.AddItem('-- ALL DIVISI',TObject(0));

  ExQry(Q1,'SELECT * FROM divisi_pengerjaan ORDER BY name ASC',True);

  while not Q1.Eof do begin

    cbDivisi.AddItem(GetVal(Q1,'name'),TObject(GetValInt(Q1,'id')));
    Q1.Next;
  end;
end;

end.
