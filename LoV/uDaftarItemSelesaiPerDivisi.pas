unit uDaftarItemSelesaiPerDivisi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarItemProsesDivisi = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgBarang: TAdvStringGrid;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    btnPilih: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPilihClick(Sender: TObject);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private

    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    idDivisi : String;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarItemProsesDivisi: TFDaftarItemProsesDivisi;


implementation



{$R *.dfm}

uses uInputHasilBeritaAcara, uMarCon, uInputMutasiBarang;



{ TFinputMotif }

procedure TFDaftarItemProsesDivisi.btnFindClick(Sender: TObject);
begin
  LoadGrid(' AND (p.no_so LIKE "%'+Ecari.Text+'%" '+
  ' OR i.itemno LIKE "%'+Ecari.Text+'%" OR '+
  ' i.description LIKE "%'+Ecari.Text+'%" OR '+
  ' p.nomer_container LIKE "%'+ECari.Text+'%")');
end;

procedure TFDaftarItemProsesDivisi.btnPilihClick(Sender: TObject);
var
  order , MH , Cost : real;
  qty_component : real;
  total_component : real;
  i , x , c : integer;
  isCheck : boolean;
begin

  for  c := 0 to sgBarang.RowCount -1 do begin
      sgBarang.GetCheckBoxState(6,c,isCheck);

      if isCheck then begin

        With FInputMutasiBarang do begin


           sg.Cells[0,sg.RowCount -1] := IntToStr(sg.RowCount -1);
           sg.Cells[1,sg.RowCount -1] := sgBarang.Cells[2,c];
           sg.Cells[2,sg.RowCount -1] := sgBarang.Cells[1,c];
           sg.Cells[3,sg.RowCount -1] := sgBarang.Cells[7,c];
           sg.Cells[4,sg.RowCount -1] := sgBarang.Cells[3,c];
           sg.Cells[5,sg.RowCount -1] := sgBarang.Cells[4,c];
           sg.Cells[6,sg.RowCount -1] := '';
           sg.Cells[7,sg.RowCount -1] := '';
           sg.Cells[8,sg.RowCount -1] := sgBarang.Cells[5,c];
           sg.RowCount := sg.RowCount + 1;
           sg.Row      := sg.RowCount -1;
           sg.SetFocus;
           sg.Col    := 1;

        end;
      end;
  end;
  Close;
end;

procedure TFDaftarItemProsesDivisi.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarItemProsesDivisi.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 8;
    RowCount := 2;

    Cells[0,0] := 'Divisi';
    Cells[1,0] := 'No SO';
    Cells[2,0] := 'No Container';
    Cells[3,0] := 'Item';
    Cells[4,0] := 'Qty';
    Cells[5,0] := 'item_Id';
    Cells[6,0] := 'Pilih';
    Cells[7,0] := 'Item No';

    ColWidths[0] := 100;
    ColWidths[1] := 100;
    ColWidths[2] := 100;
    ColWidths[3] := 200;
    ColWidths[4] := 50;
    ColWidths[5] := 0;
    ColWidths[6] := 50;
    ColWidths[7] := 0;

    ColumnSize.StretchColumn := 3;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarItemProsesDivisi.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin

    btnFind.Click;
  end;
end;

procedure TFDaftarItemProsesDivisi.FormShow(Sender: TObject);
begin


  TampilanAwal;
  LoadGrid(' WHERE p.id_divisi="'+GetIdCmb(FInputMutasiBarang.cbDivisiAwal)+'" ');
end;

procedure TFDaftarItemProsesDivisi.LoadGrid(Filter: String);
var
  i : integer;

begin
  CreateGrid;
    ExQry(Q1,' SELECT                                        '+
             '     p.tgl,                                    '+
             '     p.nobukti,                                '+
             '     p.no_so,                                  '+
             '     p.`nomer_container`,                      '+
             '     p.id_divisi,                              '+
             '     p.item_id,                                '+
             '     SUM(p.qty - p.qty_out) AS qty_sisa,       '+
             '     i.description,                            '+
             '     i.itemno,                                 '+
             '     d.name                                    '+
             '   FROM                                        '+
             '     progress p                                '+
             '     LEFT JOIN item i                          '+
             '       ON i.`id` = p.`item_id`                 '+
             '     LEFT JOIN divisi d                        '+
             '       ON d.`id` = p.`id_divisi` '+Filter+'    '+
             '   GROUP BY p.`item_id`,                       '+
             '     p.`no_so`,                                '+
             '     p.`nomer_container`,                      '+
             '     p.`id_divisi` HAVING qty_sisa > 0 ',True);
      i := 0;
      sgBarang.RowCount := Q1.RecordCount + 1;
      while not Q1.Eof do begin
        with sgBarang do begin
             Cells[0,i+1] := GetVal(Q1,'name');
             Cells[1,i+1] := GetVal(Q1,'no_so');
             Cells[2,i+1] := GetVal(Q1,'nomer_container');
             Cells[3,i+1] := GetVal(Q1,'description');
             Cells[4,i+1] := GetValR(Q1,'qty_sisa');
             Cells[5,i+1] := GetVal(Q1,'item_id');
             Cells[7,i+1] := GetVal(Q1,'itemno');
             AddCheckBox(6,i+1,False,false);
             Inc(i);
           end;

           Q1.Next;


        end;


end;

procedure TFDaftarItemProsesDivisi.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 6
end;

procedure TFDaftarItemProsesDivisi.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarItemProsesDivisi.TampilanAwal;
begin
  ClearText(Self);



end;

end.
