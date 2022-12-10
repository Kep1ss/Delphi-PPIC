unit uInputJobOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFinputJobOrder = class(TForm)
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
    CbDivisi: TAdvComboBox;
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
  FinputJobOrder: TFinputJobOrder;


implementation
 uses uListofSO, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputJobOrder.AdvSmoothButton1Click(Sender: TObject);
begin
  if CbDivisi.ItemIndex = - 1 then begin
     Error('Silahkan pilih divisi terlebih dahulu');
     Exit;

  end else begin
     FDaftarSO.LoadGrid(' WHERE  '+
      ' gd.id_divisi="'+GetIdcmb(CbDivisi)+'"  ');
      FDaftarSO.Liddivisi.Caption := GetIdcmb(CbDivisi);
      FDaftarSO.Lnamadivisi.Caption :=  CbDivisi.Text;
      FDaftarSO.Show;
  end;
end;

procedure TFinputJobOrder.btnSimpanClick(Sender: TObject);
var
  i   : integer;
  aList : TStringList;
begin
  if not CheckEdit(Self) then begin


         aList := TStringList.Create;
         try

         AddParam('no_input', Enomer.Text,aList,'str');
         AddParam('tgl_input', frmTgl(dtMulai.Date),aList,'date');
         AddParam('keterangan', Edeskripsi.Text,aList,'str');
         addParam('id_divisi', GetIdcmb(CbDivisi), aList,'str');

         ExQry(Q1,'SELECT id FROM master_job_order WHERE no_input="'+Enomer.Text+'"',True);

         if Q1.Isempty then begin
            exeDb(Q2,'master_job_order',aList);
         end else
            updatedb(Q2,'master_job_order',aList,'id',GetVal(Q1,'id'));

         ExQry(Q1,'DELETE FROM detail_job_order WHERE no_input="'+Enomer.Text+'"',False);

         if sg.Cells[2,sg.RowCount -1] <> '' then
            sg.RowCount := sg.RowCount + 1;

         for i := 2 to sg.RowCount -1 do begin
            if sg.Cells[1,i] <> '' then begin
               AddParam('no_input',           Enomer.Text, aList,'str');
               AddParam('nomer_container',    sg.Cells[1,i], aList,'str');
               AddParam('item_id',            sg.Cells[12,i], aList,'str');
               AddParam('qty_order',          StrTODecimal(sg.Cells[4,i]), aList,'str');
               AddParam('alokasi_per_menit',  StrTODecimal(sg.Cells[5,i]), aList,'str');
               AddParam('total_alokasi',      StrTODecimal(sg.Cells[6,i]), aList,'str');
               AddParam('jml_karyawan',       StrTODecimal(sg.Cells[7,i]), aList,'str');
               AddParam('total_alokasi_perhari', StrTODecimal(sg.Cells[8,i]), aList,'str');
               AddParam('target_perolehan',      StrTODecimal(sg.Cells[9,i]), aList,'str');
               AddParam('tgl_mulai',             Tanggal(sg.dates[10,i]), aList,'str');
               AddParam('tgl_akhir',             Tanggal(sg.dates[11,i]), aList,'str');
               AddParam('no_so',                 sg.Cells[13,i], aList,'str');
               AddParam('gant_detail_id',        sg.Cells[14,i], aList,'str');
               exeDb(Q2,'detail_job_order',aList);
            end;
         end;

           Informasi('JOB ORDER Berhasil Disimpan');
           TampilanAwal;
         finally
           alist.Free;
         end;

  end;
end;

procedure TFinputJobOrder.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputJobOrder.FormCreate(Sender: TObject);
begin
  FinputJobOrder := Self;


end;

procedure TFinputJobOrder.GridWo;
begin
  with sg do begin

     ClearAll;

     ColCount := 15;
     RowCount := 3;
     FixedRows := 2;
     FixedCols := 0;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Code Container';
     Cells[2,0] := 'Item No';
     Cells[3,0] := 'Description ';
     Cells[4,0] := 'Jml Order';
     Cells[5,0] := 'Alokasi Waktu Per Set (Menit)';
     Cells[6,0] := 'Total Alokasi Waktu (Menit)';
     Cells[7,0] := 'Jml Kary';
     Cells[8,0] := 'Total Alokasi Waktu Per Hari';
     Cells[9,0] := 'Target Perolehan Per Hari';
     Cells[10,0] := 'Target Tgl Selesai';
     Cells[10,1] := 'Tgl Mulai';
     Cells[11,1] := 'Tgl Selesai';
     Cells[12,1] := 'Item Id';
     Cells[13,1] := 'NO SO';
     Cells[14,1] := 'GD ID';


     ColWidths[0] := 30;
     ColWidths[1] := 100;
     ColWidths[2] := 100;
     ColWidths[3] := 80;
     ColWidths[4] := 80;
     ColWidths[5] := 50;
     ColWidths[6] := 50;
     ColWidths[7] := 50;
     ColWidths[8] := 60;
     ColWidths[9] := 65;
     ColWidths[10] := 100;
     ColWidths[11] := 100;
     ColWidths[12] := 0;
     ColWidths[13] := 0;
     ColWidths[14] := 0;


     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;
     MergeCells(0,0,1,2);
     MergeCells(1,0,1,2);
     MergeCells(2,0,1,2);
     MergeCells(3,0,1,2);
     MergeCells(4,0,1,2);
     MergeCells(5,0,1,2);
     MergeCells(6,0,1,2);
     MergeCells(7,0,1,2);
     MergeCells(8,0,1,2);
     MergeCells(9,0,1,2);
     MergeCells(10,0,2,1);

  end;
end;

procedure TFinputJobOrder.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol in [1,2,3,4,6];
end;

procedure TFinputJobOrder.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACOl = 10 then begin
     HAlign := taCenter;
     VAlign := vtaCenter;
  end;
end;

procedure TFinputJobOrder.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_DELETE : begin
                sg.ClearRows(sg.Row,1);
                sg.RowCount := sg.RowCount -1;
              end;
  end;

end;

procedure TFinputJobOrder.sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if sg.Col in [3,4] then begin
     Subtotal(sg.Row);
  end;
end;

procedure TFinputJobOrder.Subtotal(arow: integer);

begin
 

end;

procedure TFinputJobOrder.TampilanAwal;
begin
  ClearText(Self);

  Enomer.Text   := GetCode(Q1,'master_job_order','no_input','JO');
  GridWo;
  dtMulai.Date  := now;
 
end;


end.
