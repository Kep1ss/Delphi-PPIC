unit uImportGanttChart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,math,
  AdvGrid, AdvSmoothButton, Vcl.ComCtrls, Vcl.StdCtrls, AdvEdit, AdvGroupBox, uComCtrl,DateUtils, uEngine, Data.DB, MemDS, DBAccess, MyAccess,
  VirtualTable, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, tmsAdvGridExcel;

type
  TFImportGC = class(TForm)
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    ENoSo: TAdvEdit;
    AdvSmoothButton3: TAdvSmoothButton;
    sg1: TAdvStringGrid;
    AdvGroupBox2: TAdvGroupBox;
    AdvSmoothButton1: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    Label2: TLabel;
    Label3: TLabel;
    EnoContainer: TAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    Ecode: TAdvEdit;
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
    Label7: TLabel;
    Label8: TLabel;
    Ecustomer: TAdvEdit;
    Label9: TLabel;
    Label10: TLabel;
    cancelDate: TDateTimePicker;
    AdvSmoothButton2: TAdvSmoothButton;
    Label11: TLabel;
    Label12: TLabel;
    EFile: TAdvEdit;
    OpenDialog1: TOpenDialog;
    IO: TAdvGridExcelIO;
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
    procedure btnGenerateTableClick(Sender: TObject);
    procedure sg1KeyPress(Sender: TObject; var Key: Char);
    procedure sg1DatePickerCloseUp(Sender: TObject; ARow, ACol: Integer);
    procedure AdvSmoothButton2Click(Sender: TObject);
  private
    { Private declarations }

    procedure ResetColor(ARow : Integer;Acol:integer);

  public
    { Public declarations }
    isFocusForm : Boolean;
   
    procedure CreateGrid;
    procedure TampilAwal;
    procedure KosongkanGrid;
    procedure CreateChart;
    procedure ResetChart;
    procedure GenerateDate(ARow : integer;ADate:TDate);
    procedure UpdateDate(ADate:TDate);
    procedure UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
    function convertDate(AStr:String):String;
    function toDate(AStr:String):TDate;
    function IdDivisi : String;
    function FindDivisi(id_divisi:integer):integer;
    function GetStarDate(ADate:TDate;id_divisi:String;KapasitasDivisi:Integer;var KapasitasTerpakai:Integer):TDate;
    function FindStartRow:Integer;
  end;

var
  FImportGC: TFImportGC;
  IndexWarna : Integer;

implementation

{$R *.dfm}

uses uListofSoGant, uDataGanttChart, uMarCon, uGanttChatParameters, uLoading,
  uScheduleChart;

{ TFGanttChart }

procedure TFImportGC.AdvSmoothButton1Click(Sender: TObject);
var
  i,x         : integer;
  qty_order   : integer;
  itemno, Deskripsi   : String;
  idGantChart : Integer;
  idDivisi    : Integer;
  ls : TStringList;
  tglA : TDate;
  StartDate : TDate;
  ENdDate   : TDate;
  DeleteDates : String;

begin
  if not CheckEdit(Self) then begin
     if sg1.ColCount = 18 then begin
        Error('Chart belum siap');
        Exit;
     end else begin
           ls := TStringList.Create;

           try
                idGantChart := StrToIntDef(GetData(Q1,'gantt_chart WHERE code="'+ECode.Text+'"','id'),0);
                addParam('code',     Ecode.Text,ls,'str');
                addParam('tgl_input',  frmTgl(Now),ls,'date');
                addParam('nomer_container ',  EnoContainer.Text,ls,'str');
                addParam('so_no',    ENoSo.Text,ls,'str');
                addParam('cancel_date',    frmTgl(cancelDate.Date),ls,'date');

                if Q1.IsEmpty then
                  ExeDB(Q2,'gantt_chart',ls)
                else UpdateDB(Q2,'gantt_chart',ls,'id',IntToStr(idGantChart));

                ExQry(Q2,'DELETE FROM gant_detail WHERE gantt_code="'+Ecode.Text+'"',False);
                ExQry(Q2,'DELETE FROM detailjadwal WHERE gc_code="'+Ecode.Text+'"',False);
                Floading.Show;
                Floading.pgbar.Maximum := sg1.RowCount;
                Floading.pgbar.Position := 0;
                Floading.Lprocess.Caption := 'Sedang memproses data ..... ';

                for i := 1 to sg1.RowCount -1 do begin

                  if sg1.Cells[1,i] <> '' then begin
                     itemno       := Copy(sg1.Cells[1,i],1,POS('|',sg1.Cells[1,i])-1);
                     Deskripsi    := Copy(sg1.Cells[1,i],POS('|',sg1.Cells[1,i])+1,Length(sg1.Cells[1,i]));
                     qty_order    := StrToIntDef(sg1.Cells[2,i],0);

                  end;
                    if  (sg1.Cells[4,i] <> '') and  (sg1.Cells[11,i] <> '')  and (sg1.Cells[13,i] <> '')    then begin
                         addParam('gantt_code', Ecode.Text,ls,'str');
                         addParam('itemno',     itemno,ls,'str');
                         addParam('item_id',     sg1.Cells[16,i],ls,'str');
                         addParam('deskripsi',  Deskripsi,ls,'str');
                         addParam('qty_order',  IntToStr(qty_order),ls,'str');
                         addParam('step_process',sg1.Cells[3,i],ls,'str');
                         addParam('keterangan',sg1.Cells[4,i],ls,'str');
                         addParam('tng_kerja',StrToDecimal(sg1.Cells[15,i]),ls,'str');
                         idDivisi := StrToIntDef(sg1.Cells[14,i],0);
                         addParam('id_divisi',IntToStr(idDivisi),ls,'str');
                         addParam('manhour',StrToDecimal(sg1.Cells[6,i]),ls,'str');
                         addParam('jam_kerja',StrToDecimal(sg1.Cells[7,i]),ls,'str');
                         addParam('alokasi_tng_kerja',StrToDecimal(sg1.Cells[8,i]),ls,'str');
                         addParam('hari',StrToDecimal(sg1.Cells[9,i]),ls,'str');
                         addParam('plusmin_hari',StrToDecimal(sg1.Cells[10,i]),ls,'str');;
                         if sg1.Cells[11,i] <> '' then
                         addParam('tgl_mulai',frmTgl(sg1.Dates[11,i]),ls,'date');
                         addParam('plusmin_date',StrToDecimal(sg1.Cells[12,i]),ls,'str');
                         if sg1.Cells[13,i] <> '' then
                         addParam('tgl_akhir',frmTgl(sg1.Dates[13,i]),ls,'date');

                         ExeDB(Q2,'gant_detail',ls);

                          for x := 19 to sg1.ColCount -1 do begin
                             if StrToIntDef(sg1.Cells[x,i],0) > 0 then begin

                                 tglA := StrToDate(convertDate(sg1.Cells[x,0]));

                                 Q1.Close;
                                 Q1.SQL.Text := 'INSERT INTO detailjadwal ('+
                                 'id_divisi,tgl,sono,item_id,'+
                                 'qty_order,total_menit,gc_code,kapasitas,manhour,no_urut,alokasi_tng_kerja,jam_kerja) '+
                                 'VALUES (:id_divisi,:tgl,:sono,:item_id,:qty_order,'+
                                 ':total_menit,:gc_code,:kapasitas,:manhour,:no_urut,:alokasi_tng_kerja,:jam_kerja) ';
                                 Q1.ParamByName('id_divisi').AsString       := IntToStr(idDivisi);
                                 Q1.ParamByName('tgl').AsDate               := tglA;
                                 Q1.ParamByName('sono').AsString            := ENoSo.Text;
                                 Q1.ParamByName('item_id').AsString         := sg1.Cells[16,i];
                                 Q1.ParamByName('qty_order').AsString       := sg1.Cells[17,i];
                                 Q1.ParamByName('total_menit').AsInteger    := StrToIntDef(sg1.Cells[x,i],0);
                                 Q1.ParamByName('gc_code').AsString         := Ecode.Text;
                                 Q1.ParamByName('kapasitas').AsInteger      := StrToIntDef(sg1.Cells[15,i],0) * StrToIntDef(sg1.Cells[7,i],0) * 60 ;
                                 Q1.ParamByName('manhour').AsInteger        := StrToIntDef(nilai(sg1.Cells[6,i]),0);
                                 Q1.ParamByName('no_urut').AsInteger        := StrToIntDef(sg1.Cells[18,i],0);
                                 Q1.ParamByName('alokasi_tng_kerja').AsString := StrToDecimal(sg1.Cells[8,i]);
                                 Q1.ParamByName('jam_kerja').AsString        :=  StrToDecimal(sg1.Cells[7,i]);
                                 Q1.ExecSQL;
                             end;

                         end;



                    end;

                    Floading.pgbar.Position := i;
                    Application.ProcessMessages;

                end;

                Informasi('Data Berhasil Disimpan');
                TampilAwal;
           finally
              Floading.Close;
             ls.Free;
           end;
          end;


  end;
end;

procedure TFImportGC.AdvSmoothButton2Click(Sender: TObject);
begin
  if OpenDialog1.ExeCute then begin
     EFile.Text := OpenDialog1.FileName;

     IO.XLSImport(OpenDialog1.FileName);
  end;

end;

procedure TFImportGC.AdvSmoothButton3Click(Sender: TObject);
begin
  FDaftarSOGant.ShowMOdal;
end;

procedure TFImportGC.btnAddClick(Sender: TObject);
begin
  if MessageDlg('Tutup data GC ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Close;
  end;
end;

procedure TFImportGC.btnGenerateTableClick(Sender: TObject);
var
  i , x , j: integer;
  MinTgl : TDate;
  MaxTgl : TDate;
  RangeTanggal : Integer;
begin

     SQ1.Close;
     SQ1.SQL.Text := 'DELETE FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"';
     SQ1.ExecSQL;

     IndexWarna := 1;
     Floading.Show;
     Floading.pgbar.Maximum := sg1.RowCount -1;
     Floading.pgbar.Position:= 0;
     sg1.BeginUpdate;
     for I := 2 to sg1.RowCount -1 do begin

        if (sg1.Cells[1,i] <> '') then
           IndexWarna := 1;
        if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

             if sg1.Cells[11,i] <> '' then

             GenerateDate(I,sg1.Dates[11,i]) else
             GenerateDate(I,now);


             SQ2.Open('SELECT tgl FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"  ORDER BY tgl ASC LIMIT 1');
             MinTgl := SQ2.FieldByName('tgl').AsDateTime;

             SQ2.Open('SELECT tgl FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"  ORDER BY tgl DESC LIMIT 1');
             MaxTgl := SQ2.FieldByName('tgl').AsDateTime;

             RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;
             sg1.ColCount   := RangeTanggal + 19;

             for j := 0 to sg1.ColCount -1 do
               ResetColor(i,j+19);


             for x := 0 to RangeTanggal -1 do begin

                sg1.Cells[19+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
                sg1.AddRotated(19+x,0,90,sg1.Cells[18+x,0]);
                sg1.ColWidths[19+x] := 30;

                if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
                    sg1.Colors[19+x,0]    := clRed;
                    sg1.ColorsTo[19+x,0]  := $003535FF;
                end else begin
                  sg1.Colors[19+x,0]    := $00D6D6D6;
                  sg1.ColorsTo[19+x,0]  := clWhite;
                end;

                SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE item_id="'+sg1.Cells[16,i]+'"  '+
                ' AND id_divisi="'+sg1.Cells[14,i]+'" AND tgl="'+Tanggal(MinTgl + x)+'" AND gc_code="'+ECode.Text+'"');

                if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                  ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
                  sg1.Cells[19+x,i]    := SQ4.FieldByName('total_menit').AsString;
                  sg1.Colors[19+x,i]   := GetValInt(Q4,'initial_color');
                  sg1.ColorsTo[19+x,i] := GetValInt(Q4,'initial_color');
                end else begin
                  sg1.Cells[19+x,i]    := '';
                  sg1.Colors[19+x,i]   := clWhite;
                  sg1.ColorsTo[19+x,i] := clWhite;
                end;
                Application.ProcessMessages;

             end;
        end;

        Floading.pgbar.Position := i;

     end;
     sg1.EndUpdate;
     Floading.Close;


end;

function TFImportGC.convertDate(AStr: String): String;
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

procedure TFImportGC.CreateChart;


begin



end;

procedure TFImportGC.CreateGrid;
begin
  with sg1 do begin
     ClearAll;

     ColCount   := 19;
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

     ColWidths[0] := 50;
     ColWidths[1] := 150;
     ColWidths[2] := 50;
     ColWidths[3] := 50;
     ColWidths[4] := 120;
     ColWidths[5] := 60;
     ColWidths[6] := 60;
     ColWidths[7] := 50;
     ColWidths[8] := 70;
     ColWidths[9] := 40;
     ColWidths[10] := 0;
     ColWidths[11] := 70;
     ColWidths[12] := 0;
     ColWidths[13] := 70;
     ColWidths[14] := 0;
     ColWidths[15] := 0;
     ColWidths[16] := 0;
     ColWidths[17] := 0;
     ColWidths[18] := 0;

  end;
end;

procedure TFImportGC.GenerateDate(ARow: integer;ADate:TDate);
var
  Jamkerja          : Integer;
  JumlahKaryawan    : Integer;
  ManHour           : Integer;
  KapasitasDivisi   : Integer;
  AlokasiWaktu      : Integer;
  LamaHari          : Integer;
  ExtendHari        : integer;
  KapasitasTerpakai : Integer;
  i,x,y               : integer;
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
  j  : Integer;

begin


  JamKerja        := StrToIntDef(nilai(sg1.Cells[7,ARow]),1);
  JumlahKaryawan  := StrToIntDef(nilai(sg1.Cells[8,ARow]),1);
  ManHour         := StrToIntDef(nilai(sg1.Cells[6,ARow]),1);
  BaseManhour     := StrToIntDef(nilai(sg1.Cells[6,ARow]),1);
  NoUrut          := StrToIntDef(nilai(sg1.Cells[18,ARow]),0);
  KapasitasDivisi := StrToIntDef(sg1.Cells[15,ARow],0) * (JamKerja * 60);



  if (JamKerja > 0) and (JumlahKaryawan > 0) and (ManHour > 0) then begin

      AlokasiWaktu      := Jamkerja * JumlahKaryawan * 60;
      LamaHari          := Ceil(ManHour /AlokasiWaktu);
      if LamaHari < 1 then
      LamaHari :=  1;
      sg1.Cells[9,ARow] := IntToStr(LamaHari);

      AjustDate         := StrToIntDef(sg1.Cells[12,ARow],0);
      plusHari          := StrToIntDef(sg1.Cells[10,ARow],0);

      if plusHari > 0 then  begin
         ManHour  := ManHour + (AlokasiWaktu * plusHari);
         LamaHari := LamaHari + plusHari;
      end;




        StartDate := ADate;

        SQDelete.Close;
        SQDelete.SQL.Text := 'DELETE FROM detail_jadwal WHERE '+
                     ' id_divisi="'+sg1.Cells[14,Arow]+'" '+
                     ' AND gc_code="'+Ecode.Text+'" '+
                     ' AND item_id="'+sg1.Cells[16,Arow]+'"';
        SQDelete.ExecSQL;



         j := 0;
         for i := 0 to LamaHari -1 do begin
              NextDate := GetStarDate(StartDate+i-j,sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai);
              if NextDate > StartDate + i then begin
                 StartDate := NextDate;
                 j := i;
              end;

              //ShowMessage(Tanggal(NextDate)+' Divisi : '+sg1.Cells[14,Arow]+' Item Id : '+sg1.Cells[16,Arow]);
              SQ1.Close;
              SQ1.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
              ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
              ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
              ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

              SQ1.ParamByName('id_divisi').AsInteger     := StrToIntDef(sg1.Cells[14,Arow],0);
              SQ1.ParamByName('tgl').AsDate              := NextDate;
              SQ1.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
              SQ1.ParamByName('gc_code').AsString        := Ecode.Text;
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
                        SQ4.ParamByName('tgl').AsDate              := NextDate + 1;
                        SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                        SQ4.ParamByName('gc_code').AsString        := Ecode.Text;
                        SQ4.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                        SQ4.ParamByName('manhour').AsInteger       := BaseManhour;
                        SQ4.ParamByName('no_urut').AsInteger       := NoUrut;
                        SQ4.ParamByName('jam_kerja').AsInteger     := JamKerja;
                        SQ4.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                        SQ4.ParamByName('is_edit').AsBoolean := False;
                        SQ4.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                        if ManHour <= AlokasiWaktu then
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
                            SQ4.ParamByName('tgl').AsDate              := (NextDate+y+1);
                            SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                            SQ4.ParamByName('gc_code').AsString        := Ecode.Text;
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
                  end else if (KapasitasTerpakai > 0) and (KapasitasTerpakai >= AlokasiWaktu) then begin

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
                                SQ4.ParamByName('tgl').AsDate              := NextDate + y +1;
                                SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                                SQ4.ParamByName('gc_code').AsString        := Ecode.Text;
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
                            SQ4.ParamByName('tgl').AsDate              := NextDate + 1;
                            SQ4.ParamByName('item_id').AsString        := sg1.Cells[16,Arow];
                            SQ4.ParamByName('gc_code').AsString        := Ecode.Text;
                            SQ4.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                            SQ4.ParamByName('manhour').AsInteger       := BaseManhour;
                            SQ4.ParamByName('no_urut').AsInteger       := NoUrut;
                            SQ4.ParamByName('jam_kerja').AsInteger     := JamKerja;
                            SQ4.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                            SQ4.ParamByName('qty_order').AsInteger     := StrToIntDef(sg1.Cells[17,Arow],0);
                            SQ4.ParamByName('is_edit').AsBoolean       := False;

                            if ManHour <= AlokasiWaktu then
                              SQ4.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                            else
                              SQ4.ParamByName('total_menit').AsInteger   := ManHour;

                            SQ4.ExecSQL;

                    end;
                  end;

              end else if ManHour <= AlokasiWaktu then begin

                 SQ1.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan);

              end;


             // ShowMessage(IntToStr(ManHour));
              SQ1.ExecSQL;


        end;
    
       SQ1.Open(' SELECT * '+
           ' FROM detail_jadwal ');

  end;


end;

function TFImportGC.GetStarDate(ADate: TDate;id_divisi:String;KapasitasDivisi:Integer;var KapasitasTerpakai:Integer): TDate;
begin
  SQ2.Open(' SELECT tgl,total_menit FROM detail_jadwal '+
  ' WHERE tgl="'+Tanggal(ADate)+'" AND id_divisi="'+id_divisi+'" ');

  if (SQ2.IsEmpty)  then begin
    // ShowMessage(SQ2.FieldByName('tgl').AsString);
     KapasitasTerpakai := 0;
    // ShowMessage(Tanggal(ADate));
     Result := Adate;
    // ShowMessage('OK');

  end else begin


     SQ3.Open(' SELECT tgl,SUM(total_menit) as KapasitasTerpakai '+
              ' FROM detail_jadwal WHERE id_divisi="'+id_divisi+'" '+
              ' AND tgl>="'+Tanggal(Adate)+'" GROUP BY tgl '+
              ' HAVING '+IntToStr(KapasitasDivisi)+'-KapasitasTerpakai > 0  ');

   //  ShowMessage(SQ3.SQL.Text);

    KapasitasTerpakai := StrToIntDef(SQ3.FieldByName('KapasitasTerpakai').AsString,0);
    //ShowMessage('Start Date '+Tanggal(SQ3.FieldByName('tgl').AsDateTime) +' Kapasitas '+IntToStr(KapasitasTerpakai)+' Tanggal Where '+Tanggal(ADate));
    Result := SQ3.FieldByName('tgl').AsDateTime;
  end;
  Exit;
end;

function TFImportGC.IdDivisi: String;
var
  i : integer;
  id_divisi : String;

begin
  id_divisi := '';
  for i := sg1.Row to sg1.RowCount -1 do begin
     if (sg1.Cells[14,i] <> '') and (sg1.Cells[8,i] <> '') then begin
        id_divisi := id_divisi + '"'+sg1.Cells[14,i]+'",';

     end;
     if sg1.Cells[4,i] = '' then
        Break;

  end;
  Delete(id_divisi,length(id_divisi),1);
  Result := id_divisi;

end;

procedure TFImportGC.KosongkanGrid;
var
  c , i : integer;
begin
  for i := 0 to sg1.ColCount -1 do
  for c := 1 to sg1.RowCount -1 do
    sg1.Cells[i,c] := '';
  sg1.RowCount := 2;

end;


procedure TFImportGC.ResetChart;
begin
  //ResetColor(1);
  sg1.ColCount := 18;
end;

procedure TFImportGC.ResetColor(Arow:Integer;Acol:integer);

begin

      sg1.Colors[Acol,Arow]    :=  clWhite;
      sg1.ColorsTo[Acol,Arow]  := clWhite;
      sg1.Cells[Acol,Arow]     := '';

end;

procedure TFImportGC.sg1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACOl in [5,7,8,10,11,12,13];
end;

procedure TFImportGC.sg1DatePickerCloseUp(Sender: TObject; ARow,
  ACol: Integer);
  var
  KapasitasDivisi : Integer;
  KapasitasTerpakai : integer;
  indexRow , i ,j , x, GapDate,RangeTanggal: Integer;
  TglMulai , MInTgl,MaxTgl : TDate;
begin
  sg1.Col := 12;
  SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE tgl>="'+Tanggal(sg1.Dates[11,Arow])+'"');
  if SQ1.IsEmpty = False then begin

     sg1.Dates[11,Arow] := GetStarDate(sg1.Dates[11,Arow],sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai);
     Warning(' Tanggal yang dipilih jadwal sudah penuh !! '+#13 +
             ' Program otomatis akan merubah jadwal pada tanggal kosong '+#13#13#13+
             ' Untuk penyesuaian tanggal lalukan pada data gant chart !' );
     KapasitasDivisi := StrToIntDef(sg1.Cells[15,ARow],0) * (StrToIntDef(sg1.Cells[7,ARow],0) * 60);
     sg1.Dates[11,Arow] := GetStarDate(sg1.Dates[11,Arow],sg1.Cells[14,Arow],KapasitasDivisi,KapasitasTerpakai);


     IndexWarna := 1;
     Floading.Show;
     Floading.pgbar.Maximum := sg1.RowCount -1;
     Floading.pgbar.Position:= 0;
     sg1.BeginUpdate;

     IndexRow := FindStartRow;
     if IndexRow = 0 then
        IndexRow :=  2;


     for I := IndexRow to sg1.RowCount -1 do begin

        if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

           //  TglMulai := GetStarDate()
             SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                 ' AND id_divisi="'+sg1.Cells[14,i-1]+'" AND gc_code="'+Ecode.Text+'" ORDER BY tgl DESC limit 1');


             if SQ1.IsEmpty then begin
                if sg1.Cells[11,i] <> '' then
                TglMulai := sg1.Dates[11,i] else
                TglMulai := Now ;
              end else
                TglMulai := SQ1.FieldByName('tgl').AsDateTime + 1 ;
            // ShowMessage(Tanggal(TglMulai));


             GenerateDate(I,TglMulai);
             SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
             ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND gc_code="'+Ecode.Text+'" '+
             '  AND item_id="'+sg1.Cells[16,i]+'" ');
             sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
             sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);

             for j := 0 to sg1.ColCount -1 do
             ResetColor(i,j+19);

             SQ2.Open('SELECT tgl FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"  ORDER BY tgl ASC LIMIT 1');
             MinTgl := SQ2.FieldByName('tgl').AsDateTime;

             SQ2.Open('SELECT tgl FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"  ORDER BY tgl DESC LIMIT 1');
             MaxTgl := SQ2.FieldByName('tgl').AsDateTime;

             RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;
             sg1.ColCount   := RangeTanggal + 19;

             for x := 0 to RangeTanggal -1 do begin

                sg1.Cells[19+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
                sg1.AddRotated(19+x,0,90,sg1.Cells[19+x,0]);
                sg1.ColWidths[19+x] := 30;

                if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
                    sg1.Colors[19+x,0]    := clRed;
                    sg1.ColorsTo[19+x,0]  := $003535FF;
                end else begin
                    sg1.Colors[19+x,0]    := $00D6D6D6;
                    sg1.ColorsTo[19+x,0]  := clWhite;
                end;
             end;

                SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE '+
                ' item_id="'+sg1.Cells[16,i]+'"  '+
                ' AND id_divisi="'+sg1.Cells[14,i]+'" AND gc_code="'+Ecode.Text+'"'+
                ' AND tgl>="'+Tanggal(MinTgl)+'" AND tgl<="'+Tanggal(MaxTgl)+'" ');
                while not SQ4.Eof do begin


                if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                  GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                  ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
                  sg1.Cells[19+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                  sg1.Colors[19+GapDate,i]   := GetValInt(Q4,'initial_color');
                  sg1.ColorsTo[19+GapDate,i] := GetValInt(Q4,'initial_color');
                end;
                SQ4.Next;

                Application.ProcessMessages;

             end;
        end;

        Floading.pgbar.Position := i;

     end;

     sg1.EndUpdate;
     Floading.Close;
  end;
end;


procedure TFImportGC.sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then
     HAlign := taCenter;
end;

procedure TFImportGC.sg1GetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin

  case ACol of
  11,13 : AEditor := edDateEdit;
  end;
end;

function TFImportGC.FindDivisi(id_divisi:integer):integer;
var
  i : integer;
begin
  for i := 2 to FImportGC.sg1.RowCount -1 do begin
     if StrToIntDef(FImportGC.sg1.Cells[14,i],0) = id_divisi then
     begin
       Result := i ;
       Break;
     end;

  end;

end;

function TFImportGC.FindStartRow: Integer;
var
  i : integer;
begin
  if (sg1.Cells[9,2] = '') and (sg1.Cells[8,2] <> '') and (sg1.Cells[4,2] <> '') then
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

procedure TFImportGC.sg1KeyPress(Sender: TObject; var Key: Char);
var
  i , x , j: integer;
  MinTgl : TDate;
  MaxTgl : TDate;
  RangeTanggal : Integer;
  TglMulai : TDate;
  IndexRow          : Integer;
  GapDate : integer;

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


         for I := IndexRow to sg1.RowCount -1 do begin

            if (sg1.Cells[4,i] <> '') and (sg1.Cells[7,i] <> '') and (sg1.Cells[8,i] <> '') then begin

               //  TglMulai := GetStarDate()
                 SQ1.Open(' SELECT tgl FROM detail_jadwal WHERE item_id="'+Sg1.Cells[16,i]+'" '+
                     ' AND id_divisi="'+sg1.Cells[14,i-1]+'" '+
                     ' AND gc_code="'+ECode.Text+'" ORDER BY tgl DESC limit 1');


                 if SQ1.IsEmpty then begin
                    if sg1.Cells[11,i] <> '' then
                    TglMulai := sg1.Dates[11,i] else
                    TglMulai := Now ;
                  end else
                    TglMulai := SQ1.FieldByName('tgl').AsDateTime + 1 ;
                // ShowMessage(Tanggal(TglMulai));


                 GenerateDate(I,TglMulai);
                 SQ4.Open(' SELECT MIN(tgl) as Startdate , MAX(tgl) as Enddate FROM '+
                 ' detail_jadwal WHERE id_divisi="'+sg1.Cells[14,i]+'" AND item_id="'+sg1.Cells[16,i]+'" '+
                 ' AND gc_code="'+Ecode.Text+'"');
                 sg1.dates[11,i] := toDate(SQ4.FieldByName('Startdate').AsString);
                 sg1.dates[13,i] := toDate(SQ4.FieldByName('Enddate').AsString);

                 for j := 0 to sg1.ColCount -1 do
                 ResetColor(i,j+19);

                 SQ2.Open('SELECT tgl FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"  ORDER BY tgl ASC LIMIT 1');
                 MinTgl := SQ2.FieldByName('tgl').AsDateTime;

                 SQ2.Open('SELECT tgl FROM detail_jadwal WHERE gc_code="'+Ecode.Text+'"  ORDER BY tgl DESC LIMIT 1');
                 MaxTgl := SQ2.FieldByName('tgl').AsDateTime;

                 RangeTanggal   := DaysBetween(MinTgl,MaxTgl) + 1;
                 sg1.ColCount   := RangeTanggal + 19;

                 for x := 0 to RangeTanggal -1 do begin

                    sg1.Cells[19+x,0]   :=  FormatDateTime('dd-mmm-yyyy',MinTgl + x);
                    sg1.AddRotated(19+x,0,90,sg1.Cells[19+x,0]);
                    sg1.ColWidths[19+x] := 30;

                    if (FormatDateTime('dddd',MinTgl + x) ='Minggu') or (FormatDateTime('dddd',MinTgl + x) ='Sunday') then begin
                        sg1.Colors[19+x,0]    := clRed;
                        sg1.ColorsTo[19+x,0]  := $003535FF;
                    end else begin
                        sg1.Colors[19+x,0]    := $00D6D6D6;
                        sg1.ColorsTo[19+x,0]  := clWhite;
                    end;
                 end;

                    SQ4.Open('SELECT tgl,total_menit FROM detail_jadwal WHERE '+
                    ' item_id="'+sg1.Cells[16,i]+'"  '+
                    ' AND id_divisi="'+sg1.Cells[14,i]+'" '+
                    ' AND tgl>="'+Tanggal(MinTgl)+'" AND tgl<="'+Tanggal(MaxTgl)+'" '+
                    ' AND gc_code="'+Ecode.Text+'" ');
                    while not SQ4.Eof do begin


                    if SQ4.FieldByName('total_menit').AsInteger > 0 then begin
                      GapDate              := DaysBetween(MinTgl,SQ4.FieldByName('tgl').AsDateTime);
                      ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+sg1.Cells[14,i]+'"',True);
                      sg1.Cells[19+GapDate,i]    := SQ4.FieldByName('total_menit').AsString;
                      sg1.Colors[19+GapDate,i]   := GetValInt(Q4,'initial_color');
                      sg1.ColorsTo[19+GapDate,i] := GetValInt(Q4,'initial_color');
                    end;
                    SQ4.Next;

                    Application.ProcessMessages;

                 end;
            end;

            Floading.pgbar.Position := i;

         end;

         sg1.EndUpdate;
         Floading.Close;


      end;
   end;


end;

procedure TFImportGC.sg1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

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



procedure TFImportGC.TampilAwal;
 var
  _Bulk : String;
begin
  ClearText(Self);

  Ecode.Text := GetCode(Q1,'gantt_chart','code','');
  CreateGrid;
  isFocusForm := True;


  SQ1.Close;
  SQ1.SQL.Text := 'DELETE FROM detail_jadwal';
  SQ1.ExecSQL;

  ExQry(Q1,'SELECT * FROM detailjadwal WHERE tgl>="'+Tanggal(now-30)+'"',True);


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

function TFImportGC.toDate(AStr: String): TDate;
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

procedure TFImportGC.UpdateDate( ADate: TDate);
var
  Jamkerja          : Integer;
  JumlahKaryawan    : Integer;
  ManHour           : Integer;
  KapasitasDivisi   : Integer;
  AlokasiWaktu      : Integer;
  LamaHari          : Integer;
  ExtendHari        : integer;
  KapasitasTerpakai : Integer;
  i,x,y               : integer;
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
  Id_Divisi  : String;
  gc_code   : String;
  qty_order : integer;
  counter  : integer;

begin

  SQ1.Close;
  SQ1.SQL.Text :=' SELECT j.item_id,j.kapasitas,j.no_urut,j.id_divisi,j.manhour,j.jam_kerja,j.alokasi_tng_kerja,qty_order,'+
  ' j.gc_code FROM detail_jadwal j WHERE j.gc_code<>"'+Ecode.Text+'" '+
  ' AND (j.id_divisi in ('+IdDivisi+') or j.no_urut >="'+sg1.Cells[18,sg1.Row]+'") AND j.tgl>="'+Tanggal(ADate)+'" '+
  '  GROUP BY j.item_id,j.id_divisi '+
  ' ORDER BY j.gc_code,j.item_id,j.no_urut ASC ';
  SQ1.Open;



  while  not SQ1.Eof do begin

  

        JamKerja        := SQ1.FieldByName('jam_kerja').AsInteger;
        JumlahKaryawan  := SQ1.FieldByName('alokasi_tng_kerja').AsInteger;
        ManHour         := SQ1.FieldByName('manhour').AsInteger;
        BaseManhour     := SQ1.FieldByName('manhour').AsInteger;
        NoUrut          := SQ1.FieldByName('no_urut').AsInteger;
        KapasitasDivisi := SQ1.FieldByName('kapasitas').AsInteger;
        Id_Divisi       := SQ1.FieldByName('id_divisi').AsString;
        gc_code         := SQ1.FieldByName('gc_code').AsString;
        qty_order       := SQ1.FieldByName('qty_order').AsInteger;

        if (JamKerja > 0) and (JumlahKaryawan > 0) and (ManHour > 0) then begin

            SQ4.Open('SELECT COUNT(tgl) as jml,SUM(total_menit) as manhourterpakai FROM detail_jadwal WHERE id_divisi="'+Id_Divisi+'" '+
            ' AND item_id="'+SQ1.FieldByName('item_id').AsString+'" AND total_menit > 0 '+
            ' AND gc_code="'+gc_code+'" ');

            AlokasiWaktu      := Jamkerja * JumlahKaryawan * 60;
            LamaHari          := Ceil(ManHour /AlokasiWaktu) - SQ4.FieldByName('jml').AsInteger;
            ManHour           := ManHour - StrToIntDef(SQ4.FieldByName('manhourterpakai').AsString,0);

          //  SQ4.Open('SELECT MAX(tgl) as tgl FROM detail_jadwal WHERE);
            if SQ1.RecNo = 1 then
               StartDate := ADate else
            begin
              SQ4.Open('SELECT MAX(tgl) as tgl FROM detail_jadwal WHERE '+
              ' no_urut<="'+IntToStr(SQ1.FieldByName('no_urut').AsInteger -1)+'" '+
              ' AND item_id="'+SQ1.FieldByName('item_id').AsString+'" '+
              ' AND gc_code="'+gc_code+'" ORDER BY no_urut DESC LIMIT 1 ');

             // ShowMessage(SQ4.SQL.Text);


              try


                StartDate := toDate(SQ4.FieldByName('tgl').AsString) + 1;
              except
                ShowMessage('error');

              end;
            end;




           counter := 0;
           for i := 0 to LamaHari -1 do begin
                if counter = 0 then
                   NextDate := GetStarDate(StartDate+i,Id_Divisi,KapasitasDivisi,KapasitasTerpakai) else
                   NextDate := GetStarDate(StartDate+(i-counter),Id_Divisi,KapasitasDivisi,KapasitasTerpakai);
                if NextDate > StartDate + i then begin
                   StartDate := NextDate;
                   counter   := i;
                end;
              //  ShowMessage(Tanggal(NextDate));
        
               { SQ2.Open(' SELECT tgl,SUM(total_menit) as KapasitasTerpakai '+
                ' FROM detail_jadwal WHERE id_divisi="'+sg1.Cells[14,Arow]+'" '+
                ' AND tgl>="'+Tanggal((StartDate + i))+'" GROUP BY tgl '+
                ' HAVING '+IntToStr(KapasitasDivisi)+'-KapasitasTerpakai > 0 ');


                if SQ2.IsEmpty = False then  begin
                      if (KapasitasDivisi - SQ2.FieldByName('KapasitasTerpakai').AsInteger > 0) then begin
                          StartDate          := SQ2.FieldByName('tgl').AsDateTime;
                      end;
                      if (AlokasiWaktu = KapasitasDivisi) and (SQ2.FieldByName('KapasitasTerpakai').AsInteger < KapasitasDivisi) then
                      begin
                         KapasitasTerpakai  := SQ2.FieldByName('KapasitasTerpakai').AsInteger;
                         if ManHour > AlokasiWaktu then

                         ManHour            := ManHour + KapasitasTerpakai;
                      end;
                end else begin
                   KapasitasTerpakai  := 0;
                end;      }
                if  (KapasitasTerpakai > 0)  and (KapasitasTerpakai < KapasitasDivisi) then
                begin

                   if ManHour > AlokasiWaktu then
                   ManHour            := ManHour + KapasitasTerpakai;
                end;


                SQ2.Close;
                SQ2.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                SQ2.ParamByName('id_divisi').AsString     := Id_Divisi;
                SQ2.ParamByName('tgl').AsDate              := NextDate;
                SQ2.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
                SQ2.ParamByName('gc_code').AsString        := gc_code;
                SQ2.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                SQ2.ParamByName('manhour').AsInteger       := BaseManhour;
                SQ2.ParamByName('no_urut').AsInteger       := NoUrut;
                SQ2.ParamByName('qty_order').AsInteger       := qty_order;
                SQ2.ParamByName('jam_kerja').AsInteger       := JamKerja;
                SQ2.ParamByName('alokasi_tng_kerja').AsInteger := JumlahKaryawan;
                SQ2.ParamByName('is_edit').AsBoolean := True;

                if  ManHour > AlokasiWaktu then begin

                    if (KapasitasTerpakai > 0) and (KapasitasTerpakai < alokasiWaktu) then begin
                       SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu - KapasitasTerpakai;
                       ManHour         := ManHour - AlokasiWaktu;



                       if (ManHour > 0) and (ManHour < alokasiWaktu) then  begin

                          SQ3.Close;
                          SQ3.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                          ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                          ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                          ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                          SQ3.ParamByName('id_divisi').AsString     := Id_Divisi;
                          SQ3.ParamByName('tgl').AsDate              := NextDate + 1;
                          SQ3.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
                          SQ3.ParamByName('gc_code').AsString        := gc_code;
                          SQ3.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                          SQ3.ParamByName('manhour').AsInteger       := BaseManhour;
                          SQ3.ParamByName('no_urut').AsInteger       := NoUrut;
                          SQ3.ParamByName('qty_order').AsInteger       := qty_order;
                          SQ3.ParamByName('jam_kerja').AsInteger       := JamKerja;
                          SQ3.ParamByName('alokasi_tng_kerja').AsInteger       := JumlahKaryawan;
                          SQ3.ParamByName('is_edit').AsBoolean := True;
                          if ManHour < AlokasiWaktu then
                          SQ3.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                          else
                          SQ3.ParamByName('total_menit').AsInteger   := ManHour;
                          SQ3.ExecSQL;
                       end else if (ManHour >  alokasiWaktu) and ( i = lamahari -1) then begin
                          ExtendHari := Ceil(ManHour/AlokasiWaktu);


                          for y := 0 to ExtendHari-1 do begin


                              SQ3.Close;
                              SQ3.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                              ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                              ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                              ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                              SQ3.ParamByName('id_divisi').AsString     := Id_Divisi ;
                              SQ3.ParamByName('tgl').AsDate              := (NextDate+y+1);
                              SQ3.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
                              SQ3.ParamByName('gc_code').AsString        := gc_code;
                              SQ3.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                              SQ3.ParamByName('manhour').AsInteger       := BaseManhour;
                              SQ3.ParamByName('no_urut').AsInteger       := NoUrut;
                              SQ3.ParamByName('qty_order').AsInteger       := qty_order;
                              SQ3.ParamByName('jam_kerja').AsInteger       := JamKerja;
                              SQ3.ParamByName('alokasi_tng_kerja').AsInteger       := JumlahKaryawan;
                              SQ3.ParamByName('is_edit').AsBoolean := True;
                              if ManHour > AlokasiWaktu then

                              SQ3.ParamByName('total_menit').AsInteger   := AlokasiWaktu
                              else begin
                                if ManHour < AlokasiWaktu then

                                    SQ3.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                                else
                                    SQ3.ParamByName('total_menit').AsInteger   := ManHour;
                              end;
                              SQ3.ExecSQL;
                              ManHour := ManHour - AlokasiWaktu;

                          end;
                       end;
                    end else begin
                      SQ2.ParamByName('total_menit').AsInteger   := AlokasiWaktu;
                      ManHour         := ManHour - AlokasiWaktu;


                      if (i = LamaHari -1) and (ManHour > 0)  then begin

                                  SQ3.Close;
                                  SQ3.SQL.Text := 'INSERT INTO detail_jadwal(id_divisi,tgl,item_id,'+
                                  ' gc_code,total_menit,kapasitas,manhour,no_urut,qty_order,jam_kerja,alokasi_tng_kerja,is_edit) '+
                                  ' VALUES (:id_divisi,:tgl,:item_id,:gc_code,'+
                                  ' :total_menit,:kapasitas,:manhour,:no_urut,:qty_order,:jam_kerja,:alokasi_tng_kerja,:is_edit)';

                                  SQ3.ParamByName('id_divisi').AsString      :=  Id_Divisi;
                                  SQ3.ParamByName('tgl').AsDate              := NextDate + 1;
                                  SQ3.ParamByName('item_id').AsString        := SQ1.FieldByName('item_id').AsString;
                                  SQ3.ParamByName('gc_code').AsString        := gc_code;
                                  SQ3.ParamByName('kapasitas').AsInteger     := KapasitasDivisi;
                                  SQ3.ParamByName('manhour').AsInteger       := BaseManhour;
                                  SQ3.ParamByName('no_urut').AsInteger       := NoUrut;
                                  SQ3.ParamByName('qty_order').AsInteger       := qty_order;
                                  SQ3.ParamByName('jam_kerja').AsInteger       := JamKerja;
                                  SQ3.ParamByName('alokasi_tng_kerja').AsInteger       := JumlahKaryawan;
                                  SQ3.ParamByName('is_edit').AsBoolean := True;
                                  if ManHour < AlokasiWaktu then

                                    SQ3.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan)
                                  else
                                    SQ3.ParamByName('total_menit').AsInteger   := ManHour;
                                  SQ3.ExecSQL;

                                 // ManHour := ManHour - AlokasiWaktu;

                      end;

                    end;
                end else if ManHour < AlokasiWaktu then begin
                   SQ2.ParamByName('total_menit').AsInteger   := ROUND(ManHour/JumlahKaryawan);

                end;



                SQ2.ExecSQL;


           end;

        end;
         SQ1.Next;
  end;

  //SQ2.Close;
  //SQ2.SQL.Text := 'DELETE FROM detail_jadwal WHERE total_menit=0 ';
  //SQ2.ExecSQL;
   SQ1.Open(' SELECT * '+
       ' FROM detail_jadwal ');

end;


procedure TFImportGC.UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
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
