unit uJadwalDivisi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, AdvSmoothButton, Vcl.ComCtrls, Vcl.StdCtrls, AdvEdit, AdvGroupBox, uComCtrl,DateUtils, uEngine,
  Vcl.Samples.Gauges, Planner, tmsAdvGridExcel, AdvScrollBox, Vcl.ExtCtrls,
  Data.DB, frxClass, frxDBSet, frxCross,
  uPilihPeriode, AdvSmoothPanel, MemDS, DBAccess, MyAccess;

type
  TFJadwalDivisi = class(TForm)
    AdvGroupBox2: TAdvGroupBox;
    AdvSmoothButton1: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvGridExcelIO1: TAdvGridExcelIO;
    gp: TGridPanel;
    sg1: TAdvStringGrid;
    Ldivisi: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dt1: TDateTimePicker;
    Label4: TLabel;
    dt2: TDateTimePicker;
    frxReport1: TfrxReport;
    frJadwal: TfrxDBDataset;
    frxCrossObject1: TfrxCrossObject;
    QJadwal: TMyQuery;
    Q1: TMyQuery;
    Q2: TMyQuery;
    procedure FormShow(Sender: TObject);
    procedure sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormCreate(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure sg1Click(Sender: TObject);
    procedure dt1Change(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);

  private
    { Private declarations }

    procedure LoadDivisi;

  public
    { Public declarations }
    PrintReport : Boolean;
    DtReport1,DtReport2 : TDate;
      procedure CreateButtonGrid;

    procedure TampilAwal;
  end;

var
  FJadwalDivisi: TFJadwalDivisi;
  IndexWarna : Integer;

implementation

{$R *.dfm}

uses uListofSoGant, uDataGanttChart, pData, uMarCon;

{ TFGanttChart }




procedure TFJadwalDivisi.AdvSmoothButton1Click(Sender: TObject);

begin
  PrintReport := False;
  FPilihPeriode.ShowModal;
  if PrintReport = True then begin

        QJadwal.Close;
        QJadwal.SQL.Text := ' SELECT            '+
                            '    d.name,        '+
                            '    d.divno,        '+
                            '    j.tgl,         '+
                            '    j.sono,        '+
                            '    CONCAT(i.description,"[",j.sono,"] : ",j.`qty_order`,"[",j.`total_menit`,"]") as details  '+
                            '  FROM                         '+
                            '    detailjadwal j             '+
                            '    LEFT JOIN divisi d         '+
                            '      ON d.`id` = j.`id_divisi`   '+
                            '    LEFT JOIN item i              '+
                            '      ON i.`id` = j.item_id       '+
                            '    WHERE j.tgl >="'+Tanggal(FPilihPeriode.dt1.Date)+'" '+
                            '    AND j.tgl <="'+Tanggal(FPilihPeriode.dt2.Date)+'" '+
                            '    ORDER BY CONVERT(d.divno,UNSIGNED) ASC          ';
        QJadwal.Open;

       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frJadwal.fr3');
       frxReport1.ShowReport();
  end;
  PrintReport := False;
end;

procedure TFJadwalDivisi.AdvSmoothButton3Click(Sender: TObject);
begin
  FDaftarSOGant.ShowMOdal;
end;

procedure TFJadwalDivisi.btnAddClick(Sender: TObject);
begin
  Close;
end;

procedure TFJadwalDivisi.CreateButtonGrid;
var
  i : integer;
  aFrame: TFramePData;
  tglAwal : TDate;
  Akhir    : integer;
  jmlPersen : Integer;
  Jam2,Jam3 : Integer;
 
begin
  gp.RowCollection.BeginUpdate;
  gp.ColumnCollection.BeginUpdate;

  tglAwal := dt1.Date;

  Akhir   := DaysBetween(tglAwal,tglAwal + 30);

  for i := 0 to -1 + gp.ControlCount do
    gp.Controls[0].Free;

  //btw, cannot clear if there are controls, so first remove "old" controls above
  gp.RowCollection.Clear;
  gp.ColumnCollection.Clear;



  for i := 1 to 6 do
    with gp.ColumnCollection.Add do
    begin
      SizeStyle := ssPercent;
      Value := 100 / 6; //have cells evenly distributed
    end;
 

  for i := 0 to Akhir -1 do
  begin
    aFrame := TFramePData.Create(self);
    aFrame.Parent := gp; //magic: place in the next empty cell
    aFrame.Visible := true;
    aFrame.Name := 'Frame'+IntToStr(i);
    aFrame.Align := alClient;
    aFrame.AlignWithMargins := true;
    aFrame.Ltanggal.Caption := FormatDateTime('dd mmmm yyyy',tglAwal+i);
    aFrame.dt1.Date         := tglAwal+i;
    aFrame.Ldivisi.Caption  := sg1.Cells[2,sg1.Row];
    aFrame.Lnamadivisi.Caption := sg1.Cells[1,sg1.Row];


    ExQry(Q1,'SELECT divisi.jmlkaryawan,detailjadwal.id_divisi,detailjadwal.tgl, '+
    ' detailjadwal.jam_kerja,(detailjadwal.kapasitas div detailjadwal.jam_kerja) as jml_pekerja,'+
    ' detailjadwal.kapasitas as kapasitas_divisi,SUM(detailjadwal.total_menit) as kapasitas_terpakai '+
    ' FROM detailjadwal JOIN divisi ON divisi.id=detailjadwal.id_divisi WHERE id_divisi="'+sg1.Cells[2,sg1.Row]+'" '+
    ' AND tgl="'+Tanggal(tglAwal+i)+'" ',True);


    Jam2 := (GetValInt(Q1,'jmlkaryawan') * 7) ;
    Jam3 := GetValInt(Q1,'kapasitas_terpakai') div 60;

    aFrame.Lmanhour.Caption   := IntToStr(GetValInt(Q1,'jam_kerja'))+' Jam';
    aFrame.LKapasitas.Caption := IntToStr(Jam2)+' Jam';
    aFrame.Lalokasi.Caption   := IntToStr(Jam3)+' Jam';


         if Jam3 > 0 then begin

         if GetValInt(Q1,'kapasitas_terpakai') = 0 then
         jmlPersen := 0 else
         jmlPersen := Round(Jam3 /Jam2  * 100) ;
         aFrame.Gauge1.Progress := jmlPersen;
         end;

        case aFrame.Gauge1.Progress of
        0      : begin
                   with aFrame do begin
                      Gauge1.ForeColor         := clSilver;
                      Gauge1.BackColor         := clSilver;
                   end;
                 end;
        10..40 : begin
                   with aFrame do begin
                      Gauge1.ForeColor         := clGreen;
                      Gauge1.BackColor         := clSilver;
                   end;
                end;
        41..80 :begin
                   with aFrame do begin
                      Gauge1.ForeColor         := $000080FF;
                      Gauge1.BackColor         := clSilver;
                   end;
                end;
        81..100 :begin
                   with aFrame do begin
                      Gauge1.ForeColor         := $003C3CFF;
                      Gauge1.BackColor         := clSilver;
                   end;
                end;
        end;



  end;

  gp.RowCollection.EndUpdate;
  gp.ColumnCollection.EndUpdate;
end;



procedure TFJadwalDivisi.dt1Change(Sender: TObject);
begin
  dt2.MaxDate := dt1.Date + 30;
end;

procedure TFJadwalDivisi.FormCreate(Sender: TObject);
begin
  FJadwalDivisi := Self;
end;

procedure TFJadwalDivisi.FormShow(Sender: TObject);
begin
  LoadDivisi;
  TampilAwal;
  dt1.Date := Now;
  dt2.Date := Now + 30;
  dt2.MaxDate := dt1.Date + 30;
end;




procedure TFJadwalDivisi.LoadDivisi;
var
   i : Integer;
begin
  ExQry(Q1,'SELECT * FROM divisi WHERE is_active=true',True);

  with sg1 do begin
     ColCount := 3;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Divisi';
     Cells[2,0] := 'Id';

     ColWidths[0] :=  40;
     ColWidths[1] := 150;
     ColWidths[2] := 0;

     ColumnSize.StretchColumn := 1;
     ColumnSize.Stretch       := True;

     i := 0;
     RowCount := Q1.RecordCount + 1;
     while not Q1.Eof do begin
       Cells[0,i+1] := IntToStr(i+1);
       Cells[1,i+1] := GetVal(Q1,'name');
       Cells[2,i+1] := GetVal(Q1,'id');
       Inc(i);
       Q1.Next;
     end;

  end;
end;

procedure TFJadwalDivisi.sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACOl in [3,6,8,10];
end;

procedure TFJadwalDivisi.sg1Click(Sender: TObject);
begin
  Ldivisi.Caption := sg1.Cells[1,sg1.Row];

  CreateButtonGrid;
end;

procedure TFJadwalDivisi.sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then
     HAlign := taCenter;
end;

procedure TFJadwalDivisi.TampilAwal;
begin
  ClearText(Self);
end;

end.
