unit uDataGanttChart;

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
  TFDataGanttChart = class(TForm)
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
    Q4: TMyQuery;
    Q5: TMyQuery;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton4: TAdvSmoothButton;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    GroupBox1: TGroupBox;
    AdvSmoothButton2: TAdvSmoothButton;
    GList: TGroupBox;
    sgGantChart: TAdvStringGrid;
    CheckBox1: TCheckBox;
    Ecari: TAdvEdit;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    dt: TDateTimePicker;
    AdvSmoothButton5: TAdvSmoothButton;
    P1: TMenuItem;
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
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sg1Enter(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure sg1DateTimeChange(Sender: TObject; ACol, ARow: Integer;
      ADateTime: TDateTime);
    procedure SpeedButton1Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure sgGantChartDblClick(Sender: TObject);
    procedure AdvSmoothButton5Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
  private
    { Private declarations }

    isShow : Boolean;
    isSave : Boolean;
    procedure ResetColor(ARow : Integer;Acol:integer);

  public
    { Public declarations }
    isFocusForm : Boolean;
   
    procedure CreateGrid;
    procedure TampilAwal;
    procedure KosongkanGrid;
    procedure CreateChart(gc_code:string);
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
    procedure gridGantChart;
  end;

var
  FDataGanttChart: TFDataGanttChart;
  IndexWarna : Integer;

implementation

{$R *.dfm}

uses uListofSoGant, uMarCon, uGanttChatParameters, uLoading,
  uGanttChart, uCancelDate;

{ TFGanttChart }

procedure TFDataGanttChart.A1Click(Sender: TObject);
begin
  FCancelDate.EGCCode.Text := sg1.Cells[19,sg1.Row];
  FCancelDate.ShowModal;

end;

procedure TFDataGanttChart.addLocal;
var
  _Bulk : String;
   st : TStringList;
begin

  SQ1.Close;
  SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
  SQ1.ExecSQL;

  ExQry(Q1,'SELECT * FROM detailjadwal WHERE tgl>="'+Tanggal(dt.date)+'" ORDER BY tgl ASC',True);

  if Q1.IsEmpty = False then begin

  _bulk := '';
    st := TStringList.Create;
    st.BeginUpdate;

      while not Q1.Eof do begin

        _bulk := _bulk+'('+GetVal(Q1,'id_divisi')+',"'+Tanggal(GetValDate(Q1,'tgl'))+'",'+
        ''+IntToStr(StrToIntDef(GetVal(Q1,'total_menit'),0))+',"'+GetVal(Q1,'gc_code')+'",'+GetVal(Q1,'item_id')+','+
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

  end;

end;

procedure TFDataGanttChart.AdvSmoothButton1Click(Sender: TObject);

begin
  AdvGridExcelIO1.XLSExport(' GANT CHART '+FormatDateTime('dd mmmm yyyy',dt.date)+'.xls');
end;

procedure TFDataGanttChart.AdvSmoothButton2Click(Sender: TObject);
begin
  GList.Visible := not GList.Visible;
end;

procedure TFDataGanttChart.AdvSmoothButton3Click(Sender: TObject);
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
      CreateChart(sg1.Cells[19,sg1.Row]);

    end;
  end;

end;

procedure TFDataGanttChart.AdvSmoothButton4Click(Sender: TObject);
begin
  if MessageDlg('Update data GC ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
     SaveGC;
end;

procedure TFDataGanttChart.AdvSmoothButton5Click(Sender: TObject);
begin
  if sgGantChart.Cells[2,sgGantChart.Row] = '' then
  begin
    Error('Silahkan pilih GC yang akan dihapus !');
    Exit;
  end else begin
    if MessageDlg('Apakah yakin Item '+sg1.Cells[1,sg1.Row]+' Akan dihapus ??',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      ExQry(Q1,'DELETE FROM gantt_chart WHERE code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',False);
      ExQry(Q1,'DELETE FROM gant_detail WHERE gantt_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'" ',False);

      ExQry(Q1,'DELETE FROM detailjadwal WHERE gc_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'" ',False);

      SQ1.Close;
      SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
      SQ1.ExecSQL;

      CheckBox1Click(Sender);
      CreateGrid;

      CreateChart(sg1.Cells[19,sg1.Row]);

    end;
  end;
end;

procedure TFDataGanttChart.BitBtn1Click(Sender: TObject);
var
  i ,j: integer;
  MinTgl : TDate;
  MaxTgl : TDate;
  RangeTanggal : integer;
  x : integer;
  GapDate : integer;
  NextDate : integer;
  LamaHari : integer;
begin
  SQ1.Close;
  SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
  SQ1.ExecSQL;

  for i := 1 to sg1.RowCount -1 do begin
    if sg1.Cells[4,i] <> '' then begin
       ExQry(Q1,'SELECT * FROM detailjadwal WHERE gc_code="'+sg1.Cells[19,i]+'" '+
       ' AND id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" '+
       ' ORDER BY id ASC',True);
       NextDate := 0;
      // LamaHari := StrToIntDef(sg1.Cells[9,i],0);
       while not Q1.Eof do begin
          ExQry(Q2,'UPDATE detailjadwal SET tgl="'+Tanggal(sg1.Dates[11,i]+NextDate)+'" '+
          ' WHERE id="'+GetVal(Q1,'id')+'"',False);

          Inc(NextDate);
          Q1.Next;
       end;

       ExQry(Q2,'DELETE FROM detailjadwal WHERE gc_code="'+sg1.Cells[19,i]+'" '+
       ' AND id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" '+
       ' AND tgl>"'+Tanggal(sg1.Dates[13,i])+'"',False);


    end;


  end;


end;

procedure TFDataGanttChart.btnAddClick(Sender: TObject);
begin
  if MessageDlg('Tutup data GC ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Close;
  end;
end;

procedure TFDataGanttChart.CheckBox1Click(Sender: TObject);
var
  i : integer;
begin
  if CheckBox1.Checked then begin

      gridGantChart;

       Q1.Close;
       Q1.SQL.Text := 'SELECT code,so_no,nomer_container FROM gantt_chart  ORDER BY so_no ASC ';
       Q1.Open;

       i := 1;
       sgGantChart.RowCount := Q1.RecordCount + 2;
       while Q1.Eof = false do begin
          sgGantChart.Cells[0,i] := GetVal(Q1,'so_no');
          sgGantChart.Cells[1,i] := GetVal(Q1,'nomer_container');
          sgGantChart.Cells[2,i] := GetVal(Q1,'code');
          Q1.Next;
          Inc(i);

       end;
  end else begin
     gridGantChart;

     Q1.Close;
     Q1.SQL.Text := 'SELECT code,so_no,nomer_container FROM gantt_chart '+
     ' WHERE DATE_ADD(cancel_date,interval 30 day) >= "'+tanggal(now)+'" ORDER BY so_no ASC ';
     Q1.Open;

     i := 1;
     sgGantChart.RowCount := Q1.RecordCount + 2;
     while Q1.Eof = false do begin
        sgGantChart.Cells[0,i] := GetVal(Q1,'so_no');
        sgGantChart.Cells[1,i] := GetVal(Q1,'nomer_container');
        sgGantChart.Cells[2,i] := GetVal(Q1,'code');
        Q1.Next;
        Inc(i);

     end;
  end;
  dt.Date := findStartDate;
  addLocal;
end;

procedure TFDataGanttChart.Col10(Arow:Integer);
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
           ' AND id_divisi="'+sg1.Cells[14,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'" ORDER BY tgl ASC limit 1');

        if SQ1.IsEmpty then
           TglMulai := dt.date else
           TglMulai   :=  SQ1.FieldByName('tgl').AsDateTime;

     end else if sg1.Cells[14,Arow-1] <> '' then begin
        SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,i]+'" '+
           ' AND id_divisi="'+sg1.Cells[14,Arow-1]+'" AND gc_code="'+sg1.Cells[19,Arow]+'" ORDER BY tgl DESC limit 1');
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

  if PlusHari > 0 then begin
     if ROUND(PlusHari * AlokasiWaktu) > ManHour then
     ManHour := ManHour * Round(PlusHari) else
     ManHour := ManHour + ROUND(PlusHari * AlokasiWaktu);
  end;

     RangeHari := DaysBetween(TglMulai,TglAkhir) ;

   

   SQ2.Close;
   SQ2.SQL.Text :=' UPDATE detail_jadwal SET total_menit=0 WHERE '+
   ' tgl>="'+Tanggal(TglMulai)+'" AND id_divisi="'+sg1.Cells[14,Arow]+'"  AND id_divisi IN ('+IdDivisi+') '+
   ' AND item_id<>"'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'"';
   SQ2.ExecSQL;

   SQ2.close;
   SQ2.SQL.Text := 'DELETE FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,Arow]+'" AND id_divisi="'+sg1.Cells[14,Arow]+'" '+
   ' AND ( id_divisi IN ('+IdDivisi+') OR no_urut >="'+sg1.Cells[18,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'")';
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

   for i := sg1.Row to IndexLastItem-1 do begin
      for j := 21 to sg1.ColCount -1 do begin
        ResetColor(i,j);
      end;

   end;

   sg1.EndUpdate;

   sg1.BeginUpdate;



        

   for I := sg1.Row to IndexLastItem -1 do begin
      if  (StrToIntDef(sg1.Cells[18,i],0) >= StrToIntDef(sg1.Cells[18,
                                              FindDivisi(StrToIntDef(sg1.Cells[14,Arow],0))],0)) then begin
          if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

               if i <> Arow then begin
                  if sg1.Cells[14,i-1] = '' then begin

                      SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                         ' AND id_divisi="'+sg1.Cells[14,i]+'" AND gc_code="'+sg1.Cells[19,i]+'" ORDER BY tgl ASC limit 1');

                      if SQ1.IsEmpty then begin

                         NextDate := GetStarDate(TglMulai,sg1.Cells[14,i],KapasitasDivisi,KapasitasTerpakai);
                      end else begin
                        NextDate   :=  SQ1.FieldByName('tgl').AsDateTime;

                      end;

                   end else if sg1.Cells[14,i-1] <> '' then begin
                      SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                         ' AND id_divisi="'+sg1.Cells[14,i-1]+'" AND gc_code="'+sg1.Cells[19,i]+'" ORDER BY tgl DESC limit 1');
                      NextDate   :=  SQ1.FieldByName('tgl').AsDateTime + 1;

                   end;
                 //  ShowMessage(Tanggal(NextDate));
                 GenerateDate(i,NextDate);
               end;
              // dt.Date := StartDateTemp;
               SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
               ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" '+
               ' AND gc_code="'+sg1.Cells[19,i]+'"');
               sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
               sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);

               SQ2.Open('SELECT min(tgl) as stardate,max(tgl) as enddate FROM detail_jadwal '+
               '  WHERE gc_code="'+sg1.Cells[19,i]+'" ');
               MinTgl := toDate(SQ2.FieldByName('stardate').AsString);

               MaxTgl := toDate(SQ2.FieldByName('enddate').AsString);

               RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;
               ColumnCounter  := sg1.ColCount - 21;
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

                  SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,i]+'"  '+
                  ' AND id_divisi="'+sg1.Cells[14,i]+'" AND gc_code="'+sg1.Cells[19,i]+'" '+
                  ' AND tgl>="'+Tanggal(MinTgl)+'" AND tgl<="'+Tanggal(MaxTgl)+'" ORDER BY tgl ASC ');

                  while not SQ4.Eof do begin
                    if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                      gapDate := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                      ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
                      sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                      sg1.Colors[21+GapDate,i]   := GetValInt(Q4,'initial_color');
                      sg1.ColorsTo[21+GapDate,i] := GetValInt(Q4,'initial_color');
                      sg1.FontColors[21+GapDate,i] := clWhite;
                      sg1.FontSizes[21+GapDate,i]  := 8;
                    end;
                    Application.ProcessMessages;
                    SQ4.Next;
                  end;

          end;
      end;
      Inc(IndexWarna);
      Floading.pgbar.Position := i;
   end;

  // CreateChart();
   sg1.EndUpdate;
   Floading.Close;
  Except
    Floading.Close;
      Error('Terjadi kesalahan dalam pencarian tanggal mulai, Tanggal Mulai Divisi '+
      ' Kurang dari tanggal mulai Divisi Sebelumnya ');
  end;
end;

procedure TFDataGanttChart.Col12(arow:integer);

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
                ' AND item_id="'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'" '+
                ' AND tgl>="'+Tanggal(dt.date)+'" '+
                ' ORDER BY tgl ASC Limit 1');
                if (SQ4.IsEmpty) then begin
                   TglMulai := sg1.Dates[11,Arow] + AjustDate;                 
                end else begin
                  TglMulai := SQ4.FieldByName('tgl').AsDateTime + AjustDate;                 
                end;



          end else begin
             if sg1.Cells[14,Arow -1] <> '' then

             EXQry(Q1,'SELECT tgl FROM detailjadwal WHERE id_divisi="'+sg1.Cells[14,Arow-1]+'" '+
                ' AND item_id="'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'" AND tgl>="'+Tanggal(dt.date)+'" '+
                ' ORDER BY tgl DESC Limit 1',True) else
             EXQry(Q1,'SELECT tgl FROM detailjadwal WHERE id_divisi="'+sg1.Cells[14,Arow]+'" '+
                ' AND item_id="'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'" AND tgl>="'+Tanggal(dt.date)+'" '+
                ' ORDER BY tgl ASC Limit 1',True);

             if Q1.IsEmpty then
                TglMulai := dt.date else begin
                    TglMulai := GetStarDate(GetValDate(Q1,'tgl'),sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai) ;

                    if DaysBetween(TglMulai,Now) >= 100 then
                       TglMulai := sg1.Dates[13,Arow -1] + 1;

                end;


          end;

                Hari            :=  StrToIntDef(sg1.Cells[9,Arow],0) + StrToIntDef(sg1.Cells[10,Arow],0);
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
                             ' (id_divisi in ('+IdDivisi+') AND id_divisi="'+sg1.Cells[14,Arow]+'" '+
                             '  AND no_urut >='+sg1.Cells[18,Arow]+') AND  ';

                             if AjustDate > 0 then
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai-AjustDate)+'" ' else
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai)+'" ';

                             SQ2.ExecSQL;
                         end else begin

                             SQ2.Close;
                             SQ2.SQL.Text := 'UPDATE detail_jadwal SET total_menit=0 WHERE '+
                             ' (id_divisi in ('+IdDivisi+')  AND id_divisi="'+sg1.Cells[14,Arow]+'" OR no_urut >='+sg1.Cells[18,Arow]+') '+
                             ' AND item_id="'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'" AND ';

                             if AjustDate > 0 then
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai-AjustDate)+'" ' else
                             SQ2.SQL.Text := SQ2.SQL.Text +' tgl>="'+Tanggal(TglMulai)+'" ';


                             SQ2.ExecSQL;
                             Memo1.Lines.Add('SQL : '+SQ2.SQL.Text+' Divis : '+sg1.Cells[4,Arow]+' Tanggal : '+Tanggal(TglMulai-ajustDate)+' Tanggal Ori : '+Tanggal(TglMulai));
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
                         ' (id_divisi in ('+IdDivisi+') AND id_divisi="'+sg1.Cells[14,Arow]+'" '+
                         '  OR no_urut >= "'+sg1.Cells[18,Arow]+'")'+
                         ' AND tgl>="'+Tanggal(TglMulai-AjustDate)+'" ';
                         SQDelete.ExecSQL;
                     end else begin
                         SQDelete.Close;
                         SQDelete.SQL.Text := 'UPDATE detail_jadwal set total_menit=0 WHERE '+
                         ' (id_divisi in ('+IdDivisi+') AND id_divisi="'+sg1.Cells[14,Arow]+'"  OR no_urut >= "'+sg1.Cells[18,Arow]+'")'+
                         ' AND tgl>="'+Tanggal(TglMulai-AjustDate)+'" AND item_id="'+Sg1.Cells[16,Arow]+'" '+
                         ' AND gc_code="'+sg1.Cells[19,Arow]+'"';
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
                     ' AND item_id="'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'"';
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

                   for i := sg1.Row to IndexLastItem-1 do begin
                      for j := 21 to sg1.ColCount -1 do begin
                        ResetColor(i,j);
                      end;

                   end;

                   sg1.EndUpdate;


                 sg1.BeginUpdate;

             //     sg1.ClearCols(21,sg1.ColCount-1);
                  for I := sg1.Row to IndexLastItem -1 do begin


                  //  if  (StrToIntDef(sg1.Cells[18,i],0) >= StrToIntDef(sg1.Cells[18,
                  //                                  FindDivisi(StrToIntDef(sg1.Cells[14,Arow],0))],0)) then begin

                      //  ShowMessage(sg1.Cells[18,i]+' '+sg1.Cells[18,
                      //                              FindDivisi(StrToIntDef(sg1.Cells[14,Arow],0))]);

                        if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

                            if i <> Arow then begin
                                if sg1.Cells[14,i-1] = '' then begin

                                    SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                                       ' AND id_divisi="'+sg1.Cells[14,i]+'" AND total_menit > 0 '+
                                       ' AND gc_code="'+sg1.Cells[19,i]+'" ORDER BY tgl ASC limit 1');

                                    if SQ1.IsEmpty then begin

                                       NextDate := GetStarDate(TglMulai,sg1.Cells[14,i],KapasitasDivisi,KapasitasTerpakai);
                                    end else begin
                                      NextDate   :=  SQ1.FieldByName('tgl').AsDateTime;

                                    end;
                                   

                                 end else if sg1.Cells[14,i-1] <> '' then begin


                                    SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                                       ' AND id_divisi="'+sg1.Cells[14,i-1]+'" AND total_menit>0 '+
                                       ' AND gc_code="'+sg1.Cells[19,i]+'" ORDER BY tgl DESC limit 1');

                                    if AjustDate <> 0 then begin

                                        if SQ1.FieldByName('tgl').AsDateTime < TglMulai then
                                            NextDate   :=  TglMulai else
                                            NextDate   :=  SQ1.FieldByName('tgl').AsDateTime +1;

                                         
                                    end else
                                            NextDate   :=  SQ1.FieldByName('tgl').AsDateTime +1;

                            
                                 end;
                              GenerateDate(i,NextDate);
                            end;



                     //   end;
                    end;
                  //  dt.Date := StartDateTemp;

                   SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
                              ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND '+
                              ' item_id="'+sg1.Cells[16,i]+'" AND total_menit>0 AND gc_code="'+sg1.Cells[19,i]+'"');

                    if (SQ4.FieldByName('Startdate').AsString <> '') and (SQ4.FieldByName('Enddate').AsString <> '') then begin

                    sg1.Dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
                    sg1.Dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);
                    end;

                     SQ2.Open('SELECT min(tgl) as StartDate,Max(tgl) as EndDate FROM detail_jadwal '+
                     ' WHERE  total_menit>0 AND  gc_code="'+sg1.Cells[19,i]+'"');
                     MinTgl := toDate(SQ2.FieldByName('StartDate').AsString);
                     MaxTgl := toDate(SQ2.FieldByName('EndDate').AsString);


                     RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 2;
                     sg1.ColCount   := 21;
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

                        SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,i]+'"  '+
                        ' AND id_divisi="'+sg1.Cells[14,i]+'" AND '+
                        ' tgl>="'+Tanggal(MinTgl)+'" AND tgl<="'+Tanggal(MaxTgl)+'" '+
                        ' AND total_menit>0 AND gc_code="'+sg1.Cells[19,i]+'"');

                        while  not SQ4.Eof do begin


                            if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                              GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                              ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
                              sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                              sg1.Colors[21+GapDate,i]   := GetValInt(Q4,'initial_color');
                              sg1.ColorsTo[21+GapDate,i] := GetValInt(Q4,'initial_color');
                              sg1.FontColors[21+GapDate,i] := clWhite;
                              sg1.FontSizes[21+GapDate,i]  := 8;
                            end;
                              SQ4.Next;
                        end;
                      Application.ProcessMessages;
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
      on E:exception do begin
          Floading.Close;
          Error(E.Message+ 'Terjadi kesalahan dalam pencarian tanggal mulai, Tanggal Mulai Divisi '+
          ' Kurang dari tanggal mulai Divisi Sebelumnya ');
      end;
    end;


end;

function TFDataGanttChart.convertDate(AStr: String): String;
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

procedure TFDataGanttChart.CreateChart(gc_code:string);
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
  varQtyOrder : Integer;
  urutDivisi : integer;
begin

  r := 0;
  urut := 1;

  sg1.BeginUpdate;
  sg1.FloatingFooter.Visible := False;
  CreateGrid;
 //


  ExQry(Q1,'SELECT MIN(tgl) as tglmulai,MAX(tgl) as tglakhir FROM detailjadwal '+
        ' WHERE  gc_code="'+gc_code+'" ',True);

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


    ExQry(Q1,'SELECT DISTINCT i.id,i.itemno,d.deskripsi,d.qty_order,'+
    ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
    ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
    ' WHERE g.code="'+gc_code+'" ',True);


   if GetValDate(Q1,'cancel_date') < dt.Date then
      sg1.FixedCols :=  14 else
      sg1.FixedCols := 0;

    while not Q1.Eof do begin

      with sg1 do begin

          Cells[1,r+1] := GetVal(Q1,'deskripsi');
          Cells[1,r+2] := 'No SO : '+ GetVal(Q1,'so_no');
          Cells[1,r+3] := 'Container : '+ GetVal(Q1,'nomer_container');
          Cells[1,r+4] := 'Tgl Input : '+ GetVal(Q1,'tgl_input');
          Cells[1,r+5] := 'Cancel Date : '+ GetVal(Q1,'cancel_date');
          ExQry(Q3,'SELECT d.jumlah FROM detail_sales_order d '+
          ' LEFT JOIN sales_order s ON s.no_input=d.no_input '+
          ' WHERE s.no_sales_order="'+GetVal(Q1,'so_no')+'" '+
          ' AND s.nomer_container="'+GetVal(Q1,'nomer_container')+'" '+
          ' AND d.item_id="'+GetVal(Q1,'id')+'"',True);

          if GetValInt(Q3,'jumlah') <> GetValInt(Q1,'qty_order') then begin
             Colors[2,r+1]   := clRed;
             ColorsTo[2,r+1] := clRed;
             Cells[2,r+1]    := GetVal(Q3,'jumlah');
             varQtyOrder     := GetValInt(Q3,'jumlah');
          end else begin
             Colors[2,r+1]   := clWhite;
             ColorsTo[2,r+1] := clWhite;
             Cells[2,r+1]    := GetVal(Q1,'qty_order');
             varQtyOrder     := GetValInt(Q1,'qty_order');
          end;
          Cells[0,r+1] := IntToStr(Urut);
          Cells[19,r+1]:= GetVal(Q1,'gantt_code');
          Cells[16,r+1]:= GetVal(Q1,'id');

       
              _SQL := 'SELECT g.*,i.id as itemid,d.name,sp.no_urut FROM gant_detail g LEFT JOIN '+
             ' item i ON i.id=g.item_id LEFT JOIN setting_process sp '+
             ' ON sp.item_id=g.item_id '+
             ' LEFT JOIN pekerjaan p ON p.id=sp.id_pekerjaan '+
             ' LEFT JOIN divisi d ON d.id=p.id_divisi '+
             ' AND d.id=g.id_divisi '+
             ' WHERE g.item_id="'+GetVal(Q1,'id')+'" '+
             ' AND '+
             ' g.gantt_code="'+GetVal(Q1,'gantt_code')+'" '+
             ' GROUP BY d.id HAVING d.`name` IS NOT NULL ORDER BY sp.no_urut ASC ';
              ExQry(Q2,_SQL,True);

          indexRow    := r + 1;
          j           := r + 1;
          MergeCount  := 0;
          urutDivisi  := 1;
          while not Q2.Eof do begin
              RowCount     := RowCount + 1;
//              if GetVal(Q2,'no_urut') <> GetVal(Q2,'step_process') then
//              begin
//                Colors[3,IndexRow+1] := clRed;
//                ColorsTo[3,IndexRow +1] := clRed;
//              end else begin
//                Colors[3,IndexRow+1] := clWhite;
//                ColorsTo[3,IndexRow +1] := clWhite;
//              end;
              Cells[3, indexRow +1 ]    := IntToStr(urutDivisi);
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

              if (ROUND(GetValF(Q4,'menit') * varQtyOrder)) <> GetValF(Q2,'manhour')  then
              begin
                Cells[6,indexRow+1]      := Format('%.0n',[GetValF(Q4,'menit') * varQtyOrder]);
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
              Cells[17,indexRow +1]    := IntToStr(varQtyOrder);
              Cells[18,indexRow +1]    := GetVal(Q4,'no_urut');
              Cells[19,indexRow +1]    := GetVal(Q1,'gantt_code');
              Inc(urutDivisi);



              Q5.Close;
              Q5.SQL.Text :='SELECT tgl,total_menit FROM detailjadwal WHERE '+
                   ' item_id="'+GetVal(Q2,'itemid')+'"  '+
                   ' AND id_divisi="'+GetVal(Q2,'id_divisi')+'" '+
                   ' AND tgl>="'+Tanggal(tglMulai)+'" AND tgl<="'+Tanggal(tglAkhir)+'" '+
                   ' AND gc_code="'+getVal(Q1,'gantt_code')+'" ORDER BY tgl ASC';
              Q5.Open;

              Q5.First;

              while Q5.Eof = False do begin

               if Q5.FieldByName('total_menit').AsInteger > 0 then begin
                 GapDate := DaysBetween(tglMulai,Q5.FieldByName('tgl').AsDateTime);
                 ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+GetVal(Q2,'id_divisi')+'"',True);
                 sg1.Cells[21+GapDate,indexRow +1]    := Q5.FieldByName('total_menit').AsString;
                 sg1.Colors[21+GapDate,indexRow +1]   := GetValInt(Q4,'initial_color');
                 sg1.ColorsTo[21+GapDate,indexRow +1] := GetValInt(Q4,'initial_color');
                 sg1.FontColors[21+GapDate,IndexRow+1] := clWhite;
                 sg1.FontSizes[21+GapDate,IndexRow + 1] := 8;
               end;
               Q5.Next;
              end;





          Q2.Next;
          Inc(indexRow);
          Inc(MergeCount);
          sg1.MergeCells(1,j+1+4,1,MergeCount-3);
          Application.ProcessMessages;


        end;
        Inc(urut);


        ExQry(Q4,'SELECT img FROM item WHERE itemno="'+GetVal(Q1,'itemno')+'"',True);
          if not Q4.FieldByName('img').IsNull then begin
            bs          := Q4.CreateBlobStream(Q4.FieldByName('img'),bmRead);
            jpg         :=TJPEGImage.Create;
            jpg.LoadFromStream(bs);

            CreatePicture(1,j+1+4  ,True,StretchWithAspectRatio,1,haCenter,vaCenter).Assign(jpg);
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





procedure TFDataGanttChart.CreateGrid;
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

procedure TFDataGanttChart.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    i : integer;
begin
  if Key = 13 then begin
     gridGantChart;

     Q1.Close;
     Q1.SQL.Text := 'SELECT code,so_no,nomer_container FROM gantt_chart '+
     ' WHERE (code LIKE "%'+Ecari.Text+'%" OR so_no LIKE "%'+ECari.Text+'%" '+
     ' OR nomer_container LIKE "%'+ECari.Text+'%") ORDER BY so_no ASC ';
     Q1.Open;

     i := 1;
     sgGantChart.RowCount := Q1.RecordCount + 2;
     while Q1.Eof = false do begin
        sgGantChart.Cells[0,i] := GetVal(Q1,'so_no');
        sgGantChart.Cells[1,i] := GetVal(Q1,'nomer_container');
        sgGantChart.Cells[2,i] := GetVal(Q1,'code');
        Q1.Next;
        Inc(i);

     end;

  end;
end;

procedure TFDataGanttChart.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin


  if (isSave = False) then begin
      if MessageDlg('Ada perubahan di data gant chart yang belum disimpan '+#13+
                    'Apakah ingin meyimpan perubahan ? ',mtConfirmation,[mbYes,mbNo],0) =mrYes then begin
                      SaveGC;
                    end;
  end;
  SQ1.Close;
  SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
  SQ1.ExecSQL;

  CanClose := True;

end;

procedure TFDataGanttChart.FormCreate(Sender: TObject);
begin
    isShow := True;
  //  dt.date := findStartDate;


end;

procedure TFDataGanttChart.FormShow(Sender: TObject);
var
  _bulk : String;
  i : integer;
begin

 isSave := True;

 gridGantChart;

 Q1.Close;
 Q1.SQL.Text := 'SELECT code,so_no,nomer_container FROM gantt_chart '+
 ' WHERE DATE_ADD(cancel_date,interval 30 day) >= "'+tanggal(now)+'" ORDER BY so_no ASC ';
 Q1.Open;

 i := 1;
 sgGantChart.RowCount := Q1.RecordCount + 2;
 while Q1.Eof = false do begin
    sgGantChart.Cells[0,i] := GetVal(Q1,'so_no');
    sgGantChart.Cells[1,i] := GetVal(Q1,'nomer_container');
    sgGantChart.Cells[2,i] := GetVal(Q1,'code');
    Q1.Next;
    Inc(i);
 end;

  dt.date := findStartDate;

  addLocal;
  CreateGrid;

end;

procedure TFDataGanttChart.GenerateDate(ARow: integer;ADate:TDate);
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
                           ' AND item_id="'+sg1.Cells[16,Arow]+'" AND gc_code="'+sg1.Cells[19,Arow]+'"';
             SQDelete.ExecSQL;

             Memo1.Lines.Add(sqDELETE.sQL.Text);
         end;
        





          SQ3.Open('SELECT COUNT(tgl) as jmltgl,MAX(tgl) as tgl FROM detail_jadwal WHERE '+
          ' id_divisi="'+sg1.Cells[14,Arow]+'" '+
          ' AND item_id="'+sg1.Cells[16,Arow]+'" '+
          ' AND total_menit>0 AND gc_code="'+sg1.Cells[19,Arow]+'"');

          JmlTgl      := SQ3.FieldByName('jmltgl').AsInteger;
          if SQ3.FieldByName('tgl').AsString <> '' then
             TglTerakhir := toDate(SQ3.FieldByName('tgl').AsString) else
             TglTerakhir := Now;


          if JmlTgl >0 then begin
         
                try           
                   SQ3.Open('SELECT SUM(total_menit) as totalterpakai FROM detail_jadwal WHERE '+
                   ' id_divisi="'+sg1.Cells[14,Arow]+'" AND item_id="'+sg1.Cells[16,Arow]+'" '+
                   ' AND gc_code="'+sg1.Cells[19,Arow]+'" '+
                   ' AND tgl>="'+Tanggal(ADate)+'" ');

                   if (StrToIntDef(SQ3.Fields[0].AsString,0) = 0) then begin
                      SQ1.Open('SELECT SUM(total_menit) as totalterpakai FROM detail_jadwal WHERE '+
                      ' id_divisi="'+sg1.Cells[14,Arow]+'" AND item_id="'+sg1.Cells[16,Arow]+'" '+
                      ' AND gc_code="'+sg1.Cells[19,Arow]+'" '+
                      ' AND tgl>="'+Tanggal(sg1.Dates[11,Arow])+'" ');

                      if (StrToIntDef(SQ1.Fields[0].AsString,0) > 0) then 
                         ManHour := ManHour - StrToIntDef(SQ1.Fields[0].AsString,0) 
                      else
                         ManHour := ManHour - 0;
             
                   end else begin                      
                      ManHour := ManHour - StrToIntDef(SQ3.Fields[0].AsString,0) ;
                   end;
                Except
                  on E:Exception do begin
                     Memo1.Lines.Add('Error 3: '+E.Message+' SQL : '+SQ3.SQL.Text+' Total Terpakai : '+ SQ3.FieldByName('totalterpakai').AsString);
                  end;
                end;
          

          end;


          if (JmlTgl <= Lamahari - Plushari)  then begin
        

             j := 0;
             for i := 0 to (LamaHari - JmlTgl) -1 do begin
                  NextDate := GetStarDate(StartDate+i-j,sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai);
                  if NextDate > StartDate + i then begin
                     StartDate := NextDate;
                     j := i;
                  end;


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

function TFDataGanttChart.GetStarDate(ADate: TDate;id_divisi:String;KapasitasDivisi:Integer;var KapasitasTerpakai:Integer): TDate;
begin
  SQ2.Open(' SELECT tgl,total_menit FROM detail_jadwal '+
  ' WHERE tgl="'+Tanggal(ADate)+'" AND id_divisi="'+id_divisi+'"  ');
  
  if (SQ2.IsEmpty)  then begin
     KapasitasTerpakai := 0;
     Result := Adate;
  end else begin


     SQ3.Open(' SELECT tgl,SUM(total_menit) as KapasitasTerpakai '+
              ' FROM detail_jadwal WHERE id_divisi="'+id_divisi+'" '+
              ' AND tgl>="'+Tanggal(Adate)+'" GROUP BY tgl '+
              ' HAVING '+IntToStr(KapasitasDivisi)+'-KapasitasTerpakai > 0  ');

    KapasitasTerpakai := StrToIntDef(SQ3.FieldByName('KapasitasTerpakai').AsString,0);

    if DaysBetween(SQ3.FieldByName('tgl').AsDateTime,Now) >= 100 then
       Result := ADate else
    Result := SQ3.FieldByName('tgl').AsDateTime;
  end;
  Exit;
end;

procedure TFDataGanttChart.gridGantChart;
begin
  with sgGantChart do begin
     ClearAll;
     ColCount := 3;

     Cells[0,0] := 'No So';
     Cells[1,0] := 'Container';
     Cells[2,0] := 'Code';

     ColWidths[0] := 100;
     ColWidths[1] := 200;
     ColWidths[2] := 0;

     ColumnSize.StretchColumn := 1;
     ColumnSize.Stretch       := True;
  end;
end;

function TFDataGanttChart.IdDivisi: String;
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

function TFDataGanttChart.IndexLastItem: Integer;
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

procedure TFDataGanttChart.KosongkanGrid;
var
  c , i : integer;
begin
  for i := 0 to sg1.ColCount -1 do
  for c := 1 to sg1.RowCount -1 do
    sg1.Cells[i,c] := '';
  sg1.RowCount := 2;

end;


procedure TFDataGanttChart.P1Click(Sender: TObject);
var
  StartDate : TDate;
  EndDate   : TDate;
  GapDate   : Integer;
  TglA      : TDate;
  i , x      : Integer;
  so_no : String;
  _bulk     : String;
  JumlahHari : integer;
  ManHour   : Integer;
  TambahHari : Integer;
  AlokasiWaktu ,JamKerja,JmlKaryawan : integer;
begin


    Floading.Show;
    Floading.pgbar.Maximum := sg1.RowCount;
    ExQry(Q2,'DELETE FROM detailjadwal WHERE gc_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',False);
     for i := 1 to sg1.RowCount -1 do begin
       if sg1.Cells[11,i] <> '' then
       begin


         JamKerja         := StrToIntDef(Nilai(sg1.Cells[7,i]),0);
         JmlKaryawan      := StrToIntDef(Nilai(sg1.Cells[8,i]),0);
         ManHour          := StrToIntDef(Nilai(sg1.Cells[6,i]),0);
         TambahHari       := StrToIntDef(Nilai(sg1.Cells[10,i]),0);
         AlokasiWaktu     := Jamkerja * JmlKaryawan * 60;
         JumlahHari       := Ceil(ManHour / AlokasiWaktu) + TambahHari;
         sg1.Cells[9,i]   := IntToStr(JumlahHari-TambahHari);
         sg1.Dates[13,i]  := sg1.Dates[11,i]+ (JumlahHari-1);

         Q3.Close;
         Q3.SQL.Text := 'UPDATE gant_detail set tgl_mulai="'+Tanggal(sg1.Dates[11,i])+'", '+
         ' tgl_akhir="'+Tanggal(sg1.Dates[13,i])+'", '+
         ' alokasi_tng_kerja="'+sg1.Cells[8,i]+'",'+
         ' jam_kerja="'+sg1.Cells[7,i]+'",'+
         ' manhour="'+StrToDecimal(sg1.Cells[6,i])+'",'+
         ' qty_order="'+StrToDecimal(sg1.Cells[17,i])+'",'+
         ' hari="'+nilai(sg1.Cells[9,i])+'",'+
         ' plusmin_hari="'+StrToDecimal(sg1.Cells[10,i])+'",'+
         ' plusmin_date="'+StrToDecimal(sg1.Cells[12,i])+'", '+
         ' step_process="'+sg1.Cells[3,i]+'" '+
         ' WHERE gantt_code="'+sg1.Cells[19,i]+'" '+
         ' AND id_divisi="'+sg1.Cells[14,i]+'" AND '+
         ' item_id="'+sg1.Cells[16,i]+'" AND gantt_code="'+sg1.Cells[19,i]+'" ';
         Q3.ExecSQL;


         ExQry(Q3,'SELECT MIN(tgl_mulai) as StartDate FROM gant_detail '+
         ' WHERE gantt_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',True);

         TglA := GetValDate(Q3,'StartDate');

         ExQry(Q3,'SELECT so_no FROM gantt_chart WHERE code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',True);
         so_no := GetVal(Q3,'so_no');


         StartDate        := sg1.Dates[11,i];
         EndDate          := sg1.Dates[13,i];

         GapDate          := DaysBetween(TglA,StartDate);




         for x := 0 to JumlahHari-1 do begin

               Q1.Close;
               Q1.SQL.Text := 'INSERT INTO detailjadwal ('+
               'id_divisi,tgl,sono,item_id,'+
               'qty_order,total_menit,gc_code,kapasitas,manhour,no_urut,alokasi_tng_kerja,jam_kerja) '+
               'VALUES (:id_divisi,:tgl,:sono,:item_id,:qty_order,'+
               ':total_menit,:gc_code,:kapasitas,:manhour,:no_urut,:alokasi_tng_kerja,:jam_kerja) ';
               Q1.ParamByName('id_divisi').AsString       := sg1.Cells[14,i];
               Q1.ParamByName('tgl').AsDate               := StartDate + x;
               Q1.ParamByName('sono').AsString            := so_no;
               Q1.ParamByName('item_id').AsString         := sg1.Cells[16,i];
               Q1.ParamByName('qty_order').AsString       := sg1.Cells[17,i];

               if ManHour  >= AlokasiWaktu then begin
                  Q1.ParamByName('total_menit').AsInteger    := AlokasiWaktu;
                  ManHour := ManHour - AlokasiWaktu;
                  Memo1.Lines.Add(' INSERT INTO detail_jadwal(tgl,total_menit) ' +
                              ' "'+Tanggal(StartDate+x)+'","'+IntToStr(ManHour)+'" Alo"'+IntToStr(AlokasiWaktu)+'")');
               end else if AlokasiWaktu > ManHour then begin
                  Q1.ParamByName('total_menit').AsInteger    := ROUND(ManHour / JmlKaryawan);
                  Memo1.Lines.Add(' INSERT INTO detail_jadwal(tgl,total_menit) ' +
                              ' "'+Tanggal(StartDate+x)+'","'+IntToStr(ManHour)+'")');
               end;

               Q1.ParamByName('gc_code').AsString         := sgGantChart.Cells[2,sgGantChart.Row];
               Q1.ParamByName('kapasitas').AsInteger      := StrToIntDef(sg1.Cells[15,i],0) * StrToIntDef(sg1.Cells[7,i],0) * 60 ;
               Q1.ParamByName('manhour').AsInteger        := StrToIntDef(nilai(sg1.Cells[6,i]),0);
               Q1.ParamByName('no_urut').AsInteger        := StrToIntDef(sg1.Cells[18,i],0);
               Q1.ParamByName('alokasi_tng_kerja').AsString := StrToDecimal(sg1.Cells[8,i]);
               Q1.ParamByName('jam_kerja').AsString        :=  StrToDecimal(sg1.Cells[7,i]);
               Q1.ExecSQL;


        //      Memo1.Lines.Add('Tanggal : '+Tanggal(StartDate + x)+' menit : '+INtToStr(StrToIntDef(sg1.Cells[21 + GapDate +x,i],0)));


           Application.ProcessMessages;
          end;

          Floading.pgbar.Position := i;
          Application.ProcessMessages;
       end;
     end;
     Floading.Close;


    sgGantChartDblClick(Sender);

    isSave := True;
    Informasi('GC berhasil di update');

end;

procedure TFDataGanttChart.ResetChart;
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

procedure TFDataGanttChart.ResetColor(Arow:Integer;Acol:integer);

begin

      sg1.Colors[Acol,Arow]    :=  clWhite;
      sg1.ColorsTo[Acol,Arow]  := clWhite;
      sg1.Cells[Acol,Arow]     := '';

end;

procedure TFDataGanttChart.SaveGC;
var
  StartDate : TDate;
  EndDate   : TDate;
  GapDate   : Integer;
  TglA      : TDate;
  i , x      : Integer;
  so_no : String;
  _bulk     : String;
  JumlahHari : integer;
  ManHour   : Integer;
  AlokasiWaktu ,JamKerja,JmlKaryawan : integer;
begin


    Floading.Show;
    Floading.pgbar.Maximum := sg1.RowCount;
    ExQry(Q2,'DELETE FROM detailjadwal WHERE gc_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',False);
     for i := 1 to sg1.RowCount -1 do begin
       if sg1.Cells[11,i] <> '' then
       begin
         Q3.Close;
         Q3.SQL.Text := 'UPDATE gant_detail set tgl_mulai="'+Tanggal(sg1.Dates[11,i])+'", '+
         ' tgl_akhir="'+Tanggal(sg1.Dates[13,i])+'", '+
         ' alokasi_tng_kerja="'+sg1.Cells[8,i]+'",'+
         ' jam_kerja="'+sg1.Cells[7,i]+'",'+
         ' manhour="'+StrToDecimal(sg1.Cells[6,i])+'",'+
         ' hari="'+nilai(sg1.Cells[9,i])+'",'+
         ' plusmin_hari="'+StrToDecimal(sg1.Cells[10,i])+'",'+
         ' plusmin_date="'+StrToDecimal(sg1.Cells[12,i])+'", '+
         ' step_process="'+sg1.Cells[3,i]+'" '+
         ' WHERE gantt_code="'+sg1.Cells[19,i]+'" '+
         ' AND id_divisi="'+sg1.Cells[14,i]+'" AND '+
         ' item_id="'+sg1.Cells[16,i]+'" AND gantt_code="'+sg1.Cells[19,i]+'" ';
         Q3.ExecSQL;


         ExQry(Q3,'SELECT MIN(tgl_mulai) as StartDate FROM gant_detail '+
         ' WHERE gantt_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',True);

         TglA := GetValDate(Q3,'StartDate');

         ExQry(Q3,'SELECT so_no FROM gantt_chart WHERE code="'+sgGantChart.Cells[2,sgGantChart.Row]+'"',True);
         so_no := GetVal(Q3,'so_no');


         StartDate        := sg1.Dates[11,i];
         EndDate          := sg1.Dates[13,i];

         GapDate          := DaysBetween(TglA,StartDate);

         JumlahHari       := DaysBetween(StartDate,EndDate) ;
         JamKerja         := StrToIntDef(Nilai(sg1.Cells[7,i]),0);
         JmlKaryawan      := StrToIntDef(Nilai(sg1.Cells[8,i]),0);
         ManHour          := StrToIntDef(Nilai(sg1.Cells[6,i]),0);
         AlokasiWaktu     := Jamkerja * JmlKaryawan * 60;


         for x := 0 to JumlahHari do begin

               Q1.Close;
               Q1.SQL.Text := 'INSERT INTO detailjadwal ('+
               'id_divisi,tgl,sono,item_id,'+
               'qty_order,total_menit,gc_code,kapasitas,manhour,no_urut,alokasi_tng_kerja,jam_kerja) '+
               'VALUES (:id_divisi,:tgl,:sono,:item_id,:qty_order,'+
               ':total_menit,:gc_code,:kapasitas,:manhour,:no_urut,:alokasi_tng_kerja,:jam_kerja) ';
               Q1.ParamByName('id_divisi').AsString       := sg1.Cells[14,i];
               Q1.ParamByName('tgl').AsDate               := StartDate + x;
               Q1.ParamByName('sono').AsString            := so_no;
               Q1.ParamByName('item_id').AsString         := sg1.Cells[16,i];
               Q1.ParamByName('qty_order').AsString       := sg1.Cells[17,i];

               if ManHour  >= AlokasiWaktu then begin
                  Q1.ParamByName('total_menit').AsInteger    := AlokasiWaktu;
                  ManHour := ManHour - AlokasiWaktu;
//                  Memo1.Lines.Add(' INSERT INTO detail_jadwal(tgl,total_menit) ' +
//                              ' "'+Tanggal(StartDate+x)+'","'+IntToStr(ManHour)+'" Alo"'+IntToStr(AlokasiWaktu)+'")');
               end else if AlokasiWaktu > ManHour then begin
                  Q1.ParamByName('total_menit').AsInteger    := ROUND(ManHour / JmlKaryawan);
//                  Memo1.Lines.Add(' INSERT INTO detail_jadwal(tgl,total_menit) ' +
//                              ' "'+Tanggal(StartDate+x)+'","'+IntToStr(ManHour)+'")');
               end;

               Q1.ParamByName('gc_code').AsString         := sgGantChart.Cells[2,sgGantChart.Row];
               Q1.ParamByName('kapasitas').AsInteger      := StrToIntDef(sg1.Cells[15,i],0) * StrToIntDef(sg1.Cells[7,i],0) * 60 ;
               Q1.ParamByName('manhour').AsInteger        := StrToIntDef(nilai(sg1.Cells[6,i]),0);
               Q1.ParamByName('no_urut').AsInteger        := StrToIntDef(sg1.Cells[18,i],0);
               Q1.ParamByName('alokasi_tng_kerja').AsString := StrToDecimal(sg1.Cells[8,i]);
               Q1.ParamByName('jam_kerja').AsString        :=  StrToDecimal(sg1.Cells[7,i]);
               Q1.ExecSQL;


        //      Memo1.Lines.Add('Tanggal : '+Tanggal(StartDate + x)+' menit : '+INtToStr(StrToIntDef(sg1.Cells[21 + GapDate +x,i],0)));


           Application.ProcessMessages;
          end;

          Floading.pgbar.Position := i;
          Application.ProcessMessages;
       end;
     end;
     Floading.Close;



    SQ1.Close;
    SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
    SQ1.ExecSQL;

    isSave := True;
    Informasi('GC berhasil di update');

end;

procedure TFDataGanttChart.sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACOl in [5,7,8,10,11,12,13];
end;

procedure TFDataGanttChart.sg1DateTimeChange(Sender: TObject; ACol, ARow: Integer;
  ADateTime: TDateTime);
  var
    tglMulai  : TDate;
    PlusMin   : integer;
begin

  SQ1.Open('SELECT tgl FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,sg1.Row]+'" '+
  ' AND id_divisi="'+sg1.Cells[14,sg1.Row]+'" '+
  ' AND gc_code="'+sg1.Cells[19,sg1.Row]+'"');

  if SQ1.IsEmpty = False then begin


      tglMulai := SQ1.FieldByName('tgl').AsDateTime;

      PlusMin := DaysBetween(ADateTime,TglMulai) + 1;


      if ADateTime < tglMulai then
      PlusMin  := PlusMin * -1;
      sg1.Cells[12,sg1.Row] := IntToStr(PlusMin);

      if PlusMin <> 0 then
        sg1.Cells[20,sg1.Row] := '1' else
        sg1.Cells[20,sg1.Row] := '0';

      if PlusMin >=100 then
      begin
        Error('Plus minus tanggal melebihi 100 hari !!, Kerjakan data atasnya dulu yaa..');
        sg1.Cells[12,sg1.Row] := '1';
        Exit;
      end;
  end else begin
      tglMulai := sg1.Dates[11,sg1.Row];

      PlusMin := DaysBetween(ADateTime,TglMulai) + 1;


      if ADateTime < tglMulai then
      PlusMin  := PlusMin * -1;
      sg1.Cells[12,sg1.Row] := IntToStr(PlusMin);

      if PlusMin <> 0 then
        sg1.Cells[20,sg1.Row] := '1' else
        sg1.Cells[20,sg1.Row] := '0';

      if PlusMin >=100 then
      begin
        Error('Plus minus tanggal melebihi 100 hari !!, Kerjakan data atasnya dulu yaa..');
        sg1.Cells[12,sg1.Row] := '1';
        Exit;
      end;
  end;



end;

procedure TFDataGanttChart.sg1Enter(Sender: TObject);
begin
  sg1.Options := sg1.Options - [goRowSelect];
end;

procedure TFDataGanttChart.sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then
     HAlign := taCenter;
end;

procedure TFDataGanttChart.sg1GetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin

  case ACol of
  11,13 : AEditor := edDateEdit;
  end;
end;

function TFDataGanttChart.FindDivisi(id_divisi:integer):integer;
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

function TFDataGanttChart.findStartDate: TDate;
var
  item_id : String;
  i : integer;
  gc_code : String;
begin

  gc_code := '';
  for i := 1 to sgGantChart.RowCount -1  do begin
      if sgGantChart.Cells[2,i] <> '' then
      gc_code := gc_code + sgGantChart.Cells[2,i]+',';

  end;

  Delete(gc_code,length(gc_code),1);

   ExQry(Q1,'SELECT dj.tgl FROM detailjadwal dj WHERE dj.gc_code IN ('+gc_code+') '+
   ' ORDER BY dj.tgl ASC LIMIT 1',True );
    if Q1.IsEmpty = false then
    Result := GetValDate(Q1,'tgl')
   else
    Result := Now;

end;

function TFDataGanttChart.FindStartRow: Integer;
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

function TFDataGanttChart.finishEdit: integer;
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

procedure TFDataGanttChart.sg1KeyPress(Sender: TObject; var Key: Char);
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
               sg1.BeginUpdate;sg1.BeginUpdate;

               for i := sg1.Row to IndexLastItem-1 do begin
                  for j := 21 to sg1.ColCount -1 do begin
                    ResetColor(i,j);
                  end;

               end;

               sg1.EndUpdate;


               IndexRow := FindStartRow;
               if IndexRow = 0 then
                  IndexRow :=  2;

              // if sg1.Cells[11,sg1.Row -1] = '' then begin
                  SQDelete.Close;
                  SQDelete.SQL.Text := 'DELETE FROM detail_jadwal WHERE '+
                  ' tgl>= "'+Tanggal(sg1.Dates[11,sg1.Row])+'" '+
                //  ' AND id_divisi="'+sg1.Cells[14,sg1.Row]+'" '+
                  ' AND item_id="'+sg1.Cells[16,sg1.Row]+'" AND gc_code="'+sg1.Cells[19,sg1.Row]+'" ';
                  SQDelete.ExecSQL;

              // end;


               DateMin :=  sg1.Dates[11,sg1.Row] + StrToIntDef(sg1.Cells[12,sg1.Row],0);


               if DateMin < dt.date then
                      dt.date :=  DateMin;


               for I := sg1.Row to IndexLastItem-1 do begin

                  if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

                     //  TglMulai := GetStarDate()
                       SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                           ' AND id_divisi="'+sg1.Cells[14,i-1]+'" AND gc_code="'+sg1.Cells[19,i]+'" ORDER BY tgl DESC limit 1');

                      // ShowMessage(sg1.Cells[4,i]+' '+SQ1.FieldByName('tgl').AsString);
                       if SQ1.IsEmpty then
                          TglMulai := sg1.Dates[11,i] else
                          TglMulai := SQ1.FieldByName('tgl').AsDateTime + 1 ;
                      // ShowMessage(Tanggal(TglMulai));
                       GenerateDate(I,TglMulai);

                      // dt.Date := StartDateTemp;
                       SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
                       ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" '+
                       ' AND gc_code="'+sg1.Cells[19,i]+'"');
                       sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
                       sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);


                       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.date)+'" '+
                       ' AND gc_code="'+sg1.Cells[19,i]+'"  ORDER BY tgl ASC LIMIT 1');
                       MinTgl := SQ2.FieldByName('tgl').AsDateTime;

                       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.date)+'" '+
                       ' AND gc_code="'+sg1.Cells[19,i]+'"  ORDER BY tgl DESC LIMIT 1');
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
                          ' tgl<="'+Tanggal(MaxTgl)+'" AND gc_code="'+sg1.Cells[19,i]+'"');

                          while not SQ4.Eof do begin

                            if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                              GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                              ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
                              sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                              sg1.Colors[21+GapDate,i]   := GetValInt(Q4,'initial_color');
                              sg1.ColorsTo[21+GapDate,i] := GetValInt(Q4,'initial_color');
                              sg1.FontColors[21+GapDate,IndexRow+1] := clWhite;
                              sg1.FontSizes[21+GapDate,IndexRow+1]  := 8;
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
               if DateMin < dt.date then
                        dt.date :=  DateMin;
              Col12(sg1.Row);

              sg1.Cells[20,sg1.Row] := '0';

      end else if (sg1.Col in [10]) then begin
         DateMin :=  sg1.Dates[11,sg1.Row] + StrToIntDef(sg1.Cells[12,sg1.Row],0);


              if DateMin < dt.date then
                      dt.date :=  DateMin;
              Col10(sg1.Row);
              sg1.Cells[20,i] := '0';
         
      end;
       //  SQ1.Open(' SELECT * '+
       //    ' FROM detail_jadwal ');
       isSave := False;
   end;


end;

procedure TFDataGanttChart.sg1KeyUp(Sender: TObject; var Key: Word;
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



procedure TFDataGanttChart.sgGantChartDblClick(Sender: TObject);
begin
   ExQry(Q1,'SELECT MIN(tgl) as tglmulai,MAX(tgl) as tglakhir FROM detailjadwal '+
        ' WHERE  gc_code="'+sgGantChart.Cells[2,sgGantChart.Row]+'" ',True);
  dt.date := GetValDate(Q1,'tglmulai');
  addLocal;
  CreateChart(sgGantChart.Cells[2,sgGantChart.Row]);
end;

procedure TFDataGanttChart.SpeedButton1Click(Sender: TObject);
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

       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.date)+'"  ORDER BY tgl ASC LIMIT 1');
       MinTgl := SQ2.FieldByName('tgl').AsDateTime;

       SQ2.Open('SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.date)+'"  ORDER BY tgl DESC LIMIT 1');
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
              ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
              sg1.Cells[21+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
              sg1.Colors[21+GapDate,i]   := GetValInt(Q4,'initial_color');
              sg1.ColorsTo[21+GapDate,i] := GetValInt(Q4,'initial_color');
              sg1.FontColors[21+GapDate,i] := clWhite;
              sg1.FontSizes[21+GapDate,i]  := 8;
            end;

            Application.ProcessMessages;
            SQ4.Next;
         end;

       end;

  end;


end;

function TFDataGanttChart.StartDateTemp: TDate;
var
  item_id : String;
begin
  SQ1.OPEN('SELECT item_id FROM detail_jadwal WHERE tgl>="'+Tanggal(dt.date)+'" '+
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

function TFDataGanttChart.startEdit: integer;
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


procedure TFDataGanttChart.TampilAwal;
begin
  ClearText(Self);

  CreateGrid;
  isFocusForm := True;
  isSave      := True;
end;

function TFDataGanttChart.toDate(AStr: String): TDate;
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



procedure TFDataGanttChart.UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
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
