unit uSettingComponentProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, MemDS, DBAccess, MyAccess;
type
  TFSettingComponentProduct = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LItemNo: TLabel;
    Lproduct: TLabel;
    Label8: TLabel;
    PopupMenu1: TPopupMenu;
    InsertRow1: TMenuItem;
    DeleteRow1: TMenuItem;
    Q1: TMyQuery;
    Q2: TMyQuery;
    GroupBox1: TGroupBox;
    AdvGroupBox2: TAdvGroupBox;
    sg: TAdvStringGrid;
    AdvGroupBox3: TAdvGroupBox;
    sgCost: TAdvStringGrid;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btnComponent: TAdvSmoothButton;
    AdvSmoothPanel4: TAdvSmoothPanel;
    AdvSmoothButton1: TAdvSmoothButton;
    Label6: TLabel;
    Label9: TLabel;
    Lnamacomponent: TLabel;
    Lcomponentid: TLabel;
    Q3: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnComponentClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InsertRow1Click(Sender: TObject);
    procedure DeleteRow1Click(Sender: TObject);
    procedure sgClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure sgCostExit(Sender: TObject);
    procedure sgCostGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgCostKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private



    procedure TampilanAwal;
    procedure GridProses;
    procedure GridCostComponent;
    procedure LoadProcess;
    procedure LoadData(ItemNo:String);



    { Private declarations }
  public
    procedure upDateNumber;
    function checkDivisi(idDivisi:String):Boolean;

    { Public declarations }
  end;

var
  FSettingComponentProduct: TFSettingComponentProduct;


implementation
 uses
    uDataJobs, uListOfDivisi, uMarCon, uListOfComponent, uLoading,
  uListOfDiviComponent;


{$R *.dfm}

{ TFInputSupplier }

procedure TFSettingComponentProduct.AdvSmoothButton1Click(Sender: TObject);
begin
  if Lcomponentid.Caption = '' then begin
     Error('Component Belum dipilih');
     Exit;
  end else
  FDaftarDivisiComponent.ShowModal;
end;

procedure TFSettingComponentProduct.btnComponentClick(Sender: TObject);
begin
  FDaftarComponent.ShowModal;
end;

procedure TFSettingComponentProduct.btnSimpanClick(Sender: TObject);
var
  item_id , i ,j: Integer;
  material_component_id , idPekerjaan: integer;
  Cost : Real;
  M3,M2,MLR,MLRLEBAR : Real;
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin

       ls := TStringList.Create;
       try
           ExQry(Q1,'DELETE FROM material_product WHERE itemno="'+LItemNo.Caption+'"',False);
           ExQry(Q1,'DELETE FROM process_component WHERE itemno="'+LItemNo.Caption+'"',False);

           item_id := StrToInt(GetData(Q2,'item WHERE itemno="'+FSettingComponentProduct.LItemNo.Caption+'"','id'));
           Cost := 0;
           for i := 2 to sg.RowCount -1 do begin
              if sg.Cells[1,i] <> '' then begin

                 AddParam('itemno',  LItemNo.Caption,ls,'str');
                 AddParam('component_id', sg.Cells[11,i],ls,'str');
                 AddParam('nama',    sg.Cells[1,i],ls,'str');
                 AddParam('jumlah',     StrToDecimal(sg.Cells[2,i]),ls,'str');
                 AddParam('tinggi',   StrToDecimal(sg.Cells[3,i]),ls,'str');
                 AddParam('lebar',    StrToDecimal(sg.Cells[4,i]),ls,'str');
                 AddParam('panjang',  StrToDecimal(sg.Cells[5,i]),ls,'str');
                 AddParam('ket',     sg.Cells[6,i],ls,'str');
                 AddParam('m3',       StrToDecimal(sg.Cells[7,i]),ls,'str');
                 AddParam('m2',       StrToDecimal(sg.Cells[8,i]),ls,'str');
                 AddParam('mlr',      StrToDecimal(sg.Cells[9,i]),ls,'str');
                 AddParam('mlrlebar', StrToDecimal(sg.Cells[10,i]),ls,'str');
                 ExeDB(Q2,'material_product',ls);


                 M3                     := CellF(sg.Cells[7,i]);
                 M2                     := CellF(sg.Cells[8,i]);
                 MLR                    := CellF(sg.Cells[9,i]);
                 MLRLEBAR               := CellF(sg.Cells[10,i]);


              end;
           end;

           ExQry(Q1,'SELECT * FROM temp_cost_component',True);

           while not Q1.Eof do begin

             addParam('item_id', GetVal(Q1,'item_id'), ls,'str');
             addParam('itemno', LItemNo.Caption, ls,'str');
             addParam('component_id', GetVal(Q1,'component_id'), ls,'str');
             addParam('idpekerjaan', GetVal(Q1,'idpekerjaan'), ls,'str');

             addParam('cost', StrTODecimal(GetVal(Q1,'cost')), ls,'str');
             ExeDB(Q2,'process_component',ls);
             Q1.Next;
             end;


             ExQry(Q1,'DELETE FROM temp_cost_component',False);
           Informasi('Setting Process Berhasil Disimpan');
           TampilanAwal;
       finally
         ls.free;
       end;


  end;
end;

procedure TFSettingComponentProduct.btnTutupClick(Sender: TObject);
begin
  Close;
end;


function TFSettingComponentProduct.checkDivisi(idDivisi:String): Boolean;
var
  i : integer;
begin
  Result := False;

  for i := 1 to sg.RowCount -1 do begin
     if sg.Cells[3,i] <> '' then begin
        if sg.Cells[3,i] = idDivisi then
        begin
          Result := True;
          Break;
        end;

     end;

  end;

end;

procedure TFSettingComponentProduct.DeleteRow1Click(Sender: TObject);
var
  i : integer;
begin
  sg.RemoveRows(sg.Row,1);
  for i := sg.Row to sg.RowCount -1 do
    sg.MoveRow(sg.Row+1,sg.Row);
  upDateNumber;
end;

procedure TFSettingComponentProduct.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ExQry(Q2,'DELETE FROM temp_cost_component',False);
end;

procedure TFSettingComponentProduct.FormCreate(Sender: TObject);
begin
  GridProses;
end;

procedure TFSettingComponentProduct.FormShow(Sender: TObject);
begin


  TampilanAwal;
end;

procedure TFSettingComponentProduct.GridCostComponent;
begin
  with sgCost do begin

    ClearAll;

    ColCount  := 5;
    RowCount  := 2;

    Cells[0,0] := 'No';
    Cells[1,0] := 'Divisi';
    Cells[2,0] := 'Pekerjaan';
    Cells[3,0] := 'Biaya';
    Cells[4,0] := 'idpekerjaan';


    ColWidths[0] := 50;
    ColWidths[1] := 150;
    ColWidths[2] := 100;
    ColWidths[3] := 80;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;

  end;
end;

procedure TFSettingComponentProduct.GridProses;
begin
  with sg do begin

    ClearAll;

    ColCount  := 12;
    RowCount  := 3;
    FixedCols := 2;
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
    Cells[11,0] := 'ID';

    ColWidths[0] := 50;
    ColWidths[1] := 300;
    ColWidths[2] := 30;
    ColWidths[3] := 30;
    ColWidths[4] := 30;
    ColWidths[5] := 30;
    ColWidths[6] := 80;
    ColWidths[7] := 60;
    ColWidths[8] := 40;
    ColWidths[9] := 40;
    ColWidths[10] := 80;
    ColWidths[11] := 0;

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

  end;
end;



procedure TFSettingComponentProduct.InsertRow1Click(Sender: TObject);
begin
  sg.InsertRows(sg.Row + 1,1);
  sg.Row := sg.Row + 1;
  upDateNumber;
  FDaftarComponent.ShowModal;
end;

procedure TFSettingComponentProduct.LoadData(ItemNo: String);
var
  i , j , idPekerjaan : integer;
  item_id : integer;
begin
  ExQry(Q1,getSQL('ComponentProduct')+' WHERE mp.itemno="'+ItemNo+'"',True);
  ExQry(Q2,'SELECT id FROM item WHERE itemno="'+ItemNo+'"',True);
  item_id := GetValInt(Q2,'id');
  Floading.pgbar.Maximum := Q1.RecordCount;
  Floading.Lprocess.Caption := 'Retrive Data Process Component ....';
  FLoading.pgbar.Position := 1;
  sg.RowCount := Q1.RecordCount + 3;
  for I := 0 to Q1.RecordCount -1 do begin
     sg.Cells[0,i+2] := IntToStr(i+1);
     sg.Cells[1,i+2] := GetVal(Q1,'nama');
     sg.Cells[2,i+2] := GetVal(Q1,'jumlah');
     sg.Cells[3,i+2] := GetVal(Q1,'tinggi');
     sg.Cells[4,i+2] := GetVal(Q1,'lebar');
     sg.Cells[5,i+2] := GetVal(Q1,'panjang');
     sg.Cells[6,i+2] := GetVal(Q1,'ket');
     sg.Cells[7,i+2] := GetVal(Q1,'m3');
     sg.Cells[8,i+2] := GetVal(Q1,'m2');
     sg.Cells[9,i+2] := GetVal(Q1,'mlr');
     sg.Cells[10,i+2] := GetVal(Q1,'mlrlebar');
     sg.Cells[11,i+2] := GetVal(Q1,'component_id');


     ExQry(Q2,'SELECT * FROM process_component '+
     ' WHERE component_id="'+GetVal(Q1,'component_id')+'" '+
     ' AND item_id="'+IntToStr(item_id)+'" ',True);

     while not Q2.Eof do begin
       ExQry(Q3,'INSERT INTO temp_cost_component(item_id,component_id,idpekerjaan,cost) '+
       ' VALUES ("'+IntToStr(item_id)+'","'+GetVal(Q1,'component_id')+'", '+
       ' "'+GetVal(Q2,'idpekerjaan')+'" , "'+GetVal(Q2,'cost')+'" )',False);

       Q2.Next;

     end;
     Q1.Next;
     Floading.pgbar.Position := i;
     Application.ProcessMessages;
  end;
  sg.Row := sg.RowCount -1;
  Floading.pgbar.Position := Q1.RecordCount;


end;

procedure TFSettingComponentProduct.LoadProcess;
var
  i  ,IndexCol,JmlMerge,Posisi: integer;
  Group : String;
begin
  ExQry(Q1,'SELECT d.name,p.deskripsi FROM pekerjaan p LEFT JOIN divisi d ON d.id=p.id_divisi',True);

  JmlMerge := 0;
  Floading.pgbar.Maximum := Q1.RecordCount;
  Floading.Lprocess.Caption := 'Retrive Data Pekerjaan .....';
  Floading.pgbar.Position := 1;
  for i := 0 to Q1.RecordCount -1 do begin
     sg.Cells[10+i+1,0] := GetVal(Q1,'name');
     sg.Cells[10+i+1,1] := GetVal(Q1,'deskripsi');
     sg.ColCount        := sg.ColCount + 1;
     sg.Col             := sg.ColCount -1;
     sg.ColWidths[10+i+1] := 100;
     Group := sg.Cells[10+i,0];
     if Group <>  GetVal(Q1,'name') then
     IndexCol := 1 else IndexCol := 0;

     if IndexCol = 0 then JmlMerge := JmlMerge + 1 else JmlMerge := 0;

     if IndexCol = 1 then
        Posisi :=  sg.ColCount -1;
        sg.MergeCells(Posisi,0,(Posisi+JmlMerge+1)-Posisi,1);


     Q1.Next;
     Application.ProcessMessages;
     Floading.pgbar.Position := i;


  end;
  Floading.pgbar.Position := Q1.RecordCount;

  sg.Col := 2;
  sg.Row := 2;
end;

procedure TFSettingComponentProduct.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
    CanEdit := ACol >= 2;
end;

procedure TFSettingComponentProduct.sgClick(Sender: TObject);
var
  i : integer;
  item_id : integer;
begin

  Lnamacomponent.Caption := sg.Cells[1,sg.Row];
  Lcomponentid.Caption   := sg.Cells[11,sg.Row];
  ExQry(Q2,'SELECT id FROM item WHERE itemno="'+LItemNo.Caption+'"',True);
  item_id := GetValInt(Q2,'id');

  ExQry(Q1,'SELECT p.component_id,p.item_id,p.idpekerjaan,p.cost,'+
  ' pk.deskripsi,d.name FROM temp_cost_component p '+
  ' LEFT JOIN pekerjaan pk ON pk.id=p.idpekerjaan LEFT JOIN divisi d '+
  ' ON d.id=pk.id_divisi WHERE p.component_id="'+Lcomponentid.Caption+'" '+
  ' AND p.item_id="'+IntToStr(item_id)+'" ',True);

  i := 1;

  sgCost.RowCount := 2;
  if Q1.IsEmpty = false then begin

      while not Q1.Eof do begin
         sgCost.Cells[0,i] := IntToStr(i);
         sgCost.Cells[1,i] := GetVal(Q1,'name');
         sgCost.Cells[2,i] := GetVal(Q1,'deskripsi');
         sgCost.Cells[3,i] := GetValR(Q1,'cost');
         sgCost.Cells[4,i] := GetValR(Q1,'idpekerjaan');
         sgCost.RowCount   := sgCost.RowCount + 1;
         Inc(i);
         Q1.Next;
      end;
  end else
  GridCostComponent;
end;

procedure TFSettingComponentProduct.sgCostExit(Sender: TObject);
var
  i : integer;
  Item_id : integer;
begin
  item_id := StrToInt(GetData(Q2,'item WHERE itemno="'+FSettingComponentProduct.LItemNo.Caption+'"','id'));
  for i := 1 to sgCost.RowCount -1 do begin
     if sgCost.Cells[3,i] <> '' then begin
        ExQry(Q2,'SELECT * FROM temp_cost_component WHERE '+
        ' item_id="'+IntToStr(Item_id)+'" AND '+
        ' component_id="'+Lcomponentid.Caption+'" '+
        ' AND idpekerjaan="'+sgCost.Cells[4,i]+'"',True );

        if Q2.IsEmpty then begin
           ExQry(Q1,'INSERT INTO temp_cost_component (item_id,component_id,idpekerjaan,cost) '+
              ' VALUES ("'+IntToStr(item_id)+'","'+Lcomponentid.Caption+'",'+
              '"'+StrToDecimal(sgCost.Cells[3,i])+'","'+sgCost.Cells[4,i]+'")',False);

        end else begin
           ExQry(Q1,'UPDATE temp_cost_component SET '+
           ' cost="'+StrTODecimal(sgCost.Cells[3,i])+'" '+
           ' WHERE item_id="'+IntToStr(Item_id)+'" '+
           ' AND component_id="'+Lcomponentid.Caption+'" '+
           ' AND idpekerjaan="'+sgCost.Cells[4,i]+'" ',False);
        end;

     end;

  end;

end;

procedure TFSettingComponentProduct.sgCostGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  IsFloat := ACol = 3;
  FloatFormat := '%.0n';
end;

procedure TFSettingComponentProduct.sgCostKeyUp(Sender: TObject; var Key: Word;

  Shift: TShiftState);
 var
    i ,item_id: integer;
begin
  if Key = 13 then begin
     if sgCost.Col <= sgCost.ColCount - 2 then
     begin
       sgCost.Col := sgCost.Col + 1;
     end else
     begin
       sgCost.Row := sgCost.Row + 1;
       sgCost.Col := 2;
     end;

  end else if Key = VK_DELETE then begin
      item_id := StrToInt(GetData(Q2,'item WHERE itemno="'+FSettingComponentProduct.LItemNo.Caption+'"','id'));
      ExQry(Q1,'DELETE FROM temp_cost_component WHERE item_id="'+IntToStr(item_id)+'" '+
      ' AND component_id="'+Lcomponentid.Caption+'" '+
      ' AND idpekerjaan="'+sgCost.Cells[4,sgCost.Row]+'"',False);
      sgCost.ClearRows(sgCost.Row,1);
      for I := sgCost.Row to sgCost.RowCount - 1 do
      sgCost.MoveRow(I + 1, i);

      sgCost.RowCount := sgCost.RowCount - 1;
      for i := 1 to sgCost.RowCount -1 do begin
        sgCost.Cells[0,i] := '';
        if sgCost.Cells[1,i] <>'' then

        sgCost.Cells[0,i] := IntToStr(i);
      end;

  end;

  end;

procedure TFSettingComponentProduct.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFSettingComponentProduct.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 3 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFSettingComponentProduct.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    i : integer;
begin
  if Key = 13 then begin
     if sg.Col <= sg.ColCount - 2 then
     begin
       sg.Col := sg.Col + 1;
     end else
     begin
       sg.Row := sg.Row + 1;
       sg.Col := 2;
     end;

  end else if Key = VK_DELETE then begin
      sg.ClearRows(sg.Row,1);
      for I := sg.Row to sg.RowCount - 1 do
      sg.MoveRow(I + 1, i);
      sg.RowCount := sg.RowCount - 1;

  end;
end;

procedure TFSettingComponentProduct.sgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    t , l , p ,qty,M3,M2,MLR,MLRLEBAR: Real;
begin
  if sg.Col in [3,4,5] then begin

     t    := StrToFloatDef(sg.Cells[3,sg.Row],0);
     l    := StrToFloatDef(sg.Cells[4,sg.Row],0);
     p    := StrToFloatDef(sg.Cells[5,sg.Row],0);
     qty  := StrToFloatDef(sg.Cells[2,sg.Row],0);

     M3                  := t * l * p* qty / 1000000000;
     M2                  := l * p * qty / 1000000;
     MLR                 := p * qty / 1000;
     MLRLEBAR            := l * qty / 1000;
     sg.Cells[7,sg.Row]  := Format('%.4n',[M3]);
     sg.Cells[8,sg.Row]  := Format('%.4n',[M2]);
     sg.Cells[9,sg.Row]  := Format('%.4n',[MLR]);
     sg.Cells[10,sg.Row] := Format('%.4n',[MLRLEBAR]);
  
  end;
end;

procedure TFSettingComponentProduct.TampilanAwal;
begin
  ClearText(Self);

  GridProses;
  Floading.Show;
  GridCostComponent;
  LoadData(LItemNo.Caption);
  Floading.Close;

end;

procedure TFSettingComponentProduct.upDateNumber;
var
  i : integer;
begin
  for i := 2 to sg.RowCount -1 do begin
     sg.Cells[0,i] := IntToStr(i-1);

  end;

end;

end.
