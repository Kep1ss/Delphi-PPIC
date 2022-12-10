unit uScheduleChart_backup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,math,
  AdvGrid, AdvSmoothButton, Vcl.ComCtrls, Vcl.StdCtrls, AdvEdit, AdvGroupBox, uComCtrl,DateUtils, uEngine, Data.DB, MemDS, DBAccess, MyAccess,
  VirtualTable, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,JPEG,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, AdvSmoothListBox, AdvSmoothComboBox,
  tmsAdvGridExcel, AdvCombo, Vcl.Menus, Vcl.Buttons;

type
  TFGrafikJadwal_backup = class(TForm)
    sg1: TAdvStringGrid;
    AdvGroupBox2: TAdvGroupBox;
    AdvSmoothButton1: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    vtemp_date: TVirtualTable;
    vtemp_datetglawal: TDateField;
    vtemp_datetglakhir: TDateField;
    DataSource1: TDataSource;
    SQ1: TFDQuery;
    SQ2: TFDQuery;
    SQ3: TFDQuery;
    SQ4: TFDQuery;
    SQDelete: TFDQuery;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    dt: TDateTimePicker;
    Label2: TLabel;
    cbDIvisi: TAdvSmoothComboBox;
    Q4: TMyQuery;
    Q5: TMyQuery;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    Label3: TLabel;
    cbFixed: TComboBox;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton4: TAdvSmoothButton;
    Label4: TLabel;
    cbItem: TAdvComboBox;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    SpeedButton1: TSpeedButton;
    procedure sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure sg1GetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure sg1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sg1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cbDIvisiItemCheckClick(Sender: TObject; itemindex: Integer;
      checked: Boolean);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbFixedChange(Sender: TObject);
    procedure cbDIvisiItemChanged(Sender: TObject; itemindex: Integer);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure dtCloseUp(Sender: TObject);
    procedure cbItemChange(Sender: TObject);
    procedure sg1Enter(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure sg1DateTimeChange(Sender: TObject; ACol, ARow: Integer;
      ADateTime: TDateTime);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }

    isShow : Boolean;
    procedure ResetColor(ARow : Integer;Acol:integer);

  public
    { Public declarations }
    isFocusForm : Boolean;
    divisi_selected : String;
    const
      warna : Array[0..19] of TColor = ($000080FF,$7280FA,$228B22,$D0E040,$B469FF,$CD5A6A,
                               $4F4F2F,	$DEC4B0,$3C14DC,$008080,$5C5CCD,$009BE452,
                               $003E9EFF,$0082C0FF,$004F4FFF,	$00FF5353,$00FFBA2B,$006BB6B6,
                               $00BABA74,$005EFFFF);
    procedure CreateGrid;
    procedure TampilAwal;
    procedure KosongkanGrid;
    procedure CreateChart;
    procedure ResetChart;
    procedure GenerateDate(ARow : integer;ADate:TDate);
   // procedure UpdateDate(ADate:TDate);
    procedure UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
    function convertDate(AStr:String):String;
    function toDate(AStr:String):TDate;
    function IdDivisi : String;
    function FindDivisi(id_divisi:integer):integer;
    procedure Col12(Arow:Integer);
    procedure Col10(Arow:Integer);
    function GetStarDate(ADate:TDate;id_divisi:String;KapasitasDivisi:Integer;var KapasitasTerpakai:Integer):TDate;
    function FindStartRow:Integer;
    procedure SaveGC;
    procedure addLocal;
    function findStartDate:TDate;
    function StartDateTemp : TDate;
    function startEdit:integer;
    function finishEdit:integer;
    function IndexLastItem:Integer;
  end;

var
  FGrafikJadwal_backup: TFGrafikJadwal_backup;
  IndexWarna : Integer;

implementation

{$R *.dfm}

uses uListofSoGant, uDataGanttChart, uMarCon, uGanttChatParameters, uLoading,
  uGanttChart, uCancelDate;

{ TFGanttChart }

procedure TFGrafikJadwal_backup.A1Click(Sender: TObject);
begin
  FCancelDate.EGCCode.Text := sg1.Cells[19,sg1.Row];
  FCancelDate.ShowModal;

end;

procedure TFGrafikJadwal_backup.addLocal;
var
  _Bulk : String;

begin

  SQ1.Close;
  SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
  SQ1.ExecSQL;

  ExQry(Q1,'SELECT * FROM detailjadwal WHERE tgl>="'+Tanggal(dt.Date)+'"',True);

  _bulk := '';
  while not Q1.Eof do begin
    _bulk := _bulk+'('+GetVal(Q1,'id_divisi')+',"'+Tanggal(GetValDate(Q1,'tgl'))+'",'+
    ''+GetVal(Q1,'total_menit')+',"'+GetVal(Q1,'gc_code')+'",'+GetVal(Q1,'item_id')+','+
    ''+GetVal(Q1,'qty_order')+','+GetVal(Q1,'kapasitas')+','+
    ''+GetVal(Q1,'manhour')+','+GetVal(Q1,'no_urut')+','+
    ''+IntToStr(GetValInt(Q1,'jam_kerja'))+','+IntToStr(GetValInt(Q1,'alokasi_tng_kerja'))+',0),';
    Q1.Next;

  end;

  Delete(_bulk,length(_bulk),1);
  if Length(_bulk) > 5 then begin

      SQ1.Close;
      SQ1.SQL.Text := 'INSERT INTO detail_Jadwal (id_divisi,tgl,total_menit,gc_code,'+
      'item_id,qty_order,kapasitas,manhour,no_urut,jam_kerja,alokasi_tng_kerja,is_edit)' +
      'VALUES '+_bulk;
      SQ1.ExecSQL;
  end;
  SQ1.Close;
end;

procedure TFGrafikJadwal_backup.AdvSmoothButton1Click(Sender: TObject);

begin
  AdvGridExcelIO1.XLSExport(' GANT CHART '+FormatDateTime('dd mmmm yyyy',dt.Date)+'.xls');
end;

procedure TFGrafikJadwal_backup.AdvSmoothButton2Click(Sender: TObject);
begin
  FGanttChart.CreateGrid;
  FGanttChart.TampilAwal;
  FGanttChart.ShowModal;
end;

procedure TFGrafikJadwal_backup.AdvSmoothButton3Click(Sender: TObject);
begin
  if sg1.Cells[16,sg1.Row] = '' then
  begin
    Error('Silahkan pilih Item yang akan dihapus !');
    Exit;
  end else begin
    if MessageDlg('Apakah yakin Item '+sg1.Cells[1,sg1.Row]+' Akan dihapus ??',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      ExQry(Q1,'DELETE FROM gant_detail WHERE item_id="'+sg1.Cells[16,sg1.Row]+'" '+
      ' AND gantt_code="'+sg1.Cells[19,sg1.Row]+'" ',False);

      ExQry(Q1,'DELETE FROM detailjadwal WHERE item_id="'+sg1.Cells[16,sg1.Row]+'" '+
      ' AND gc_code="'+sg1.Cells[19,sg1.Row]+'" ',False);

      SQ1.Close;
      SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
      SQ1.ExecSQL;


      CreateGrid;
      CreateChart;

    end;
  end;

end;

procedure TFGrafikJadwal_backup.AdvSmoothButton4Click(Sender: TObject);
begin
  FDataGanttChart.ShowModal;
end;

procedure TFGrafikJadwal_backup.btnAddClick(Sender: TObject);
begin
  Close;
end;

procedure TFGrafikJadwal_backup.cbDIvisiItemChanged(Sender: TObject;
  itemindex: Integer);
begin
  if itemindex = 0 then begin
     CreateGrid;
     CreateChart;

  end;
end;

procedure TFGrafikJadwal_backup.cbDIvisiItemCheckClick(Sender: TObject;
  itemindex: Integer; checked: Boolean);
begin

  isShow := False;
  if itemindex = 0 then begin
     divisi_selected := '';

  end else begin
     if checked  then
        divisi_selected := divisi_selected +'"'+ cbDIvisi.Items.Items[itemindex].Info +'",'
     else
        Delete(divisi_selected,POS('"'+cbDIvisi.Items.Items[itemindex].Info+'"',divisi_selected),Length('"'+cbDIvisi.Items.Items[itemindex].Info+'",'));


  end;

  if Length(divisi_selected) < 3 then
  divisi_selected := '';



  CreateChart;
end;

procedure TFGrafikJadwal_backup.cbFixedChange(Sender: TObject);
begin
  if cbFixed.ItemIndex =0  then begin
     sg1.FixedCols := 0;
  end else begin
     sg1.FixedCols := cbFixed.ItemIndex + 1;
  end;
end;

procedure TFGrafikJadwal_backup.cbItemChange(Sender: TObject);
var
  i : integer;
  Arow : integer;
begin
  sg1.Col := 3;
  for i := 2 to sg1.RowCount -1 do begin
     if sg1.Cells[16,i] = GetIdcmb(cbItem) then
     begin
       Arow := i ;
       sg1.Row := i +1;
       sg1.Options := sg1.Options + [GoRowSelect];
       Break;
     end;

  end;

end;

procedure TFGrafikJadwal_backup.Col10(Arow:Integer);
var
  i , x , j         : integer;
  MinTgl            : TDate;
  MaxTgl            : TDate;
  RangeTanggal      : Integer;
  ColumnCounter     : Integer;
  TglMulai          : TDate;
  TglAkhir          : TDate;
  Hari              : integer;
  PlusHari          : Real;
  RangeHari         : Integer;
  Jamkerja          : Integer;
  JumlahKaryawan    : Integer;
  ManHour           : Integer;
  KapasitasDivisi   : Integer;
  AlokasiWaktu      : Integer;
  KapasitasTerpakai : Integer;
  TglSebelum        : TDate;
  BaseManhour       : Integer;
  NextDate          : TDate;
  gapDate           : Integer;
begin

  try
     if sg1.Cells[14,Arow-1] = '' then begin
        SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,Arow]+'" '+
           ' AND id_divisi="'+sg1.Cells[14,Arow]+'" ORDER BY tgl ASC limit 1');

        if SQ1.IsEmpty then
           TglMulai := dt.Date else
           TglMulai   :=  SQ1.FieldByName('tgl').AsDateTime;
        //ShowMessage(Tanggal(TglMulai));
     end else if sg1.Cells[14,Arow-1] <> '' then begin
        SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,Arow]+'" '+
           ' AND id_divisi="'+sg1.Cells[14,Arow-1]+'" ORDER BY tgl DESC limit 1');
        tglMulai   :=  SQ1.FieldByName('tgl').AsDateTime + 1;
     end;

    Hari            :=  StrToIntDef(sg1.Cells[9,Arow],0);
    PlusHari        :=  StrToFloatDef(StringReplace(sg1.Cells[10,Arow],'.',',',[rfReplaceAll]),0);
    TglAkhir        :=  TglMulai   + Hari + PlusHari;

    JamKerja        := StrToIntDef(nilai(sg1.Cells[7,Arow]),1);
    JumlahKaryawan  := StrToIntDef(nilai(sg1.Cells[8,Arow]),1);
    ManHour         := StrToIntDef(nilai(sg1.Cells[6,Arow]),1);
    KapasitasDivisi := StrToIntDef(sg1.Cells[15,Arow],0) * (JamKerja * 60);

    BaseManhour     := StrToIntDef(nilai(sg1.Cells[6,Arow]),1);
    AlokasiWaktu    := Jamkerja * JumlahKaryawan * 60;

  if PlusHari > 0 then
     ManHour := ManHour + ROUND(PlusHari * AlokasiWaktu);

     RangeHari := DaysBetween(TglMulai,TglAkhir) ;

   

   SQ2.Close;
   SQ2.SQL.Text :=' UPDATE detail_jadwal SET total_menit=0 WHERE '+
   ' tgl>="'+Tanggal(TglMulai)+'" AND id_divisi="'+sg1.Cells[14,Arow]+'"  AND id_divisi IN ('+IdDivisi+') '+
   ' AND item_id<>"'+sg1.Cells[16,Arow]+'" ';
   SQ2.ExecSQL;

   SQ2.close;
   SQ2.SQL.Text := 'DELETE FROM detail_jadwal WHERE tgl>="'+Tanggal(TglMulai)+'" '+
   ' AND item_id="'+sg1.Cells[16,Arow]+'" AND id_divisi="'+sg1.Cells[14,Arow]+'" '+
   ' AND ( id_divisi IN ('+IdDivisi+') OR no_urut >="'+sg1.Cells[18,Arow]+'")';
   SQ2.ExecSQL;


   for i := 0 to RangeHari -1 do begin


        SQ2.Close;
        SQ2.SQL.Text := 'INSERT INTO detail_jadwal '+
        ' (id_divisi,tgl,item_id,gc_code,total_menit,kapasitas,manhour,no_urut,qty_order) '+
        ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,:total_menit,:kapasitas,:manhour,:no_urut,:qty_order)';
        SQ2.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
        SQ2.ParamByName('tgl').AsDateTime          := (TglMulai) + i ;
        SQ2.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
        SQ2.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
        SQ2.ParamByName('no_urut').AsString        := sg1.Cells[18,Arow];
        SQ2.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
        if  ManHour > AlokasiWaktu then begin

          SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
          ManHour         := ManHour - AlokasiWaktu;
        end else if ManHour <= AlokasiWaktu then begin
                SQ2.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan);
        end;

        SQ2.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
        SQ2.ParamByName('manhour').AsInteger       := BaseManhour;
        SQ2.ExecSQL;

   end;

   Floading.Show;
   Floading.pgbar.Maximum := sg1.RowCount -1;
   Floading.pgbar.Position:= 0;
   sg1.BeginUpdate;

        

   for I := sg1.Row to IndexLastItem -1 do begin
      if  (StrToIntDef(sg1.Cells[18,i],0) >= StrToIntDef(sg1.Cells[18,
                                              FindDivisi(StrToIntDef(sg1.Cells[14,Arow],0))],0)) then begin
          if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

               if i <> Arow then begin
                  if sg1.Cells[14,i-1] = '' then begin

                      SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                         ' AND id_divisi="'+sg1.Cells[14,i]+'" ORDER BY tgl ASC limit 1');

                      if SQ1.IsEmpty then begin

                         NextDate := GetStarDate(TglMulai,sg1.Cells[14,i],KapasitasDivisi,KapasitasTerpakai);
                      end else begin
                        NextDate   :=  SQ1.FieldByName('tgl').AsDateTime;

                      end;

                   end else if sg1.Cells[14,i-1] <> '' then begin
                      SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                         ' AND id_divisi="'+sg1.Cells[14,i-1]+'" ORDER BY tgl DESC limit 1');
                      NextDate   :=  SQ1.FieldByName('tgl').AsDateTime + 1;

                   end;
                 //  ShowMessage(Tanggal(NextDate));
                 GenerateDate(i,NextDate);
               end;
              // dt.Date := StartDateTemp;
               SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
               ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" '+
               ' AND tgl>="'+Tanggal(dt.Date)+'" AND item_id="'+sg1.Cells[16,i]+'" ');
               sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
               sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);

               SQ2.Open('SELECT min(tgl) as stardate,max(tgl) as enddate FROM detail_jadwal '+
               ' WHERE tgl>="'+Tanggal(dt.Date)+'" ');
               MinTgl := toDate(SQ2.FieldByName('stardate').AsString);

               MaxTgl := toDate(SQ2.FieldByName('enddate').AsString);

               RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;
               ColumnCounter  := sg1.ColCount - 21;
               sg1.ColCount   := RangeTanggal + 21;

               for j := 0 to sg1.ColCount -1 do
                     ResetColor(i,j+21);


               for x := 0 to RangeTanggal -1 do begin

                  sg1.Cells[21+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
                  sg1.AddRotated(21+x,0,90,sg1.Cells[21+x,0]);
                  sg1.ColWidths[21+x] := 35;

                  if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
                      sg1.Colors[21+x,0]    := clRed;
                      sg1.ColorsTo[21+x,0]  := $003535FF;
                  end else begin
                      sg1.Colors[21+x,0]    := $00D6D6D6;
                      sg1.ColorsTo[21+x,0]  := clWhite;
                  end;
               end;

                  SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,i]+'"  '+
                  ' AND id_divisi="'+sg1.Cells[14,i]+'" '+
                  ' AND tgl>="'+Tanggal(MinTgl)+'" AND tgl<="'+Tanggal(MaxTgl)+'" ORDER BY tgl ASC ');

                  while not SQ4.Eof do begin
                    if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                      gapDate := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                      sg1.Cells[21+gapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                      sg1.Colors[21+gapDate,i]   := warna[StrToInt(sg1.Cells[3,i])];
                      sg1.ColorsTo[21+gapDate,i] := warna[StrToInt(sg1.Cells[3,i])];
                    end;
                    Application.ProcessMessages;
                    SQ4.Next;
                  end;

          end;
      end;
      Inc(IndexWarna);
      Floading.pgbar.Position := i;
   end;

   sg1.EndUpdate;
   Floading.Close;
  Except
    Floading.Close;
      Error('Terjadi kesalahan dalam pencarian tanggal mulai, Tanggal Mulai Divisi '+
      ' Kurang dari tanggal mulai Divisi Sebelumnya ');
  end;
end;

procedure TFGrafikJadwal_backup.Col12(arow:integer);

var
  i , x , j: integer;
  MinTgl : TDate;
  MaxTgl : TDate;
  RangeTanggal : Integer;
  ColumnCounter : Integer;
  TglMulai : TDate;
  TglAkhir : TDate;
  AjustDate: Integer;
  Hari     : integer;
  RangeHari: Integer;
  Jamkerja          : Integer;
  JumlahKaryawan    : Integer;
  ManHour           : Integer;
  KapasitasDivisi   : Integer;
  AlokasiWaktu      : Integer;
  KapasitasTerpakai : Integer;
  TglSebelum        : TDate;
  BaseManhour       : Integer;
  NextDate          : TDate;
  GapDate           : Integer;
  TempTgl           : TDate;
  plushari          : Integer;
begin

    try
          AjustDate       := StrToIntDef(sg1.Cells[12,Arow],0);

          JamKerja        := StrToIntDef(nilai(sg1.Cells[7,Arow]),1);
          JumlahKaryawan  := StrToIntDef(nilai(sg1.Cells[8,Arow]),1);
          ManHour         := StrToIntDef(nilai(sg1.Cells[6,Arow]),1);
          KapasitasDivisi := StrToIntDef(sg1.Cells[15,Arow],0) * (JamKerja * 60);

          BaseManhour     := StrToIntDef(nilai(sg1.Cells[6,Arow]),1);

          if AjustDate <> 0 then begin

                SQ4.Open('SELECT tgl FROM detail_jadwal WHERE id_divisi="'+sg1.Cells[14,Arow]+'" '+
                ' AND item_id="'+sg1.Cells[16,Arow]+'" AND tgl>="'+Tanggal(dt.date)+'" '+
                ' ORDER BY tgl ASC Limit 1');


                TglMulai := SQ4.FieldByName('tgl').AsDateTime + AjustDate;

          end else begin
             if sg1.Cells[14,Arow -1] <> '' then

             EXQry(Q1,'SELECT tgl FROM detailjadwal WHERE id_divisi="'+sg1.Cells[14,Arow-1]+'" '+
                ' AND item_id="'+sg1.Cells[16,Arow]+'" AND tgl>="'+Tanggal(dt.date)+'" '+
                ' ORDER BY tgl DESC Limit 1',True) else
             EXQry(Q1,'SELECT tgl FROM detailjadwal WHERE id_divisi="'+sg1.Cells[14,Arow]+'" '+
                ' AND item_id="'+sg1.Cells[16,Arow]+'" AND tgl>="'+Tanggal(dt.date)+'" '+
                ' ORDER BY tgl ASC Limit 1',True);

             if Q1.IsEmpty then
                TglMulai := dt.Date else
                TglMulai := GetStarDate(GetValDate(Q1,'tgl'),sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai) ;
          end;

                Hari            :=  StrToIntDef(sg1.Cells[9,Arow],0);
                TglAkhir        :=  TglMulai   + Hari ;
                AlokasiWaktu    :=  Jamkerja * JumlahKaryawan * 60;

                RangeHari := DaysBetween(TglMulai,TglAkhir);

                 Floading.Show;
                 Floading.pgbar.Maximum := sg1.RowCount -1;
                 Floading.pgbar.Position:= 0;
                 Floading.Lprocess.Caption := 'Sedang Proses Data';
                  if AjustDate < 0 then begin

                         if AlokasiWaktu >= KapasitasDivisi then begin

                             SQ2.Close;
                             SQ2.SQL.Text := 'UPDATE detail_jadwal SET total_menit=0 WHERE '+
                             ' (id_divisi in ('+IdDivisi+') AND id_divisi="'+sg1.Cells[14,Arow]+'"  AND no_urut >='+sg1.Cells[18,Arow]+') AND ';

                             if AjustDate > 0 then
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai-AjustDate)+'" ' else
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai)+'" ';

                             SQ2.ExecSQL;
                         end else begin

                             SQ2.Close;
                             SQ2.SQL.Text := 'UPDATE detail_jadwal SET total_menit=0 WHERE '+
                             ' (id_divisi in ('+IdDivisi+')  AND id_divisi="'+sg1.Cells[14,Arow]+'" OR no_urut >='+sg1.Cells[18,Arow]+') '+
                             ' AND item_id="'+sg1.Cells[16,Arow]+'" AND ';

                             if AjustDate > 0 then
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai-AjustDate)+'" ' else
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai)+'" ';


                             SQ2.ExecSQL;

                             //ShowMessage(SQ2.SQL.Text);
                         end;




                        for i := 0 to RangeHari -1 do begin
                          SQ2.Close;
                          SQ2.SQL.Text := 'INSERT INTO detail_jadwal '+
                          ' (id_divisi,tgl,item_id,gc_code,total_menit,kapasitas,manhour,no_urut,qty_order) '+
                          ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,:total_menit,:kapasitas,:manhour,:no_urut,:qty_order)';
                          SQ2.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                          if StrToIntDef(sg1.Cells[12,Arow],0) >= 0 then
                          SQ2.ParamByName('tgl').AsDateTime          := TglMulai + i  else
                          SQ2.ParamByName('tgl').AsDateTime          := TglMulai + i;
                          SQ2.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                          SQ2.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                          SQ2.ParamByName('no_urut').AsString        := sg1.Cells[18,Arow];
                          SQ2.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);


                          if  ManHour > AlokasiWaktu then begin

                            SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                            ManHour         := ManHour - AlokasiWaktu;
                          end else if ManHour <= AlokasiWaktu then begin

                           SQ2.ParamByName('total_menit').AsInteger    := ROUND(ManHour/JumlahKaryawan);
                          end;

                          SQ2.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                          SQ2.ParamByName('manhour').AsInteger       := BaseManhour;
                          SQ2.ExecSQL;

                      end;


                 end else if AjustDate > 0 then begin

                     if AlokasiWaktu >= KapasitasDivisi then  begin

                         SQDelete.Close;
                         SQDelete.SQL.Text := 'UPDATE detail_jadwal set total_menit=0 WHERE '+
                         ' (id_divisi in ('+IdDivisi+') AND id_divisi="'+sg1.Cells[14,Arow]+'"  OR no_urut >= "'+sg1.Cells[18,Arow]+'")'+
                         ' AND tgl>="'+Tanggal(TglMulai-AjustDate)+'" ';
                         SQDelete.ExecSQL;
                     end else begin
                         SQDelete.Close;
                         SQDelete.SQL.Text := 'UPDATE detail_jadwal set total_menit=0 WHERE '+
                         ' (id_divisi in ('+IdDivisi+') AND id_divisi="'+sg1.Cells[14,Arow]+'"  OR no_urut >= "'+sg1.Cells[18,Arow]+'")'+
                         ' AND tgl>="'+Tanggal(TglMulai-AjustDate)+'" AND item_id="'+Sg1.Cells[16,Arow]+'"';
                         SQDelete.ExecSQL;
                     end;

                     for i := 0 to RangeHari -1 do begin
                          SQ2.Close;
                          SQ2.SQL.Text := 'INSERT INTO detail_jadwal '+
                          ' (id_divisi,tgl,item_id,gc_code,total_menit,kapasitas,manhour,no_urut,qty_order) '+
                          ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,:total_menit,:kapasitas,:manhour,:no_urut,:qty_order)';
                          SQ2.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                          if StrToIntDef(sg1.Cells[12,Arow],0) >= 0 then
                          SQ2.ParamByName('tgl').AsDateTime          := TglMulai + i  else
                          SQ2.ParamByName('tgl').AsDateTime          := TglMulai + i;
                          SQ2.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                          SQ2.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                          SQ2.ParamByName('no_urut').AsString        := sg1.Cells[18,Arow];
                          SQ2.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);


                          if  ManHour > AlokasiWaktu then begin

                            SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                            ManHour         := ManHour - AlokasiWaktu;
                          end else if ManHour <= AlokasiWaktu then begin

                           SQ2.ParamByName('total_menit').AsInteger    := ROUND(ManHour/JumlahKaryawan);
                          end;

                          SQ2.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                          SQ2.ParamByName('manhour').AsInteger       := BaseManhour;
                          SQ2.ExecSQL;

                      end;
                 end else begin

                     SQDelete.Close;
                     SQDelete.SQL.Text := 'DELETE FROM detail_jadwal '+
                     ' WHERE id_divisi IN ('+IdDivisi+') OR id_divisi="'+sg1.Cells[14,Arow]+'"  '+
                     ' AND item_id="'+sg1.Cells[16,Arow]+'" ';
                     SQDelete.ExecSQL;


                     SQDelete.Close;
                     SQDelete.SQL.Text := 'DELETE FROM detail_jadwal WHERE '+
                     ' (id_divisi in ('+IdDivisi+') OR no_urut > "'+sg1.Cells[18,Arow]+'") '+
                     ' AND tgl>="'+Tanggal(TglMulai-AjustDate)+'" ';
                     SQDelete.ExecSQL;


                     for i := 0 to RangeHari -1 do begin
                          SQ2.Close;
                          SQ2.SQL.Text := 'INSERT INTO detail_jadwal '+
                          ' (id_divisi,tgl,item_id,gc_code,total_menit,kapasitas,manhour,no_urut,qty_order) '+
                          ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,:total_menit,:kapasitas,:manhour,:no_urut,:qty_order)';
                          SQ2.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                          if StrToIntDef(sg1.Cells[12,Arow],0) >= 0 then
                          SQ2.ParamByName('tgl').AsDateTime          := TglMulai + i  else
                          SQ2.ParamByName('tgl').AsDateTime          := TglMulai + i;
                          SQ2.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                          SQ2.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                          SQ2.ParamByName('no_urut').AsString        := sg1.Cells[18,Arow];
                          SQ2.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);


                          if  ManHour > AlokasiWaktu then begin

                            SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                            ManHour         := ManHour - AlokasiWaktu;
                          end else if ManHour <= AlokasiWaktu then begin

                           SQ2.ParamByName('total_menit').AsInteger    := ROUND(ManHour/JumlahKaryawan);
                          end;

                          SQ2.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                          SQ2.ParamByName('manhour').AsInteger       := BaseManhour;
                          SQ2.ExecSQL;

                      end;
                 end;



                 sg1.BeginUpdate;

           

                  for I := sg1.Row to IndexLastItem -1 do begin


                  //  if  (StrToIntDef(sg1.Cells[18,i],0) >= StrToIntDef(sg1.Cells[18,
                  //                                  FindDivisi(StrToIntDef(sg1.Cells[14,Arow],0))],0)) then begin

                      //  ShowMessage(sg1.Cells[18,i]+' '+sg1.Cells[18,
                      //                              FindDivisi(StrToIntDef(sg1.Cells[14,Arow],0))]);

                        if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin
                      
                            if i <> Arow then begin
                                if sg1.Cells[14,i-1] = '' then begin

                                    SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                                       ' AND id_divisi="'+sg1.Cells[14,i]+'" AND total_menit > 0 ORDER BY tgl ASC limit 1');

                                    if SQ1.IsEmpty then begin

                                       NextDate := GetStarDate(TglMulai,sg1.Cells[14,i],KapasitasDivisi,KapasitasTerpakai);
                                    end else begin
                                      NextDate   :=  SQ1.FieldByName('tgl').AsDateTime;

                                    end;

                                 end else if sg1.Cells[14,i-1] <> '' then begin
                           
                      
                                    SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                                       ' AND id_divisi="'+sg1.Cells[14,i-1]+'" AND total_menit>0 ORDER BY tgl DESC limit 1');

                                    if AjustDate <> 0 then begin

                                        if SQ1.FieldByName('tgl').AsDateTime < TglMulai then
                                            NextDate   :=  TglMulai else
                                            NextDate   :=  SQ1.FieldByName('tgl').AsDateTime +1;
                                    end else
                                            NextDate   :=  SQ1.FieldByName('tgl').AsDateTime +1;


                              //     ShowMessage('SQL : '+SQ1.SQL.Text+#13+' '+Tanggal(NextDate)+' Divisi : '+sg1.Cells[4,i]+' Item Id : '+sg1.Cells[16,i]+' ID DIVISI : '+sg1.Cells[14,i]);
                                 end;

                              GenerateDate(i,NextDate);
                            end;

                     //   end;
                    end;
                  //  dt.Date := StartDateTemp;

                    SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
                              ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND '+
                              ' item_id="'+sg1.Cells[16,i]+'" AND total_menit>0 ');

                    if (SQ4.FieldByName('Startdate').AsString <> '') and (SQ4.FieldByName('Enddate').AsString <> '') then begin

                    sg1.Dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
                    sg1.Dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);
                    end;

                     SQ2.Open('SELECT min(tgl) as StartDate,Max(tgl) as EndDate FROM detail_jadwal '+
                     ' WHERE  total_menit>0 AND tgl>="'+Tanggal(dt.Date)+'"');
                     MinTgl := toDate(SQ2.FieldByName('StartDate').AsString);
                     MaxTgl := toDate(SQ2.FieldByName('EndDate').AsString);

                     RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 2;
                     sg1.ColCount   := 21;
                     sg1.ColCount   := RangeTanggal + 21;

                     for j := 0 to sg1.ColCount -1 do begin
                           sg1.Cells[21+j,0] := '';
                           ResetColor(i,j+21);
                     end;

                       for x := 0 to RangeTanggal -1 do begin

                    
                          sg1.Cells[21+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
                          sg1.AddRotated(21+x,0,90,sg1.Cells[21+x,0]);
                          sg1.ColWidths[21+x] := 35;



                          if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
                              sg1.Colors[21+x,0]    := clRed;
                              sg1.ColorsTo[21+x,0]  := $003535FF;
                          end else begin
                              sg1.Colors[21+x,0]    := $00D6D6D6;
                              sg1.ColorsTo[21+x,0]  := clWhite;
                          end;
                       end;

                        SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,i]+'"  '+
                        ' AND id_divisi="'+sg1.Cells[14,i]+'" AND '+
                        ' tgl>="'+Tanggal(MinTgl)+'" AND tgl<="'+Tanggal(MaxTgl)+'" '+
                        ' AND total_menit>0');

                        while  not SQ4.Eof do begin


                            if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                              GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                              sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                              sg1.Colors[21+GapDate,i]   := warna[StrToInt(sg1.Cells[3,i])];
                              sg1.ColorsTo[21+GapDate,i] := warna[StrToInt(sg1.Cells[3,i])];
                            end;
                              SQ4.Next;
                        end;
                      Application.ProcessMessages;
                      Inc(IndexWarna);
                    Floading.pgbar.Position := i;

                  end;
                 Floading.Close;
                 sg1.EndUpdate;

                 sg1.FloatFormat            := '%.0n';
                  for i := 21 to sg1.ColCount-1 do begin
                      sg1.FloatingFooter.ColumnCalc[i] := acSUM;
                      sg1.FontSizes[i,sg1.RowCount-1]  := 6;
                      sg1.FontStyles[i,sg1.RowCount-1] := Font.Style - [fsBold];
                  end;
                 SQ1.Close;
                 SQ1.SQL.Text := 'DELETE FROM detail_jadwal WHERE total_menit=0';
                 SQ1.ExecSQL;
    Except
      Floading.Close;
      Error('Terjadi kesalahan dalam pencarian tanggal mulai, Tanggal Mulai Divisi '+
      ' Kurang dari tanggal mulai Divisi Sebelumnya ');
    end;


end;

function TFGrafikJadwal_backup.convertDate(AStr: String): String;
var
  dd    : String;
  mm    : String;
  yy    : String;
  Ls    : TStringList;
  i     : integer;
  aDate : TDate;
  ResultString : String;
  newMonth : String;
begin
  ls  := TStringList.Create;
  try

    SplitString('-',AStr,ls);
    dd := ls[0];
    mm := ls[1];
    yy := ls[2];

    for I := 1 to 12 do begin
      aDate := EncodeDate(YearOf(now),i,1);
      if FormatDateTime('mmm',aDate) = mm then begin
         newMonth := IntToStr(i);
         Break;
      end;
    end;

    ResultString := dd+'/'+newMonth+'/'+yy;
    Result := ResultString;
  finally
    ls.Free;
  end;
end;

procedure TFGrafikJadwal_backup.CreateChart;
var
  tglMulai  : TDate;
  tglAkhir  : TDate;
  i, RangeHari,j : Integer;
  IndexImage ,IndexRow,r,MergeCOunt: integer;
  urut : integer;
  _SQL : String;
  jpg  : TJPEGImage;
  bs   : TStream;
  GapDate : Integer;
begin

  r := 0;
  urut := 1;

  sg1.BeginUpdate;
  sg1.FloatingFooter.Visible := False;
  CreateGrid;
  dt.Date := findStartDate;

  addLocal;

  if cbItem.ItemIndex >= 0 then
  ExQry(Q1,'SELECT MIN(tgl) as tglmulai,MAX(tgl) as tglakhir FROM detailjadwal '+
        ' WHERE   tgl >="'+Tanggal(dt.Date)+'" AND item_id="'+GetIdcmb(cbItem)+'" ',True)
  else
  ExQry(Q1,'SELECT MIN(tgl) as tglmulai,MAX(tgl) as tglakhir FROM detailjadwal '+
        ' WHERE   tgl >="'+Tanggal(dt.Date)+'" ',True);

  tglMulai := Q1.FieldByName('tglmulai').AsDateTime;
  tglAkhir := Q1.FieldByName('tglakhir').AsDateTime;

  RangeHari     := DaysBetween(tglMulai,tglAkhir) + 1;
  sg1.ColCount  := 21;
  sg1.ColCount  := sg1.ColCount + RangeHari+1;

  for i := 0 to RangeHari do begin

   sg1.Cells[21+i,0]   :=  FormatDateTime('dd-mmm-yyyy',tglMulai + i);
   sg1.AddRotated(21+i,0,90,sg1.Cells[21+i,0]);
   sg1.ColWidths[21+i] := 40;

   if (FormatDateTime('dddd',tglMulai + i) ='Minggu') or (FormatDateTime('dddd',tglMulai + i) ='Sunday') then begin
      sg1.Colors[21+i,0]    := clRed;
      sg1.ColorsTo[21+i,0]  := $003535FF;
   end else begin
      sg1.Colors[21+i,0]    := $00D6D6D6;
      sg1.ColorsTo[21+i,0]  := clWhite;
   end;

  end;


  if isShow then begin

    Floading.Show;
    Floading.pgbar.Maximum := RangeHari;
    Floading.pgbar.Position:= 1;
    Floading.Lprocess.Caption := 'Sedang mem-proses data gantt chart ....';
  end;
  IndexImage := 0;

    if cbItem.ItemIndex >= 0 then
    ExQry(Q1,'SELECT DISTINCT i.id,i.itemno,d.deskripsi,d.qty_order,'+
    ' g.so_no,g.tgl_input,g.cancel_date,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
    ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
    ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'" AND d.item_id="'+GetIdcmb(cbItem)+'" ',True)
    else
    ExQry(Q1,'SELECT DISTINCT i.id,i.itemno,d.deskripsi,d.qty_order,'+
    ' g.so_no,g.tgl_input,g.cancel_date,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
    ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
    ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'" ',True);

    while not Q1.Eof do begin

      with sg1 do begin

          Cells[1,r+1] := GetVal(Q1,'deskripsi');
          Cells[1,r+2] := 'No SO : '+ GetVal(Q1,'so_no');
          Cells[1,r+3] := 'Tgl Input : '+ GetVal(Q1,'tgl_input');
          Cells[1,r+4] := 'Cancel Date : '+ GetVal(Q1,'cancel_date');
          Cells[2,r+1] := GetVal(Q1,'qty_order');
          Cells[0,r+1] := IntToStr(Urut);
          Cells[19,r+1]:= GetVal(Q1,'gantt_code');
          Cells[16,r+1]:= GetVal(Q1,'id');

          if  Length(divisi_selected) > 0 then
             _SQL := 'SELECT g.*,i.id as itemid FROM gant_detail g LEFT JOIN '+
             ' item i ON i.itemno=g.itemno WHERE g.itemno="'+GetVal(Q1,'itemno')+'" AND '+
             ' g.gantt_code="'+GetVal(Q1,'gantt_code')+'" '+
             ' AND g.id_divisi in ('+Copy(divisi_selected,1,Length(divisi_selected)-1)+') ' else
              _SQL := 'SELECT g.*,i.id as itemid FROM gant_detail g LEFT JOIN '+
             ' item i ON i.itemno=g.itemno WHERE g.itemno="'+GetVal(Q1,'itemno')+'" AND '+
             ' g.gantt_code="'+GetVal(Q1,'gantt_code')+'" ';
              ExQry(Q2,_SQL,True);

          indexRow    := r + 1;
          j           := r + 1;
          MergeCount  := 0;

          while not Q2.Eof do begin
              RowCount     := RowCount + 1;
              Cells[3, indexRow +1 ]    := GetVal(Q2,'step_process');
              Cells[4, indexRow +1 ]    := GetVal(Q2,'keterangan');
              if GetValInt(Q2,'tng_kerja') = 0 then
              Cells[5, indexRow +1]    := GetVal(Q2,'tng_plan') else
              Cells[5, indexRow +1]    := GetVal(Q2,'tng_kerja');
              ExQry(Q4,'SELECT                                   '+
                        '    d.id,                        '+
                        '    SUM(sp.cost) as cost,sp.no_urut,                        '+
                        '    SUM(sp.cost) / 200 as menit   '+
                        '  FROM                                   '+
                        '    setting_process sp                     '+
                        '    LEFT JOIN pekerjaan p ON p.id=sp.id_pekerjaan '+
                        '    LEFT JOIN divisi d ON d.id=p.id_divisi   '+
                        '    LEFT JOIN item i ON i.id=sp.item_id '+
                        '  WHERE d.id="'+GetVal(Q2,'id_divisi')+'" '+
                        '  AND i.itemno="'+GetVal(Q1,'itemno')+'" ',True);

              if (ROUND(GetValF(Q4,'menit') * GetValF(Q1,'qty_order'))) <> GetValF(Q2,'manhour')  then
              begin
                Cells[6,indexRow+1]      := Format('%.0n',[GetValF(Q4,'menit') * GetValF(Q1,'qty_order')]);
                Colors[6,indexRow+1]     := clRed;
                ColorsTo[6,indexRow+1]   := clRed;
              end else
              Cells[6, indexRow +1]    := GetValR(Q2,'manhour');
              Cells[7, indexRow +1]    := GetVal(Q2,'jam_kerja');
              Cells[8, indexRow +1]    := GetVal(Q2,'alokasi_tng_kerja');
              Cells[9, indexRow +1]    := GetVal(Q2,'hari');
              Cells[10,indexRow +1]    := GetVal(Q2,'plusmin_hari');
              Cells[11,indexRow +1]    := GetVal(Q2,'tgl_mulai');
              Cells[12,indexRow +1]    := '';
              Cells[13,indexRow +1]    := GetVal(Q2,'tgl_akhir');
              Cells[14,indexRow +1]    := GetVal(Q2,'id_divisi');
              Cells[15,indexRow +1]    := FloatToStr(GetValF(Q2,'tng_kerja') * GetValF(Q2,'jam_kerja') * 60 );
              Cells[16,indexRow +1]    := GetVal(Q2,'itemid');
              Cells[17,indexRow +1]    := GetVal(Q1,'qty_order');
              Cells[18,indexRow +1]    := GetVal(Q4,'no_urut');
              Cells[19,indexRow +1]    := GetVal(Q1,'gantt_code');




              SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE '+
                   ' item_id="'+GetVal(Q2,'itemid')+'"  '+
                   ' AND id_divisi="'+GetVal(Q2,'id_divisi')+'" '+
                   ' AND tgl>="'+Tanggal(tglMulai)+'" AND tgl<="'+Tanggal(tglAkhir)+'" ORDER BY tgl ASC');

              SQ4.First;

              while SQ4.Eof = False do begin

               if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                 GapDate := DaysBetween(tglMulai,SQ4.FieldByName('tgl').AsDateTime);
                 sg1.Cells[21+GapDate,indexRow +1]    := SQ4.FieldByName('total_menit').AsString;
                 sg1.Colors[21+GapDate,indexRow +1]   := warna[StrToInt(GetVal(Q2,'id_divisi'))];
                 sg1.ColorsTo[21+GapDate,indexRow +1] := warna[StrToInt(GetVal(Q2,'id_divisi'))];
                 sg1.FontSizes[21+GapDate,IndexRow + 1] := 8;
               end;
               SQ4.Next;
              end;





          Q2.Next;
          Inc(indexRow);
          Inc(MergeCount);
          sg1.MergeCells(1,j+1+3,1,MergeCount-2);
          Application.ProcessMessages;


        end;
        Inc(urut);


        ExQry(Q4,'SELECT img FROM item WHERE itemno="'+GetVal(Q1,'itemno')+'"',True);
          if not Q4.FieldByName('img').IsNull then begin
            bs          := Q4.CreateBlobStream(Q4.FieldByName('img'),bmRead);
            jpg         :=TJPEGImage.Create;
            jpg.LoadFromStream(bs);

            CreatePicture(1,j+1+3  ,True,StretchWithAspectRatio,1,haCenter,vaCenter).Assign(jpg);
            bs.Free;
            jpg.Free;
          end;
       r :=  indexRow +1;
       Q1.Next;
       if isShow then
       Floading.pgbar.Position := r;
      RowCount := RowCount + 2;
      Application.ProcessMessages;
    end;
  end;

  sg1.FloatingFooter.Visible := True;


  sg1.EndUpdate;
  sg1.FloatFormat            := '%.0n';
  for i := 21 to sg1.ColCount-1 do begin
      sg1.FloatingFooter.ColumnCalc[i] := acSUM;
      sg1.FontSizes[i,sg1.RowCount-1]  := 6;
      sg1.FontStyles[i,sg1.RowCount-1] := Font.Style - [fsBold];
  end;
  if isShow then begin

  Floading.pgbar.Position := Floading.pgbar.Maximum;
  Floading.Close;
  end;
end;





procedure TFGrafikJadwal_backup.CreateGrid;
begin
  with sg1 do begin
     ClearAll;

     ColCount   := 21;
     RowCount   := 2;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Code / Description';
     Cells[2,0] := 'Order';
     Cells[3,0] := 'Step';
     Cells[4,0] := 'Keterangan';
     Cells[5,0] := 'Jml Tng';
     Cells[6,0] := 'ManHour';
     Cells[7,0] := 'Jam Kerja';
     Cells[8,0] := 'Alokasi Tng';
     Cells[9,0] := 'Hari';
     Cells[10,0] := 'Hari (+/-)';
     Cells[11,0] := 'Tgl Mulai';
     Cells[12,0] := '(+/-)';
     Cells[13,0] := 'Tgl Selesai';
     Cells[14,0] := 'Id Divisi';
     Cells[15,0] := 'Default Kapasitas';
     Cells[16,0] := 'Item Id';
     Cells[17,0] := 'Order';
     Cells[18,0] := 'nourut';
     Cells[19,0] := 'gc_code';
     Cells[20,0] := 'edit';

     ColWidths[0] := 50;
     ColWidths[1] := 150;
     ColWidths[2] := 40;
     ColWidths[3] := 35;
     ColWidths[4] := 120;
     ColWidths[5] := 40;
     ColWidths[6] := 60;
     ColWidths[7] := 40;
     ColWidths[8] := 50;
     ColWidths[9] := 30;
     ColWidths[10] := 50;
     ColWidths[11] := 70;
     ColWidths[12] := 40;
     ColWidths[13] := 70;
     ColWidths[14] := 0;
     ColWidths[15] := 0;
     ColWidths[16] := 0;
     ColWidths[17] := 0;
     ColWidths[18] := 0;
     ColWidths[19] := 0;
     ColWidths[20] := 0;

  end;
end;

procedure TFGrafikJadwal_backup.dtCloseUp(Sender: TObject);
begin
   // CreateGrid;
  CreateChart;
end;

procedure TFGrafikJadwal_backup.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Simpan posisi Gantt Chart Saat ini ? ',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
   // if divisi_selected <> '' then
       SaveGC;
  end else
  divisi_selected := '';

  SQ1.Close;
  SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
  SQ1.ExecSQL;

  CanClose := True;

end;

procedure TFGrafikJadwal_backup.FormCreate(Sender: TObject);
begin
    isShow := True;
    dt.Date := findStartDate;


end;

procedure TFGrafikJadwal_backup.FormShow(Sender: TObject);
var
  _bulk : String;
  i : integer;
begin


 SQ1.Close;
 SQ1.SQL.Text := ' DELETE FROM detail_jadwal ';
 SQ1.ExecSQL;



  Q1.Close;
  Q1.SQL.Text := 'SELECT id,name FROM divisi ORDER BY divno ASC ';
  Q1.Open;


  cbDIvisi.BeginUpdate;
  cbDIvisi.Items.Clear;

  with cbDIvisi.Items.Add do begin
    Caption := '--- ALL ---';
    GraphicLeftType   := gtCheckBox;
  end;
  while not Q1.Eof do begin
    with cbDIvisi.Items.Add do begin
      Caption           := Q1.FieldByName('name').AsString;
      GraphicLeftType   := gtCheckBox;
      Checked           := False;
      Info              := Q1.FieldByName('id').AsString;
    end;
    Q1.Next;

  end;
  cbDIvisi.EndUpdate;


  addLocal;
  CreateGrid;
  CreateChart;

  cbFixed.Items.Clear;
  cbFixed.Items.Add('Unfixed all column');
  for i := 0 to 13 do begin
    cbFixed.Items.Add(sg1.Cells[i,0]);
  end;


end;

procedure TFGrafikJadwal_backup.GenerateDate(ARow: integer;ADate:TDate);
var
  Jamkerja          : Integer;
  JumlahKaryawan    : Integer;
  ManHour           : Integer;
  KapasitasDivisi   : Integer;
  AlokasiWaktu      : Integer;
  LamaHari          : Integer;
  ExtendHari        : integer;
  KapasitasTerpakai : Integer;
  i,x,y,j               : integer;
  SelisihHari       : integer;
  DateCounterDB     : integer;
  ColumnCounter     : integer;
  MinTgl            : TDate;
  MaxTgl            : TDate;
  RangeTanggal      : Integer;
  MenitPerTanggal   : Integer;
  SisaKapasitas     : Integer;
  SisaManHour       : Integer;
  SisaKapasitasTanggal : Integer;
  GapStartDateDivisi: integer;
  AjustDate         : Integer;
  BaseManhour       : integer;
  KapasitasSudahDipakai : integer;
  AList : TListItem;
  StartDate : TDate;
  NextDate  : TDate;
  NoUrut    : Integer;
  plusHari  : Integer;
  JmlTgl    : Integer;
  TglTerakhir : TDate;

begin


  JamKerja        := StrToIntDef(nilai(sg1.Cells[7,ARow]),1);
  JumlahKaryawan  := StrToIntDef(nilai(sg1.Cells[8,ARow]),1);
  ManHour         := StrToIntDef(nilai(sg1.Cells[6,ARow]),1);
  BaseManhour     := StrToIntDef(nilai(sg1.Cells[6,ARow]),1);
  NoUrut          := StrToIntDef(nilai(sg1.Cells[18,ARow]),0);
  KapasitasDivisi := StrToIntDef(sg1.Cells[15,ARow],0);


  if (JamKerja > 0) and (JumlahKaryawan > 0) and (ManHour > 0) then begin

          AlokasiWaktu      := Jamkerja * JumlahKaryawan * 60;
          LamaHari          := Ceil(ManHour /AlokasiWaktu);
          sg1.Cells[9,ARow] := IntToStr(LamaHari);

          AjustDate         := StrToIntDef(sg1.Cells[12,ARow],0);
          plusHari          := StrToIntDef(sg1.Cells[10,ARow],0);

          if plusHari > 0 then  begin
             ManHour  := ManHour + (AlokasiWaktu * plusHari);
             LamaHari := LamaHari + plusHari;
          end;

         StartDate := ADate;
         if  AlokasiWaktu >= KapasitasDivisi then begin

             SQDelete.Close;
             SQDelete.SQL.Text := 'DELETE FROM detail_jadwal WHERE '+
                           ' id_divisi="'+sg1.Cells[14,Arow]+'" '+
                           ' AND tgl>="'+Tanggal(ADate)+'" '+
                           ' AND item_id="'+sg1.Cells[16,Arow]+'"';
             SQDelete.ExecSQL;
         end;






          SQ3.Open('SELECT COUNT(tgl) as jmltgl,MAX(tgl) as tgl FROM detail_jadwal WHERE '+
          ' id_divisi="'+sg1.Cells[14,Arow]+'" '+
          ' AND item_id="'+sg1.Cells[16,Arow]+'" AND total_menit>0');

          JmlTgl      := SQ3.FieldByName('jmltgl').AsInteger;
         // ShowMessage(IntToStr(JmlTgl)+' '+SQ3.FieldByName('tgl').AsString+' '+sg1.Cells[4,Arow]+' '+sg1.Cells[16,Arow]);
          if SQ3.FieldByName('tgl').AsString <> '' then
             TglTerakhir := toDate(SQ3.FieldByName('tgl').AsString) else
             TglTerakhir := Now;


          if JmlTgl >0 then begin
           //  StartDate := TglTerakhir;

             SQ3.Open('SELECT SUM(total_menit) as totalterpakai,MAX(tgl) as tgl FROM detail_jadwal WHERE '+
             ' id_divisi="'+sg1.Cells[14,Arow]+'" AND item_id="'+sg1.Cells[16,Arow]+'" '+
             ' AND tgl>="'+Tanggal(dt.Date)+'" ');
             ManHour := ManHour - SQ3.FieldByName('totalterpakai').AsInteger ;


          end;


          if (JmlTgl <= Lamahari - Plushari)  then begin

            // ShowMessage(sg1.Cells[16,Arow]+' DIVISI : '+sg1.Cells[4,Arow]+' '+Tanggal(StartDate));

             j := 0;
             for i := 0 to (LamaHari - JmlTgl) -1 do begin
                  NextDate := GetStarDate(StartDate+i-j,sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai);
                  if NextDate > StartDate + i then begin
                     StartDate := NextDate;
                     j := i;
                  end;

                 // ShowMessage(sg1.Cells[16,Arow]+' DIVISI : '+sg1.Cells[4,Arow]+' '+Tanggal(NextDate));

                Floading.Lprocess.Caption := 'Updating schedule for divisi '+sg1.Cells[4,Arow]+' to date '+FormatDateTime('dd/mm/yyyy',NextDate);

                        SQ1.Close;
                        SQ1.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                      ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                      ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                      ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                      SQ1.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                      SQ1.ParamByName('tgl').AsDate              := NextDate + AjustDate;
                      SQ1.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                      SQ1.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                      SQ1.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                      SQ1.ParamByName('manhour').AsInteger       := BaseManhour;
                      SQ1.ParamByName('no_urut').AsInteger       := NoUrut;
                      SQ1.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                      SQ1.ParamByName('jam_kerja').AsInteger     := JamKerja;
                      SQ1.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                      SQ1.ParamByName('is_edit').AsBoolean := False;

                      if  ManHour > AlokasiWaktu then begin

                          if (KapasitasTerpakai > 0) and (KapasitasTerpakai < alokasiWaktu) then begin
                             if KapasitasTerpakai + AlokasiWaktu >= KapasitasDivisi then begin
                                SQ1.ParamByName('total_menit').AsInteger   := KapasitasDivisi - KapasitasTerpakai;
                                ManHour         := ManHour - (KapasitasDivisi - KapasitasTerpakai);
                             end else begin
                                SQ1.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                                ManHour         := ManHour -AlokasiWaktu;
                             end;
                           


                             if (ManHour > 0) and (ManHour < alokasiWaktu) then  begin

                                SQ4.Close;
                                SQ4.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                                ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                                ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                                ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                                SQ4.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                                SQ4.ParamByName('tgl').AsDate              := NextDate + 1 + AjustDate;
                                SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                                SQ4.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                                SQ4.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                                SQ4.ParamByName('manhour').AsInteger       := BaseManhour;
                                SQ4.ParamByName('no_urut').AsInteger       := NoUrut;
                                SQ4.ParamByName('jam_kerja').AsInteger     := JamKerja;
                                SQ4.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                                SQ4.ParamByName('is_edit').AsBoolean := False;
                                SQ4.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                                if ManHour < AlokasiWaktu then
                                SQ4.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                                else
                                SQ4.ParamByName('total_menit').AsInteger   := ManHour;
                                SQ4.ExecSQL;
                             end else if (ManHour >  alokasiWaktu) and ( i = lamahari -1) then begin

                                ExtendHari := Ceil(ManHour/AlokasiWaktu);


                                for y := 0 to ExtendHari-1 do begin


                                    SQ4.Close;
                                    SQ4.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                                    ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                                    ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                                    ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                                    SQ4.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                                    SQ4.ParamByName('tgl').AsDate              := (NextDate+y+1) + AjustDate;
                                    SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                                    SQ4.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                                    SQ4.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                                    SQ4.ParamByName('manhour').AsInteger       := BaseManhour;
                                    SQ4.ParamByName('no_urut').AsInteger       := NoUrut;
                                    SQ4.ParamByName('jam_kerja').AsInteger     := JamKerja;
                                    SQ4.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                                    SQ4.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                                    SQ4.ParamByName('is_edit').AsBoolean := False;
                                    if ManHour > AlokasiWaktu then

                                    SQ4.ParamByName('total_menit').AsInteger   := AlokasiWaktu
                                    else begin
                                      if ManHour <= AlokasiWaktu then

                                          SQ4.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                                      else
                                          SQ4.ParamByName('total_menit').AsInteger   := ManHour;
                                    end;
                                    SQ4.ExecSQL;
                                    ManHour := ManHour - AlokasiWaktu;

                                end;
                             end;
                            end  else if (KapasitasTerpakai > 0) and (KapasitasTerpakai >= AlokasiWaktu) then begin

                              if KapasitasTerpakai + AlokasiWaktu >= KapasitasDivisi then begin
                                SQ1.ParamByName('total_menit').AsInteger   := KapasitasDivisi - KapasitasTerpakai;
                                ManHour         := ManHour - (KapasitasDivisi - KapasitasTerpakai);
                              end else begin
                               SQ1.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                               ManHour         := ManHour - AlokasiWaktu;
                              end;

                              if (i = LamaHari -1) and (ManHour > AlokasiWaktu)  then begin
                                    ExtendHari := Ceil(ManHour/AlokasiWaktu);

                                    for y := 0 to ExtendHari-1 do begin
                                        SQ4.Close;
                                        SQ4.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                                        ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,'+
                                        ' jam_kerja,alokasi_tng_kerja,is_edit) '+
                                        ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                                        ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,'+
                                        ' :jam_kerja,:alokasi_tng_kerja,:is_edit)';

                                        SQ4.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                                        SQ4.ParamByName('tgl').AsDate              := NextDate + y +1 + AjustDate;
                                        SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                                        SQ4.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                                        SQ4.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                                        SQ4.ParamByName('manhour').AsInteger       := BaseManhour;
                                        SQ4.ParamByName('no_urut').AsInteger       := NoUrut;
                                        SQ4.ParamByName('jam_kerja').AsInteger     := JamKerja;
                                        SQ4.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                                        SQ4.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                                        SQ4.ParamByName('is_edit').AsBoolean       := False;
                                        if ManHour > AlokasiWaktu then
                                          SQ4.ParamByName('total_menit').AsInteger   := AlokasiWaktu
                                        else
                                          SQ4.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan);
                                        SQ4.ExecSQL;
                                        ManHour := ManHour - AlokasiWaktu;
                                      end;

                                end;

                            end  else begin
                                SQ1.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                                MenitPerTanggal := AlokasiWaktu;
                                ManHour         := ManHour - AlokasiWaktu;


                              if (i = LamaHari -1) and (ManHour > 0)  then begin

                                          SQ4.Close;
                                          SQ4.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                                          ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,'+
                                          ' jam_kerja,alokasi_tng_kerja,is_edit) '+
                                          ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                                          ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,'+
                                          ' :jam_kerja,:alokasi_tng_kerja,:is_edit)';

                                          SQ4.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
                                          SQ4.ParamByName('tgl').AsDate              := NextDate + 1 + AjustDate;
                                          SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                                          SQ4.ParamByName('gc_code').AsString        := sg1.Cells[19,Arow];
                                          SQ4.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                                          SQ4.ParamByName('manhour').AsInteger       := BaseManhour;
                                          SQ4.ParamByName('no_urut').AsInteger       := NoUrut;
                                          SQ4.ParamByName('jam_kerja').AsInteger     := JamKerja;
                                          SQ4.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                                          SQ4.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                                          SQ4.ParamByName('is_edit').AsBoolean       := False;
                                          if ManHour < AlokasiWaktu then

                                            SQ4.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                                          else
                                            SQ4.ParamByName('total_menit').AsInteger   := ManHour;
                                          SQ4.ExecSQL;

                                         // ManHour := ManHour - AlokasiWaktu;

                              end;

                          end;
                      end else if ManHour <= AlokasiWaktu then begin
                         SQ1.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan);
                         MenitPerTanggal  := ManHour;
                      end;

                  SQ1.ExecSQL;
             end;
                

             end;
        
  end;


end;

function TFGrafikJadwal_backup.GetStarDate(ADate: TDate;id_divisi:String;KapasitasDivisi:Integer;var KapasitasTerpakai:Integer): TDate;
begin
  SQ2.Open(' SELECT tgl,total_menit FROM detail_jadwal '+
  ' WHERE tgl="'+Tanggal(ADate)+'" AND id_divisi="'+id_divisi+'"  ');
  //ShowMessage(SQ2.SQL.Text);
  if (SQ2.IsEmpty)  then begin
     KapasitasTerpakai := 0;
     Result := Adate;

  end else begin


     SQ3.Open(' SELECT tgl,SUM(total_menit) as KapasitasTerpakai '+
              ' FROM detail_jadwal WHERE id_divisi="'+id_divisi+'" '+
              ' AND tgl>="'+Tanggal(Adate)+'" GROUP BY tgl '+
              ' HAVING '+IntToStr(KapasitasDivisi)+'-KapasitasTerpakai > 0  ');

    //ShowMessage(SQ3.SQL.Text);
    KapasitasTerpakai := StrToIntDef(SQ3.FieldByName('KapasitasTerpakai').AsString,0);

    Result := SQ3.FieldByName('tgl').AsDateTime;
  end;
  Exit;
end;

function TFGrafikJadwal_backup.IdDivisi: String;
var
  i : integer;
  id_divisi : String;

begin
  id_divisi := '';
  for i := sg1.Row to sg1.RowCount -1 do begin
     if (sg1.Cells[14,i+1] <> '') and (sg1.Cells[8,i+1] <> '') then begin
        id_divisi := id_divisi + '"'+sg1.Cells[14,i+1]+'",';

     end;
     if sg1.Cells[4,i] = '' then
        Break;

  end;
  Delete(id_divisi,length(id_divisi),1);
  Result := id_divisi;

end;

function TFGrafikJadwal_backup.IndexLastItem: Integer;
var
  i : integer;
begin
  for i := sg1.Row to sg1.RowCount -1 do begin
    if sg1.Cells[4,i] = '' then
    begin
      Result := i;
      Break;
    end;
  end;

end;

procedure TFGrafikJadwal_backup.KosongkanGrid;
var
  c , i : integer;
begin
  for i := 0 to sg1.ColCount -1 do
  for c := 1 to sg1.RowCount -1 do
    sg1.Cells[i,c] := '';
  sg1.RowCount := 2;

end;


procedure TFGrafikJadwal_backup.ResetChart;
begin
  //ResetColor(1);
  sg1.ColCount := 21;
end;

function toVal(Q:TFDQuery;Field:String) : String;
begin
  Result := Q.FieldByName(Field).AsString;
end;

function toInt(Q:TFDQuery;Field:String) : integer;
begin
  Result := Q.FieldByName(Field).AsInteger;
end;

function QToDate(Q:TFDQuery;Field:String) : TDate;
begin
  Result := Q.FieldByName(Field).AsDateTime;
end;

procedure TFGrafikJadwal_backup.ResetColor(Arow:Integer;Acol:integer);

begin

      sg1.Colors[Acol,Arow]    :=  clWhite;
      sg1.ColorsTo[Acol,Arow]  := clWhite;
      sg1.Cells[Acol,Arow]     := '';

end;

procedure TFGrafikJadwal_backup.SaveGC;
var
  StartDate : TDate;
  EndDate   : TDate;
  i         : Integer;
  _bulk     : String;
begin
     for i := 1 to sg1.RowCount -1 do begin
       if sg1.Cells[11,i] <> '' then
       begin
         Q3.Close;
         Q3.SQL.Text := 'UPDATE gant_detail set tgl_mulai="'+Tanggal(sg1.Dates[11,i])+'", '+
         ' tgl_akhir="'+Tanggal(sg1.Dates[13,i])+'", '+
         ' alokasi_tng_kerja="'+sg1.Cells[8,i]+'",'+
         ' jam_kerja="'+sg1.Cells[7,i]+'",'+
         ' manhour="'+nilai(sg1.Cells[6,i])+'",'+
         ' hari="'+nilai(sg1.Cells[9,i])+'",'+
         ' plusmin_hari="'+StrToDecimal(sg1.Cells[10,i])+'",'+
         ' plusmin_date="'+StrToDecimal(sg1.Cells[12,i])+'" '+
         ' WHERE gantt_code="'+sg1.Cells[19,i]+'" '+
         ' AND id_divisi="'+sg1.Cells[14,i]+'" AND '+
         ' item_id="'+sg1.Cells[16,i]+'" ';
         Q3.ExecSQL;
       end;

     end;
     SQ3.Open('SELECT * FROM detail_jadwal WHERE  total_menit>0 AND tgl>="'+Tanggal(dt.Date)+'"');
     ExQry(Q2,'DELETE FROM detailjadwal WHERE tgl>="'+Tanggal(Dt.date)+'"',False);

     while SQ3.Eof = false do begin
        _bulk := _bulk+'('+toVal(SQ3,'id_divisi')+','+
        '"'+Tanggal(QToDate(SQ3,'tgl'))+'",'+
        '"'+toVal(SQ3,'sono')+'",'+
        ''+toVal(SQ3,'item_id')+','+
        ''+toVal(SQ3,'qty_order')+','+
        ''+toVal(SQ3,'total_menit')+','+
        '"'+toVal(SQ3,'gc_code')+'",'+
        ''+toVal(SQ3,'kapasitas')+','+
        ''+toVal(SQ3,'manhour')+','+
        ''+toVal(SQ3,'no_urut')+','+
        ''+IntToStr(toInt(SQ3,'alokasi_tng_kerja'))+','+
        ''+IntToStr(toInt(SQ3,'jam_kerja'))+'),';


       SQ3.Next;
     end;

     Delete(_bulk,Length(_bulk),1);

 
     if _bulk <> '' then begin
         Q1.Close;
         Q1.SQL.Text := 'INSERT INTO detailjadwal ('+
         'id_divisi,tgl,sono,item_id,'+
         'qty_order,total_menit,gc_code,kapasitas,manhour,no_urut,'+
         'alokasi_tng_kerja,jam_kerja) '+
         'VALUES '+_bulk;
         Q1.ExecSQL;
     end;

    SQ1.Close;
    SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
    SQ1.ExecSQL;

end;

procedure TFGrafikJadwal_backup.sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACOl in [5,7,8,10,11,12,13];
end;

procedure TFGrafikJadwal_backup.sg1DateTimeChange(Sender: TObject; ACol, ARow: Integer;
  ADateTime: TDateTime);
  var
    tglMulai  : TDate;
    PlusMin   : integer;
begin

  SQ1.Open('SELECT tgl FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,sg1.Row]+'" '+
  ' AND id_divisi="'+sg1.Cells[14,sg1.Row]+'" '+
  ' AND gc_code="'+sg1.Cells[19,sg1.Row]+'"');

  tglMulai := SQ1.FieldByName('tgl').AsDateTime;

  PlusMin := DaysBetween(ADateTime,TglMulai) + 1;


  if ADateTime < tglMulai then
  PlusMin  := PlusMin * -1;
  sg1.Cells[12,sg1.Row] := IntToStr(PlusMin);

  if PlusMin <> 0 then
    sg1.Cells[20,sg1.Row] := '1' else
    sg1.Cells[20,sg1.Row] := '0';


end;

procedure TFGrafikJadwal_backup.sg1Enter(Sender: TObject);
begin
  sg1.Options := sg1.Options - [goRowSelect];
end;

procedure TFGrafikJadwal_backup.sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then
     HAlign := taCenter;
end;

procedure TFGrafikJadwal_backup.sg1GetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin

  case ACol of
  11,13 : AEditor := edDateEdit;
  end;
end;

function TFGrafikJadwal_backup.FindDivisi(id_divisi:integer):integer;
var
  i : integer;
begin
  Result := 0 ;
  for i := 2 to sg1.RowCount -1 do begin
     if StrToIntDef(sg1.Cells[14,i],0) = id_divisi then
     begin
       Result := i ;
       Break;
     end;

  end;

end;

function TFGrafikJadwal_backup.findStartDate: TDate;
var
  item_id : String;
begin
  ExQry(Q1,'SELECT distinct dj.item_id,i.description FROM detailjadwal dj LEFT JOIN item i '+
  ' ON i.id=dj.item_id WHERE tgl>="'+Tanggal(dt.Date)+'"',True );

  cbItem.Clear;
  while not Q1.Eof do begin
    cbItem.AddItem(GetVal(Q1,'description'),TObject(GetValInt(Q1,'item_id')));
    item_id := item_id + GetVal(Q1,'item_id')+',';

    Q1.Next;
  end;

  Delete(item_id,Length(item_id),1);

  if item_id <> '' then
  begin
    ExQry(Q1,'SELECT tgl FROM detailjadwal WHERE item_id IN ('+item_id+') ORDER BY tgl ASC LIMIT 1',True);

    Result := GetValDate(Q1,'tgl');
  end else
    Result := Now;

end;

function TFGrafikJadwal_backup.FindStartRow: Integer;
var
  i : integer;
begin
  Result := 0 ;
  if sg1.Cells[11,2] = '' then
     Result := 2
  else begin
       for i := 2 to sg1.RowCount -1 do begin
          if (sg1.Cells[8,i] <> '') and (sg1.Cells[4,i] <> '')  and (sg1.Cells[11,i] = '') then begin
             Result := i;
             //ShowMessage(IntToStr(i));
             Break;

          end;
       end;
  end;

end;

function TFGrafikJadwal_backup.finishEdit: integer;
var
  i : integer;
  Row : integer;
begin
  Row := 0;
  for i := sg1.RowCount -1 downto 1 do begin
     if sg1.Cells[12,i] <>'' then
     begin
       Row := i;
       Break;
     end;

  end;
  Result := row;

end;

procedure TFGrafikJadwal_backup.sg1KeyPress(Sender: TObject; var Key: Char);
var
  i , x , j: integer;
  MinTgl : TDate;
  MaxTgl : TDate;
  RangeTanggal : Integer;
  TglMulai : TDate;
  IndexRow          : Integer;
  GapDate           : Integer;
  DateMin : TDate;

begin


   if Key = #13 then begin

      if sg1.Col in [5,6,7,8,9] then begin

               IndexWarna := 1;
               Floading.Show;
               Floading.pgbar.Maximum := sg1.RowCount -1;
               Floading.pgbar.Position:= 0;
               sg1.BeginUpdate;

               IndexRow := FindStartRow;
               if IndexRow = 0 then
                  IndexRow :=  2;

              // if sg1.Cells[11,sg1.Row -1] = '' then begin
                  SQDelete.Close;
                  SQDelete.SQL.Text := 'DELETE FROM detail_jadwal WHERE '+
                  ' tgl>= "'+Tanggal(sg1.Dates[11,sg1.Row])+'" '+
                //  ' AND id_divisi="'+sg1.Cells[14,sg1.Row]+'" '+
                  ' AND item_id="'+sg1.Cells[16,sg1.Row]+'" ';
                  SQDelete.ExecSQL;

              // end;


               DateMin :=  sg1.Dates[11,sg1.Row] + StrToIntDef(sg1.Cells[12,sg1.Row],0);


               if DateMin < dt.Date then
                      dt.Date :=  DateMin;


               for I := sg1.Row to IndexLastItem-1 do begin

                  if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

                     //  TglMulai := GetStarDate()
                       SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                           ' AND id_divisi="'+sg1.Cells[14,i-1]+'" ORDER BY tgl DESC limit 1');

                      // ShowMessage(sg1.Cells[4,i]+' '+SQ1.FieldByName('tgl').AsString);
                       if SQ1.IsEmpty then
                          TglMulai := sg1.Dates[11,i] else
                          TglMulai := SQ1.FieldByName('tgl').AsDateTime + 1 ;
                      // ShowMessage(Tanggal(TglMulai));
                       GenerateDate(I,TglMulai);

                      // dt.Date := StartDateTemp;
                       SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
                       ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" ');
                       sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
                       sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);

                       for j := 0 to sg1.ColCount -1 do
                       ResetColor(i,j+21);

                       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.Date)+'"  ORDER BY tgl ASC LIMIT 1');
                       MinTgl := SQ2.FieldByName('tgl').AsDateTime;

                       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.Date)+'"  ORDER BY tgl DESC LIMIT 1');
                       MaxTgl := SQ2.FieldByName('tgl').AsDateTime;

                       RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;

                       sg1.ColCount   := RangeTanggal + 21;

                       for x := 0 to RangeTanggal -1 do begin

                          sg1.Cells[21+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
                          sg1.AddRotated(21+x,0,90,sg1.Cells[21+x,0]);
                          sg1.ColWidths[21+x] := 35;

                          if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
                              sg1.Colors[21+x,0]    := clRed;
                              sg1.ColorsTo[21+x,0]  := $003535FF;
                          end else begin
                              sg1.Colors[21+x,0]    := $00D6D6D6;
                              sg1.ColorsTo[21+x,0]  := clWhite;
                          end;
                       end;

                          SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE '+
                          ' item_id="'+sg1.Cells[16,i]+'"  '+
                          ' AND id_divisi="'+sg1.Cells[14,i]+'" '+
                          ' AND tgl>="'+Tanggal(MinTgl)+'" AND '+
                          ' tgl<="'+Tanggal(MaxTgl)+'" ');

                          while not SQ4.Eof do begin

                            if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                              GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                              sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;

                              sg1.Colors[21+GapDate,i]   := warna[StrToInt(sg1.Cells[3,i])];
                              sg1.ColorsTo[21+GapDate,i] := warna[StrToInt(sg1.Cells[3,i])];
                            end;

                            Application.ProcessMessages;
                            SQ4.Next;
                         end;

                       end;

                    Floading.pgbar.Position := i;
                  end;




               sg1.EndUpdate;
               Floading.Close;


      end else if (sg1.Col in [12]) then begin

              DateMin :=  sg1.Dates[11,sg1.Row] + StrToIntDef(sg1.Cells[12,sg1.Row],0);
                if DateMin < dt.Date then
                        dt.Date :=  DateMin;
                Col12(sg1.Row);

              sg1.Cells[20,i] := '0';

      end else if (sg1.Col in [10]) then begin
         DateMin :=  sg1.Dates[11,sg1.Row] + StrToIntDef(sg1.Cells[12,sg1.Row],0);


              if DateMin < dt.Date then
                      dt.Date :=  DateMin;
              Col10(sg1.Row);
              sg1.Cells[20,i] := '0';
         
      end;
       //  SQ1.Open(' SELECT * '+
       //    ' FROM detail_jadwal ');
   end;


end;

procedure TFGrafikJadwal_backup.sg1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

  //  ShowMessage(FloatToStr(StrToFloatDef(nilai(sg1.Cells[12,sg1.Row]),0)));
    if (sg1.Col = 12)  then begin
      if (StrToFloatDef(nilai(sg1.Cells[12,sg1.Row]),0) <> 0) then
      sg1.Cells[20,sg1.Row] := '1'  else
      sg1.Cells[20,sg1.Row] := '0';
    end;

    if (sg1.Col = 10)  then begin
      if (StrToFloatDef(nilai(sg1.Cells[10,sg1.Row]),0) <> 0) then
      sg1.Cells[20,sg1.Row] := '1'  else
      sg1.Cells[20,sg1.Row] := '0';
    end;


  if sg1.Col = 8 then begin

      if StrToIntDef(TRIM(sg1.Cells[15,sg1.Row]),0) <  StrToIntDef(sg1.Cells[8,sg1.Row],0) then
      begin
        Error('Alokasi yang dimasukan melebihi jumlah kapasitas');
        Exit;
      end else begin

      end;
  end else if sg1.Col = 5 then begin
      if POS('[',sg1.Cells[5,sg1.Row]) > 0 then
      sg1.Cells[15,sg1.Row] := TRIM(COPY(sg1.Cells[5,sg1.Row],1,Pos('[',sg1.Cells[5,sg1.Row])-1))
      else
      begin
        sg1.Cells[15,sg1.Row] := sg1.Cells[5,sg1.Row];
      end;

  end;


 // CreateChart;

end;



procedure TFGrafikJadwal_backup.SpeedButton1Click(Sender: TObject);
var
  i ,j: integer;
  MinTgl : TDate;
  MaxTgl : TDate;
  RangeTanggal : integer;
  x : integer;
  GapDate : integer;
begin
  for i := 1 to sg1.RowCount -1 do begin
    if sg1.Cells[4,i] <> '' then begin
       GenerateDate(i,sg1.Dates[11,i]);

       SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
                       ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" ');
       sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
       sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);

       for j := 0 to sg1.ColCount -1 do
       ResetColor(i,j+21);

       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.Date)+'"  ORDER BY tgl ASC LIMIT 1');
       MinTgl := SQ2.FieldByName('tgl').AsDateTime;

       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.Date)+'"  ORDER BY tgl DESC LIMIT 1');
       MaxTgl := SQ2.FieldByName('tgl').AsDateTime;

       RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;

       sg1.ColCount   := RangeTanggal + 21;

       for x := 0 to RangeTanggal -1 do begin

          sg1.Cells[21+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
          sg1.AddRotated(21+x,0,90,sg1.Cells[21+x,0]);
          sg1.ColWidths[21+x] := 35;

          if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
              sg1.Colors[21+x,0]    := clRed;
              sg1.ColorsTo[21+x,0]  := $003535FF;
          end else begin
              sg1.Colors[21+x,0]    := $00D6D6D6;
              sg1.ColorsTo[21+x,0]  := clWhite;
          end;
       end;

          SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE '+
          ' item_id="'+sg1.Cells[16,i]+'"  '+
          ' AND id_divisi="'+sg1.Cells[14,i]+'" '+
          ' AND tgl>="'+Tanggal(MinTgl)+'" AND '+
          ' tgl<="'+Tanggal(MaxTgl)+'" ');

          while not SQ4.Eof do begin

            if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
              GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
              sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;

              sg1.Colors[21+GapDate,i]   := warna[StrToInt(sg1.Cells[3,i])];
              sg1.ColorsTo[21+GapDate,i] := warna[StrToInt(sg1.Cells[3,i])];
            end;

            Application.ProcessMessages;
            SQ4.Next;
         end;

       end;

  end;


end;

function TFGrafikJadwal_backup.StartDateTemp: TDate;
var
  item_id : String;
begin
  SQ1.OPEN('SELECT item_id FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.Date)+'" '+
  ' GROUP BY item_id');

  while not SQ1.Eof do begin

    item_id := item_id + SQ1.FieldByName('item_id').AsString+',';
    SQ1.Next;
  end;

  Delete(item_id,Length(item_id),1);
  if item_id <> '' then
  begin
    SQ1.Open('SELECT tgl FROM detail_jadwal WHERE item_id IN ('+item_id+') ORDER BY tgl ASC LIMIT 1');

    Result :=SQ1.FieldByName('tgl').AsDateTime;
  end else
    Result := Now;

end;

function TFGrafikJadwal_backup.startEdit: integer;
var
  i : integer;
  Row : integer;
begin
  Row := 0;
  for i := 1 to sg1.RowCount -1 do begin
     if sg1.Cells[12,i] <>'' then
     begin
       Row := i;
       Break;
     end;

  end;
  Result := row;

end;


procedure TFGrafikJadwal_backup.TampilAwal;
begin
  ClearText(Self);

  CreateGrid;
  isFocusForm := True;
end;

function TFGrafikJadwal_backup.toDate(AStr: String): TDate;
var
  dd    : String;
  mm    : String;
  yy    : String;
  Ls    : TStringList;
  aDate : TDate;

begin
  ls  := TStringList.Create;
  try

   SplitString('-',AStr,ls);



    yy := ls[0];
    mm := ls[1];
    dd := ls[2];

    aDate  := EncodeDate(StrToInt(yy),StrToInt(mm),StrToInt(dd));
    Result := aDate;
  finally
    ls.Free;
  end;
end;

//procedure TFGrafikJadwal.UpdateDate( ADate: TDate);
//var
//  Jamkerja          : Integer;
//  JumlahKaryawan    : Integer;
//  ManHour           : Integer;
//  KapasitasDivisi   : Integer;
//  AlokasiWaktu      : Integer;
//  LamaHari          : Integer;
//  ExtendHari        : integer;
//  KapasitasTerpakai : Integer;
//  i,x,y               : integer;
//  SelisihHari       : integer;
//  DateCounterDB     : integer;
//  ColumnCounter     : integer;
//  MinTgl            : TDate;
//  MaxTgl            : TDate;
//  RangeTanggal      : Integer;
//  MenitPerTanggal   : Integer;
//  SisaKapasitas     : Integer;
//  SisaManHour       : Integer;
//  SisaKapasitasTanggal : Integer;
//  GapStartDateDivisi: integer;
//  AjustDate         : Integer;
//  BaseManhour       : integer;
//  KapasitasSudahDipakai : integer;
//  AList : TListItem;
//  StartDate : TDate;
//  NextDate  : TDate;
//  NoUrut    : Integer;
//  plusHari  : Integer;
//  Id_Divisi  : String;
//  gc_code   : String;
//  qty_order : integer;
//  counter  : integer;
//
//begin
//
////  SQ1.Close;
////  SQ1.SQL.Text :=' SELECT j.item_id,j.kapasitas,j.no_urut,j.id_divisi,j.manhour,j.jam_kerja,j.alokasi_tng_kerja,qty_order,'+
////  ' j.gc_code FROM detail_jadwal j WHERE j.gc_code<>"'+Ecode.Text+'" '+
////  ' AND (j.id_divisi in ('+IdDivisi+') or j.no_urut >="'+sg1.Cells[18,sg1.Row]+'") AND j.tgl>="'+Tanggal(ADate)+'" '+
////  '  GROUP BY j.item_id,j.id_divisi '+
////  ' ORDER BY j.gc_code,j.item_id,j.no_urut ASC ';
////  SQ1.Open;
//
//
//
//  while  not SQ1.Eof do begin
//
//
//
//        JamKerja        := SQ1.FieldByName('jam_kerja').AsInteger;
//        JumlahKaryawan  := SQ1.FieldByName('alokasi_tng_kerja').AsInteger;
//        ManHour         := SQ1.FieldByName('manhour').AsInteger;
//        BaseManhour     := SQ1.FieldByName('manhour').AsInteger;
//        NoUrut          := SQ1.FieldByName('no_urut').AsInteger;
//        KapasitasDivisi := SQ1.FieldByName('kapasitas').AsInteger;
//        Id_Divisi       := SQ1.FieldByName('id_divisi').AsString;
//        gc_code         := SQ1.FieldByName('gc_code').AsString;
//        qty_order       := SQ1.FieldByName('qty_order').AsInteger;
//
//        if (JamKerja > 0) and (JumlahKaryawan > 0) and (ManHour > 0) then begin
//
//            SQ4.Open('SELECT COUNT(tgl) as jml,SUM(total_menit) as manhourterpakai FROM detail_jadwal WHERE id_divisi="'+Id_Divisi+'" '+
//            ' AND item_id="'+SQ1.FieldByName('item_id').AsString+'" AND total_menit > 0 '+
//            ' AND gc_code="'+gc_code+'" ');
//
//            AlokasiWaktu      := Jamkerja * JumlahKaryawan * 60;
//            LamaHari          := Ceil(ManHour /AlokasiWaktu) - SQ4.FieldByName('jml').AsInteger;
//            ManHour           := ManHour - StrToIntDef(SQ4.FieldByName('manhourterpakai').AsString,0);
//
//          //  SQ4.Open('SELECT MAX(tgl) as tgl FROM detail_jadwal WHERE);
//            if SQ1.RecNo = 1 then
//               StartDate := ADate else
//            begin
//              SQ4.Open('SELECT MAX(tgl) as tgl FROM detail_jadwal WHERE '+
//              ' no_urut<="'+IntToStr(SQ1.FieldByName('no_urut').AsInteger -1)+'" '+
//              ' AND item_id="'+SQ1.FieldByName('item_id').AsString+'" '+
//              ' AND gc_code="'+gc_code+'" ORDER BY no_urut DESC LIMIT 1 ');
//
//             // ShowMessage(SQ4.SQL.Text);
//
//
//              try
//
//
//                StartDate := toDate(SQ4.FieldByName('tgl').AsString) + 1;
//              except
//                ShowMessage('error');
//
//              end;
//            end;
//
//
//
//
//           counter := 0;
//           for i := 0 to LamaHari -1 do begin
//                if counter = 0 then
//                   NextDate := GetStarDate(StartDate+i,Id_Divisi,KapasitasDivisi,KapasitasTerpakai) else
//                   NextDate := GetStarDate(StartDate+(i-counter),Id_Divisi,KapasitasDivisi,KapasitasTerpakai);
//                if NextDate > StartDate + i then begin
//                   StartDate := NextDate;
//                   counter   := i;
//                end;
//              //  ShowMessage(Tanggal(NextDate));
//
//               { SQ2.Open(' SELECT tgl,SUM(total_menit) as KapasitasTerpakai '+
//                ' FROM detail_jadwal WHERE id_divisi="'+sg1.Cells[14,Arow]+'" '+
//                ' AND tgl>="'+Tanggal((StartDate + i))+'" GROUP BY tgl '+
//                ' HAVING '+IntToStr(KapasitasDivisi)+'-KapasitasTerpakai > 0 ');
//
//
//                if SQ2.IsEmpty = False then  begin
//                      if (KapasitasDivisi - SQ2.FieldByName('KapasitasTerpakai').AsInteger > 0) then begin
//                          StartDate          := SQ2.FieldByName('tgl').AsDateTime;
//                      end;
//                      if (AlokasiWaktu = KapasitasDivisi) and (SQ2.FieldByName('KapasitasTerpakai').AsInteger < KapasitasDivisi) then
//                      begin
//                         KapasitasTerpakai  := SQ2.FieldByName('KapasitasTerpakai').AsInteger;
//                         if ManHour > AlokasiWaktu then
//
//                         ManHour            := ManHour + KapasitasTerpakai;
//                      end;
//                end else begin
//                   KapasitasTerpakai  := 0;
//                end;      }
//                if  (KapasitasTerpakai > 0)  and (KapasitasTerpakai < KapasitasDivisi) then
//                begin
//
//                   if ManHour > AlokasiWaktu then
//                   ManHour            := ManHour + KapasitasTerpakai;
//                end;
//
//
//                SQ2.Close;
//                SQ2.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
//                ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
//                ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
//                ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';
//
//                SQ2.ParamByName('id_divisi').AsString     := Id_Divisi;
//                SQ2.ParamByName('tgl').AsDate              := NextDate;
//                SQ2.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
//                SQ2.ParamByName('gc_code').AsString        := gc_code;
//                SQ2.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
//                SQ2.ParamByName('manhour').AsInteger       := BaseManhour;
//                SQ2.ParamByName('no_urut').AsInteger       := NoUrut;
//                SQ2.ParamByName('qty_order').AsInteger       := qty_order;
//                SQ2.ParamByName('jam_kerja').AsInteger       := JamKerja;
//                SQ2.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
//                SQ2.ParamByName('is_edit').AsBoolean := True;
//
//                if  ManHour > AlokasiWaktu then begin
//
//                    if (KapasitasTerpakai > 0) and (KapasitasTerpakai < alokasiWaktu) then begin
//                       SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu - KapasitasTerpakai;
//                       MenitPerTanggal := AlokasiWaktu;
//                       ManHour         := ManHour - AlokasiWaktu;
//
//
//
//                       if (ManHour > 0) and (ManHour < alokasiWaktu) then  begin
//
//                          SQ3.Close;
//                          SQ3.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
//                          ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
//                          ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
//                          ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';
//
//                          SQ3.ParamByName('id_divisi').AsString     := Id_Divisi;
//                          SQ3.ParamByName('tgl').AsDate              := NextDate + 1;
//                          SQ3.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
//                          SQ3.ParamByName('gc_code').AsString        := gc_code;
//                          SQ3.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
//                          SQ3.ParamByName('manhour').AsInteger       := BaseManhour;
//                          SQ3.ParamByName('no_urut').AsInteger       := NoUrut;
//                          SQ3.ParamByName('qty_order').AsInteger       := qty_order;
//                          SQ3.ParamByName('jam_kerja').AsInteger       := JamKerja;
//                          SQ3.ParamByName('alokasi_tng_kerja').AsInteger       := JumlahKaryawan;
//                          SQ3.ParamByName('is_edit').AsBoolean := True;
//                          if ManHour < AlokasiWaktu then
//                          SQ3.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
//                          else
//                          SQ3.ParamByName('total_menit').AsInteger   := ManHour;
//                          SQ3.ExecSQL;
//                       end else if (ManHour >  alokasiWaktu) and ( i = lamahari -1) then begin
//                          ExtendHari := Ceil(ManHour/AlokasiWaktu);
//
//
//                          for y := 0 to ExtendHari-1 do begin
//
//
//                              SQ3.Close;
//                              SQ3.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
//                              ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
//                              ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
//                              ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';
//
//                              SQ3.ParamByName('id_divisi').AsString     := Id_Divisi ;
//                              SQ3.ParamByName('tgl').AsDate              := (NextDate+y+1);
//                              SQ3.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
//                              SQ3.ParamByName('gc_code').AsString        := gc_code;
//                              SQ3.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
//                              SQ3.ParamByName('manhour').AsInteger       := BaseManhour;
//                              SQ3.ParamByName('no_urut').AsInteger       := NoUrut;
//                              SQ3.ParamByName('qty_order').AsInteger       := qty_order;
//                              SQ3.ParamByName('jam_kerja').AsInteger       := JamKerja;
//                              SQ3.ParamByName('alokasi_tng_kerja').AsInteger       := JumlahKaryawan;
//                              SQ3.ParamByName('is_edit').AsBoolean := True;
//                              if ManHour > AlokasiWaktu then
//
//                              SQ3.ParamByName('total_menit').AsInteger   := AlokasiWaktu
//                              else begin
//                                if ManHour < AlokasiWaktu then
//
//                                    SQ3.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
//                                else
//                                    SQ3.ParamByName('total_menit').AsInteger   := ManHour;
//                              end;
//                              SQ3.ExecSQL;
//                              ManHour := ManHour - AlokasiWaktu;
//
//                          end;
//                       end;
//                    end else begin
//                      SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
//                      MenitPerTanggal := AlokasiWaktu;
//                      ManHour         := ManHour - AlokasiWaktu;
//
//
//                      if (i = LamaHari -1) and (ManHour > 0)  then begin
//
//                                  SQ3.Close;
//                                  SQ3.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
//                                  ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
//                                  ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
//                                  ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';
//
//                                  SQ3.ParamByName('id_divisi').AsString      :=  Id_Divisi;
//                                  SQ3.ParamByName('tgl').AsDate              := NextDate + 1;
//                                  SQ3.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
//                                  SQ3.ParamByName('gc_code').AsString        := gc_code;
//                                  SQ3.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
//                                  SQ3.ParamByName('manhour').AsInteger       := BaseManhour;
//                                  SQ3.ParamByName('no_urut').AsInteger       := NoUrut;
//                                  SQ3.ParamByName('qty_order').AsInteger       := qty_order;
//                                  SQ3.ParamByName('jam_kerja').AsInteger       := JamKerja;
//                                  SQ3.ParamByName('alokasi_tng_kerja').AsInteger       := JumlahKaryawan;
//                                  SQ3.ParamByName('is_edit').AsBoolean := True;
//                                  if ManHour < AlokasiWaktu then
//
//                                    SQ3.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
//                                  else
//                                    SQ3.ParamByName('total_menit').AsInteger   := ManHour;
//                                  SQ3.ExecSQL;
//
//                                 // ManHour := ManHour - AlokasiWaktu;
//
//                      end;
//
//                    end;
//                end else if ManHour < AlokasiWaktu then begin
//                   SQ2.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan);
//                   MenitPerTanggal  := ManHour;
//                end;
//
//
//
//                SQ2.ExecSQL;
//
//
//           end;
//
//        end;
//         SQ1.Next;
//  end;
//
//  //SQ2.Close;
//  //SQ2.SQL.Text := 'DELETE FROM detail_jadwal WHERE total_menit=0 ';
//  //SQ2.ExecSQL;
//   SQ1.Open(' SELECT * '+
//       ' FROM detail_jadwal ');
//
//end;


procedure TFGrafikJadwal_backup.UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
var
  i : integer;
begin
  for i := 1 to sg1.RowCount -1 do begin
     if (sg1.Cells[14,i] = Id_divisi) and (i <> Arow) and (sg1.Cells[11,i] <> '') then begin
        sg1.Cells[5,i]  := IntToStr(StrToIntDef(Sg1.Cells[15,i],0) - JmlPekerja);
     end;
  end;

end;

end.
