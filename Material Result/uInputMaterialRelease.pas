unit uInputMaterialRelease;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, AdvSmoothListBox, Vcl.ToolWin,
  AdvTreeComboBox, AdvDBLookupComboBox, ZAbstractTable, Vcl.DBCtrls, Vcl.Mask,
  AdvDropDown, AdvCustomGridDropDown, AdvGridDropDown;
type
  TFinputMaterialRelease = class(TForm)
    QM1: TZQuery;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    Eketerangan: TAdvEdit;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btnTutup: TAdvSmoothButton;
    btnSimpan: TAdvSmoothButton;
    Label4: TLabel;
    ENoWo: TAdvEdit;
    EDeskripsi: TAdvEdit;
    Label5: TLabel;
    cbDivisi: TAdvComboBox;
    Label8: TLabel;
    dtRelease: TDateTimePicker;
    sgMaterial: TAdvStringGrid;
    Label9: TLabel;
    DataSource1: TDataSource;
    ZTable1: TZTable;
    cbJOBS: TAdvGridDropDown;
    Label7: TLabel;
    EQty: TAdvEdit;
    Label10: TLabel;
    EBomNo: TAdvEdit;
    Bevel1: TBevel;

    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure sgMaterialCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgMaterialGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure sgPekerjaanCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    
    procedure sgPekerjaanGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnTutupClick(Sender: TObject);
    procedure ENoWoChange(Sender: TObject);
    procedure cbJOBSChange(Sender: TObject);
    procedure cbDivisiChange(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
  private
   


    procedure GridMaterial;


    procedure LoadMaterial(idDivisi:Integer);
  

    { Private declarations }
  public
    procedure TampilanAwal;



    { Public declarations }
  end;

var
  FinputMaterialRelease: TFinputMaterialRelease;



implementation
 uses
  uDataKaryawan, uListOfProduct, uListofMaterial, uListofPekerjaan, uImportBom,
  uListOfWO, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputMaterialRelease.AdvSmoothButton2Click(Sender: TObject);
begin
  FDaftarWO.ShowModal;
end;



procedure TFinputMaterialRelease.btnSimpanClick(Sender: TObject);
var
  i   : integer;
  yDB : TYDb;
  id_release : integer;
  id_wo : String;
begin
  if not CheckEdit(Self) then begin
     if sgMaterial.Cells[1,1] = '' then begin
        Error('Belum ada data');
        exit;
     end else begin
        yDB := TYDb.Create(MariaCon.ZMy);

        try
          id_wo := getData(QM1,'wo WHERE no_wo="'+ENoWo.Text+'"','id');

          yDB.Table := 'material_release';
          yDB.FieldString('no_release',Enomer.Text);
          yDB.FieldDate('tgl',dtRelease.Date);
          yDB.FieldString('id_wo',id_wo);
          yDB.FieldString('id_divisi',GetIdcmb(cbDivisi));
          yDB.FieldString('keterangan',Eketerangan.Text);
          yDB.Save(0);

          id_release := yDB.LastId;

          yDB.Table := 'material_release_detail';
          for i := 1 to sgMaterial.RowCount -1 do begin
             if sgMaterial.Cells[1,i] <> '' then begin
                yDB.FieldInt('id_material_release',id_release);
                yDB.FieldString('item_id', sgMaterial.Cells[5,i]);
                yDB.FieldString('qty',StrToDecimal(sgMaterial.Cells[2,i]));
                yDB.FieldString('unit',sgMaterial.Cells[3,i]);
                yDB.FieldString('notes',sgMaterial.Cells[4,i]);
                yDB.Save(0);

             end;

          end;
          Informasi('Data berhasil disimpan');
          TampilanAwal;

        finally
          yDB.Free;
        end;


     end;


  end;

end;

procedure TFinputMaterialRelease.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputMaterialRelease.cbDivisiChange(Sender: TObject);
var
  id_bom , i: integer;
  id_divisi : Integer;
  yDB       : TYDb;
begin
  if cbDivisi.ItemIndex >=0 then begin

     yDB := TYDb.Create(MariaCon.ZMy);

     try
         GridMaterial;
         id_bom   := yDb.FindIdTable('bom','bom_no',EBomNo.Text,'id');
         id_divisi:= StrToInt(GetIdcmb(cbDivisi));

         ExQry(QM1,' SELECT                         '+
                   '     i.itemno,                  '+
                   '     i.description,             '+
                   '     bd.unit,                   '+
                   '     bd.jumlah,                 '+
                   '     bd.item_id                 '+
                   '   FROM                         '+
                   '     bom_detail bd              '+
                   '     LEFT JOIN item i           '+
                   '       ON i.`id` = bd.`item_id` '+
                   '   WHERE bd.id_bom='+IntToStr(id_bom)+' '+
                   '   AND bd.id_divisi='+IntToStr(id_divisi)+' ',True );
         i := 1;
         sgMaterial.RowCount := QM1.RecordCount + 2;
         while not QM1.Eof do begin
            with sgMaterial do begin
              Cells[0,i] := GetVal(QM1,'itemno');
              Cells[1,i] := GetVal(QM1,'description');
              Cells[2,i] := FloatToStr(GetValF(QM1,'jumlah') * StrToFloatDef(EQty.Text,0));
              Cells[3,i] := GetVal(QM1,'unit');
              Cells[4,i] := '';
              Cells[5,i] := GetVal(QM1,'item_id');
            end;
            QM1.Next;
            Inc(i);
         end;
     finally
       yDB.Free;
     end;

  end;
end;

procedure TFinputMaterialRelease.cbJOBSChange(Sender: TObject);
var
  id_bom : Integer;
  yDb     : TYDb;
begin
  if cbJOBS.Text <> '' then begin

      yDb := TYDb.Create(MariaCon.ZMy);

      try
          EQty.Text   := cbJOBS.Items[cbJOBS.ItemIndex].Text[2];
          EBomNo.Text := cbJOBS.Items[cbJOBS.ItemIndex].Text[4];

          id_bom  := yDb.FindIdTable('bom','bom_no',EBomNo.Text,'id');

          ExQry(QM1,'SELECT DISTINCT                  '+
                    '    d.id_divisi,                 '+
                    '    dv.name                      '+
                    '  FROM                           '+
                    '    bom_detail d                 '+
                    '    LEFT JOIN divisi dv          '+
                    '      ON dv.`id` = d.`id_divisi` '+
                    '  WHERE d.id_bom='+IntToStr(id_bom)+' '+
                    ' ORDER BY dv.`id` ASC ',True  );


          cbDivisi.Items.Clear;
          while QM1.Eof = False do begin
             cbDivisi.AddItem(GetVal(QM1,'name'),TObject(GetValInt(QM1,'id_divisi')));
             QM1.Next;
          end;
      finally
        yDb.Free;
      end;


  end;
end;

procedure TFinputMaterialRelease.ENoWoChange(Sender: TObject);
var
  i , x   : integer;
  ls : TStringList;
  id_wo : String;
begin
  if ENoWo.Text <> '' then begin
     ls := TStringList.Create;

     try
        id_wo := getData(QM1,'wo WHERE no_wo="'+ENoWo.Text+'"','id');
        ExQry(QM1,'SELECT                 '+
                   '   w.item_no,           '+
                   '   w.deskripsi,         '+
                   '   w.qty,               '+
                   '   w.so_no,              '+
                   '   b.bom_no              '+
                   ' FROM                 '+
                   '   wo_jobs w LEFT JOIN '+
                   '   bom b ON b.id=w.id_bom '+
                   '  WHERE id_wo="'+id_wo+'"',True);
        cbJOBS.Items.Clear;
        while QM1.Eof = False do begin
           for i := 0 to QM1.Fields.Count -1 do
              ls.Add(QM1.Fields[i].AsString);

           cbJOBS.Items.Add;
           cbJOBS.Items[x].Text := ls;
           Inc(x);
           ls.Clear;
           QM1.Next;
        end;
     finally
       ls.Free;
     end;


  end;
end;

procedure TFinputMaterialRelease.FormCreate(Sender: TObject);
begin
  FinputMaterialRelease     := Self;
end;

procedure TFinputMaterialRelease.FormShow(Sender: TObject);
var
  Q : TZQuery;
  ydb : TYDb;
begin

  ydb := TYDb.Create(MariaCon.ZMy);
  Q := TZQuery.Create(nil);
  try
    Q.Connection := yDb.Conn;
    isiCmb(Q,'divisi',['id','name'],cbDivisi);
  finally
    Q.Free;
    ydb.Free;
  end;



end;

procedure TFinputMaterialRelease.GridMaterial;
begin
  with sgMaterial do begin
    ClearAll;
    RowCount :=  2;
    ColCount :=  6;
    FixedCols:=  0;

    Cells[0,0] := 'Item No';
    Cells[1,0] := 'Description';
    Cells[2,0] := 'Qty';
    Cells[3,0] := 'Unit';
    Cells[4,0] := 'Keterangan';
    Cells[5,0] := 'idItem';

    ColWidths[0] := 100;
    ColWidths[1] := 250;
    ColWidths[2] := 100;
    ColWidths[3] := 120;
    ColWidths[4] := 200;
    ColWidths[5] := 0;

    ColumnSize.StretchColumn  := 4;
    ColumnSize.Stretch        := True;
  end;
end;



procedure TFinputMaterialRelease.LoadMaterial(idDivisi: Integer);
var
  i : integer;
  yDB : TYDb;
begin
  GridMaterial;
  yDB := TYDb.Create(MariaCon.ZMy);

  try
      yDb.SQL := 'SELECT tb.*,p.itemno,p.description FROM temp_bom_detail tb '+
                 ' LEFT JOIN item p ON p.id=tb.item_id WHERE '+
                 ' tb.id_divisi='+IntToStr(idDivisi)+'';
      yDb.ExQuery;

      if yDb.DataCount > 0 then begin

          sgMaterial.RowCount := yDb.DataCount + 2;

          for I := 0 to yDb.DataCount -1 do begin
              sgMaterial.Cells[0,i+1] := yDb.ValString('itemno');
              sgMaterial.Cells[1,i+1] := yDb.ValString('description');
              sgMaterial.Cells[2,i+1] := yDb.ValString('unit');
              sgMaterial.Cells[3,i+1] := yDb.ValString('standart_cost');
              sgMaterial.Cells[4,i+1] := yDb.ValString('jumlah');
              sgMaterial.Cells[5,i+1] := yDb.ValString('total_biaya');
              sgMaterial.Cells[6,i+1] := yDb.ValString('keterangan');
              sgMaterial.Cells[7,i+1] := yDb.ValString('item_id');
              yDb.NextRec;
          end;
      end else
        GridMaterial;
  finally
    yDB.Free;
  end;

end;

procedure TFinputMaterialRelease.sgMaterialCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
    if ACol in [0,2,3,4,6] then
       CanEdit := True
    else CanEdit := False;
end;

procedure TFinputMaterialRelease.sgMaterialGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  case ACol of
  3,4,5 : begin
           IsFloat := True;
           FloatFormat := '%.2n';
          end;
  0,1,2,6 : IsFloat := False;

  end;
end;

procedure TFinputMaterialRelease.sgPekerjaanCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  if ACol in [0,1] then
     CanEdit := True
  else CanEdit := False;
end;

procedure TFinputMaterialRelease.sgPekerjaanGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  case ACol of
  1 : begin
           IsFloat := True;
           FloatFormat := '%.2n';
          end;
  0 : IsFloat := False;

  end;
end;




procedure TFinputMaterialRelease.TampilanAwal;
var
  yDB : TYDb;
begin
  ClearText(Self);
  Fid            := 0;
  FCanEdit       := False;
  yDB            := TYDb.Create(MariaCon.ZMy);
  try
    yDb.Table      := 'material_release';
    Enomer.Text    := yDb.Code('no_release','');
  finally
    yDB.Free;
  end;
  GridMaterial;

end;





end.
