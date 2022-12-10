unit uInpuWorkOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls;
type
  TFinputWo = class(TForm)
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
    Label8: TLabel;
    dtMulai: TDateTimePicker;
    dtSelesai: TDateTimePicker;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label4: TLabel;
    Edeskripsi: TAdvEdit;
    AdvSmoothButton1: TAdvSmoothButton;
    EPIC: TAdvEdit;
    AdvGroupBox2: TAdvGroupBox;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    sg: TAdvStringGrid;
    Label7: TLabel;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    yDb : TYDb;


    procedure TampilanAwal;
    procedure GridWo;


    { Private declarations }
  public


    { Public declarations }
  end;

var
  FinputWo: TFinputWo;


implementation
 uses
  uDataKaryawan, uListofSO, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputWo.AdvSmoothButton1Click(Sender: TObject);
begin
  FDaftarSO.ShowMOdal;
end;

procedure TFinputWo.btnSimpanClick(Sender: TObject);
var
  i , idWo , id_bom ,item_id: integer;

begin
  if not CheckEdit(Self) then begin

     yDb.Table := 'wo';
     yDb.FieldString('no_wo', Enomer.Text);
     yDb.FieldString('no_container', EContainer.Text);
     yDb.FieldDate('tgl_input', Now);
     yDb.FieldDate('tgl_mulai', dtMulai.Date);
     yDb.FieldDate('tgl_selesai', dtSelesai.Date);
     yDb.FieldString('pic', EPIC.Text);
     yDb.FieldString('deskripsi', Edeskripsi.Text);
     yDb.Save(Fid);

     idWo := yDb.LastId;

     yDb.Table := 'wo_jobs';

     for i := 1 to sg.RowCount -1 do begin
        if sg.Cells[1,i] <> '' then begin
           id_bom   := yDb.FindIdTable('bom','bom_no',sg.Cells[3,i],'id');
           item_id  := yDb.FindIdTable('item','itemno',sg.Cells[1,i],'id');
           yDb.FieldInt('id_wo', idWo);
           yDb.FieldString('deskripsi', sg.Cells[2,i]);
           yDb.FieldString('item_no', sg.Cells[1,i]);
           yDb.FieldFloat('qty', CellF(sg.Cells[4,i]));
           yDb.FieldFloat('unit_price', CellF(sg.Cells[5,i]));
           yDb.FieldInt('qtyorder', StrToIntDef(sg.Cells[6,i],0));
           yDb.FieldFloat('totalcost', CellF(sg.Cells[4,i]) * CellF(sg.Cells[5,i]));
           yDb.FieldString('so_no', sg.Cells[0,i]);
           yDb.FieldInt('id_bom', id_bom);
           yDb.FieldInt('item_id', item_id);
           yDb.Save(0);
        end;


     end;

     Informasi('Work Order Berhasil Disimpan');
     TampilanAwal;
  end;
end;

procedure TFinputWo.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputWo.FormCreate(Sender: TObject);
begin
  FinputWo := Self;
  yDb      := TYDb.Create(MariaCon.ZMy);
end;

procedure TFinputWo.FormDestroy(Sender: TObject);
begin
  yDb.Free;
end;

procedure TFinputWo.FormShow(Sender: TObject);
begin
  GridWo;
  TampilanAwal;
end;

procedure TFinputWo.GridWo;
begin
  with sg do begin

     ColCount := 7;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'NO SO';
     Cells[1,0] := 'Item No';
     Cells[2,0] := 'Item Order';
     Cells[3,0] := 'BOM No';
     Cells[4,0] := 'Qty';
     Cells[5,0] := 'Unit Price';
     Cells[6,0] := 'qtytotal';


     ColWidths[0] := 100;
     ColWidths[1] := 150;
     ColWidths[2] := 100;
     ColWidths[3] := 80;
     ColWidths[4] := 150;
     ColWidths[5] := 150;
     ColWidths[6] := 0;


     ColumnSize.StretchColumn := 2;
     ColumnSize.Stretch       := True;

  end;
end;

procedure TFinputWo.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol = 4  then
     CanEdit := True else
     CanEdit := False;
end;

procedure TFinputWo.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_DELETE : begin
                sg.ClearRows(sg.Row,1);
                sg.RowCount := sg.RowCount -1;
              end;
  end;

end;

procedure TFinputWo.TampilanAwal;
begin
  ClearText(Self);
  Fid           := 0;
  FCanEdit      := False;
  yDb.Table     := 'wo';
  Enomer.Text   := yDb.Code('no_wo','WO');
  GridWo;
 
end;

end.
