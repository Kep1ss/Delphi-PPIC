unit uProcessInspect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFProsesInspect = class(TForm)
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
    Q1: TMyQuery;
    Q2: TMyQuery;
    cbCustomer: TAdvComboBox;
    procedure btnTutupClick(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
   { Private declarations }
  public
    id :String;
     procedure TampilanAwal;
     procedure GridInspect;

    { Public declarations }
  end;

var
  FProsesInspect: TFProsesInspect;


implementation
 uses
   uListofSO, uMarCon, uDaftarSalesOrderInspect;


{$R *.dfm}

{ TFInputSupplier }

procedure TFProsesInspect.AdvSmoothButton1Click(Sender: TObject);
begin
  FDaftarSO.ShowMOdal;
end;

procedure TFProsesInspect.btnSimpanClick(Sender: TObject);
var
  i  : integer;
  aList : TStringLIst;

begin
  if not CheckEdit(Self) then begin


         aList := TStringList.Create;

         try


             AddParam('nomer',       Enomer.Text,aList,'str');
             AddParam('tgl_realisasi',         frmTgl(dtMulai.Date),aList,'date');
             AddParam('buyer',       cbCustomer.Text,aList,'str');
             AddParam('keterangan',     Edeskripsi.Text,aList,'str');
             AddParam('processed',    BolStr(True),aList,'str');

             ExQry(Q1,'SELECT id FROM inspect WHERE nomer="'+Enomer.Text+'"',True);
             if Q1.IsEmpty then
                exeDb(Q2,'inspect',aList)
             else
                updatedb(Q2,'inspect',aList,'id',GetVal(Q1,'id'));


             ExQry(Q1,'DELETE FROM detail_inspect WHERE nomer="'+Enomer.Text+'"',False);

             if sg.Cells[1,sg.RowCount -1] <> '' then
                sg.RowCount := sg.RowCount + 1;

             for i := 1 to sg.RowCount -1 do begin
                if sg.Cells[1,i] <> '' then begin
                   AddParam('nomer',   Enomer.Text,aList,'str');
                   AddParam('item_id', sg.Cells[9,i],aList,'str');;
                   AddParam('no_so',    sg.Cells[0,i],aList,'str');
                   AddParam('no_container',   sg.Cells[1,i],aList,'str');
                   AddParam('qty_pass',   StrToDecimal(sg.Cells[6,i]),aList,'str');
                   AddParam('qty_failed',   StrToDecimal(sg.Cells[7,i]),aList,'str');
                   AddParam('keterangan_fail',   StrToDecimal(sg.Cells[8,i]),aList,'str');

                   ExQry(Q1,'SELECT id FROM detail_inspect WHERE item_id="'+sg.Cells[9,i]+'" '+
                   ' AND no_so="'+sg.Cells[0,i]+'" AND no_container="'+sg.Cells[1,i]+'" '+
                   ' AND nomer="'+Enomer.Text+'"',True);

                   if Q1.IsEmpty = false then
                      updatedb(Q2,'detail_inspect',alist,'id',GetVal(Q1,'id')) else
                   aList.Clear;


                   addParam('tgl', frmTgl(dtMulai.Date),aList,'date');
                   addParam('no_so', sg.Cells[0,i], aList,'str');
                   addParam('nomer_container', sg.Cells[1,i], aList,'str');
                   addParam('item_id', sg.Cells[9,i], aList,'str');
                   addParam('qty_pass', sg.Cells[6,i], aList,'str');
                   addParam('qty_failed', sg.Cells[7,i], aList,'str');
                   addParam('keterangan', sg.Cells[8,i], aList,'str');

                   exeDb(Q2,'item_finished',aList);
                end;


             end;

             Informasi('Data Inspect Berhasil Disimpan');
             TampilanAwal;
         finally
           aList.Free;
         end;

  end;
end;

procedure TFProsesInspect.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFProsesInspect.FormCreate(Sender: TObject);
begin
  FProsesInspect := Self;
  dtMulai.Date     := now;
end;

procedure TFProsesInspect.GridInspect;
begin
  with sg do begin

     ClearAll;

     ColCount := 10;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'No So';
     Cells[1,0] := 'No Container';
     Cells[2,0] := 'Item No';
     Cells[3,0] := 'Deskripsi';
     Cells[4,0] := 'Unit';
     Cells[5,0] := 'Qty Plan';
     Cells[6,0] := 'Qty Pass';
     Cells[7,0] := 'Qty Fails';
     Cells[8,0] := 'Keterangan';
     Cells[9,0] := 'itemid';


     ColWidths[0] := 100;
     ColWidths[1] := 100;
     ColWidths[2] := 80;
     ColWidths[3] := 200;
     ColWidths[4] := 100;
     ColWidths[5] := 100;
     ColWidths[6] := 100;
     ColWidths[7] := 100;
     ColWidths[8] := 150;
     ColWidths[9] := 0;


     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;

  end;
end;

procedure TFProsesInspect.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol in [6,7];
end;

procedure TFProsesInspect.sgKeyDown(Sender: TObject; var Key: Word;
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

procedure TFProsesInspect.sgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  qty_plan,qty_pass,qty_fail : integer;
begin
  if sg.Col = 6 then begin
     qty_plan := StrToIntDef(nilai(sg.Cells[5,sg.Row]),0);
     qty_pass := StrToIntDef(nilai(sg.Cells[6,sg.Row]),0);
     qty_fail := qty_plan-qty_pass;

     sg.Cells[7,sg.Row] := FloatToStr(qty_fail);
  end else if sg.Col = 7 then begin

     qty_plan := StrToIntDef(nilai(sg.Cells[5,sg.Row]),0);
     qty_fail := StrToIntDef(nilai(sg.Cells[7,sg.Row]),0);
     qty_pass := qty_plan-qty_fail;

     sg.Cells[6,sg.Row] := FloatToStr(qty_pass);

  end;

end;

procedure TFProsesInspect.TampilanAwal;
begin
  ClearText(Self);

  Enomer.Text   := GetCode(Q1,'inspect','nomer','IP');
  GridInspect;
  isiCmb(Q1,'category_buyer',['id','buyer_name'],cbCustomer);
 
end;



end.
