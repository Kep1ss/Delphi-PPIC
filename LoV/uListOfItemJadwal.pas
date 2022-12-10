unit uListOfItemJadwal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, AdvSmoothButton, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, Vcl.StdCtrls, AdvSmoothPanel, uEngine, Data.DB, uComCtrl, MemDS, DBAccess,
  MyAccess;

type
  TFlistItemJadwal = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnTutup: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    sgBarang: TAdvStringGrid;
    procedure AdvSmoothButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure CreateGrid;
  end;

var
  FlistItemJadwal: TFlistItemJadwal;

implementation

{$R *.dfm}

uses uEditJadwalDivisi, uMarCon;

{ TFlistItemJadwal }

procedure TFlistItemJadwal.AdvSmoothButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TFlistItemJadwal.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;
    ColCount   := 11;
    RowCount   := 2;

    Cells[0,0] := 'No SO';
    Cells[1,0] := 'Itemno';
    Cells[2,0] := 'Deskripsi';
    Cells[3,0] := 'Qty';
    Cells[4,0] := 'Alokasi';
    Cells[5,0] := 'IdJadwal';
    Cells[6,0] := 'iddivisi';
    Cells[7,0] := 'namadivisi';
    Cells[8,0] := 'tgl';
    Cells[9,0] := 'itempermenit';
    Cells[10,0] := 'alokasipermenit';

    ColWidths[0] := 80;
    ColWidths[1] := 150;
    ColWidths[2] := 80;
    ColWidths[3] := 80;
    ColWidths[4] := 80;
    ColWidths[5] := 0;
    ColWidths[6] := 0;
    ColWidths[7] := 0;
    ColWidths[8] := 0;
    ColWidths[9] := 0;
    ColWidths[10] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;


  end;
end;

end.
