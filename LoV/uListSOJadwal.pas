unit uListSOJadwal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDataSoJadwal = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgBarang: TAdvStringGrid;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangDblClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private


    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDataSoJadwal: TFDataSoJadwal;


implementation



{$R *.dfm}

uses uMarCon, uInputJadwalDivisi;



{ TFinputMotif }

procedure TFDataSoJadwal.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (i.description LIKE "%'+Ecari.Text+'%")');
end;

procedure TFDataSoJadwal.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDataSoJadwal.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 4;
    RowCount := 2;

    Cells[0,0] := 'Nomer SO';
    Cells[1,0] := 'Item';
    Cells[2,0] := 'Description';
    Cells[3,0] := 'Qty';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 80;
    ColWidths[3] := 80;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDataSoJadwal.FormShow(Sender: TObject);
begin

  TampilanAwal;
end;

procedure TFDataSoJadwal.LoadGrid(Filter: String);
var
  i : integer;
begin
  CreateGrid;

      ExQry(Q1,'SELECT s.no_so,i.itemno,d.jumlah,i.description FROM master_so s '+
      ' LEFT JOIN detail_so d ON s.no_so=d.no_so left join item i on i.id=d.item_id',true);

      i := 1;


      while not Q1.Eof do begin
        with sgBarang do begin

             Cells[0,i] := GetVal(Q1,'no_so');
             Cells[1,i] := GetVal(Q1,'itemno');
             Cells[2,i] := GetVal(Q1,'description');
             Cells[3,i] := Format('%.0n',[GetValF(Q1,'jumlah')]);

             sgBarang.RowCount := sgBarang.RowCount + 1;
             Inc(i);
           end;

           Q1.Next;


        end;


end;

procedure TFDataSoJadwal.sgBarangDblClick(Sender: TObject);

begin
  With FinputJadwalDivisi do begin

          
          EnomerSo.Text     := sgBarang.Cells[0,sgBarang.Row];
          Eitem.Text        := sgBarang.Cells[2,sgBarang.Row];
          EitemNo.Text      := sgBarang.Cells[1,sgBarang.Row];
          Eorder.Text       := sgBarang.Cells[3,sgBarang.Row];

          ExQry(Q2,'SELECT                                   '+
                            '    d.id,                        '+
                            '    SUM(sp.cost) / 200 as menit   '+
                            '  FROM                                   '+
                            '    setting_process sp                     '+
                            '    LEFT JOIN pekerjaan p ON p.id=sp.id_pekerjaan '+
                            '    LEFT JOIN divisi d ON d.id=p.id_divisi   '+
                            '    LEFT JOIN item i ON i.id=sp.item_id '+
                            '  WHERE d.id="'+FinputJadwalDivisi.LidDivisi.Caption+'" '+
                            '  AND i.itemno="'+sgBarang.Cells[1,sgBarang.Row]+'" ',True);
          Ewaktuperitem.Text    := Format('%.2n',[GetValF(Q2,'menit')]);
          Ewaktuitemperjam.Text := Format('%.2n',[GetValF(Q2,'menit') / 60]);
          Etotalwaktumenit.Text := Format('%.2n',[Eorder.AsFLoat * GetvalF(Q2,'menit')]);
          Etotalwaktujam.Text   := Format('%.2n',[Eorder.AsFLoat * Ewaktuitemperjam.AsFLoat]);

    
  end;
end;


procedure TFDataSoJadwal.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDataSoJadwal.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' ');


end;

end.
