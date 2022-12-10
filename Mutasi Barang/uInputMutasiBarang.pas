unit uInputMutasiBarang;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFInputMutasiBarang = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    Label5: TLabel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    dtMulai: TDateTimePicker;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label4: TLabel;
    Edeskripsi: TAdvEdit;
    AdvGroupBox2: TAdvGroupBox;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    sg: TAdvStringGrid;
    Label7: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    cbDivisiAwal: TAdvComboBox;
    Label6: TLabel;
    cbDivisiAkhir: TAdvComboBox;
    Label8: TLabel;
    cbJenisMutasi: TAdvComboBox;
    Q3: TMyQuery;
    Q4: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
  private

    procedure Subtotal(arow : integer);

    { Private declarations }
  public
     procedure TampilanAwal;
    procedure GridWo;

    { Public declarations }
  end;

var
  FInputMutasiBarang: TFInputMutasiBarang;


implementation
 uses uListofSO, uMarCon, uDaftarItemSelesaiPerDivisi;


{$R *.dfm}

{ TFInputSupplier }

procedure TFInputMutasiBarang.AdvSmoothButton1Click(Sender: TObject);
begin
  if (cbDivisiAwal.ItemIndex = - 1) and (cbDivisiAkhir.ItemIndex = -1) then begin
     Error('Silahkan pilih divisi terlebih dahulu');
     Exit;

  end else begin
     FDaftarItemProsesDivisi.ShowModal;
  end;
end;

procedure TFInputMutasiBarang.btnSimpanClick(Sender: TObject);
var
  i   : integer;
  aList : TStringList;
  Qty_per_hasil : Integer;
  Qty_input :integer;
begin
  if not CheckEdit(Self) then begin


         aList := TStringList.Create;
         try

         AddParam('code',           Enomer.Text,aList,'str');
         AddParam('tgl',            frmTgl(dtMulai.Date),aList,'date');
         AddParam('keterangan',     Edeskripsi.Text,aList,'str');
         addParam('divisi_id_from', GetIdcmb(cbDivisiAwal), aList,'str');
         addParam('divisi_id_to',   GetIdcmb(cbDivisiAkhir), aList,'str');
         addParam('jenis_mutasi',   cbJenisMutasi.Text, aList,'str');

         ExQry(Q1,'SELECT id FROM mutasi_produksi WHERE code="'+Enomer.Text+'"',True);

         if Q1.Isempty then begin
            exeDb(Q2,'mutasi_produksi',aList);
         end else
            updatedb(Q2,'mutasi_produksi',aList,'id',GetVal(Q1,'id'));

         ExQry(Q1,'DELETE FROM mutasi_produksi_detail WHERE code="'+Enomer.Text+'"',False);

         if sg.Cells[2,sg.RowCount -1] <> '' then
            sg.RowCount := sg.RowCount + 1;

         for i := 1 to sg.RowCount -1 do begin
            if sg.Cells[1,i] <> '' then begin
               AddParam('code',           Enomer.Text, aList,'str');
               AddParam('no_so',          sg.Cells[2,i], aList,'str');
               AddParam('nomer_container',sg.Cells[1,i], aList,'str');
               AddParam('item_id',        sg.Cells[8,i], aList,'str');
               AddParam('qty',            StrTODecimal(sg.Cells[6,i]), aList,'str');
               AddParam('keterangan',     sg.Cells[7,i], aList,'str');

               exeDb(Q2,'mutasi_produksi_detail',aList);

               ExQry(Q3,'SELECT qty - qty_out as sisa,nobukti,no_so,nomer_container,'+
               ' item_id,id_divisi FROM progress '+
               ' WHERE no_so="'+Sg.Cells[2,i]+'" AND '+
               ' nomer_container="'+sg.Cells[1,i]+'" AND '+
               ' item_id="'+sg.Cells[8,i]+'" '+
               ' AND id_divisi="'+GetIdcmb(cbDivisiAwal)+'" ORDER BY tgl ASC',True );


               Qty_input := StrToIntDef(nilai(Sg.Cells[6,i]),0);

               repeat
                  Qty_per_hasil := GetValInt(Q3,'sisa');
                  if Qty_input >= Qty_per_hasil then begin
                     ExQry(Q4,'UPDATE progress SET qty_out=qty '+
                     ' WHERE no_so="'+GetVal(Q3,'no_so')+'" '+
                     ' AND nomer_container="'+GetVal(Q3,'nomer_container')+'" '+
                     ' AND item_id="'+GetVal(Q3,'item_id')+'" '+
                     ' AND id_divisi="'+GetVal(Q3,'id_divisi')+'" '+
                     ' AND nobukti="'+GetVal(Q3,'nobukti')+'" ',False);
                     Qty_input := Qty_input - Qty_per_hasil;
                     Q3.Next;

                  end else begin
                    ExQry(Q4,'UPDATE progress SET qty_out="'+StrToDecimal(IntToStr(Qty_input))+'" '+
                     ' WHERE no_so="'+GetVal(Q3,'no_so')+'" '+
                     ' AND nomer_container="'+GetVal(Q3,'nomer_container')+'" '+
                     ' AND item_id="'+GetVal(Q3,'item_id')+'" '+
                     ' AND id_divisi="'+GetVal(Q3,'id_divisi')+'" '+
                     ' AND nobukti="'+GetVal(Q3,'nobukti')+'" ',False);
                     Qty_input := 0;
                  end;

               until (Qty_input = 0);


            end;
         end;

           Informasi('Mutasi Barang Berhasil Disimpan');
           TampilanAwal;
         finally
           alist.Free;
         end;

  end;
end;

procedure TFInputMutasiBarang.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFInputMutasiBarang.FormCreate(Sender: TObject);
begin
  FInputMutasiBarang := Self;


end;

procedure TFInputMutasiBarang.GridWo;
begin
  with sg do begin

     ClearAll;

     ColCount := 9;
     RowCount := 2;
     FixedRows := 1;
     FixedCols := 0;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Code Container';
     Cells[2,0] := 'No So';
     Cells[3,0] := 'Item';
     Cells[4,0] := 'Description ';
     Cells[5,0] := 'Qty Ready';
     Cells[6,0] := 'Qty Mutasi';
     Cells[7,0] := 'Keterangan';
     Cells[8,0] := 'Item Id';


     ColWidths[0] := 30;
     ColWidths[1] := 100;
     ColWidths[2] := 100;
     ColWidths[3] := 150;
     ColWidths[4] := 80;
     ColWidths[5] := 80;
     ColWidths[6] := 80;
     ColWidths[7] := 150;
     ColWidths[8] := 0;


     ColumnSize.StretchColumn := 4;
     ColumnSize.Stretch       := True;
  end;
end;

procedure TFInputMutasiBarang.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol in [5,6];
end;

procedure TFInputMutasiBarang.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACOl = 10 then begin
     HAlign := taCenter;
     VAlign := vtaCenter;
  end;
end;

procedure TFInputMutasiBarang.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_DELETE : begin
                sg.ClearRows(sg.Row,1);
                sg.RowCount := sg.RowCount -1;
              end;
  end;

end;

procedure TFInputMutasiBarang.sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if sg.Col in [6] then begin
     Subtotal(sg.Row);
  end;
end;

procedure TFInputMutasiBarang.Subtotal(arow: integer);
var
  Qty_Ready , Qty_Mutasi : Integer;
begin
  Qty_Ready := StrToIntDef(nilai(sg.Cells[5,arow]),0);
  Qty_Mutasi:= StrToIntDef(nilai(sg.Cells[6,arow]),0);

  if Qty_Mutasi > Qty_Ready then begin
     Error('Jumlah Dimasukan melebihi jumlah tersedia');
     sg.Cells[6,Arow] := '0';
  end;


end;

procedure TFInputMutasiBarang.TampilanAwal;
begin
  ClearText(Self);

  Enomer.Text   := GetCode(Q1,'mutasi_produksi','code','NT');
  GridWo;
  dtMulai.Date  := now;

end;


end.
