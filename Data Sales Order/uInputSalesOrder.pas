unit uInputSalesOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFinputSalesOrder = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
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
    Label8: TLabel;
    AdvSmoothButton2: TAdvSmoothButton;
    Label5: TLabel;
    EnoSo: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Label6: TLabel;
    ENoContainer: TAdvEdit;
    cbCustomer: TAdvComboBox;
    procedure btnTutupClick(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvSmoothButton2Click(Sender: TObject);
  private
   { Private declarations }
  public
    id :String;
     procedure TampilanAwal;
    procedure GridWo;

    { Public declarations }
  end;

var
  FinputSalesOrder: TFinputSalesOrder;


implementation
 uses
   uListofSO, uMarCon, uDaftarBarangSO;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputSalesOrder.AdvSmoothButton1Click(Sender: TObject);
begin
  FDaftarSO.ShowMOdal;
end;

procedure TFinputSalesOrder.AdvSmoothButton2Click(Sender: TObject);
begin

  FDaftarBarangSO.LoadGrid('WHERE buyer_id="'+GetIdcmb(cbCustomer)+'"');
  FDaftarBarangSO.ShowModal;
end;

procedure TFinputSalesOrder.btnSimpanClick(Sender: TObject);
var
  i  : integer;
  aList : TStringLIst;

begin
  if not CheckEdit(Self) then begin


         aList := TStringList.Create;

         try


             AddParam('no_input',       Enomer.Text,aList,'str');
             AddParam('no_sales_order', EnoSo.Text,aList,'str');
             AddParam('tgl_input',      frmTgl(dtMulai.Date),aList,'date');
             AddParam('customer',       cbCustomer.Text,aList,'str');
             AddParam('nomer_container',   ENoContainer.Text,aList,'str');
             AddParam('keterangan',     Edeskripsi.Text,aList,'str');

             ExQry(Q1,'SELECT id FROM sales_order WHERE no_input="'+Enomer.Text+'"',True);
             if Q1.IsEmpty then
                exeDb(Q2,'sales_order',aList)
             else
                updatedb(Q2,'sales_order',aList,'id',GetVal(Q1,'id'));


             ExQry(Q1,'DELETE FROM detail_sales_order WHERE no_input="'+Enomer.Text+'"',False);

             if sg.Cells[1,sg.RowCount -1] <> '' then
                sg.RowCount := sg.RowCount + 1;

             for i := 1 to sg.RowCount -1 do begin
                if sg.Cells[1,i] <> '' then begin
                   AddParam('no_input',   Enomer.Text,aList,'str');
                   AddParam('item_id', sg.Cells[4,i],aList,'str');;
                   AddParam('unit',    sg.Cells[2,i],aList,'str');
                   AddParam('jumlah',   StrToDecimal(sg.Cells[3,i]),aList,'str');
                   exeDb(Q2,'detail_sales_order',aList)
                end;


             end;

             Informasi('SALES ORDER Berhasil Disimpan');
             TampilanAwal;
         finally
           aList.Free;
         end;

  end;
end;

procedure TFinputSalesOrder.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputSalesOrder.FormCreate(Sender: TObject);
begin
  FinputSalesOrder := Self;
  dtMulai.Date     := now;
end;

procedure TFinputSalesOrder.GridWo;
begin
  with sg do begin

     ClearAll;

     ColCount := 5;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'Item No';
     Cells[1,0] := 'Deskripsi';
     Cells[2,0] := 'Unit';
     Cells[3,0] := 'Qty';
     Cells[4,0] := 'itemid';


     ColWidths[0] := 100;
     ColWidths[1] := 150;
     ColWidths[2] := 100;
     ColWidths[3] := 100;
     ColWidths[4] := 0;


     ColumnSize.StretchColumn := 1;
     ColumnSize.Stretch       := True;

  end;
end;

procedure TFinputSalesOrder.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol in [1,2,3,4,6];
end;

procedure TFinputSalesOrder.sgKeyDown(Sender: TObject; var Key: Word;
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

procedure TFinputSalesOrder.TampilanAwal;
begin
  ClearText(Self);

  Enomer.Text   := GetCode(Q1,'sales_order','no_input','SO');
  GridWo;
  isiCmb(Q1,'category_buyer',['id','buyer_name'],cbCustomer);
 
end;



end.
