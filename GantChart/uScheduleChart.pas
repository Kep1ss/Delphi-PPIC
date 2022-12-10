unit uScheduleChart;

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
  TFGrafikJadwal = class(TForm)
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
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LtotalSo: TLabel;
    LtotalContainer: TLabel;
    LtotalItem: TLabel;
    dtCancelMulai: TDateTimePicker;
    Label10: TLabel;
    dtCancelAkhir: TDateTimePicker;
    cCancelDate: TCheckBox;
    cbFilterBy: TComboBox;
    Label4: TLabel;
    LtotalJenis: TLabel;
    Label8: TLabel;
    cbPage: TComboBox;
    Label9: TLabel;
    procedure sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure sg1GetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure sg1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure cbDIvisiItemCheckClick(Sender: TObject; itemindex: Integer;
      checked: Boolean);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbFixedChange(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure dtCloseUp(Sender: TObject);
    procedure sg1Enter(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure cbItemItemCheckClick(Sender: TObject; itemindex: Integer;
      checked: Boolean);
    procedure EPencarianKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cCancelDateClick(Sender: TObject);
    procedure dtCancelMulaiCloseUp(Sender: TObject);
    procedure cbFilterByCloseUp(Sender: TObject);
    procedure cbPageChange(Sender: TObject);

  private
    { Private declarations }

    isShow : Boolean;
    SoCounter : TStringList;
    ContainerCounter : TStringList;
    CountJenis : TStringLIst;
    procedure ResetColor(ARow : Integer;Acol:integer);


  public
    { Public declarations }
    isFocusForm : Boolean;
    Filter_selected : String;
    
    procedure CreateGrid;
    procedure TampilAwal;
    procedure KosongkanGrid;
    procedure CreateChart(page:Integer);
    procedure ResetChart;

    procedure UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
    function convertDate(AStr:String):String;
    function toDate(AStr:String):TDate;
    function IdDivisi : String;
    function FindDivisi(id_divisi:integer):integer;

    function FindStartRow:Integer;
    function startEdit:integer;
    function finishEdit:integer;
    function IndexLastItem:Integer;
    function getCbChecked:String;
  end;

var
  FGrafikJadwal: TFGrafikJadwal;
  IndexWarna : Integer;

implementation

{$R *.dfm}

uses uListofSoGant, uDataGanttChart, uMarCon, uGanttChatParameters, uLoading,
  uGanttChart, uCancelDate;

{ TFGanttChart }

procedure TFGrafikJadwal.A1Click(Sender: TObject);
begin
  FCancelDate.EGCCode.Text := sg1.Cells[19,sg1.Row];
  FCancelDate.ShowModal;
end;


procedure TFGrafikJadwal.AdvSmoothButton1Click(Sender: TObject);

begin
  AdvGridExcelIO1.XLSExport(' GANT CHART '+FormatDateTime('dd mmmm yyyy',dt.Date)+'.xls');
end;

procedure TFGrafikJadwal.AdvSmoothButton2Click(Sender: TObject);
begin
  FGanttChart.CreateGrid;
  FGanttChart.TampilAwal;
  FGanttChart.ShowModal;
end;

procedure TFGrafikJadwal.AdvSmoothButton3Click(Sender: TObject);
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

      CreateGrid;
      CreateChart(StrToIntDef(cbPage.Text,0));

    end;
  end;

end;

procedure TFGrafikJadwal.AdvSmoothButton4Click(Sender: TObject);
begin
  FDataGanttChart.ShowModal;
end;

procedure TFGrafikJadwal.btnAddClick(Sender: TObject);
begin
  if MessageDlg('Tutup data GC ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Close;
  end;
end;

procedure TFGrafikJadwal.cbDIvisiItemCheckClick(Sender: TObject;
  itemindex: Integer; checked: Boolean);
  var
    i : integer;
begin

  isShow := False;

  case cbFilterBy.ItemIndex  of
  1 : begin
        if (itemindex = 0) and (checked = True) then begin
            isShow          := True;
            Filter_selected := '';
            for i := 0 to cbDIvisi.Items.Count -1 do begin
               if i > 0 then begin
                  cbDIvisi.Items.Items[i].Checked := False;

               end;

            end;
        end else begin
           if checked then begin
             cbDIvisi.Items.Items[0].Checked := False;
             Filter_selected := Filter_selected +'"'+ cbDIvisi.Items.Items[itemindex].Info +'",'
           end else
             Delete(Filter_selected,POS('"'+cbDIvisi.Items.Items[itemindex].Info+'"',Filter_selected),Length('"'+cbDIvisi.Items.Items[itemindex].Info+'",'));
        end;
      end;
  2 : begin
        if (itemindex = 0) and (checked = True) then begin
            isShow          := True;
            Filter_selected := '';

            for i := 0 to cbDIvisi.Items.Count -1 do begin
               if i > 0 then begin
                  cbDIvisi.Items.Items[i].Checked := False;

               end;

            end;
        end else begin
           if checked then begin
             cbDIvisi.Items.Items[0].Checked := False;
             Filter_selected := Filter_selected +'"'+ cbDIvisi.Items.Items[itemindex].Info +'",'
           end else
             Delete(Filter_selected,POS('"'+cbDIvisi.Items.Items[itemindex].Info+'"',Filter_selected),Length('"'+cbDIvisi.Items.Items[itemindex].Info+'",'));
        end;
      end;
  3 : begin
        if (itemindex = 0) and (checked = True) then begin
            isShow          := True;
            Filter_selected := '';

            for i := 0 to cbDIvisi.Items.Count -1 do begin
               if i > 0 then begin
                  cbDIvisi.Items.Items[i].Checked := False;

               end;

            end;
        end else begin
           if checked then begin
             cbDIvisi.Items[0].Checked := False;
             Filter_selected := Filter_selected +'"'+ cbDIvisi.Items.Items[itemindex].Caption +'",'
           end else
             Delete(Filter_selected,POS('"'+cbDIvisi.Items.Items[itemindex].Caption+'"',Filter_selected),Length('"'+cbDIvisi.Items.Items[itemindex].Caption+'",'));
        end;

      end;
  4 : begin
        if (itemindex = 0) and (checked = True) then begin
            isShow          := True;
            Filter_selected := '';

            for i := 0 to cbDIvisi.Items.Count -1 do begin
               if i > 0 then begin
                  cbDIvisi.Items.Items[i].Checked := False;

               end;

            end;
        end else begin
           if checked then begin
             cbDIvisi.Items[0].Checked := False;
             Filter_selected := Filter_selected +'"'+ cbDIvisi.Items.Items[itemindex].Caption +'",'
           end else
             Delete(Filter_selected,POS('"'+cbDIvisi.Items.Items[itemindex].Caption+'"',Filter_selected),Length('"'+cbDIvisi.Items.Items[itemindex].Caption+'",'));
        end;

      end;
  end;
  

  if Length(Filter_selected) < 1 then begin
    Filter_selected := '';
    isShow := True;
  end;

 // ShowMessage(Filter_selected);
  CreateChart(StrToIntDef(cbPage.Text,0));
end;

procedure TFGrafikJadwal.cbFixedChange(Sender: TObject);
begin
  if cbFixed.ItemIndex =0  then begin
     sg1.FixedCols := 0;
  end else begin
     sg1.FixedCols := cbFixed.ItemIndex + 1;
  end;
end;


procedure TFGrafikJadwal.cbItemItemCheckClick(Sender: TObject;
  itemindex: Integer; checked: Boolean);
begin

 

  CreateChart(StrToIntDef(cbPage.Text,0));;
end;

procedure TFGrafikJadwal.cbPageChange(Sender: TObject);
begin
   CreateChart(StrToIntDef(cbPage.Text,0));;
end;

procedure TFGrafikJadwal.cCancelDateClick(Sender: TObject);
begin
  dtCancelMulai.Enabled := cCancelDate.Checked;
  dtCancelAkhir.Enabled := cCancelDate.Checked;
end;

procedure TFGrafikJadwal.cbFilterByCloseUp(Sender: TObject);
begin
  case cbFilterBy.ItemIndex of
  0 : begin
        cbDIvisi.Items.Clear;
      end;
  1 : begin
        Q1.Close;
        Q1.SQL.Text := 'SELECT id,name FROM divisi WHERE is_active=true ORDER BY divno ASC ';
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
     end;
  2 : begin
         ExQry(Q1,'SELECT distinct dj.item_id,i.description FROM detailjadwal dj LEFT JOIN item i '+
          ' ON i.id=dj.item_id WHERE tgl>="'+Tanggal(dt.Date)+'"',True );

          cbDIvisi.BeginUpdate;
          cbDIvisi.Items.Clear;

          with cbDIvisi.Items.Add do begin
            Caption := '--- ALL ---';
            GraphicLeftType   := gtCheckBox;
          end;
          while not Q1.Eof do begin
            with cbDIvisi.Items.Add do begin
              Caption           := Q1.FieldByName('description').AsString;
              GraphicLeftType   := gtCheckBox;
              Checked           := False;
              Info              := Q1.FieldByName('item_id').AsString;
            end;
            Q1.Next;

          end;
          cbDIvisi.EndUpdate;
      end;
  3 : begin
         ExQry(Q1,'SELECT  '+
        '               g.so_no,g.id FROM gant_detail d '+
        ' LEFT JOIN  gantt_chart g ON g.code=d.gantt_code '+
        ' WHERE d.tgl_mulai>="'+Tanggal(dt.Date)+'" '+
        ' GROUP BY g.so_no ',True);

          cbDIvisi.BeginUpdate;
          cbDIvisi.Items.Clear;

          with cbDIvisi.Items.Add do begin
            Caption := '--- ALL ---';
            GraphicLeftType   := gtCheckBox;
          end;
          while not Q1.Eof do begin
            with cbDIvisi.Items.Add do begin
              Caption           := Q1.FieldByName('so_no').AsString;
              GraphicLeftType   := gtCheckBox;
              Checked           := False;
              Info              := Q1.FieldByName('id').AsString;
            end;
            Q1.Next;

          end;
          cbDIvisi.EndUpdate;
      end;
  4 : begin
         ExQry(Q1,'SELECT  '+
        '               g.nomer_container,g.id FROM gant_detail d '+
        ' LEFT JOIN  gantt_chart g ON g.code=d.gantt_code '+
        ' WHERE d.tgl_mulai>="'+Tanggal(dt.Date)+'" '+
        ' GROUP BY g.nomer_container ',True);

          cbDIvisi.BeginUpdate;
          cbDIvisi.Items.Clear;

          with cbDIvisi.Items.Add do begin
            Caption := '--- ALL ---';
            GraphicLeftType   := gtCheckBox;
          end;
          while not Q1.Eof do begin
            with cbDIvisi.Items.Add do begin
              Caption           := Q1.FieldByName('nomer_container').AsString;
              GraphicLeftType   := gtCheckBox;
              Checked           := False;
              Info              := Q1.FieldByName('id').AsString;
            end;
            Q1.Next;

          end;
          cbDIvisi.EndUpdate;
      end;
  end;
end;

function TFGrafikJadwal.convertDate(AStr: String): String;
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

procedure TFGrafikJadwal.CreateChart(Page:Integer);
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
  varFilterSO : String;
  SumTenagaKerja, SumManHour, SumAlokasi,SumJamKerja,SumHari : Integer;
  FilterLimit : String;
begin

  r     := 0;
  urut  := 1;

  sg1.BeginUpdate;
  sg1.FloatingFooter.Visible := False;
  CreateGrid;

  SoCounter            := TStringList.Create;
  SoCounter.Duplicates := dupIgnore;
  SoCounter.Sorted     := True;


  ContainerCounter := TStringList.Create;
  ContainerCounter.Duplicates := dupIgnore;
  ContainerCounter.Sorted     := True;

  CountJenis            := TStringList.Create;
  CountJenis.Duplicates := dupIgnore;
  CountJenis.Sorted     := True;

  if page = 0 then
     FilterLimit := '' else
     FilterLimit := ' LIMIT '+IntToStr(page);




  try


      if cCancelDate.Checked = False then begin

          if Filter_selected <> '' then begin

              case cbFilterBy.ItemIndex of
                0 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   d.tgl >="'+Tanggal(dt.Date)+'"  ',True);
                1 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   d.tgl >="'+Tanggal(dt.Date)+'"  ',True);
                2 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   d.tgl >="'+Tanggal(dt.Date)+'" AND '+
                    ' d.item_id IN('+Copy(Filter_selected,1,Length(Filter_selected)-1)+') ',True);
                3 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   d.tgl >="'+Tanggal(dt.Date)+'" AND '+
                    ' g.so_no IN('+Copy(Filter_selected,1,Length(Filter_selected)-1)+') ',True);
                4 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   d.tgl >="'+Tanggal(dt.Date)+'" AND '+
                    ' g.nomer_container IN('+Copy(Filter_selected,1,Length(Filter_selected)-1)+') ',True);
            
              end;
          end else begin
              ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   d.tgl >="'+Tanggal(dt.Date)+'"  ',True);
          end;
          
      end else begin
          if Filter_selected <> '' then begin
              case cbFilterBy.ItemIndex of
                1 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   g.cancel_date >="'+Tanggal(dtCancelMulai.Date)+'" AND '+
                    ' g.cancel_date <="'+Tanggal(dtCancelAkhir.Date)+'"  ',True);
                2 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   g.cancel_date >="'+Tanggal(dtCancelMulai.Date)+'" AND '+
                    ' g.cancel_date <="'+Tanggal(dtCancelAkhir.Date)+'" AND  '+
                    ' d.item_id IN('+Copy(Filter_selected,1,Length(Filter_selected)-1)+') ',True);
                3 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   g.cancel_date >="'+Tanggal(dtCancelMulai.Date)+'" AND '+
                    ' g.cancel_date <="'+Tanggal(dtCancelAkhir.Date)+'" AND  '+
                    ' g.so_no IN('+Copy(Filter_selected,1,Length(Filter_selected)-1)+') ',True);
                4 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   g.cancel_date >="'+Tanggal(dtCancelMulai.Date)+'" AND '+
                    ' g.cancel_date <="'+Tanggal(dtCancelAkhir.Date)+'" AND  '+
                    ' g.nomer_container IN('+Copy(Filter_selected,1,Length(Filter_selected)-1)+') ',True);
                0 : ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   g.cancel_date >="'+Tanggal(dtCancelMulai.Date)+'" AND '+
                    ' g.cancel_date <="'+Tanggal(dtCancelAkhir.Date)+'"  ',True)
              end;
          end else begin
             ExQry(Q1,'SELECT MIN(d.tgl) as tglmulai,MAX(d.tgl) as tglakhir FROM detailjadwal d '+
                    ' LEFT JOIN gantt_chart g ON g.code=d.gc_code'+
                    ' WHERE   g.cancel_date >="'+Tanggal(dtCancelMulai.Date)+'" AND '+
                    ' g.cancel_date <="'+Tanggal(dtCancelAkhir.Date)+'"  ',True);
          end;
      end;
      
  
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



  IndexImage := 0;
    if cCancelDate.Checked = False then begin
        if Filter_selected <> '' then begin

              case cbFilterBy.ItemIndex of
                  1 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,'+
                      ' d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN '+
                      ' gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'"'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  2 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'" AND d.item_id '+
                      ' IN ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  3 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'" AND g.so_no '+
                      ' IN ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  4 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'" AND g.nomer_container '+
                      ' IN ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  0 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,'+
                      ' d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN '+
                      ' gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'"'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id  '+FilterLimit+'',True);
              end;
        end else
            ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,'+
                      ' d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN '+
                      ' gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE tgl_mulai>="'+Tanggal(dt.Date)+'"'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);

    end else begin
        if Filter_selected<>'' then begin

              case cbFilterBy.ItemIndex of
                  1 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,'+
                      ' d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN '+
                      ' gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE g.cancel_date>="'+Tanggal(dtCancelMulai.Date)+'" '+
                      ' AND g.cancel_date<="'+Tanggal(dtCancelAkhir.Date)+'" '+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  2 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE g.cancel_date>="'+Tanggal(dtCancelMulai.Date)+'" '+
                      ' AND g.cancel_date<="'+Tanggal(dtCancelAkhir.Date)+'" AND d.item_id '+
                      ' IN ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  3 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE g.cancel_date>="'+Tanggal(dtCancelMulai.Date)+'" '+
                      ' AND g.cancel_date<="'+Tanggal(dtCancelAkhir.Date)+'" AND g.so_no '+
                      ' IN ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  4 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE g.cancel_date>="'+Tanggal(dtCancelMulai.Date)+'" '+
                      ' AND g.cancel_date<="'+Tanggal(dtCancelAkhir.Date)+'" AND g.nomer_container '+
                      ' IN ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')'+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+' ',True);
                  0 : ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,'+
                      ' d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN '+
                      ' gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE g.cancel_date>="'+Tanggal(dtCancelMulai.Date)+'" '+
                      ' AND g.cancel_date<="'+Tanggal(dtCancelAkhir.Date)+'" '+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id '+FilterLimit+'  ',True);
              end;        
        end else
           ExQry(Q1,'SELECT  i.id,i.itemno,d.deskripsi,d.qty_order,'+
                      ' g.so_no,g.tgl_input,g.cancel_date,g.nomer_container,'+
                      ' d.tgl_inspect,d.gantt_code FROM gant_detail d '+
                      ' LEFT JOIN item i ON i.itemno=d.itemno LEFT JOIN '+
                      ' gantt_chart g ON g.code=d.gantt_code '+
                      ' WHERE g.cancel_date>="'+Tanggal(dtCancelMulai.Date)+'" '+
                      ' AND g.cancel_date<="'+Tanggal(dtCancelAkhir.Date)+'" '+
                      ' GROUP BY g.nomer_container,g.so_no,d.item_id  '+FilterLimit+'',True);
    end;


    if isShow then begin

    Floading.Show;
    Floading.pgbar.Maximum := Q1.RecordCount;
    Floading.pgbar.Position:= 1;
    Floading.Lprocess.Caption := 'Sedang mem-proses data gantt chart ....';
  end;
    SoCounter.BeginUpdate;
    ContainerCounter.BeginUpdate;
    CountJenis.BeginUpdate;


    while not Q1.Eof do begin

      with sg1 do begin

          Cells[1,r+1] := GetVal(Q1,'deskripsi');
          Cells[1,r+2] := 'No SO : '+ GetVal(Q1,'so_no');
          Cells[1,r+3] := 'Container : '+ GetVal(Q1,'nomer_container');
          Cells[1,r+4] := 'Tgl Input : '+ GetVal(Q1,'tgl_input');
          Cells[1,r+5] := 'Cancel Date : '+ GetVal(Q1,'cancel_date');
          Cells[2,r+1] := GetVal(Q1,'qty_order');
          Cells[0,r+1] := IntToStr(Urut);
          Cells[19,r+1]:= GetVal(Q1,'gantt_code');
          Cells[16,r+1]:= GetVal(Q1,'id');
          SoCounter.Add(GetVal(Q1,'so_no'));
          ContainerCounter.Add(GetVal(Q1,'nomer_container'));
          CountJenis.Add(GetVal(Q1,'deskripsi'));

          if  cbFilterBy.ItemIndex = 1 then begin
              if Filter_selected<>'' then
              
                 _SQL := 'SELECT g.*,i.id as itemid FROM gant_detail g LEFT JOIN '+
                 ' item i ON i.itemno=g.itemno WHERE g.item_id="'+GetVal(Q1,'id')+'" AND '+
                 ' g.gantt_code="'+GetVal(Q1,'gantt_code')+'" '+
                 ' AND g.id_divisi in ('+Copy(Filter_selected,1,Length(Filter_selected)-1)+')  ORDER BY CONVERT(step_process,UNSIGNED) ASC'
              else
                 _SQL := 'SELECT g.*,i.id as itemid FROM gant_detail g LEFT JOIN '+
                 ' item i ON i.itemno=g.itemno WHERE g.item_id="'+GetVal(Q1,'id')+'" AND '+
                 ' g.gantt_code="'+GetVal(Q1,'gantt_code')+'"  ORDER BY CONVERT(step_process,UNSIGNED) ASC';
             end else
              _SQL := 'SELECT g.*,i.id as itemid FROM gant_detail g LEFT JOIN '+
             ' item i ON i.itemno=g.itemno WHERE g.item_id="'+GetVal(Q1,'id')+'" AND '+
             ' g.gantt_code="'+GetVal(Q1,'gantt_code')+'"  ORDER BY CONVERT(step_process,UNSIGNED) ASC ';
              ExQry(Q2,_SQL,True);

          indexRow    := r + 1;
          j           := r + 1;
          MergeCount  := 0;
          SumTenagaKerja := 0;
          SumManHour     := 0;
          SumAlokasi     := 0;
          SumHari        := 0;
          SumJamKerja    := 0;
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
                        '  AND i.id="'+GetVal(Q1,'id')+'" ',True);

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
           //   Cells[18,indexRow +1]    := GetVal(Q4,'no_urut');
              Cells[19,indexRow +1]    := GetVal(Q1,'gantt_code');

              Q5.Close;
              Q5.SQL.Text :='SELECT tgl,total_menit FROM detailjadwal WHERE '+
                   ' item_id="'+GetVal(Q2,'itemid')+'"  '+
                   ' AND id_divisi="'+GetVal(Q2,'id_divisi')+'" '+
                   ' AND tgl>="'+Tanggal(tglMulai)+'" AND tgl<="'+Tanggal(tglAkhir)+'" '+
                   ' AND gc_code="'+GetVal(Q1,'gantt_code')+'" '+
                   ' AND total_menit > 0 ORDER BY tgl ASC';
              Q5.Open;
              Q5.First;

              while Q5.Eof = False do begin

               if Q5.FieldByName('total_menit').AsInteger > 0 then begin
                 GapDate := DaysBetween(tglMulai,Q5.FieldByName('tgl').AsDateTime);
                 sg1.Cells[21+GapDate,indexRow +1]    := Q5.FieldByName('total_menit').AsString;
                 ExQry(Q4,'SELECT initial_color FROM divisi WHERE id="'+GetVal(Q2,'id_divisi')+'"',True);
                 sg1.Colors[21+GapDate,indexRow +1]   := GetValInt(Q4,'initial_color');
                 sg1.ColorsTo[21+GapDate,indexRow +1] := GetValInt(Q4,'initial_color');
                 sg1.FontSizes[21+GapDate,IndexRow + 1] := 8;
                 sg1.FontColors[21+GapDate,IndexRow+1]  := clWhite;
               end;
               Q5.Next;
              end;
              SumTenagaKerja := SumTenagaKerja + StrToIntDef(nilai(Cells[5, indexRow +1]),0);
              SumManHour     := SumManHour + StrToIntDef(nilai(Cells[6, indexRow +1]),0);
              SumJamKerja    := SumJamKerja + StrToIntDef(nilai(Cells[7, indexRow +1]),0);
              SumAlokasi     := SumAlokasi + StrToIntDef(nilai(Cells[8, indexRow +1]),0);
              SumHari        := SumHari + StrToIntDef(nilai(Cells[9, indexRow +1]),0);






          Q2.Next;
          Inc(indexRow);
          Inc(MergeCount);
          sg1.MergeCells(1,j+1+4,1,MergeCount-3);
          Application.ProcessMessages;


        end;
        Cells[4, indexRow +1 ]    := 'Total ';
        FontStyles[4,IndexRow +1] := [fsbold];
        FontStyles[5,IndexRow +1] := [fsbold];
        FontStyles[6,IndexRow +1] := [fsbold];
        FontStyles[7,IndexRow +1] := [fsbold];
        FontStyles[8,IndexRow +1] := [fsbold];
        FontStyles[9,IndexRow +1] := [fsbold];


        Cells[5, indexRow +1 ]    := GetRupiah(IntToStr(SumTenagaKerja));
        Cells[6, indexRow +1 ]    := GetRupiah(IntToStr(SumManHour));
        Cells[7, indexRow +1 ]    := GetRupiah(IntToStr(SumJamKerja));
        Cells[8, indexRow +1 ]    := GetRupiah(IntToStr(SumAlokasi));
        Cells[9, indexRow +1 ]    := GetRupiah(IntToStr(SumHari));


        Inc(urut);


        ExQry(Q4,'SELECT img FROM item WHERE itemno="'+GetVal(Q1,'itemno')+'"',True);
          if not Q4.FieldByName('img').IsNull then begin
            bs          := Q4.CreateBlobStream(Q4.FieldByName('img'),bmRead);
            jpg         :=TJPEGImage.Create;
            try
              jpg.LoadFromStream(bs);

              CreatePicture(1,j+1+4  ,True,StretchWithAspectRatio,1,haCenter,vaCenter).Assign(jpg);
            finally
              bs.Free;
              jpg.Free;
            end;

          end;
       r :=  indexRow +1;
       Q1.Next;
       if isShow then
       Floading.pgbar.Position := Q1.RecNo;
      RowCount := RowCount + 2;
      Application.ProcessMessages;
    end;
  end;
  SoCounter.EndUpdate;
  ContainerCounter.EndUpdate;
  CountJenis.EndUpdate;
  sg1.FloatingFooter.Visible := True;


  sg1.EndUpdate;
  sg1.FloatFormat            := '%.0n';
  for i := 21 to sg1.ColCount-1 do begin
      sg1.FloatingFooter.ColumnCalc[i] := acSUM;
      sg1.FontSizes[i,sg1.RowCount-1]  := 6;
      sg1.FontStyles[i,sg1.RowCount-1] := Font.Style - [fsBold];
  end;


  LtotalItem.Caption      := IntToStr(urut-1);
  LtotalSo.Caption        := IntToStr(SoCounter.Count);
  LtotalContainer.Caption := IntToStr(ContainerCounter.Count);
  LtotalJenis.Caption     := IntToStr(CountJenis.Count);
  if isShow then begin

  Floading.pgbar.Position := Floading.pgbar.Maximum;
  Floading.Close;
  end;
  finally
    SoCounter.Free;
    ContainerCounter.Free;
    CountJenis.Free;
  end;
end;





procedure TFGrafikJadwal.CreateGrid;
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
     ColWidths[10] := 0;
     ColWidths[11] := 70;
     ColWidths[12] := 0;
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

procedure TFGrafikJadwal.dtCancelMulaiCloseUp(Sender: TObject);
begin
  CreateChart(StrToIntDef(cbPage.Text,0));;;
end;

procedure TFGrafikJadwal.dtCloseUp(Sender: TObject);
begin
  CreateChart(StrToIntDef(cbPage.Text,0));;;
end;

procedure TFGrafikJadwal.EPencarianKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
     CreateChart(StrToIntDef(cbPage.Text,0));;;

  end;
end;

procedure TFGrafikJadwal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin


  CanClose := True;

end;

procedure TFGrafikJadwal.FormCreate(Sender: TObject);
begin
    isShow := True;


end;

procedure TFGrafikJadwal.FormShow(Sender: TObject);
var
  _bulk : String;
  i : integer;
begin

  dt.Date := now;

  CreateGrid;
  CreateChart(StrToIntDef(cbPage.Text,0));;;

  cbFixed.Items.Clear;
  cbFixed.Items.Add('Unfixed all column');
  for i := 0 to 13 do begin
    cbFixed.Items.Add(sg1.Cells[i,0]);
  end;
  cbDIvisi.Items.Clear;

  cCancelDate.Checked := False;
  cCancelDate.OnClick(Sender);
  dtCancelMulai.Date := EncodeDate(YearOf(dt.Date),MonthOf(dt.Date),DayOf(dt.Date));
  dtCancelMulai.Date := EncodeDate(YearOf(dt.Date),MonthOf(dt.Date),DayOf(dt.Date + 30));

end;


function TFGrafikJadwal.getCbChecked: String;
var
  i : integer;
begin


end;

function TFGrafikJadwal.IdDivisi: String;
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

function TFGrafikJadwal.IndexLastItem: Integer;
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

procedure TFGrafikJadwal.KosongkanGrid;
var
  c , i : integer;
begin
  for i := 0 to sg1.ColCount -1 do
  for c := 1 to sg1.RowCount -1 do
    sg1.Cells[i,c] := '';
  sg1.RowCount := 2;

end;


procedure TFGrafikJadwal.ResetChart;
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

procedure TFGrafikJadwal.ResetColor(Arow:Integer;Acol:integer);

begin

      sg1.Colors[Acol,Arow]    :=  clWhite;
      sg1.ColorsTo[Acol,Arow]  := clWhite;
      sg1.Cells[Acol,Arow]     := '';

end;

procedure TFGrafikJadwal.sg1Enter(Sender: TObject);
begin
  sg1.Options := sg1.Options - [goRowSelect];
end;

procedure TFGrafikJadwal.sg1GetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then
     HAlign := taCenter;
end;

procedure TFGrafikJadwal.sg1GetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin

  case ACol of
  11,13 : AEditor := edDateEdit;
  end;
end;

function TFGrafikJadwal.FindDivisi(id_divisi:integer):integer;
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


function TFGrafikJadwal.FindStartRow: Integer;
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

function TFGrafikJadwal.finishEdit: integer;
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


procedure TFGrafikJadwal.sg1KeyUp(Sender: TObject; var Key: Word;
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


function TFGrafikJadwal.startEdit: integer;
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


procedure TFGrafikJadwal.TampilAwal;
begin
  ClearText(Self);

  CreateGrid;
  isFocusForm := True;
end;

function TFGrafikJadwal.toDate(AStr: String): TDate;
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


procedure TFGrafikJadwal.UpdateKapasitas(Id_divisi:String;JmlPekerja:Integer;Arow:integer);
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
