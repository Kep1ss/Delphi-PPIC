unit uInputSalesOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl, uPatchForm,AnnabaDB,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls;
type
  TFinputJobOrder = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    QM1: TZQuery;
    Label5: TLabel;
    Label6: TLabel;
    EContainer: TAdvEdit;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    dtMulai: TDateTimePicker;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label4: TLabel;
    Edeskripsi: TAdvEdit;
    EPIC: TAdvEdit;
    AdvGroupBox2: TAdvGroupBox;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    sg: TAdvStringGrid;
    Label7: TLabel;
    Label8: TLabel;
    Ecustomer: TAdvEdit;
    AdvSmoothButton2: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    yDb : TYDb;



    procedure Subtotal(arow : integer);
    function ValidasiData:Boolean;


    { Private declarations }
  public
     procedure TampilanAwal;
    procedure GridWo;

    { Public declarations }
  end;

var
  FinputJobOrder: TFinputJobOrder;


implementation
 uses
  uDataKaryawan, uListofSO, uMarCon, uDaftarBarangSO;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputJobOrder.AdvSmoothButton1Click(Sender: TObject);
begin
  FDaftarSO.ShowMOdal;
end;

procedure TFinputJobOrder.AdvSmoothButton2Click(Sender: TObject);
begin
  FDaftarBarangSO.ShowModal;
end;

procedure TFinputJobOrder.btnSimpanClick(Sender: TObject);
var
  i , idWo , id_bom ,item_id: integer;

begin
  if not CheckEdit(Self) then begin

     if not ValidasiData then begin
        Error('Finising Belum Ditentukan, Silahkan Cek Data Pada kolom Finishing !!!');
        Exit
     end else begin


         yDb.Table := 'master_so';
         yDb.FieldString('no_so', Enomer.Text);
         yDb.FieldString('no_container', EContainer.Text);
         yDb.FieldDate('tgl_input', dtMulai.Date);
         yDb.FieldString('customer', Ecustomer.Text);
         yDb.FieldString('pic', EPIC.Text);
         yDb.FieldString('keterangan', Edeskripsi.Text);
         yDb.Save(Fid);

         idWo := yDb.LastId;

         yDb.Table := 'detail_so';

         if sg.Cells[2,sg.RowCount -1] <> '' then
            sg.RowCount := sg.RowCount + 1;

         for i := 1 to sg.RowCount -1 do begin
            if sg.Cells[1,i] <> '' then begin
               yDb.FieldString('no_so',   Enomer.Text);
               yDb.FieldString('item_id', sg.Cells[7,i]);
               yDb.FieldString('unit',    sg.Cells[2,i]);
               yDb.FieldFloat('jumlah',   CellF(sg.Cells[3,i]));
               yDb.FieldFloat('harga',    CellF(sg.Cells[4,i]));
               yDb.FieldFloat('subtotal', CellF(sg.Cells[5,i]));
               yDb.FieldString('no_po',    sg.Cells[6,i]);
               yDb.Save(0);
            end;


         end;

         Informasi('JOB ORDER Berhasil Disimpan');
         TampilanAwal;
     end;
  end;
end;

procedure TFinputJobOrder.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputJobOrder.FormCreate(Sender: TObject);
begin
  FinputSO := Self;
  yDb      := TYDb.Create(MariaCon.ZMy);

end;

procedure TFinputJobOrder.FormDestroy(Sender: TObject);
begin
  yDb.Free;
end;

procedure TFinputJobOrder.GridWo;
begin
  with sg do begin

     ClearAll;

     ColCount := 8;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'Item No';
     Cells[1,0] := 'Deskripsi';
     Cells[2,0] := 'Unit';
     Cells[3,0] := 'Qty';
     Cells[4,0] := 'Harga';
     Cells[5,0] := 'Subtotal';
     Cells[6,0] := 'No SO';
     Cells[7,0] := 'itemid';


     ColWidths[0] := 100;
     ColWidths[1] := 150;
     ColWidths[2] := 100;
     ColWidths[3] := 80;
     ColWidths[4] := 150;
     ColWidths[5] := 150;
     ColWidths[6] := 150;
     ColWidths[7] := 0;


     ColumnSize.StretchColumn := 1;
     ColumnSize.Stretch       := True;

  end;
end;

procedure TFinputJobOrder.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol in [1,2,3,4,6];
end;

procedure TFinputJobOrder.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_DELETE : begin
                sg.ClearRows(sg.Row,1);
                sg.RowCount := sg.RowCount -1;
              end;
  VK_RETURN : begin
                if sg.Col < 6 then
                   sg.Col := sg.Col + 1 else
                   begin
                     if sg.Row < sg.RowCount -1 then begin
                        sg.Row := sg.Row + 1;
                        sg.Col := 0;
                     end else begin
                       sg.RowCount := sg.RowCount + 1;
                       sg.Row      := sg.Row + 1;
                       sg.Col      := 0;
                     end;
                   end;
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
var
  Jumlah , Harga : Real;

  Total : Real;
begin
  Jumlah := StrToFloatDef(nilai(sg.Cells[3,arow]),0);
  Harga  := StrToFloatDef(nilai(sg.Cells[4,arow]),0);

  Total  := Jumlah * Harga;

  sg.Cells[5,arow] := Format('%.2n',[Total]);

end;

procedure TFinputJobOrder.TampilanAwal;
begin
  ClearText(Self);
  Fid           := 0;
  FCanEdit      := False;
  yDb.Table     := 'master_so';
  Enomer.Text   := yDb.Code('no_so','JO');
  GridWo;
 
end;

function TFinputJobOrder.ValidasiData: Boolean;
var
  i : integer;
begin
  Result := True;
  for i := 1 to sg.RowCount -1 do begin
     if (sg.Cells[6,i] = '') and (sg.Cells[0,i] <> '') then
     begin
       Result := False;
       Break;
     end;

  end;

end;

end.
