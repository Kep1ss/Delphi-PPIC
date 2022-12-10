unit uDataPOMonitoring;

interface

uses
  Winapi.Windows, Vcl.Forms, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, AdvGroupBox, AdvSmoothListBox, AdvTreeViewBase,
  AdvTreeViewData, AdvCustomTreeView, AdvTreeView, AdvOfficeButtons, MemDS,
  DBAccess, MyAccess;

type
  TFDataPOMonitoring = class(TForm)
    Label1: TLabel;
    btnAdd: TAdvSmoothButton;
    P1: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label4: TLabel;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothPanel2: TAdvSmoothPanel;
    sg1: TAdvStringGrid;
    AdvGroupBox1: TAdvGroupBox;
    rbSO: TAdvOfficeRadioButton;
    rbContainer: TAdvOfficeRadioButton;
    AdvSmoothPanel3: TAdvSmoothPanel;
    AdvGroupBox2: TAdvGroupBox;
    btnProcess: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    AdvGroupBox3: TAdvGroupBox;
    sg: TAdvStringGrid;
    AdvSmoothButton1: TAdvSmoothButton;
    EPencarian: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure sg1Click(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure rbSOClick(Sender: TObject);
    procedure rbContainerClick(Sender: TObject);
    procedure EPencarianKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure GridProsess;
    procedure GridSO;
    procedure LoadWO(Filter:String);



  public
    { Public declarations }


  end;



var
  FDataPOMonitoring: TFDataPOMonitoring;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputWIP, uInputPackingContainer;


procedure TFDataPOMonitoring.AdvSmoothButton1Click(Sender: TObject);
begin
  if MessageDlg('Hapus Data ?',mtConfirmation,[mbYes,mbno],0) = mrYes then
  begin
    ExQry(Q1,'DELETE FROM shippment WHERE id="'+sg.Cells[5,sg.Row]+'"',False);

    sg1Click(Sender);
    LoadWO('WHERE d.shipped=false');
  end;
end;

procedure TFDataPOMonitoring.btnAddClick(Sender: TObject);
var
  ItemNo    : String;
  Deskripsi : String;
  qtyReady  : Integer;
  Cbm       : Real;
  H , D ,W  : Real;
begin
   ItemNo    := sg1.Cells[16,sg1.Row];
   Deskripsi := sg1.Cells[3,sg1.Row];
   FinputPackingContainer.ECodeContainer.Text := sg1.Cells[1,sg1.Row];
   FinputPackingContainer.ESONo.Text          := sg1.Cells[2,sg1.Row];
   FinputPackingContainer.EitemNo.Text        := ItemNo;
   FinputPackingContainer.EDeskripsi.Text     := Deskripsi;
   H := CellF(sg1.Cells[6,sg1.Row]);
   D := CellF(sg1.Cells[5,sg1.Row]);
   W := CellF(sg1.Cells[4,sg1.Row]);
   Cbm := (H * D * W) / 1000/1000/1000;

   ExQry(Q2,'SELECT fc_qty_to_container("'+sg1.Cells[17,sg1.Row]+'","'+sg1.Cells[2,sg1.Row]+'","'+sg1.Cells[1,sg1.Row]+'") as QtyToContainer',True);
   qtyReady := GetValInt(Q2,'QtyToContainer');
   FinputPackingContainer.EqtyReady.Text := IntToStr(qtyReady);
   FinputPackingContainer.ECbm.Text      := Format('%.2n',[Cbm]);
   FinputPackingContainer.ShowModal;
   LoadWO('WHERE d.shipped=false');
end;

procedure TFDataPOMonitoring.btnProcessClick(Sender: TObject);
begin
  if MessageDlg('Process ?',mtConfirmation,[mbYes,mbno],0) = mrYes then
  begin
    ExQry(Q1,'UPDATE shippment SET stts="Shipped" WHERE id="'+sg.Cells[5,sg.Row]+'"',False);

    sg1Click(Sender);

    LoadWO('WHERE d.shipped=false');
  end;
end;

procedure TFDataPOMonitoring.EPencarianKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LoadWO('WHERE (s.no_sales_order LIKE "%'+EPencarian.Text+'%" OR '+
  ' s.nomer_container LIKE "%'+EPencarian.Text+'%" '+
  ' OR i.description LIKE "%'+EPencarian.Text+'%" )');
end;

procedure TFDataPOMonitoring.FormCreate(Sender: TObject);
begin
  FDataPOMonitoring  := Self;

end;



procedure TFDataPOMonitoring.FormShow(Sender: TObject);
begin
  GridProsess;
  LoadWO('WHERE d.shipped=false ');

end;

procedure TFDataPOMonitoring.GridProsess;
begin
  with sg do begin

    ClearAll;
    ColCount := 6;
    RowCount := 2;
    FixedRows := 1;
    FixedCols := 0;

    Cells[0,0] := 'Tgl';
    Cells[1,0] := 'Nomer';
    Cells[2,0] := 'Qty';
    Cells[3,0] := 'Cbm';
    Cells[4,0] := 'Status';
    Cells[5,0] := 'id';


    ColWidths[0] := 70;
    ColWidths[1] := 60;
    ColWidths[2] := 50;
    ColWidths[3] := 80;
    ColWidths[4] := 80;
    ColWidths[5] := 0;

    ColumnSize.StretchColumn := 4;
    ColumnSize.Stretch       := True;
  end;
end;


procedure TFDataPOMonitoring.GridSO;
begin
  with sg1 do begin
    ClearAll;

    ColCount   := 18;
    RowCount   := 3;
    FixedRows  := 2;
    FixedCols  := 0;

    Cells[0,0] := 'No';
    Cells[1,0] := 'Container';
    Cells[2,0] := 'SO No';
    Cells[3,0] := 'Description';
    Cells[4,0] := 'Box Dimension';
    Cells[4,1] := 'W';
    Cells[5,1] := 'D';
    Cells[6,1] := 'H';
    Cells[7,0] := 'Quantity';
    Cells[7,1] := 'Ordered';
    Cells[8,1] := 'Shipped';
    Cells[9,1] := 'Balance';
    Cells[10,1]:= 'Planed';
    Cells[11,1]:= 'Ready';
    Cells[12,1]:= 'Packing';
    Cells[13,1] := 'Unlocated';
    Cells[14,0]:= 'Status';
    Cells[15,0]:= 'idwo';
    Cells[16,0]:= 'itemno';
    Cells[17,0]:= 'itemid';

    ColWidths[0] := 30;
    ColWidths[1] := 80;
    ColWidths[2] := 90;
    ColWidths[3] := 150;
    ColWidths[4] := 30;
    ColWidths[5] := 30;
    ColWidths[6] := 30;
    ColWidths[7] := 50;
    ColWidths[8] := 50;
    ColWidths[9] := 50;
    ColWidths[10]:= 50;
    ColWidths[11]:= 50;
    ColWidths[12]:= 50;
    ColWidths[13]:= 50;
    ColWidths[14]:= 0;
    ColWidths[15]:= 0;
    ColWidths[16]:= 0;
    ColWidths[17]:= 0;

    MergeCells(0,0,1,2);
    MergeCells(1,0,1,2);
    MergeCells(2,0,1,2);
    MergeCells(3,0,1,2);
    MergeCells(4,0,3,1);
    MergeCells(7,0,7,1);

    ColumnSize.StretchColumn := 3;
    ColumnSize.Stretch       := True;

  end;
end;


function toStr(v : Integer) : String;
begin
  if v > 0 then
     Result := FloatToStr(v) else
     Result := '';
end;
procedure TFDataPOMonitoring.LoadWO(Filter:String);
var
  i , QtyReady , QtyPacking , QtyShipped,QtyPlanned,QtyReadyToPacking : integer;
begin
  GridSO;

  ExQry(Q1, ' SELECT             '+
             '  s.nomer_container,         '+
             '  i.itemno,       '+
             '  i.dim_width,       '+
             '  i.dim_depth,       '+
             '  i.dim_height,       '+
             '  i.description,       '+
             '  s.no_sales_order,         '+
             '  d.jumlah,      '+
             '  d.item_id,        '+
             '  s.id          '+
             ' FROM               '+
             '  sales_order s LEFT JOIN detail_sales_order d on s.no_input=d.no_input  '+
             ' LEFT JOIN item i ON i.id=d.item_id '+Filter+' ',True);

  i := 0;
  sg1.RowCount := Q1.RecordCount + 3;

  while not Q1.Eof  do begin
    with sg1 do begin
      Cells[0,i+2] := IntToStr(i+1);
      Cells[1,i+2] := GetVal(Q1,'nomer_container');
      Cells[2,i+2] := GetVal(Q1,'no_sales_order');
      Cells[3,i+2] := GetVal(Q1,'description');
      Cells[4,i+2] := GetVal(Q1,'dim_width');
      Cells[5,i+2] := GetVal(Q1,'dim_depth');
      Cells[6,i+2] := GetVal(Q1,'dim_height');
      Cells[7,i+2] := GetVal(Q1,'jumlah');
      ExQry(Q2,'SELECT fc_qtyreadypacking("'+GetVal(Q1,'item_id')+'","'+GetVal(Q1,'no_sales_order')+'","'+GetVal(Q1,'nomer_container')+'") as qtyFinish',True);
      qtyReady := GetValInt(Q2,'qtyFinish');
      ExQry(Q2,'SELECT fc_qtypacking("'+GetVal(Q1,'nomer_container')+'","'+GetVal(Q1,'no_sales_order')+'","'+GetVal(Q1,'item_id')+'") as qtyPacking',True);
      QtyPacking := GetValInt(Q2,'qtyPacking');
      ExQry(Q2,'SELECT fc_qtyShipped("'+GetVal(Q1,'nomer_container')+'","'+GetVal(Q1,'no_sales_order')+'","'+GetVal(Q1,'item_id')+'") as QtyShipped',True);
      QtyShipped := GetValInt(Q2,'QtyShipped');
      ExQry(Q2,'SELECT fc_qty_planed("'+GetVal(Q1,'item_id')+'","'+GetVal(Q1,'no_sales_order')+'","'+GetVal(Q1,'nomer_container')+'") as QtyPlanned',True);
      QtyPlanned := GetValInt(Q2,'QtyPlanned');
      ExQry(Q2,'SELECT fc_qty_to_container("'+GetVal(Q1,'item_id')+'","'+GetVal(Q1,'no_sales_order')+'","'+GetVal(Q1,'nomer_container')+'") as QtyToContainer',True);
      QtyReadyToPacking := GetValInt(Q2,'QtyToContainer');
      Cells[8,i+2] := toStr(QtyShipped);
      Cells[9,i+2] := toStr(StrToIntDef(nilai(Cells[7,i+2]),0)-StrToIntDef(nilai(Cells[8,i+2]),0));
      Cells[10,i+2] := toStr(QtyPlanned);
      Cells[11,i+2] := toStr(QtyReadyToPacking);
      Cells[12,i+2] := toStr(QtyPacking);
      Cells[13,i+2] := toStr(QtyReady - QtyPacking - QtyShipped - QtyPlanned - QtyReadyToPacking );
      Cells[14,i+2] := '';
      Cells[15,i+2] := GetVal(Q1,'id');
      Cells[16,i+2] := GetVal(Q1,'itemno');
      Cells[17,i+2] := GetVal(Q1,'item_id');
    end;
    Inc(i);
    Q1.Next;
  end;
end;

procedure TFDataPOMonitoring.rbContainerClick(Sender: TObject);
begin
    LoadWO('WHERE d.shipped=false ORDER BY s.nomer_container ASC');
end;

procedure TFDataPOMonitoring.rbSOClick(Sender: TObject);
begin
  LoadWO('WHERE d.shipped=false ORDER BY s.no_sales_order ASC');
end;

procedure TFDataPOMonitoring.sg1Click(Sender: TObject);
var
  i , x: integer;
  ItemNo : String;
begin

  GridProsess;
  ItemNo    := sg1.Cells[17,sg1.Row];

  ExQry(Q1,'SELECT                        '+
             '   sp.tgl,                    '+
             '   sp.no_urut,                '+
             '   sp.qty_packing,            '+
             '   sp.cbm,                    '+
             '   sp.stts,                    '+
             '   sp.id                    '+
             ' FROM                         '+
             '   shippment sp                 '+
             ' WHERE sp.no_so = "'+sg1.Cells[2,sg1.Row]+'"     '+
             '   AND sp.nomer_container = "'+sg1.Cells[1,sg1.Row]+'" '+
             '   AND sp.item_id = "'+ItemNo+'" ',True);

  sg.RowCount := Q1.RecordCount + 2;
  for I := 0 to Q1.RecordCount -1 do begin
    sg.Cells[0,i+1] := GetVal(Q1,'tgl');
    sg.Cells[1,i+1] := GetVal(Q1,'no_urut');
    sg.Cells[2,i+1] := GetVal(Q1,'qty_packing');
    sg.Cells[3,i+1] := Format('%.2n',[GetValF(Q1,'cbm')]);
    sg.Cells[4,i+1] := GetVal(Q1,'stts');
    sg.Cells[5,i+1] := GetVal(Q1,'id');

    if GetVal(Q1,'stts') = 'Shipped' then begin
       for x := 0 to sg.ColCount -1 do
       begin
         sg.Colors[x,i+1] := $32CD32;
         sg.ColorsTo[x,i+1] := $32CD32;
       end;

    end;
    Q1.Next;
  end;


end;

end.
