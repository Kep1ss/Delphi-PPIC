unit uInputBom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, AdvSmoothListBox, Vcl.ToolWin,
  MemDS, DBAccess, MyAccess;
type
  TFinputBom = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Enomer: TAdvEdit;
    Enama: TAdvEdit;
    Eitemno: TAdvEdit;
    Enamabarang: TAdvEdit;
    AdvSmoothButton2: TAdvSmoothButton;
    Pg: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    sgMaterial: TAdvStringGrid;
    sgPekerjaan: TAdvStringGrid;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btnTutup: TAdvSmoothButton;
    btnSimpan: TAdvSmoothButton;
    Bevel1: TBevel;
    Label6: TLabel;
    LtotalMaterial: TLabel;
    lb1: TAdvSmoothListBox;
    AdvSmoothButton1: TAdvSmoothButton;
    Label7: TLabel;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    LtotalBiaya: TLabel;
    Label9: TLabel;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;

    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure sgMaterialCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgMaterialKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgMaterialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgMaterialGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure sgPekerjaanCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgPekerjaanKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgPekerjaanKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Lb1ItemClick(Sender: TObject; itemindex: Integer);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnTutupClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure sgPekerjaanGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure sgMaterialCellsChanged(Sender: TObject; R: TRect);
    procedure sgPekerjaanCellsChanged(Sender: TObject; R: TRect);
  private
  



    procedure SimpanBOM;
    procedure LoadMaterial(idDivisi:Integer);
    procedure LoadPekerjaan(idDivisi:Integer);


    { Private declarations }
  public
    BomNo : String;
    procedure TampilanAwal;
    procedure GridMaterial;
    procedure GridPekerjaan;
    procedure SubtotalMaterial(Row:integer);
    procedure SubtotalPekerjaan(Row:integer);
    function  TotalMaterial:Real;
    function  TotalPekerjaan:Real;


    { Public declarations }
  end;

var
  FinputBom: TFinputBom;



implementation
 uses
   uListOfProduct, uListofMaterial, uListofPekerjaan,
  uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputBom.AdvSmoothButton1Click(Sender: TObject);
begin
  {if Enama.Text = '' then
  begin
    Error('Silahkan isi keterangan BOM terlebih dahulu');
    Enama.SetFocus;
  end else begin
    FImportBom.Lbomno.Caption      := Enomer.Text;
    FImportBom.Lketerangan.Caption := Enama.Text;
    FImportBom.Lproduct.Caption    := Eitemno.Text;

    FImportBom.ShowModal;
  end;     }
end;

procedure TFinputBom.AdvSmoothButton2Click(Sender: TObject);
begin

    FDaftarBarang.isFokus :=  1;
    FDaftarBarang.ShowModal;

end;



procedure TFinputBom.AdvSmoothButton3Click(Sender: TObject);

begin
  Pg.ActivePageIndex := 0;
  FDaftarMaterial.ShowModal;

end;

procedure TFinputBom.AdvSmoothButton4Click(Sender: TObject);
begin
  Pg.ActivePageIndex := 1;
  FDaftarPekerjaan.isForm := 1;
  FDaftarPekerjaan.ShowModal;
end;

procedure TFinputBom.btnSimpanClick(Sender: TObject);
begin
  if MessageDlg('Yakin ingin menyimpan?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    SimpanBOM;
    TampilanAwal;
    Lb1.SelectedItemIndex :=  Lb1.SelectedItemIndex + 1;
    Label6.Caption      := 'Total Biaya Divisi ['+Lb1.Items[Lb1.SelectedItemIndex].Caption+'] :';

  end;
end;

procedure TFinputBom.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputBom.FormCreate(Sender: TObject);
begin
  FinputBom     := Self;

  TampilanAwal;

end;

procedure TFinputBom.FormShow(Sender: TObject);

begin

      ExQry(Q1,'SELECT * FROM divisi WHERE is_active=true',True);

      lb1.BeginUpdate;
      Lb1.Items.Clear;

      while Q1.Eof = False do begin

         with Lb1.Items.Add do begin
           Caption := GetVal(Q1,'name');
           Info    := GetVal(Q1,'id');
         end;

         Q1.Next;
      end;
      Lb1.SelectedItemIndex := 0;
      lb1.EndUpdate;



end;

procedure TFinputBom.GridMaterial;
begin
  with sgMaterial do begin
    ClearAll;
    RowCount :=  2;
    ColCount :=  9;
    FixedCols:=  0;

    Cells[0,0] := 'Item No';
    Cells[1,0] := 'Description';
    Cells[2,0] := 'Unit';
    Cells[3,0] := 'Standart Cost';
    Cells[4,0] := 'Qty';
    Cells[5,0] := 'Total Cost';
    Cells[6,0] := 'Keterangan';
    Cells[7,0] := 'idItem';
    Cells[8,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 80;
    ColWidths[3] := 120;
    ColWidths[4] := 50;
    ColWidths[5] := 120;
    ColWidths[6] := 200;
    ColWidths[7] := 0;
    ColWidths[8] := 0;

    ColumnSize.StretchColumn  := 6;
    ColumnSize.Stretch        := True;
  end;
end;

procedure TFinputBom.GridPekerjaan;
begin
  with sgPekerjaan do begin
    ClearAll;
    RowCount  :=  2;
    ColCount  :=  7;
    FixedCols :=  0;

    Cells[0,0] := 'Nama Pekerjaan';
    Cells[1,0] := 'Qty';
    Cells[2,0] := 'Unit';
    Cells[3,0] := 'Biaya';
    Cells[4,0] := 'Total Biaya';
    Cells[5,0] := 'id';
    Cells[6,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 100;
    ColWidths[3] := 200;
    ColWidths[4] := 100;
    ColWidths[5] := 0;
    ColWidths[6] := 0;

    ColumnSize.StretchColumn  := 0;
    ColumnSize.Stretch        := True;
  end;
end;

procedure TFinputBom.Lb1ItemClick(Sender: TObject; itemindex: Integer);


begin
   LoadMaterial(StrToint(Lb1.Items[Lb1.SelectedItemIndex].Info));
   LoadPekerjaan(StrToint(Lb1.Items[Lb1.SelectedItemIndex].Info));
end;

procedure TFinputBom.LoadMaterial(idDivisi: Integer);
var
  i : integer;
begin
  GridMaterial;

      ExQry(Q1,'SELECT tb.*,p.itemno,p.description FROM temp_bom_detail tb '+
                 ' LEFT JOIN item p ON p.id=tb.item_id WHERE '+
                 ' tb.id_divisi='+IntToStr(idDivisi)+' AND iduser="'+getIdUser+'"',True);

      if Q1.RecordCount > 0 then begin

          sgMaterial.RowCount := Q1.RecordCount + 2;

          for I := 0 to Q1.RecordCount -1 do begin
              sgMaterial.Cells[0,i+1] := GetVal(Q1,'itemno');
              sgMaterial.Cells[1,i+1] := GetVal(Q1,'description');
              sgMaterial.Cells[2,i+1] := GetVal(Q1,'unit');
              sgMaterial.Cells[3,i+1] := GetVal(Q1,'standart_cost');
              sgMaterial.Cells[4,i+1] := GetVal(Q1,'jumlah');
              sgMaterial.Cells[5,i+1] := GetValR(Q1,'total_biaya');
              sgMaterial.Cells[6,i+1] := GetVal(Q1,'keterangan');
              sgMaterial.Cells[7,i+1] := GetVal(Q1,'item_id');
              sgMaterial.Cells[8,i+1] := GetVal(Q1,'id');
              Q1.Next;
          end;
      end else
        GridMaterial;


  LtotalMaterial.Caption := Format('%.2n',[TotalMaterial]);
  LtotalBiaya.Caption    := Format('%.2n',[TotalPekerjaan]);

end;

procedure TFinputBom.LoadPekerjaan(idDivisi: Integer);
var
  i : integer;
begin
  GridPekerjaan;


  ExQry(Q1,'SELECT tb.*,p.deskripsi FROM temp_bom_pekerjaan tb '+
             ' LEFT JOIN pekerjaan p ON p.id=tb.id_pekerjaan WHERE '+
             ' tb.id_divisi='+IntToStr(idDivisi)+' AND iduser="'+GetIdUser+'"',True);
  if Q1.RecordCount > 0 then begin

      sgPekerjaan.RowCount := Q1.RecordCount + 2;

      for I := 0 to Q1.RecordCount -1 do begin
          sgPekerjaan.Cells[0,i+1] := GetVal(Q1,'deskripsi');
          sgPekerjaan.Cells[1,i+1] := GetValR(Q1,'jumlah');
          sgPekerjaan.Cells[2,i+1] := GetVal(Q1,'unit');
          sgPekerjaan.Cells[3,i+1] := GetValR(Q1,'biaya_standart');
          sgPekerjaan.Cells[4,i+1] := GetValR(Q1,'total_biaya');
          sgPekerjaan.Cells[5,i+1] := GetVal(Q1,'id_pekerjaan');
          sgPekerjaan.Cells[6,i+1] := GetVal(Q1,'id');
          Q1.Next;
      end;
  end else
    GridPekerjaan;
  LtotalMaterial.Caption := Format('%.2n',[TotalMaterial]);
  LtotalBiaya.Caption    := Format('%.2n',[TotalPekerjaan]);
end;

procedure TFinputBom.sgMaterialCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
    if ACol in [0,2,3,4,6] then
       CanEdit := True
    else CanEdit := False;
end;

procedure TFinputBom.sgMaterialCellsChanged(Sender: TObject; R: TRect);

var

    id  : integer;
    ls  : TStringList;
begin
    if Eitemno.Text <> '' then begin

          if sgMaterial.Col in [4,5,6] then
                  begin
                         ls := TStringList.Create;
                         try
                         if CellF(sgMaterial.Cells[4,sgMaterial.Row]) <> 0 then
                           begin


                              ExQry(Q1,'SELECT id FROM temp_bom_detail WHERE item_id="'+sgMaterial.Cells[7,sgMaterial.Row]+'" '+
                              ' AND id_divisi="'+Lb1.Items[Lb1.SelectedItemIndex].Info+'" AND iduser="'+GetIdUser+'"',True);


                              id := GetValInt(Q1,'id');
                              addParam('iduser',GetIdUser,ls,'str');
                              addParam('id_divisi',Lb1.Items[Lb1.SelectedItemIndex].Info,ls,'str');
                              addParam('item_id',sgMaterial.Cells[7,sgMaterial.Row],ls,'str');
                              addParam('keterangan',sgMaterial.Cells[6,sgMaterial.Row],ls,'str');
                              addParam('jumlah',StrToDecimal(sgMaterial.Cells[4,sgMaterial.Row]),ls,'str');
                              addParam('unit',sgMaterial.Cells[2,sgMaterial.Row],ls,'str');
                              addParam('standart_cost',StrToDecimal(sgMaterial.Cells[3,sgMaterial.Row]),ls,'str');
                              addParam('total_biaya',StrToDecimal(sgMaterial.Cells[5,sgMaterial.Row]),ls,'str');

                              if Q1.isEmpty then
                                ExeDb(Q2,'temp_bom_detail',ls)
                              else
                                UpdateDB(Q2,'temp_bom_detail',ls,'id',IntToStr(id));
                              LoadMaterial(StrToint(Lb1.Items[Lb1.SelectedItemIndex].Info));

                              sgMaterial.Row      := sgMaterial.RowCount -1;
                              sgMaterial.Col      := 0;
                           end;


                        finally
                          ls.Free;
                        end;
                  end;
    end

end;

procedure TFinputBom.sgMaterialGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  case ACol of
  4: begin
           IsFloat := True;
           FloatFormat := '%.4n';
          end;
  3,5 : begin
           IsFloat := True;
           FloatFormat := '%.2n';
          end;
  0,1,2,6,7,8 : IsFloat := False;

  end;
end;

procedure TFinputBom.sgMaterialKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
  if Key = VK_RETURN then begin
    if Eitemno.Text <> '' then begin

      if sgMaterial.Col = 0 then
           FDaftarMaterial.ShowModal
         else if sgMaterial.Col < 6 then begin
             sgMaterial.Col := sgMaterial.Col +1;
         end else begin
                if sgMaterial.Row = sgMaterial.RowCount -1 then begin
                   sgMaterial.RowCount := sgMaterial.RowCount + 1;
                   sgMaterial.Row      := sgMaterial.RowCount - 1;
                   sgMaterial.Col      := 0;

                end else begin
                  sgMaterial.Row      := sgMaterial.RowCount -1;
                  sgMaterial.Col      := 0;
                end;
              end;


    end else begin
      Error('Silahkan pilih produk terlebih dahulu');
      Eitemno.SetFocus;
    end;

  end;

  if Key = VK_DELETE then begin


       ExQry(Q1,'DELETE FROM temp_bom_detail WHERE id="'+sgMaterial.Cells[8,sgMaterial.Row]+'"',False);
       LoadMaterial(StrToint(Lb1.Items[Lb1.SelectedItemIndex].Info));
     
  end;

end;

procedure TFinputBom.sgMaterialKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SubtotalMaterial(sgMaterial.Row);
  LtotalMaterial.Caption := Format('%.2n',[TotalMaterial]);
  LtotalBiaya.Caption    := Format('%.2n',[TotalPekerjaan]);
end;

procedure TFinputBom.sgPekerjaanCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  if ACol in [0,1,3] then
     CanEdit := True;
end;

procedure TFinputBom.sgPekerjaanCellsChanged(Sender: TObject; R: TRect);
  var
    ls : TStringList;
    id  : integer;
begin

    if Eitemno.Text <> '' then begin

          if sgPekerjaan.Col in[1,3] then
                  begin
                    ls := TStringList.Create;

                    try
                        if CellF(sgPekerjaan.Cells[1,sgPekerjaan.Row]) <> 0 then
                           begin


                                ExQry(Q1,'SELECT id FROM temp_bom_pekerjaan WHERE id_pekerjaan="'+sgPekerjaan.Cells[5,sgPekerjaan.Row]+'" '+
                                ' AND id_divisi="'+Lb1.Items[Lb1.SelectedItemIndex].Info+'" AND iduser="'+GetIdUser+'"',True);
                                id := GetValInt(Q1,'id');
                                AddParam('iduser',GetIdUser,ls,'str');
                                AddParam('id_divisi',Lb1.Items[Lb1.SelectedItemIndex].Info,ls,'str');
                                AddParam('id_pekerjaan',sgPekerjaan.Cells[5,sgPekerjaan.Row],ls,'str');
                                AddParam('jumlah',StrToDecimal(sgPekerjaan.Cells[1,sgPekerjaan.Row]),ls,'str');
                                AddParam('unit',sgPekerjaan.Cells[2,sgPekerjaan.Row],ls,'str');
                                AddParam('biaya_standart',StrToDecimal(sgPekerjaan.Cells[3,sgPekerjaan.Row]),ls,'str');
                                AddParam('total_biaya',StrToDecimal(sgPekerjaan.Cells[4,sgPekerjaan.Row]),ls,'str');

                                if Q1.IsEmpty then
                                   ExeDb(Q2,'temp_bom_pekerjaan',ls)
                                else
                                   UpdateDB(Q2,'temp_bom_pekerjaan',ls,'id',IntToStr(id));
                                LoadPekerjaan(StrToInt(Lb1.Items[Lb1.SelectedItemIndex].Info));


                              sgPekerjaan.Row      := sgPekerjaan.RowCount -1;
                              sgPekerjaan.Col      := 0;
                           end;

                    finally
                      ls.Free;
                    end;

          end;
  end ;
end;
procedure TFinputBom.sgPekerjaanGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  case ACol of
  3,4 : begin
           IsFloat := True;
           FloatFormat := '%.2n';
          end;
  0,1,2,5 : IsFloat := False;

  end;
end;

procedure TFinputBom.sgPekerjaanKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 
begin
  if Key = VK_RETURN then begin
    if Eitemno.Text <> '' then begin

          if sgPekerjaan.Col = 0 then begin
               FDaftarPekerjaan.isForm := 1;
               FDaftarPekerjaan.ShowModal;
          end else if sgPekerjaan.Col < 3 then begin
                 sgPekerjaan.Col := sgMaterial.Col +1;
              end else begin
                 if sgPekerjaan.Row = sgPekerjaan.RowCount -1 then begin
                    sgPekerjaan.RowCount := sgPekerjaan.RowCount + 1;
                    sgPekerjaan.Row      := sgPekerjaan.RowCount -1;
                    sgPekerjaan.Col      := 0;
                 end else begin
                   sgPekerjaan.Row := sgPekerjaan.RowCount -1;
                   sgPekerjaan.Col := 0;
                 end;
              end;

    end;
  end ;
  if Key = VK_DELETE then begin

         ExQry(Q1,'DELETE FROM temp_bom_pekerjaan WHERE id="'+sgPekerjaan.Cells[6,sgPekerjaan.Row]+'"',False);
         LoadPekerjaan(StrToint(Lb1.Items[Lb1.SelectedItemIndex].Info));
      
  end;
end;


procedure TFinputBom.sgPekerjaanKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if sgPekerjaan.Col in [1,3] then
  begin
    SubtotalPekerjaan(sgPekerjaan.Row);
    LtotalMaterial.Caption := Format('%.2n',[TotalMaterial]);
    LtotalBiaya.Caption    := Format('%.2n',[TotalPekerjaan]);
  end;
end;

procedure TFinputBom.SimpanBOM;
var
  id_item : String;
  idBom ,VarIdBOM  : integer;
  i    : integer;
  ls : TStringList;
begin


   ls := TStringList.Create;
  try
      id_item := GetData(Q1,'item WHERE itemno="'+EItemNo.Text+'"','id');

      VarIdBOM := StrToIntDef(GetData(Q1,'bom WHERE bom_no="'+Enomer.Text+'"','id'),0);
      AddParam('bom_no',     Enomer.Text, ls,'str');
      AddParam('tgl_input',  frmTgl(Now),ls,'date');
      AddParam('keterangan', Enama.Text,ls,'str');
      AddParam('item_id',    id_item,ls,'str');
      if VarIdBOM = 0 then begin
          ExeDb(Q1,'bom',ls);
          idBom := StrToIntDef(GetData(Q1,'item ORDER BY id DESC LIMIT 1','id'),0);
      end else begin
          UpdateDb(Q1,'bom',ls,'id',IntToStr(VarIdBom));
        idBom := VarIdBOM;
      end;

      ExQry(Q1,'DELETE FROM bom_detail WHERE id_bom="'+IntToStr(IdBom)+'"',False);

      ExQry(Q1, 'SELECT * FROM temp_bom_detail WHERE iduser="'+GetIdUSer+'"',True);

      for i := 0 to  Q1.RecordCount -1 do begin

          AddParam('id_bom',          IntToStr(idBom),ls,'str');
          AddParam('id_divisi',       GetVal(Q1,'id_divisi'),ls,'str');
          AddParam('item_id',         GetVal(Q1,'item_id'),ls,'str');
          AddParam('jumlah',          StrToDecimal(GetVal(Q1,'jumlah')),ls,'str');
          AddParam('standart_cost',   StrToDecimal(GetVal(Q1,'standart_cost')),ls,'str');
          AddParam('total_biaya',     StrToDecimal(GetVal(Q1,'total_biaya')),ls,'str');
          AddParam('keterangan',      GetVal(Q1,'keterangan'),ls,'str');
          AddParam('unit',            GetVal(Q1,'unit'),ls,'str');
          ExeDb(Q2,'bom_detail',ls);
          Q1.Next;
      end;
      ExQry(Q1,'DELETE FROM temp_bom_detail WHERE iduser="'+GetIdUser+'"',False);
      ExQry(Q1,'DELETE FROM bom_pekerjaan WHERE id_bom="'+IntToStr(idBom)+'"',False);


      ExQry(Q1, 'SELECT * FROM temp_bom_pekerjaan WHERE iduser="'+GetIdUSer+'"',True);

      for i := 0 to  Q1.RecordCount -1 do begin

          AddParam('id_bom',IntToStr(idBom),ls,'str');
          AddParam('id_divisi',GetVal(Q1,'id_divisi'),ls,'str');
          AddParam('id_pekerjaan',GetVal(Q1,'id_pekerjaan'),ls,'str');
          AddParam('jumlah',GetVal(Q1,'id_pekerjaan'),ls,'str');
          AddParam('unit',GetVal(Q1,'unit'),ls,'str');
          AddParam('biaya_standart',GetVal(Q1,'biaya_standart'),ls,'str');
          AddParam('total_biaya',GetVal(Q1,'total_biaya'),ls,'str');
          ExeDb(Q2,'bom_pekerjaan',ls);
          Q1.Next;

      end;
      ExQry(Q1,'DELETE FROM temp_bom_pekerjaan WHERE iduser="'+GetIdUser+'"',False);
  finally
    ls.Free;
  end;
end;

procedure TFinputBom.SubtotalMaterial(Row: integer);
var
  Jumlah , Harga , Subtotal: Real;
begin
  if sgMaterial.Col in [3,4] then begin
     Jumlah := CellF(sgMaterial.Cells[4,row]);
     Harga  := CellF(sgMaterial.Cells[3,Row]);

     Subtotal := Jumlah  * Harga;

     sgMaterial.Cells[5,Row] := Format('%.2n',[Subtotal]);

  end;
end;

procedure TFinputBom.SubtotalPekerjaan(Row: integer);
var
  Jumlah , Harga , Subtotal: Real;
begin
  if sgPekerjaan.Col in [1,3] then begin
     Jumlah := CellF(sgPekerjaan.Cells[1,row]);
     Harga  := CellF(sgPekerjaan.Cells[3,Row]);

     Subtotal := Jumlah  * Harga;

     sgPekerjaan.Cells[4,Row] := Format('%.2n',[Subtotal]);

  end;
end;

procedure TFinputBom.TampilanAwal;
begin
  ClearText(Self);
  Enomer.Text    := GetCode(Q1,'bom','bom_no','');

  GridMaterial;
  GridPekerjaan;
end;





function TFinputBom.TotalMaterial: Real;

begin
    ExQry(Q3,'SELECT SUM(total_biaya) as totalmaterial FROM temp_bom_detail',True);


    Result := Q3.FieldByName('totalmaterial').AsFloat;

end;

function TFinputBom.TotalPekerjaan: Real;

begin
     ExQry(Q3,'SELECT SUM(total_biaya) as totalcost FROM temp_bom_pekerjaan',True);

    Result := Q3.FieldByName('totalcost').AsFloat;

end;

end.
