unit uDataBom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet,
  DBAccess, MyAccess, DBAdvGrid, MemDS, frxExportBaseDialog, frxExportImage;

type
  TFDataBOM = class(TForm)
    Label1: TLabel;
    btnAdd: TAdvSmoothButton;
    P1: TAdvSmoothPanel;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbEntries: TAdvComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Ecari: TAdvEdit;
    Lentries: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton1: TAdvSmoothButton;
    frxReport1: TfrxReport;
    frBomMaterial: TfrxDBDataset;
    frBomPekerjaan: TfrxDBDataset;
    frMasterBom: TfrxDBDataset;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    Q1: TMyQuery;
    QMasterBom: TMyQuery;
    QBomMaterial: TMyQuery;
    QBomPekerjaan: TMyQuery;
    DBAdvGrid1: TDBAdvGrid;
    DMaterBom: TMyDataSource;
    Q2: TMyQuery;
    Q3: TMyQuery;
    frxJPEGExport1: TfrxJPEGExport;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure DBAdvGrid1DblClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure LoadData(isCari:String;isLimit : Integer;isOffSet:integer);

  end;



var
  FDataBOM: TFDataBOM;

implementation

{$R *.dfm}

uses  uInputBom, uMainMenu, uDataBarang, uMarCon;




procedure TFDataBOM.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QMasterBOM,'select                      '+
                   '     b.id,                  '+
                   '     b.bom_no,              '+
                   '     b.tgl_input,           '+
                   '     b.keterangan,          '+
                   '     b.item_id,             '+
                   '     p.description          '+
                   '   from                     '+
                   '     bom b                  '+
                   '     left join item p       '+
                   '       on b.`item_id` = p.`id` '+
                   ' WHERE b.bom_no="'+GetVal(QMasterBom,'bom_no')+'"',True);


  QBomMaterial.Active := False;
  QBomMaterial.Active := True;

  QBomPekerjaan.Active := False;
  QBomPekerjaan.Active := True;

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frBOM.fr3');
  frxReport1.ShowReport();

end;

procedure TFDataBOM.AdvSmoothButton2Click(Sender: TObject);
var
  id: integer;
  ls : TStringList;
begin
  if Assigned(FinputBom) then
       FreeAndNil(FinputBom);
   Application.CreateForm(TFinputBom,FinputBom);


   FinputBom.Parent      := FMainMenu.pg;
   FinputBom.Align       := AlClient;
   FinputBom.BorderStyle := bsNone;
   FinputBom.Position    := poOwnerFormCenter ;
   FinputBom.visible     := True;


  with FinputBOM do begin
      ls := TStringList.Create;
      try
      Enomer.Text       := GetVal(QMasterBom,'bom_no');
      EitemNo.Text      := GetVal(QMasterBom,'itemno');
      Enamabarang.Text  := GetVal(QMasterBom,'description');


         ExQry(Q1,getSQL('ItemMaterialBOM')+' WHERE d.id_bom="'+GetVal(QMasterBom,'id')+'"',True);



          while not Q1.Eof  do begin
              ExQry(Q2,'SELECT id FROM temp_bom_detail WHERE item_id="'+GetVal(Q1,'item_id')+'" '+
              ' AND id_divisi="'+GetVal(Q1,'id_divisi')+'" AND iduser="'+GetIdUser+'"',True);


              id := GetValInt(Q2,'id');
              addParam('iduser',GetIdUser,ls,'str');
              addParam('id_divisi',GetVal(Q1,'id_divisi'),ls,'str');
              addParam('item_id',GetVal(Q1,'item_id'),ls,'str');
              addParam('keterangan','keterangan',ls,'str');
              addParam('jumlah',StrToDecimal(GetVal(Q1,'jumlah')),ls,'str');
              addParam('unit',GetVal(Q1,'unit'),ls,'str');
              addParam('standart_cost',StrToDecimal(GetVal(Q1,'standart_cost')),ls,'str');
              addParam('total_biaya',StrToDecimal(GetVal(Q1,'total_biaya')),ls,'str');

              if Q2.isEmpty then
                ExeDb(Q3,'temp_bom_detail',ls)
              else
                UpdateDB(Q3,'temp_bom_detail',ls,'id',IntToStr(id));
               Q1.Next;
          end;



         ExQry(Q1,getSQL('ItemPekerjaanBOM')+' WHERE d.id_bom="'+GetVal(QMasterBom,'id')+'"',True);




          while not Q1.Eof  do begin
            ExQry(Q2,'SELECT id FROM temp_bom_pekerjaan WHERE id_pekerjaan="'+sgPekerjaan.Cells[5,sgPekerjaan.Row]+'" '+
            ' AND id_divisi="'+Lb1.Items[Lb1.SelectedItemIndex].Info+'" AND iduser="'+GetIdUser+'"',True);
            id := GetValInt(Q2,'id');
            AddParam('iduser',GetIdUser,ls,'str');
            AddParam('id_divisi',GetVal(Q1,'id_divisi'),ls,'str');
            AddParam('id_pekerjaan',GetVal(Q1,'id_pekerjaan'),ls,'str');
            AddParam('jumlah',StrToDecimal(GetVal(Q1,'jumlah')),ls,'str');
            AddParam('unit',GetVal(Q1,'unit'),ls,'str');
            AddParam('biaya_standart',StrToDecimal(GetVal(Q1,'biaya_standart')),ls,'str');
            AddParam('total_biaya',StrToDecimal(GetVal(Q1,'total_biaya')),ls,'str');

            if Q1.IsEmpty then
               ExeDb(Q3,'temp_bom_pekerjaan',ls)
            else
               UpdateDB(Q3,'temp_bom_pekerjaan',ls,'id',IntToStr(id));
            Q1.Next;

          end;

      lb1.SelectedItemIndex  := 0;
      Lb1ItemClick(Sender,lb1.SelectedItemIndex);
      LtotalMaterial.Caption := Format('%.2n',[TotalMaterial]);
      LtotalBiaya.Caption    := Format('%.2n',[TotalPekerjaan]);

    finally
      ls.Free;
    end;
  end;

end;


procedure TFDataBOM.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data BOM.xls');
end;

procedure TFDataBOM.AdvSmoothButton4Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    ExQry(Q1,'DELETE FROM bom WHERE bom_no="'+GetVal(QMasterBom,'bom_no')+'"',False);
    LoadData('',StrToIntDef(cbEntries.Text,10),0);
  end;
end;

procedure TFDataBOM.btnAddClick(Sender: TObject);

begin
   if  Assigned(FinputBom) then
       FreeAndNil(FinputBom);
   Application.CreateForm(TFinputBom,FinputBom);

   FinputBom.Parent      := FMainMenu.pg;
   FinputBom.Align       := AlClient;
   FinputBom.BorderStyle := bsNone;
   FinputBom.Position    := poOwnerFormCenter ;
   FinputBom.visible     := True;

   ExQry(Q1,'DELETE FROM temp_bom_detail WHERE iduser="'+GetIdUser+'"',False);
   ExQry(Q1,'DELETE FROM temp_bom_pekerjaan WHERE iduser="'+GetIdUser+'"',False);
   FinputBom.Enomer.Text := GetCOde(Q1,'bom','bom_no','');


end;

procedure TFDataBOM.cbEntriesChange(Sender: TObject);
begin
  LoadData('',StrToIntDef(cbEntries.Text,1),1);
end;

procedure TFDataBOM.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton2.Click;
end;

procedure TFDataBOM.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LoadData(' WHERE description LIKE "%'+ECari.Text+'%" AND inventory_group=3',StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataBOM.FormCreate(Sender: TObject);
begin
  FDataBOM := Self;

end;

procedure TFDataBOM.FormShow(Sender: TObject);
begin


  LoadData('',StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataBOM.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
  ExQry(QMasterBom,GetSQL('TableBOM')+isCari+' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);
end;


procedure TFDataBOM.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol in [0..7]) and (Arow = 0) then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
