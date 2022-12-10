unit uDataMaterial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, DBAdvGrid, DBAccess,
  MyAccess, MemDS;

type
  TFDataMaterial = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
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
    AdvSmoothPanel2: TAdvSmoothPanel;
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    QMaterial: TMyQuery;
    Q1: TMyQuery;
    DMaterial: TMyDataSource;
    Lentries: TLabel;
    DBAdvGrid1: TDBAdvGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrivClick(Sender: TObject);
    procedure DBAdvGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    varIsLimit : Integer;
    varIsPage  : Integer;
    procedure ButtonPage(Sender: TObject);
    procedure Pagination(RowStart:Integer);
  public
    { Public declarations }
    procedure LoadData(isCari:String;isLimit : Integer;isOffSet:integer);

  end;



var
  FDataMaterial: TFDataMaterial;

implementation

{$R *.dfm}

uses uInputMaterial, uMarCon;




procedure TFDataMaterial.AdvSmoothButton2Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data akan dihapus?',mtConfirmation,[MbYes,Mbno],0) = MrYes then
  begin
    ExQry(Q1,'DELETE FROM item WHERE itemno="'+DBAdvGrid1.Cells[5,DBAdvGrid1.Row]+'"',False);
    LoadData('',StrToIntDef(cbEntries.Text,1),0);
    Pagination(0);
  end;
end;

procedure TFDataMaterial.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Material.xls');
end;

procedure TFDataMaterial.AdvSmoothButton4Click(Sender: TObject);
begin

  with FInputMaterial do begin
      TampilanAwal;
      isiCmb(Q1,'category',['id','name'],FinputMaterial.cbKategori);
      Qmaterial.Locate('id',DBAdvGrid1.Cells[5,DBAdvGrid1.Row],[]);
      id                    := GetVal(QMaterial,'id');
      EnoBarang.Text        := GetVal(Qmaterial,'itemno');
      EnamaBarang.Text      := GetVal(Qmaterial,'description');
      cbKategori.ItemIndex  := idxCmb(cbKategori,GetValInt(Qmaterial,'item_category'));
      Estok.Text            := GetVal(Qmaterial,'stok');
      EHargaJual.Text       := GetVal(Qmaterial,'unit_price');
      EhargaPokok.Text      := GetVal(Qmaterial,'cost');
      EDiskon.Text          := GetVal(Qmaterial,'discount');


      ShowModal;
  end;
end;

procedure TFDataMaterial.btnAddClick(Sender: TObject);
begin
  FinputMaterial.EnoBarang.Text := GetCode(Q1,'item','itemno','MR');
  isiCmb(Q1,'category',['id','name'],FinputMaterial.cbKategori);
  FinputMaterial.ShowModal;
end;

procedure TFDataMaterial.btnNextClick(Sender: TObject);
begin
  QMaterial.Next;
end;

procedure TFDataMaterial.btnPrivClick(Sender: TObject);
begin
  QMaterial.Prior;
end;

procedure TFDataMaterial.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData('',StrToIntDef(cbEntries.Text,1),varisPages );
  end;
end;

procedure TFDataMaterial.cbEntriesChange(Sender: TObject);
begin
  LoadData('',StrToIntDef(cbEntries.Text,1),0);
  Pagination(0);
end;


procedure TFDataMaterial.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataMaterial.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  LoadData(' AND description LIKE "%'+ECari.Text+'%" ',StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataMaterial.FormCreate(Sender: TObject);
begin
  FDataMaterial := Self;

  Ecari.isCari:= True;


end;

procedure TFDataMaterial.FormShow(Sender: TObject);
begin


  LoadData('',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataMaterial.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
  ExQry(Qmaterial,getSQL('TableMaterial')+'WHERE inventory_group IN (0,1,4) '+isCari+' ORDER BY itemno ASC LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOFFSET)+' ',True);
  varIsLimit := isLimit;
  varIsPage  := isOffSet;

end;


procedure TFDataMaterial.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM item WHERE inventory_group IN (0,1,4)',True);
  TotalData := GetValInt(Q1,'totaldata');
  jmlPage := GetValInt(Q1,'totaldata') div varIsLimit;
  if GetValInt(Q1,'totaldata') mod varIsLimit > 0 then

  jmlPage := jmlPage + 1;
  pPagination.Visible := False;
  btnPriv             := FindComponent('btnPriv') as TAdvSmoothButton;

  if btnPriv <> nil then

  btnPriv.Align       := alLeft ;

  for i := pPagination.ComponentCount -1 Downto 0 do begin
      if pPagination.Components[i] is TAdvSmoothButton then
      TAdvSmoothButton(pPagination.Components[i]).Free;
  end;

  for i := jmlPage  Downto 1  do  begin

          btn := TAdvSmoothButton.Create(pPagination);
          btn.Parent := pPagination;
          btn.Height := 28;
          btn.Width  := 30;
          btn.Name   := 'btn'+IntToStr(i);
          btn.Align  := alRight;
          btn.Caption := IntToStr(i);
          btn.Color   :=  $003B3B3B;
          btn.AlignWithMargins  :=  True;
          btn.Appearance.SimpleLayout := True;
          btn.Appearance.Rounding     := 3;
          btn.AlignWithMargins        := True;
          btn.Appearance.Font.Color   := $009A9A9A;
          btn.Margins.Top             := 0;
          btn.Margins.Bottom          := 0;
          btn.Margins.Left            := 1;
          btn.Margins.Right           := 1;
          btn.OnClick                 := ButtonPage;
  end;
  btnPriv.Align := alRight;

  if varIsLimit > TotalData then
          RowOf := TotalData else RowOf := varIsLimit;
       Lentries.Caption := 'Showing '+IntToStr(Qmaterial.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;


procedure TFDataMaterial.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol in [0..11]) and (ARow = 0) then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
