unit uDataBarang;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, JPEG,AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, System.ImageList,
  Vcl.ImgList, AdvSmoothStepControl, AdvScrollBox, AdvGroupBox, DBAccess, MyAccess, MemDS,
  DBAdvGrid, VirtualTable;

type
  TFDataBarang = class(TForm)
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
    ImageList1: TImageList;
    AdvGroupBox1: TAdvGroupBox;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvGroupBox2: TAdvGroupBox;
    lb: TListBox;
    AdvGroupBox3: TAdvGroupBox;
    lb2: TListBox;
    DBAdvGrid1: TDBAdvGrid;
    QBarang: TMyQuery;
    DBarang: TMyDataSource;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    Q1: TMyQuery;
    Lentries: TLabel;
    vjadwal_divisi: TVirtualTable;
    vjadwal_divisiid_divisi: TIntegerField;
    vjadwal_divisitgl: TDateField;
    vjadwal_divisikapasitas_divisi: TIntegerField;
    vjadwal_divisikapasitas_terpakai: TIntegerField;
    vjadwal_divisigc_code: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton5Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure DBAdvGrid1Click(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrivClick(Sender: TObject);
    procedure DBAdvGrid1GetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DBAdvGrid1GetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
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
  FDataBarang: TFDataBarang;

implementation

{$R *.dfm}

uses  uInputProduct, uSettingProsesProduksi, uMarCon, uSettingComponentProduct;




procedure TFDataBarang.AdvSmoothButton1Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin akan dihapus?',MtConfirmation,[Mbyes,Mbno],0) = Mryes then
  begin

    ExQry(Q1,'DELETE FROM item WHERE id="'+DBAdvGrid1.Cells[7,DBAdvGrid1.Row]+'"',False);
    LoadData('',StrToIntDef(cbEntries.Text,1),0);
    Pagination(0);
  end;
end;

procedure TFDataBarang.AdvSmoothButton2Click(Sender: TObject);
  var

  I: integer;
begin


  with  FSettingProsesProduksi do begin
    ExQry(Q1, getSQL('TableDivisiProses')+' WHERE i.itemno="'+DBAdvGrid1.Cells[1,DBAdvGrid1.Row]+'" '+
    ' ORDER BY s.no_urut ASC ',True);
    TampilanAwal;
    sg.RowCount :=  Q1.RecordCount + 2;
    for I := 0 to Q1.RecordCount -1 do begin

      sg.Cells[0,i+1] := getVal(Q1,'no_urut');
      sg.Cells[1,i+1] := getVal(Q1,'name');
      sg.Cells[2,i+1] := getVal(Q1,'deskripsi');
      sg.Cells[3,i+1] := getValR(Q1,'cost');
      sg.Cells[4,i+1] := getVal(Q1,'id');
      Q1.Next;

    end;


    LItemNo.Caption  := DBAdvGrid1.Cells[1,DBAdvGrid1.Row];
    Lproduct.Caption := DBAdvGrid1.Cells[2,DBAdvGrid1.Row];

    ShowModal;
  end;

end;

procedure TFDataBarang.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Barang.xls');


end;

procedure TFDataBarang.AdvSmoothButton4Click(Sender: TObject);
begin
  FSettingComponentProduct.LItemNo.Caption  := DBAdvGrid1.Cells[1,DBAdvGrid1.Row];
  FSettingComponentProduct.Lproduct.Caption := DBAdvGrid1.Cells[2,DBAdvGrid1.Row];
  FSettingComponentProduct.ShowModal;
end;

procedure TFDataBarang.AdvSmoothButton5Click(Sender: TObject);
var
  jpg : TJPEGImage;
  bs  : TStream;
begin

  with FInputBarang do begin

      isiCmb(Q1,'category ORDER BY name ASC',['id','name'],FinputBarang.cbKategori);
      isiCmb(Q1,'category_product ORDER BY nama_category ASC',['id','nama_category'],FinputBarang.cbJenis);
      isiCmb(Q1,'category_rakit ORDER BY deskripsi ASC',['id','deskripsi'],FinputBarang.cbJenisRakit);
      isiCmb(Q1,'category_buyer ORDER BY buyer_name ASC',['id','buyer_name'],FinputBarang.cbBuyer);


      idProduct             := DBAdvGrid1.Cells[7,DBAdvGrid1.Row];
      QBarang.Locate('id',idProduct,[]);
      EnoBarang.Text        := GetVal(QBarang,'itemno');
      EnamaBarang.Text      := GetVal(QBarang,'description');
      cbBuyer.ItemIndex     := idxCmb(cbBuyer,GetValInt(QBarang,'buyer_id'));
      cbKategori.ItemIndex  := idxCmb(cbKategori,GetValInt(QBarang,'item_category'));
      cbJenis.ItemIndex     := idxCmb(cbJenis,GetValInt(QBarang,'item_type'));
      cbJenisRakit.ItemIndex:= idxCmb(cbJenisRakit,GetValINt(QBarang,'jenis_rakit'));
      Estok.Text            := GetVal(QBarang,'stok');
      EHargaJual.Text       := GetVal(QBarang,'unit_price');
      EhargaPokok.Text      := GetVal(QBarang,'cost');
      EDiskon.Text          := GetVal(QBarang,'discount');
      Eberat.Text           := GetVal(QBarang,'weight');
      Etinggi.Text          := GetVal(QBarang,'dim_height');
      Epanjang.Text         := GetVal(QBarang,'dim_width');
      Elebar.Text           := GetVal(QBarang,'dim_depth');
      rbKD.Checked          := GetVal(QBarang,'jenis_set') = 'KD';
      RBSet.Checked         := GetVal(QBarang,'jenis_set') = 'SET UP';

      ExQry(Q1,'SELECT img FROM item WHERE id="'+GetVal(QBarang,'id')+'"',True);

      if Q1.FieldByName('img').IsNull then begin
         Image1.Picture :=  nil;
         //Exit;
      end else begin

          bs          := Q1.CreateBlobStream(Q1.FieldByName('img'),bmRead);
          jpg         :=TJPEGImage.Create;
          try
            try
              jpg.LoadFromStream(bs);
              bs.Position :=0;
              Image1.Picture.Assign(jpg);
            except

            end;
          finally
            jpg.Free;
            bs.Free;
          end;
      end;
      ShowModal;
  end;
end;

procedure TFDataBarang.btnAddClick(Sender: TObject);
begin
  isiCmb(Q1,'category ORDER BY name ASC',['id','name'],FinputBarang.cbKategori);
  isiCmb(Q1,'category_product ORDER BY nama_category ASC',['id','nama_category'],FinputBarang.cbJenis);
  isiCmb(Q1,'category_rakit ORDER BY deskripsi ASC',['id','deskripsi'],FinputBarang.cbJenisRakit);
  isiCmb(Q1,'category_buyer ORDER BY buyer_name ASC',['id','buyer_name'],FinputBarang.cbBuyer);
  FinputBarang.TampilanAwal;
  FinputBarang.ShowModal;
end;

procedure TFDataBarang.btnNextClick(Sender: TObject);
begin
  QBarang.Next;
end;

procedure TFDataBarang.btnPrivClick(Sender: TObject);
begin
  QBarang.Prior;
end;

procedure TFDataBarang.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData('',StrToIntDef(cbEntries.Text,0),varisPages );
  end;
end;

procedure TFDataBarang.cbEntriesChange(Sender: TObject);
begin
  LoadData('',StrToIntDef(cbEntries.Text,1),0);
  Pagination(0);
end;


procedure TFDataBarang.DBAdvGrid1Click(Sender: TObject);
var

  i   : integer;
begin

    ExQry(Q1,getSQL('TableDivisiProses')+' WHERE '+
    ' i.itemno="'+DBAdvGrid1.GridCells[1,DBAdvGrid1.Row]+'" GROUP BY d.id ORDER BY s.no_urut ASC',True);

    lb.Items.Clear;
    for  i := 0 to Q1.RecordCount -1 do begin
      lb.Items.Add(IntToStr(i+1)+'. '+GetVal(Q1,'name'));
      Q1.Next;
    end;

    Q1.Close;
    Q1.SQL.Text    := 'SELECT * FROM material_product WHERE itemno="'+DBAdvGrid1.GridCells[1,DBAdvGrid1.Row]+'"';
    Q1.Open;
    lb2.Items.Clear;
    i := 0;
    while not Q1.Eof do begin
      lb2.Items.Add(IntToStr(i+1)+'. '+GetVal(Q1,'nama')+'  ( '+GetVal(Q1,'jumlah')+' )');
      inc(i);
      Q1.Next;
    end;


end;

procedure TFDataBarang.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton5.Click;
end;

procedure TFDataBarang.DBAdvGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ARow > 0 then begin

    if (DBAdvGrid1.Cells[0,ARow]) <> '' then begin
       AFont.Style := [fsBold];
       ABrush.Color := $005BFF5B;

    end;
  end;

end;

procedure TFDataBarang.DBAdvGrid1GetDisplText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);

begin
  if (ARow >= 1) and (ACol = 0) then begin
     if DBAdvGrid1.GridCells[Acol,Arow -1] =
        DBAdvGrid1.GridCells[Acol,Arow] then begin
          Value := '';

        end;
  end;
end;

procedure TFDataBarang.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    LoadData(' AND (description LIKE "%'+Ecari.Text+'%" OR itemno LIKE "%'+ECari.Text+'%") ',StrToIntDef(cbEntries.Text,25),0);

    Pagination(0);
end;

procedure TFDataBarang.FormCreate(Sender: TObject);
begin
  FDataBarang  := Self;
  Ecari.isCari := True;
end;

procedure TFDataBarang.FormShow(Sender: TObject);
begin

  LoadData('',StrToIntDef(cbEntries.Text,25),0);
  Pagination(0);
end;

procedure TFDataBarang.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin

  ExQry(Qbarang,getSQL('TableProduct')+' WHERE  '+
  'inventory_group=3 '+isCari+' ORDER BY buyer_id ASC'+
  ' LIMIT '+IntToStr(isLimit)+''+
  ' OFFSET '+IntToStr(isLimit * isOffSet)+' '+
  ' ',True);
  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataBarang.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    totalWidht,TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM item WHERE  inventory_group=3 ',True);
  TotalData := GetValInt(Q1,'totaldata');
  jmlPage := TotalData div varIsLimit;
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
       Lentries.Caption := 'Showing '+IntToStr(QBarang.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

procedure TFDataBarang.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol in [0..11]) and (ARow = 0) then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
