unit uDataKaryawan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel, AnnabaDB,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid,uDatatables, AdvCombo, tmsAdvGridExcel,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFDataKaryawan = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnAdd: TAdvSmoothButton;
    P1: TAdvSmoothPanel;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbEntries: TAdvComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Ecari: TAdvEdit;
    Lentries: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    sg: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    QFB1: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }

    procedure CreateGrid;

  public
    { Public declarations }
    procedure LoadData(isLimit : Integer;isOffSet:integer);

  end;



var
  FDataKaryawan: TFDataKaryawan;

implementation

{$R *.dfm}

uses uINputKaryawan;




procedure TFDataKaryawan.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Karyawan.xls');
end;

procedure TFDataKaryawan.btnAddClick(Sender: TObject);
begin
  FinputKaryawan.ShowModal;
end;

procedure TFDataKaryawan.cbEntriesChange(Sender: TObject);
begin
  LoadData(StrToIntDef(cbEntries.Text,1),1);
end;

procedure TFDataKaryawan.CreateGrid;

begin
  with sg do begin
     ClearAll;
     ColCount   := 8;
     RowCount   := 2;
     FixedRows  := 1;


     Cells[0,0] := 'Divisi';
     Cells[1,0] := 'Nomer';
     Cells[2,0] := 'Nama';
     Cells[3,0] := 'Alamat';
     Cells[4,0] := 'Telepon';
     Cells[5,0] := 'id';
     Cells[6,0] := 'Action';
     Cells[7,0] := '';

     ColWidths[0] := 120;
     ColWidths[1] := 100;
     ColWidths[2] := 150;
     ColWidths[3] := 120;
     ColWidths[4] := 80;
     ColWidths[5] := 0;
     ColWidths[6] := 50;
     ColWidths[7] := 50;

     MergeCells(6,0,2,1);

     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;
  end;
end;

procedure TFDataKaryawan.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  sg.LoadContent(' name LIKE "%'+ECari.Text+'%" ');
end;

procedure TFDataKaryawan.FormCreate(Sender: TObject);
begin
  FDataKaryawan := Self;
  sg.varForm    := FinputKaryawan;
  sg.aTable     := 'karyawan';
  sg.ModeForm   := mfModal;



end;

procedure TFDataKaryawan.FormShow(Sender: TObject);
begin

  CreateGrid;

  sg.AutoBuilHeader := False;
  sg.ButtonCount    := 2;
  sg.ButtonType     := ['btnEdit','btnHapus'];
  sg.RowStart       := 1;
  sg.SQL            := getSQL('TableKaryawan');
  sg.ActSQL         := asSQL;
  sg.StatPagination := True;
  LoadData(StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataKaryawan.LoadData(isLimit : Integer;isOffSet:integer);
begin
  CreateGrid;
  sg.Limit        := isLimit;
  sg.Offset       := isOffSet;
  sg.LoadContent('');
  sg.Pagination(pPagination,1);
  Lentries.Caption := sg.FLentris;
end;


procedure TFDataKaryawan.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if ACol in [0..11] then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
