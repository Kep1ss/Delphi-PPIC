unit uImportBom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, AdvSmoothListBox, Vcl.ToolWin,
  tmsAdvGridExcel;
type
  TFImportBom = class(TForm)
    QM1: TZQuery;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EFileMaterial: TAdvEdit;
    EFilePekerjaan: TAdvEdit;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    sgMaterial: TAdvStringGrid;
    sgPekerjaan: TAdvStringGrid;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btnTutup: TAdvSmoothButton;
    btnSimpan: TAdvSmoothButton;
    Bevel1: TBevel;
    AdvSmoothButton3: TAdvSmoothButton;
    Label4: TLabel;
    Label5: TLabel;
    Lbomno: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Lketerangan: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Lproduct: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    IO1: TAdvGridExcelIO;
    IO2: TAdvGridExcelIO;
    Op1: TOpenDialog;

    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgMaterialGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure sgPekerjaanGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnTutupClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    yDb : TYDb;



    procedure GridMaterial;
    procedure GridPekerjaan;
    procedure SimpanBOM;


    { Private declarations }
  public
    BomNo : String;
    procedure TampilanAwal;
  


    { Public declarations }
  end;

var
  FImportBom: TFImportBom;



implementation
 uses
  uDataKaryawan, uListOfProduct, uListofMaterial, uListofPekerjaan, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFImportBom.AdvSmoothButton1Click(Sender: TObject);
begin
  IO1.XLSExport(ExtractFilePath(Application.ExeName)+'\Format Import BOM Material.xls');
end;

procedure TFImportBom.AdvSmoothButton2Click(Sender: TObject);
begin
  if  Op1.Execute then
  begin
    EFileMaterial.Text := Op1.FileName;
    IO1.XLSImport(Op1.FileName);
  end;

end;



procedure TFImportBom.AdvSmoothButton3Click(Sender: TObject);
begin
  if  Op1.Execute then
  begin
    EFilePekerjaan.Text := Op1.FileName;
    IO2.XLSImport(Op1.FileName);
  end;

end;

procedure TFImportBom.AdvSmoothButton4Click(Sender: TObject);
begin
    IO2.XLSExport(ExtractFilePath(Application.ExeName)+'\Format Import BOM Pekerjaan.xls');
end;

procedure TFImportBom.btnSimpanClick(Sender: TObject);
begin
  if MessageDlg('Yakin ingin menyimpan?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    SimpanBOM;
    TampilanAwal;
    

  end;
end;

procedure TFImportBom.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFImportBom.FormCreate(Sender: TObject);
begin
  FImportBom     := Self;
  yDb            := TYDb.Create(MariaCon.ZMy);
  TampilanAwal;

end;

procedure TFImportBom.FormDestroy(Sender: TObject);
begin
  yDb.Free;
end;

procedure TFImportBom.GridMaterial;
begin
  with sgMaterial do begin
    ClearAll;
    RowCount :=  2;
    ColCount :=  8;
    FixedCols:=  0;

    Cells[0,0] := 'Divisi';
    Cells[1,0] := 'Item No';
    Cells[2,0] := 'Description';
    Cells[3,0] := 'Unit';
    Cells[4,0] := 'Standart Cost';
    Cells[5,0] := 'Qty';
    Cells[6,0] := 'Total Cost';
    Cells[7,0] := 'Keterangan';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 80;
    ColWidths[3] := 120;
    ColWidths[4] := 50;
    ColWidths[5] := 120;
    ColWidths[6] := 200;
    ColWidths[7] := 200;

    ColumnSize.StretchColumn  := 7;
    ColumnSize.Stretch        := True;
  end;
end;

procedure TFImportBom.GridPekerjaan;
begin
  with sgPekerjaan do begin
    ClearAll;
    RowCount  :=  2;
    ColCount  :=  7;
    FixedCols :=  0;

    Cells[0,0] := 'Divisi';
    Cells[1,0] := 'Nama Pekerjaan';
    Cells[2,0] := 'Qty';
    Cells[3,0] := 'Unit';
    Cells[4,0] := 'Biaya';
    Cells[5,0] := 'Total Biaya';
    Cells[6,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 100;
    ColWidths[3] := 200;
    ColWidths[4] := 100;
    ColWidths[5] := 100;
    ColWidths[6] := 0;

    ColumnSize.StretchColumn  := 1;
    ColumnSize.Stretch        := True;
  end;
end;


procedure TFImportBom.sgMaterialGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  case ACol of
  4,5,6 : begin
           IsFloat := True;
           FloatFormat := '%.2n';
          end;
  0,1,2,7 : IsFloat := False;

  end;
end;

procedure TFImportBom.sgPekerjaanGetFloatFormat(Sender: TObject; ACol,
  ARow: Integer; var IsFloat: Boolean; var FloatFormat: string);
begin
  case ACol of
  2 : begin
           IsFloat := True;
           FloatFormat := '%.2n';
          end;
  0 : IsFloat := False;

  end;
end;

procedure TFImportBom.SimpanBOM;
var
  id_item : String;
  idBom   : integer;
  i    : integer;
  iddivisi : String;
  id_Pekerjaan : String;
begin



  yDb.Table := 'bom';

  yDb.FieldString('bom_no', Lbomno.Caption);
  yDb.FieldDate('tgl_input',Now);
  yDb.FieldString('keterangan',Lketerangan.Caption);
  id_item := yDb.FindValue('item','itemno',Lproduct.Caption,'id');
  yDb.FieldString('item_id',id_item);
  yDb.Save(0);

  idBom := yDb.LastId;

  yDb.Table := 'bom_detail';
  for i := 1 to  sgMaterial.RowCount -1 do begin
      if Cellf(sgMaterial.Cells[5,i]) <> 0 then begin

          iddivisi := yDb.FindValue('divisi','name',sgMaterial.Cells[0,i],'id');
          id_item  := yDb.FindValue('item','itemno',sgMaterial.Cells[1,i],'id');

          yDb.FieldInt('id_bom',idBom);
          yDb.FieldString('id_divisi',iddivisi);
          yDb.FieldString('item_id',id_item);
          yDb.FieldFloat('jumlah',Cellf(sgMaterial.Cells[5,i]));
          yDb.FieldFloat('standart_cost',Cellf(sgMaterial.Cells[4,i]));
          yDb.FieldFloat('total_biaya',Cellf(sgMaterial.Cells[6,i]));
          yDb.FieldString('keterangan',sgMaterial.Cells[7,i]);
          yDb.FieldString('unit',sgMaterial.Cells[3,i]);
          yDb.Save(0);
      end;
  end;

  yDb.Table := 'bom_pekerjaan';
  QM1.Connection := yDb.Conn;
  for i := 1 to  sgPekerjaan.RowCount -1 do begin
      if sgPekerjaan.Cells[1,i] <> '' then begin
        iddivisi := yDb.FindValue('divisi','name',sgPekerjaan.Cells[0,i],'id');


        ExQry(QM1,'SELECT id FROM pekerjaan WHERE deskripsi="'+sgPekerjaan.Cells[1,i]+'" '+
        ' AND id_divisi="'+iddivisi+'"',True);
        id_Pekerjaan := QM1.Fields[0].AsString;

        yDb.FieldInt('id_bom',idBom);
        yDb.FieldString('id_divisi',iddivisi);
        yDb.FieldString('id_pekerjaan',id_Pekerjaan);
        yDb.FieldFloat('jumlah',Cellf(sgPekerjaan.Cells[2,i]));
        yDb.FieldString('unit',sgPekerjaan.Cells[3,i]);
        yDb.FieldFloat('biaya_standart',Cellf(sgPekerjaan.Cells[4,i]));
        yDb.FieldFloat('total_biaya',Cellf(sgPekerjaan.Cells[5,i]));
        yDb.Save(0);

      end;

  end;

  Informasi('Import Data BOM Selesai');
end;


procedure TFImportBom.TampilanAwal;
begin
  ClearText(Self);
  GridMaterial;
  GridPekerjaan;
end;



end.
