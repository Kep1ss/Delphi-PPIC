unit uLapCompare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB,  frxClass, frxDBSet, frxPreview, Vcl.ComCtrls, MemDS, DBAccess, MyAccess,
  DBAdvGrid;

type
  TFLapRencanavsHasil = class(TForm)
    Label1: TLabel;
    P1: TAdvSmoothPanel;
    DCompare: TDataSource;
    frxReport1: TfrxReport;
    frCompare: TfrxDBDataset;
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
    QCompare: TMyQuery;
    Q1: TMyQuery;
    frDetailHasilKerja: TfrxDBDataset;
    frHasilKerja: TfrxDBDataset;
    QHasilKerja: TMyQuery;
    QDetailHasilKerja: TMyQuery;
    DHasilKerja: TMyDataSource;
    MyQuery1: TMyQuery;
    QberitaAcara: TMyQuery;
    frBeritaAcara: TfrxDBDataset;
    QRencanaKerja: TMyQuery;
    QDetailRencanaKerja: TMyQuery;
    DRencanaKerja: TMyDataSource;
    frRencanaKerja: TfrxDBDataset;
    frDetailRencanaKerja: TfrxDBDataset;
    frBARencanaKerja: TfrxDBDataset;
    QBARencanaKerja: TMyQuery;
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
  FLapRencanavsHasil: TFLapRencanavsHasil;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon;




procedure TFLapRencanavsHasil.AdvSmoothButton1Click(Sender: TObject);
begin
if cbDivisi.ItemIndex = -1 then begin
     Error('Divisi belum dipilih');
     Exit
  end;
  ExQry(QRencanaKerja,' SELECT                                                 '+
                      '        r.nomer,                                        '+
                      '        r.tgl,                                          '+
                      '        d.name,                                         '+
                      '        SUM(r.jml_tenaga_kerja) as jml_tenaga_kerja,    '+
                      '        SUM(r.gaji) as gaji,                            '+
                      '        SUM(r.lembur) as lembur,                        '+
                      '        SUM(r.total_gaji) as total_gaji,                '+
                      '        SUM(r.hasil_kerja) as hasil_kerja,              '+
                      '        SUM(r.hasil_kerja-r.total_gaji) as plus_minus,  '+
                      '        SUM((r.hasil_kerja-r.total_gaji)/r.total_gaji) as prosentase, '+
                      '        u.full_name,                                    '+
                      '        r.divisi_planned,                               '+
                      '        r.id_divisi,                                    '+
                      '        r.metode_perhitungan,                           '+
                      '        r.id                                            '+
                      '      FROM                                             '+
                      '        rencana_kerja r                                '+
                      '        LEFT JOIN divisi_pengerjaan d                  '+
                      '          ON d.`id` = r.`divisi_planned`               '+
                      '       LEFT JOIN user_login u                          '+
                      '          ON u.`id` = r.`id_user` WHERE '+
                      ' r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" AND '+
                      ' r.divisi_planned="'+GetIdcmb(cbDivisi)+'" ',True);

   ExQry(QDetailRencanaKerja,' SELECT                                             '+
                             '       rk.nomer,                                    '+
                             '       rk.no_so,                                    '+
                             '       rk.no_job_order,                             '+
                             '       rk.no_container,                             '+
                             '       rk.item_id,                                  '+
                             '       i.description,                               '+
                             '       SUM(rk.qty) as qty,                          '+
                             '       SUM(rk.mh) as mh,                            '+
                             '       SUM(rk.qty_order) as qty_order,              '+
                             '       SUM(rk.harga_satuan) as harga_satuan,        '+
                             '       SUM(rk.subtotal) as subtotal,                '+
                             '       i.itemno,                                    '+
                             '       rk.parent_id,                                '+
                             '       rk.jenis,                                    '+
                             '       rk.parent_name,                              '+
                             '       rk.is_parent,                                '+
                             '        rk.id_divisi,                               '+
                             '       rk.id                                        '+
                             '     FROM                                           '+
                             '       rencana_kerja_detail rk                      '+
                             '       LEFT JOIN item i                             '+
                             '         ON rk.`item_id` = i.`id`                   '+
                             ' LEFT JOIN rencana_kerja r ON r.nomer=rk.nomer '+
                             ' WHERE r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" AND '+
                             ' r.divisi_planned="'+GetIdcmb(cbDivisi)+'" AND rk.is_parent=false '+
                             ' AND rk.qty>0 GROUP BY rk.no_so,rk.no_container,rk.item_id',True);


   ExQry(QHasilKerja,' SELECT                                       '+
                     '        r.nomer,                              '+
                     '         r.nomer_rencana,                     '+
                     '         r.tgl,                               '+
                     '         d.name,                              '+
                     '         SUM(r.jml_tenaga_kerja) as jml_tenaga_kerja,                  '+
                     '         SUM(r.gaji) as gaji,                              '+
                     '         SUM(r.lembur) as lembur,                            '+
                     '         SUM(r.total_gaji) total_gaji,                        '+
                     '         SUM(r.hasil_kerja) hasil_kerja,                       '+
                     '         SUM(r.hasil_kerja-r.total_gaji) as plus_minus ,                        '+
                     '         SUM((r.hasil_kerja-r.total_gaji) / -r.total_gaji) as prosentase,                         '+
                     '         u.full_name,                         '+
                     '         r.id_divisi,                         '+
                     '         r.divisi_process,                    '+
                     '         r.id_sub_divisi,                     '+
                     '         sb.deskripsi,                        '+
                     '         r.id                                 '+
                     '       FROM                                   '+
                     '         hasil_kerja r                        '+
                     '         LEFT JOIN divisi_pengerjaan d        '+
                     '          ON d.`id` = r.`divisi_process`      '+
                     '        LEFT JOIN user_login u                '+
                     '           ON u.`id` = r.`id_user`            '+
                     '         LEFT JOIN pekerjaan sb ON sb.id=r.id_sub_divisi WHERE r.tgl>="'+Tanggal(dt1.Date)+'" '+
                     ' AND r.tgl<="'+Tanggal(dt2.Date)+'" '+
                     ' AND r.divisi_process="'+GetIdcmb(cbDivisi)+'" ',True);


   ExQry(QDetailHasilKerja,getSQL('TableHasilKerjaDetail')+' '+
   ' LEFT JOIN hasil_kerja r ON r.nomer=rk.nomer '+
   ' WHERE r.tgl>="'+Tanggal(dt1.Date)+'" '+
   ' AND r.tgl<="'+Tanggal(dt2.Date)+'"  AND '+
   ' r.divisi_process="'+GetIdcmb(cbDivisi)+'" AND '+
   ' rk.qty>0 GROUP BY rk.item_id,rk.no_so,rk.no_container,rk.id_divisi',True);
   ExQry(QberitaAcara,' SELECT                          '+
                      '        ba.tgl,                  '+
                      '        ba.id_divisi,            '+
                      '        ba.nomer_hasil_kerja,    '+
                      '        ba.description,          '+
                      '        SUM(ba.qty) as qty,                  '+
                      '        SUM(ba.mh) as mh,                   '+
                      '        SUM(ba.cost) as cost,                 '+
                      '        SUM(ba.total_cost) as total_cost,           '+
                      '        ba.id                    '+
                      '      FROM                       '+
                      '        by_accident ba join hasil_kerja h ON h.nomer=ba.nomer_hasil_kerja WHERE '+
                      ' ba.tgl>="'+Tanggal(dt1.Date)+'" AND ba.tgl<="'+Tanggal(dt2.Date)+'" '+
                      ' AND h.divisi_process="'+GetIdcmb(cbDivisi)+'" '+
                      ' GROUP BY ba.description',True);
   ExQry(QBARencanaKerja,'SELECT ba.tgl,ba.id_divisi,ba.nomer_rencana_kerja, '+
   ' ba.description,ba.qty,ba.mh,ba.cost,ba.total_cost FROM rencana_berita_acara ba '+
   ' JOIN rencana_kerja h on h.nomer=ba.nomer_rencana_kerja WHERE '+
   ' h.tgl>="'+Tanggal(dt1.Date)+'" AND h.tgl<="'+Tanggal(dt2.Date)+'"'+
   ' AND h.divisi_planned="'+getVal(QHasilKerja,'divisi_process')+'" ',True);


  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frComparePeriode.fr3');
  FMemo(frxReport1,'Lperiode').Text :=' '+FormatDateTime('dd mmmm yy',dt1.Date)+' s/d '+FormatDateTime('dd mmmm yy',dt2.Date);
  frxReport1.PrepareReport();
  frxReport1.Preview := nil;
  frxReport1.ShowReport();
end;

procedure TFLapRencanavsHasil.AdvSmoothButton4Click(Sender: TObject);
begin
  if cbDivisi.ItemIndex = -1 then begin
     Error('Divisi belum dipilih');
     Exit
  end;
  ExQry(QRencanaKerja,' SELECT                                                 '+
                      '        r.nomer,                                        '+
                      '        r.tgl,                                          '+
                      '        d.name,                                         '+
                      '        SUM(r.jml_tenaga_kerja) as jml_tenaga_kerja,    '+
                      '        SUM(r.gaji) as gaji,                            '+
                      '        SUM(r.lembur) as lembur,                        '+
                      '        SUM(r.total_gaji) as total_gaji,                '+
                      '        SUM(r.hasil_kerja) as hasil_kerja,              '+
                      '        SUM(r.hasil_kerja-r.total_gaji) as plus_minus,  '+
                      '        SUM((r.hasil_kerja-r.total_gaji)/r.total_gaji) as prosentase, '+
                      '        u.full_name,                                    '+
                      '        r.divisi_planned,                               '+
                      '        r.id_divisi,                                    '+
                      '        r.metode_perhitungan,                           '+
                      '        r.id                                            '+
                      '      FROM                                             '+
                      '        rencana_kerja r                                '+
                      '        LEFT JOIN divisi_pengerjaan d                  '+
                      '          ON d.`id` = r.`divisi_planned`               '+
                      '       LEFT JOIN user_login u                          '+
                      '          ON u.`id` = r.`id_user` WHERE '+
                      ' r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" AND '+
                      ' r.divisi_planned="'+GetIdcmb(cbDivisi)+'" ',True);

   ExQry(QDetailRencanaKerja,' SELECT                                             '+
                             '       rk.nomer,                                    '+
                             '       rk.no_so,                                    '+
                             '       rk.no_job_order,                             '+
                             '       rk.no_container,                             '+
                             '       rk.item_id,                                  '+
                             '       i.description,                               '+
                             '       SUM(rk.qty) as qty,                          '+
                             '       SUM(rk.mh) as mh,                            '+
                             '       SUM(rk.qty_order) as qty_order,              '+
                             '       SUM(rk.harga_satuan) as harga_satuan,        '+
                             '       SUM(rk.subtotal) as subtotal,                '+
                             '       i.itemno,                                    '+
                             '       rk.parent_id,                                '+
                             '       rk.jenis,                                    '+
                             '       rk.parent_name,                              '+
                             '       rk.is_parent,                                '+
                             '        rk.id_divisi,                               '+
                             '       rk.id                                        '+
                             '     FROM                                           '+
                             '       rencana_kerja_detail rk                      '+
                             '       LEFT JOIN item i                             '+
                             '         ON rk.`item_id` = i.`id`                   '+
                             ' LEFT JOIN rencana_kerja r ON r.nomer=rk.nomer '+
                             ' WHERE r.tgl>="'+Tanggal(dt1.Date)+'" AND r.tgl<="'+Tanggal(dt2.Date)+'" AND '+
                             ' r.divisi_planned="'+GetIdcmb(cbDivisi)+'" AND rk.is_parent=false '+
                             ' AND rk.qty>0 GROUP BY rk.no_so,rk.no_container,rk.item_id',True);


   ExQry(QHasilKerja,' SELECT                                       '+
                     '        r.nomer,                              '+
                     '         r.nomer_rencana,                     '+
                     '         r.tgl,                               '+
                     '         d.name,                              '+
                     '         SUM(r.jml_tenaga_kerja) as jml_tenaga_kerja,                  '+
                     '         SUM(r.gaji) as gaji,                              '+
                     '         SUM(r.lembur) as lembur,                            '+
                     '         SUM(r.total_gaji) total_gaji,                        '+
                     '         SUM(r.hasil_kerja) hasil_kerja,                       '+
                     '         SUM(r.hasil_kerja-r.total_gaji) as plus_minus ,                        '+
                     '         SUM((r.hasil_kerja-r.total_gaji) / -r.total_gaji) as prosentase,                         '+
                     '         u.full_name,                         '+
                     '         r.id_divisi,                         '+
                     '         r.divisi_process,                    '+
                     '         r.id_sub_divisi,                     '+
                     '         sb.deskripsi,                        '+
                     '         r.id                                 '+
                     '       FROM                                   '+
                     '         hasil_kerja r                        '+
                     '         LEFT JOIN divisi_pengerjaan d        '+
                     '          ON d.`id` = r.`divisi_process`      '+
                     '        LEFT JOIN user_login u                '+
                     '           ON u.`id` = r.`id_user`            '+
                     '         LEFT JOIN pekerjaan sb ON sb.id=r.id_sub_divisi WHERE r.tgl>="'+Tanggal(dt1.Date)+'" '+
                     ' AND r.tgl<="'+Tanggal(dt2.Date)+'" '+
                     ' AND r.divisi_process="'+GetIdcmb(cbDivisi)+'" ',True);


   ExQry(QDetailHasilKerja,getSQL('TableHasilKerjaDetail')+' '+
   ' LEFT JOIN hasil_kerja r ON r.nomer=rk.nomer '+
   ' WHERE r.tgl>="'+Tanggal(dt1.Date)+'" '+
   ' AND r.tgl<="'+Tanggal(dt2.Date)+'"  AND '+
   ' r.divisi_process="'+GetIdcmb(cbDivisi)+'" AND '+
   ' rk.qty>0 GROUP BY rk.item_id,rk.no_so,rk.no_container,rk.id_divisi',True);
   ExQry(QberitaAcara,' SELECT                          '+
                      '        ba.tgl,                  '+
                      '        ba.id_divisi,            '+
                      '        ba.nomer_hasil_kerja,    '+
                      '        ba.description,          '+
                      '        SUM(ba.qty) as qty,                  '+
                      '        SUM(ba.mh) as mh,                   '+
                      '        SUM(ba.cost) as cost,                 '+
                      '        SUM(ba.total_cost) as total_cost,           '+
                      '        ba.id                    '+
                      '      FROM                       '+
                      '        by_accident ba join hasil_kerja h ON h.nomer=ba.nomer_hasil_kerja WHERE '+
                      ' ba.tgl>="'+Tanggal(dt1.Date)+'" AND ba.tgl<="'+Tanggal(dt2.Date)+'" '+
                      ' AND h.divisi_process="'+GetIdcmb(cbDivisi)+'" '+
                      ' GROUP BY ba.description',True);
   ExQry(QBARencanaKerja,'SELECT ba.tgl,ba.id_divisi,ba.nomer_rencana_kerja, '+
   ' ba.description,ba.qty,ba.mh,ba.cost,ba.total_cost FROM rencana_berita_acara ba '+
   ' JOIN rencana_kerja h on h.nomer=ba.nomer_rencana_kerja WHERE '+
   ' h.tgl>="'+Tanggal(dt1.Date)+'" AND h.tgl<="'+Tanggal(dt2.Date)+'"'+
   ' AND h.divisi_planned="'+getVal(QHasilKerja,'divisi_process')+'" ',True);


  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frComparePeriode.fr3');
  FMemo(frxReport1,'Lperiode').Text :=' '+FormatDateTime('dd mmmm yy',dt1.Date)+' s/d '+FormatDateTime('dd mmmm yy',dt2.Date);
  frxReport1.Preview := frxPreview1;
  frxReport1.ShowReport();
end;

procedure TFLapRencanavsHasil.FormCreate(Sender: TObject);
begin
  FLapRencanavsHasil:= Self;
  dt1.Date := now;
  dt2.Date := now;


end;

procedure TFLapRencanavsHasil.FormShow(Sender: TObject);
begin
  isiCmb(Q1,'divisi_pengerjaan order by name ASC ',['id','name'],cbDivisi);
end;

end.
