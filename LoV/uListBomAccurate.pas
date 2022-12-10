unit uListBomAccurate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl, uPatchForm,AnnabaDB,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ufbacces, uEngine;


type
  TFDaftarBOMAccurate = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btnTutup: TAdvSmoothButton;
    QM1: TZQuery;
    Label2: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    Label1: TLabel;
    Lproduk: TLabel;
    sgBarang: TAdvStringGrid;
    btnSimpan: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgBarangGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgBarangComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: string);
  private

    yDB       : TYDb;
    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarBOMAccurate: TFDaftarBOMAccurate;


implementation



{$R *.dfm}

uses uInputBom, uMarCon;

{ TFinputMotif }

procedure TFDaftarBOMAccurate.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (ITEMNO LIKE ''%'+Ecari.Text+'%'' OR DESCRIPTION LIKE ''%'+Ecari.Text+'%'') ');
end;

procedure TFDaftarBOMAccurate.btnSimpanClick(Sender: TObject);
var
  i     : integer;
  yDB   : TYDb;
  FBdb : TFBdb;
  ItemId : String;
  Q    : TZQuery;
  varIdDivisi   : String;
  varItemId     : String;
  varKeterangan : String;
  varJumlah     : real;
  varUnit       : String;
  varStandartCost : Real;
  varTotalCost    : Real;
begin
  FBdb := TFBdb.Create;
  Q    := TZQuery.Create(nil);
  Q.Connection := FBdb.FCon;

  yDB := TYDb.Create(MariaCon.ZMy);

  try
    yDB.Table := 'temp_bom_detail';
    for i := 1 to sgBarang.RowCount -1 do begin
       if sgBarang.Cells[5,i] <> '' then begin

          FBdb.ExQry(Q,'SELECT MATERIALNO,MATERIALQTY,UNIT FROM PRODBOMMAT WHERE BOMID='''+sgBarang.Cells[4,i]+''' ',True);

          while not Q.Eof do begin
              ExQry(QM1,'SELECT id,cost FROM item WHERE itemno="'+GetVal(Q,'MATERIALNO')+'" ',True);

              varIdDivisi    := sgBarang.Cells[5,i];
              varItemId      := GetVal(QM1,'id');
              varKeterangan  := '-';
              varJumlah      := GetValF(Q,'MATERIALQTY');
              varUnit        := GetVal(Q,'UNIT');
              varStandartCost:= GetValF(QM1,'cost');
              varTotalCost   := varJumlah * varStandartCost;

              ExQry(QM1,'SELECT id FROM temp_bom_detail WHERE item_id="'+varItemId+'" '+
                                ' AND id_divisi="'+varIdDivisi+'"',True);

              if (QM1.IsEmpty) AND (varItemId <> '') then begin
               yDB.FieldString('iduser', GetIdUser);
               yDB.FieldString('id_divisi', varIdDivisi);
               yDB.FieldString('item_id', varItemId);
               yDB.FieldString('keterangan', varKeterangan);
               yDB.FieldFloat('jumlah', varJumlah);
               yDB.FieldString('unit', varUnit);
               yDB.FieldFloat('standart_cost', varStandartCost);
               yDB.FieldFloat('total_biaya', varTotalCost);
               yDB.Save(0);
              end;

            Q.Next;
          end;
       end;

    end;
    Informasi('Import BOM Selesai');
  finally
    yDB.Free;
    FBdb.Free;
  end;

end;

procedure TFDaftarBOMAccurate.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarBOMAccurate.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 7;
    RowCount := 2;

    Cells[0,0] := 'Item No';
    Cells[1,0] := 'BOM No';
    Cells[2,0] := 'Deskripsi';
    Cells[3,0] := 'Set Divisi';
    Cells[4,0] := 'id';
    Cells[5,0] := 'id_divisi';
    Cells[6,0] := 'BOM ID';

    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 250;
    ColWidths[3] := 400;
    ColWidths[4] := 0;
    ColWidths[5] := 0;
    ColWidths[6] := 0;

    ColumnSize.StretchColumn := 3;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarBOMAccurate.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;
end;

procedure TFDaftarBOMAccurate.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;
procedure TFDaftarBOMAccurate.LoadGrid(Filter: String);
var
  i : integer;
  FBdb : TFBdb;
  Q    : TZQuery;
  SOISSUED : Real;
begin
  CreateGrid;

  FBdb := TFBdb.Create;
  Q    := TZQuery.Create(nil);
  Q.Connection := FBdb.FCon;
  try
      FBdb.ExQry(Q,'SELECT BOMID,BOMNO,DESCRIPTION,ITEMNO FROM PRODBOM '+Filter+' ',true);

      i := 1;


      while not Q.Eof do begin
            with sgBarang do begin


             Cells[0,i] := GetVal(Q,'ITEMNO');
             Cells[1,i] := GetVal(Q,'BOMNO');
             Cells[2,i] := GetVal(Q,'DESCRIPTION');
             Cells[4,i] := GetVal(Q,'BOMID');
             sgBarang.RowCount := sgBarang.RowCount + 1;
             Inc(i);
           end;

           Q.Next;


        end;

  finally
    FBdb.Free;
    Q.Free;
  end;
end;

procedure TFDaftarBOMAccurate.sgBarangComboChange(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: string);
begin
  sgBarang.Cells[5,sgBarang.Row] := Inttostr(integer(sgBarang.Combobox.Items.Objects[sgBarang.Combobox.ItemIndex]));
end;

procedure TFDaftarBOMAccurate.sgBarangGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    3 : begin
          AEditor := edComboList;
          sgBarang.ClearComboString;

          QM1.Connection := MariaCon.ZMy;
          ExQry(QM1,'SELECT * FROM divisi',True);

          while not QM1.Eof do begin
             sgBarang.AddComboStringObject(GetVal(QM1,'name'),TObject(GetValInt(QM1,'id')));
             QM1.Next;

          end;
        end;
  end;
end;

procedure TFDaftarBOMAccurate.TampilanAwal;
begin
  ClearText(Self);
  Fid := 0;
  //LoadGrid(' LIMIT 500');

end;

end.
