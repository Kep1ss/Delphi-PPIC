unit uJadwalKerjaDivisi;

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
  TFjadwalKerjaDivisi = class(TForm)
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
    Q4: TMyQuery;
    Q5: TMyQuery;
    AdvGridExcelIO1: TAdvGridExcelIO;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    sgDivisi: TAdvStringGrid;
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure sg1Enter(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgDivisiDblClick(Sender: TObject);
  private
    { Private declarations }

    isShow : Boolean;
    isSave : Boolean;


  public
    { Public declarations }

    procedure CreateGrid;
    procedure TampilAwal;
    procedure ResetChart;
    procedure gridGantChart;
  end;

var
  FjadwalKerjaDivisi: TFjadwalKerjaDivisi;
  IndexWarna : Integer;

implementation

{$R *.dfm}

uses uListofSoGant, uMarCon, uGanttChatParameters, uLoading,
  uGanttChart, uCancelDate;

{ TFGanttChart }

procedure TFjadwalKerjaDivisi.A1Click(Sender: TObject);
begin
  FCancelDate.EGCCode.Text := sg1.Cells[19,sg1.Row];
  FCancelDate.ShowModal;

end;


procedure TFjadwalKerjaDivisi.AdvSmoothButton1Click(Sender: TObject);

begin
  AdvGridExcelIO1.XLSExport(' JADWAL DIVISI '+FormatDateTime('dd mmmm yyyy',Now)+'.xls');
end;

procedure TFjadwalKerjaDivisi.btnAddClick(Sender: TObject);
begin
  if MessageDlg('Apakah yakin akan menutup form ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Close;
  end;
end;

procedure TFjadwalKerjaDivisi.CreateGrid;
begin
  with sg1 do begin
     ClearAll;

     ColCount   := 2;
     RowCount   := 200;
  end;
end;

procedure TFjadwalKerjaDivisi.FormShow(Sender: TObject);
begin
  gridGantChart;
end;

procedure TFjadwalKerjaDivisi.gridGantChart;
var
  i : integer;
begin
  with sgDivisi do begin
     ClearAll;
     ColCount := 3;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Divisi';
     Cells[2,0] := 'idDivisi';

     ColWidths[0] := 50;
     ColWidths[1] := 200;
     ColWidths[2] := 0;

     ColumnSize.StretchColumn := 1;
     ColumnSize.Stretch       := True;
  end;

  ExQry(Q1,'SELECT * FROM divisi_pengerjaan ORDER BY name ASC',True);

  i := 1;
  sgDivisi.RowCount := Q1.RecordCount + 1;
  while not Q1.Eof do begin
     sgDivisi.Cells[0,i] := IntToStr(Q1.RecNo);
     sgDivisi.Cells[1,i] := GetVal(Q1,'name');
     sgDivisi.Cells[2,i] := GetVal(Q1,'id');
     Inc(i);
     Q1.Next;
  end;
end;




procedure TFjadwalKerjaDivisi.ResetChart;
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



procedure TFjadwalKerjaDivisi.sg1Enter(Sender: TObject);
begin
  sg1.Options := sg1.Options - [goRowSelect];
end;

procedure TFjadwalKerjaDivisi.sgDivisiDblClick(Sender: TObject);
var
  TglMulai , TglAkhir : TDate;
  RangeHari,i ,x: Integer;
begin
  CreateGrid;
  ExQry(Q1,'SELECT min(tgl) as Start_date,Max(tgl) as End_date '+
  ' FROM jadwal_divisi WHERE id_divisi="'+sgDivisi.Cells[2,sgDivisi.Row]+'" '+
  ' AND tgl>="'+Tanggal(now)+'"',True);

  if Q1.IsEmpty = False then begin

      tglMulai := Q1.FieldByName('Start_date').AsDateTime;
      tglAkhir := Q1.FieldByName('End_date').AsDateTime;

      RangeHari     := DaysBetween(tglMulai,tglAkhir) + 1;
      sg1.ColCount  := 0;
      sg1.ColCount  := sg1.ColCount + RangeHari+1;

      for i := 0 to RangeHari do begin

       sg1.Cells[i,0]   :=  FormatDateTime('dd-mmm-yyyy',tglMulai + i);
       sg1.ColWidths[i] := 200;

       if (FormatDateTime('dddd',tglMulai + i) ='Minggu') or (FormatDateTime('dddd',tglMulai + i) ='Sunday') then begin
          sg1.Colors[i,0]    := clRed;
          sg1.ColorsTo[i,0]  := $003535FF;
       end else begin
          sg1.Colors[i,0]    := $00D6D6D6;
          sg1.ColorsTo[i,0]  := clWhite;
       end;

       ExQry(Q4,'SELECT                           '+
                '        i.description,           '+
                '        d.item_id,               '+
                '        d.tgl,                   '+
                '        d.no_so,                 '+
                '        d.nomer_container        '+
                '      FROM                       '+
                '        jadwal_divisi d          '+
                '        LEFT JOIN item i         '+
                '          ON d.`item_id` = i.`id`  '+
                ' WHERE d.id_divisi="'+sgDivisi.Cells[2,sgDivisi.Row]+'" '+
                ' AND d.tgl="'+Tanggal(tglMulai+i)+'" '+
                ' UNION '+
                ' SELECT                          '+
                '       ba.description,           '+
                '       ba.id,                    '+
                '       ba.tgl,                   '+
                '       ba.nomer_rencana_kerja,   '+
                '       ba.cost                   '+
                ' FROM rencana_berita_acara  ba     '+
                ' WHERE ba.id_divisi="'+sgDivisi.Cells[2,sgDivisi.Row]+'" '+
                ' AND ba.tgl="'+Tanggal(TglMulai+i)+'" ',True);
       x := 1;


       while not Q4.Eof do begin
          sg1.Cells[i,x] := GetVal(Q4,'description') + '['+GetVal(Q4,'nomer_container')+']';
          inc(x);
          Q4.Next;

       end;

      end;
  end else begin
    CreateGrid;
  end;
end;

procedure TFjadwalKerjaDivisi.TampilAwal;
begin
  ClearText(Self);

  CreateGrid;
end;

end.
