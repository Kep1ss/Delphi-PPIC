unit uDataJobs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, DBAccess, MyAccess,
  MemDS, DBAdvGrid;

type
  TFDataPekerjaan = class(TForm)
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
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    DBAdvGrid1: TDBAdvGrid;
    Q1: TMyQuery;
    QJobs: TMyQuery;
    DJobs: TMyDataSource;
    Lentries: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton5Click(Sender: TObject);
    procedure btnPrivClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
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
  FDataPekerjaan: TFDataPekerjaan;

implementation

{$R *.dfm}

uses uInputPekerjaan;




procedure TFDataPekerjaan.AdvSmoothButton1Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data dihapus?',MtConfirmation,[Mbyes,Mbno],0) = MrYes then
  begin
    ExQry(Q1,'DELETE FROM pekerjaan WHERE id="'+DBAdvGrid1.Cells[6,DBAdvGrid1.Row]+'" ',False);
    LoadData('',StrToIntDef(cbEntries.Text,10),0);
  end;
end;

procedure TFDataPekerjaan.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Pekerjaan.xls');
end;

procedure TFDataPekerjaan.AdvSmoothButton5Click(Sender: TObject);
begin

  with FInputPekerjaan do begin
  isiCmb(Q1,'divisi WHERE is_active=true',['id','name'],cbDivisi);

  QJobs.Locate('id',DBAdvGrid1.Cells[6,DBAdvGrid1.Row],[]);
//  ShowMessage(GetVal(QJobs,'deskripsi'));
if (not  rbByComponent.Checked) and ( not rbByProduct.Checked) and ( not RBSatuanProduk.Checked) then
     rbByComponent.Checked := true;

  if rbByProduct.Checked then
        rbByProduct.OnClick(Sender)
     else if rbByComponent.Checked then
        rbByComponent.OnClick(Sender)
     else if RBSatuanProduk.Checked then
        RBSatuanProduk.OnClick(Sender);

  id                    := DBAdvGrid1.Cells[6,DBAdvGrid1.Row];
  cbDivisi.ItemIndex    := idxCmb(cbDivisi,GetValInt(QJobs,'id_divisi'));
  EDeskripsi.Text       := GetVal(QJobs,'deskripsi');
  Ebiaya.Text           := GetValR(QJobs,'biaya');
  Esatuan.Text          := GetVal(QJobs,'satuan');
  EbiayaSetMesin.Text   := GetVal(QJobs,'biaya_set_mesin');
  EKoef.Text            := GetVal(QJobs,'koef');
  rbByProduct.Checked   := GetVal(QJobs,'jenis_biaya') = 'Product';
  rbByComponent.Checked := GetVal(QJobs,'jenis_biaya') = 'Component';
  RBSatuanProduk.Checked:= GetVal(QJobs,'jenis_biaya') = 'Satuan';



  ShowModal;
  end;
end;

procedure TFDataPekerjaan.btnAddClick(Sender: TObject);
begin
  isiCmb(Q1,'divisi WHERE is_active=true',['id','name'],FInputPekerjaan.cbDivisi);
  FInputPekerjaan.TampilanAwal;
  FInputPekerjaan.ShowModal;
end;

procedure TFDataPekerjaan.btnNextClick(Sender: TObject);
begin
  QJobs.Next;
end;

procedure TFDataPekerjaan.btnPrivClick(Sender: TObject);
begin
  QJobs.Prior;
end;

procedure TFDataPekerjaan.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData('',StrToIntDef(cbEntries.Text,1),varisPages );

  end;
end;

procedure TFDataPekerjaan.cbEntriesChange(Sender: TObject);
begin
  LoadData('',StrToIntDef(cbEntries.Text,10),0);

  Pagination(0);
end;


procedure TFDataPekerjaan.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton5.Click;
end;

procedure TFDataPekerjaan.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LoadData(' WHERE j.deskripsi LIKE "%'+ECari.Text+'%" ',StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataPekerjaan.FormCreate(Sender: TObject);
begin
  FDataPekerjaan := Self;



end;

procedure TFDataPekerjaan.FormShow(Sender: TObject);
begin

  LoadData('',StrToIntDef(cbEntries.Text,10),0);

  Pagination(0);
end;

procedure TFDataPekerjaan.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
  ExQry(Qjobs,getSQL('TableJobs')+ isCari+' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);
  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataPekerjaan.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM pekerjaan',True);
  TotalData := GetValInt(Q1,'totaldata');
  jmlPage := TotalData div varIsLimit;
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
       //   pPagination.Width           := pPagination.Width + btn.Width;
       //   pPagination.Left            := pPagination.Left - btn.Width;

  end;
  btnPriv.Align := alRight;

  if varIsLimit > TotalData then
          RowOf := TotalData else RowOf := varIsLimit;
       Lentries.Caption := 'Showing '+IntToStr(Qjobs.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

procedure TFDataPekerjaan.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol in [0..11]) and (ARow = 0) then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
