unit uDataTableCostingProduk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet,
  Vcl.ComCtrls, AdvPageControl, AdvScrollBox, MemDS, DBAccess, MyAccess;

type
  TFDataTableCostingProduct = class(TForm)
    Label1: TLabel;
    P1: TAdvSmoothPanel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGridExcelIO1: TAdvGridExcelIO;
    Label2: TLabel;
    EitemNo: TAdvEdit;
    btnFind: TAdvSmoothButton;
    ENamaProduk: TAdvEdit;
    pg: TAdvPageControl;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    Q4: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure pgChange(Sender: TObject);
  private
    { Private declarations }

    procedure LoadData(TabSheedIndex:Integer;ItemNo:String);


  public
    procedure LoadDivisi;
    procedure LoadProcess(sga:TAdvStringGrid;IdDivisi : String;IndexRow:Integer);
    { Public declarations }


  end;



var
  FDataTableCostingProduct: TFDataTableCostingProduct;

implementation

{$R *.dfm}

uses  uInputBom, uMainMenu, uMarCon, uDaftarBarangCosting, uFrameDataCosting;




procedure TFDataTableCostingProduct.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data BOM.xls');
end;

procedure TFDataTableCostingProduct.btnFindClick(Sender: TObject);
begin
  FDaftarBarangCosting.ShowModal;
end;

procedure TFDataTableCostingProduct.FormCreate(Sender: TObject);
begin
  FDataTableCostingProduct := Self;

end;

procedure TFDataTableCostingProduct.LoadData(TabSheedIndex: Integer;ItemNo:String);
var
  CompName      : String;
  FDataCosting  : TFrameDataCosting;
  I,x             : Integer;
  idDivisi      : Integer;
  SumCosting         : Real;
  SumBiayaMesin      : Real;
  SubTotalCosting    : Real;
begin
  CompName := StringReplace(pg.Pages[TabSheedIndex].Caption,' ','',[rfReplaceAll]);
  CompName := StringReplace(CompName,'&','',[rfReplaceAll]);

  if pg.Pages[TabSheedIndex].FindComponent(CompName) = nil then begin
     FDataCosting         := TFrameDataCosting.Create(pg.Pages[TabSheedIndex]);
     FDataCosting.Align   := alClient;
     FDataCosting.Parent  := pg.Pages[TabSheedIndex];
     FDataCosting.Name    := CompName;

     with FDataCosting.sg do begin
        ClearAll;

        ColCount  := 11;
        RowCount  := 4;
        FixedCols := 0;
        FixedRows := 2;

        Cells[0,0] := 'No';
        Cells[1,0] := 'Nama Komponen';
        Cells[2,0] := 'Qty';
        Cells[3,0] := 'T';
        Cells[4,0] := 'L';
        Cells[5,0] := 'P';
        Cells[6,0] := 'Ket';
        Cells[7,0] := 'M3';
        Cells[8,0] := 'M2';
        Cells[9,0] := 'MLR';
        Cells[10,0] := 'MLR LEBAR';

        ColWidths[0] := 50;
        ColWidths[1] := 150;
        ColWidths[2] := 30;
        ColWidths[3] := 30;
        ColWidths[4] := 30;
        ColWidths[5] := 30;
        ColWidths[6] := 80;
        ColWidths[7] := 60;
        ColWidths[8] := 40;
        ColWidths[9] := 40;
        ColWidths[10] := 80;

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
        MergeCells(10,0,1,2);



          idDivisi  := StrToInt(GetData(Q1,'divisi WHERE name="'+pg.Pages[TabSheedIndex].Caption+'"','id'));

          ExQry(Q1,getSQL('ComponentCosting')+' WHERE mp.itemno="'+ItemNo+'" AND '+
                       ' d.id="'+IntToStr(IdDivisi)+'" AND pc.jumlah > 0 GROUP BY    '+
                       ' pc.material_component_id ',True);

          FDataCosting.sg.RowCount := Q1.RecordCount + 6;
          FDataCosting.sg.FixedFooters           := 3;


          for I := 0 to Q1.RecordCount -1 do begin
            Cells[0,i+2] := IntToStr(i+1);
            Cells[1,i+2] := GetVal(Q1,'nama');
            Cells[2,i+2] := GetVal(Q1,'jumlah');
            Cells[3,i+2] := GetVal(Q1,'tinggi');
            Cells[4,i+2] := GetVal(Q1,'lebar');
            Cells[5,i+2] := GetVal(Q1,'panjang');
            Cells[6,i+2] := GetVal(Q1,'ket');
            Cells[7,i+2] := GetVal(Q1,'m3');
            Cells[8,i+2] := GetVal(Q1,'m2');
            Cells[9,i+2] := GetVal(Q1,'mlr');
            Cells[10,i+2] := GetVal(Q1,'mlrlebar');
            LoadProcess(FDataCosting.sg,IntToStr(idDivisi),i+2);
            SumCosting  := 0;
            for x := 0 to ColCount -1 do begin
                if (x >= 11) and (x < ColCount -1) then
                   SumCosting := SumCosting + CellF(Cells[x,i+2]);
            end;
            Cells[ColCount -1,i+2]            := Format('%.2n',[SumCosting]);


            Q1.Next;
          end;
          SubTotalCosting := 0;
          for x := 3 to RowCount - 3 do
             SubTotalCosting := SubTotalCosting + CellF(Cells[ColCount-1,x]);


          SumBiayaMesin := 0;
          for i := 11 to ColCount -2 do
             SumBiayaMesin := SumBiayaMesin + CellF(Cells[i,RowCount -2]);



          Cells[ColCount -1,RowCount-3]      := Format('%.2n',[SubTotalCosting]);
          Cells[ColCount -1,RowCount-2]      := Format('%.2n',[SumBiayaMesin]);
          Cells[ColCount -1,RowCount-1]      := Format('%.2n',[SumBiayaMesin + SubTotalCosting]);


     end;
  end;

end;

procedure TFDataTableCostingProduct.LoadDivisi;
var
  i : Integer;
  TabSheet : TAdvTabSheet;
begin
  ExQry(Q1,'select                                      '+
               '         pc.itemno,                         '+
               '         d.name,                            '+
               '         pc.jumlah                          '+
               '       FROM                                 '+
               '         process_component pc               '+
               '         left join pekerjaan p              '+
               '           on pc.`idpekerjaan` = p.`id`     '+
               '         left join divisi d                 '+
               '           on d.`id` = p.`id_divisi`        '+
               '       WHERE pc.jumlah > 0 AND              '+
               '         pc.itemno="'+EitemNo.Text+'"       '+
               '       GROUP BY d.`id` ',True);

    for i := pg.PageCount - 1 Downto 0  do
      pg.Pages[i].Destroy;

    for i := 0 to Q1.RecordCount-1 do begin
       TabSheet                 := TAdvTabSheet.Create(pg);
       TabSheet.Width           := 200;
       TabSheet.Caption         := UPPERCASE(GetVal(Q1,'name'));
       TabSheet.AdvPageControl  := pg;
      // LoadData(i);
       Q1.Next;

    end;

end;

procedure TFDataTableCostingProduct.LoadProcess(sga:TAdvStringGrid;IdDivisi : String;IndexRow:Integer);
var
  i : integer;
  Biaya              : Real;
  BiayaSetMesin      : Real;

begin
  
  Q2.Close;
  Q2.SQL.Text :=  ' SELECT p.id,p.satuan,p.biaya,p.biaya_set_mesin,p.koef,d.name,p.deskripsi FROM pekerjaan p '+
                  ' LEFT JOIN divisi d ON d.id=p.id_divisi '+
                  ' WHERE p.id_divisi="'+IdDivisi+'"';
  Q2.Open;

  Q3.Close;
  Q3.SQL.Text := ' SELECT SUM(jumlah) FROM process_component WHERE idpekerjaan="'+GetVal(Q2,'id')+'" '+
                 ' AND itemno="'+EitemNo.Text+'"';
  Q3.Open;


  sga.ColCount := 11;
  sga.ColCount := sga.ColCount + Q2.RecordCount +1;
  sga.Cells[1,sga.RowCount-3] := 'SUBTOTAL';
  sga.Cells[1,sga.RowCount-2] := 'BIAYA SET MESIN';
  sga.Cells[1,sga.RowCount-1] := 'TOTAL';
  BiayaSetMesin               := Q3.Fields[0].AsFloat;
  for i := 0 to Q2.RecordCount -1 do begin
     sga.Cells[10+i+1,0]    := GetVal(Q2,'deskripsi');
     sga.Col                := sga.ColCount -1;
     sga.ColWidths[10+i+1]  := 100;

     Q4.Close;
     Q4.SQL.Text := ' SELECT m.nama,pc.idpekerjaan,pc.jumlah,pc.itemno,pc.cost, '+
                    ' pc.biaya_set_mesin FROM process_component pc '+
                    ' LEFT JOIN material_product m ON pc.material_component_id=m.id '+
                    ' WHERE pc.idpekerjaan="'+GetVal(Q2,'id')+'" '+
                    ' AND pc.itemno="'+EitemNo.Text+'" '+
                    ' AND m.nama="'+sga.Cells[1,IndexRow]+'" ';
     Q4.Open;


     Biaya                            := GetValInt(Q4,'cost');
     sga.Cells[10+i+1,IndexRow]       := Format('%.2n',[Biaya]);
     sga.Cells[10+i+1,sga.RowCount-2] := Format('%.2n',[BiayaSetMesin * GetValF(Q2,'biaya_set_mesin')]);

     Q2.Next;
     sga.MergeCells(10+i+1,0,1,2);
  end;
  sga.Cells[sga.ColCount -1,0] := 'TOTAL COSTING';
  sga.MergeCells(sga.ColCount -1,0,1,2);

  


end;

procedure TFDataTableCostingProduct.pgChange(Sender: TObject);
begin
  LoadData(pg.ActivePageIndex,EitemNo.Text);
end;

end.
