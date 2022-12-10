unit pData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Samples.Gauges, AdvSmoothButton, AdvSmoothPanel,
  Vcl.ExtCtrls, HTMLabel, Data.DB, MemDS, DBAccess, MyAccess;

type
  TFramePData = class(TFrame)
    sp: TAdvSmoothPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Lmanhour: TLabel;
    LKapasitas: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    Bevel1: TBevel;
    Ltanggal: TLabel;
    HTMLabel3: THTMLabel;
    dt1: TDateTimePicker;
    Ldivisi: TLabel;
    Lnamadivisi: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Lalokasi: TLabel;
    Q1: TMyQuery;
    procedure HTMLabel3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uInputJadwalDivisi, uComCtrl, uEngine, uMarCon, uListOfItemJadwal;

procedure TFramePData.HTMLabel3Click(Sender: TObject);
var
  i : integer;
begin
  ExQry(Q1,'SELECT                            '+
           '     d.item_id,                    '+
           '     i.itemno,                    '+
           '     i.description,           '+
           '     d.qty_order,                 '+
           '     d.total_menit,               '+
           '     d.id_divisi,                 '+
           '     d.tgl,                       '+
           '     d.sono,                      '+
           '     v.name                       '+
           '   FROM                           '+
           '     detailjadwal d               '+
           '     LEFT JOIN item i ON i.id=d.item_id '+
           '     LEFT JOIN divisi v           '+
           '       ON v.`id` = d.`id_divisi`  '+
           '   WHERE d.`id_divisi` = "'+Ldivisi.Caption+'"       '+
           '     AND tgl = "'+Tanggal(dt1.Date)+'"   ',True);


  FlistItemJadwal.createGrid;
  FlistItemJadwal.sgBarang.RowCount := Q1.RecordCount + 2;
  i := 1;
     while not Q1.Eof do begin

        FlistItemJadwal.sgBarang.Cells[0,i] :=  GetVal(Q1,'sono');
        FlistItemJadwal.sgBarang.Cells[1,i] :=  GetVal(Q1,'itemno');
        FlistItemJadwal.sgBarang.Cells[2,i] :=  GetVal(Q1,'description');
        FlistItemJadwal.sgBarang.Cells[3,i] :=  GetVal(Q1,'qty_order');
        FlistItemJadwal.sgBarang.Cells[4,i] :=  IntToStr(GetValInt(Q1,'total_menit') div 60) +' Jam ';
        FlistItemJadwal.sgBarang.Cells[6,i] :=  GetVal(Q1,'id_divisi');
        FlistItemJadwal.sgBarang.Cells[7,i] :=  GetVal(Q1,'name');
        FlistItemJadwal.sgBarang.Cells[8,i] :=  GetVal(Q1,'tgl');
        FlistItemJadwal.sgBarang.Cells[10,i] :=  GetVal(Q1,'total_menit');
        inc(i);
        Q1.Next;


  end;


  FlistItemJadwal.Show;
end;

end.
