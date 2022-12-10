unit uInputProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,JPEG,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvOfficeButtons, MemDS, DBAccess, MyAccess, Vcl.ExtDlgs;
type
  TFinputBarang = class(TForm)
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
    Label6: TLabel;
    AdvGroupBox2: TAdvGroupBox;
    AdvGroupBox3: TAdvGroupBox;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvGroupBox4: TAdvGroupBox;
    Image1: TImage;
    EnoBarang: TAdvEdit;
    EnamaBarang: TAdvEdit;
    cbKategori: TAdvComboBox;
    AdvSmoothButton3: TAdvSmoothButton;
    EHargaJual: TAdvEdit;
    EDiskon: TAdvEdit;
    Label8: TLabel;
    Label9: TLabel;
    Epanjang: TAdvEdit;
    Elebar: TAdvEdit;
    Label10: TLabel;
    Etinggi: TAdvEdit;
    Bevel1: TBevel;
    Label11: TLabel;
    Eberat: TAdvEdit;
    Label12: TLabel;
    EhargaPokok: TAdvEdit;
    Label13: TLabel;
    Estok: TAdvEdit;
    Label14: TLabel;
    cbJenis: TAdvComboBox;
    Label15: TLabel;
    rbKD: TAdvOfficeRadioButton;
    RBSet: TAdvOfficeRadioButton;
    Label16: TLabel;
    EStepRakit: TAdvEdit;
    Label17: TLabel;
    cbJenisRakit: TAdvComboBox;
    Q1: TMyQuery;
    Q2: TMyQuery;
    op: TOpenPictureDialog;
    Label18: TLabel;
    cbBuyer: TAdvComboBox;
    AdvSmoothButton4: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
  private





    { Private declarations }
  public
    idProduct : String;
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FinputBarang: TFinputBarang;


implementation
  uses
    uDataBarang,uInputKategori, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputBarang.AdvSmoothButton1Click(Sender: TObject);
begin
  if op.Execute then begin
     Image1.Picture.LoadFromFile(op.FileName);

  end;
end;

procedure TFinputBarang.AdvSmoothButton2Click(Sender: TObject);
begin
  Image1.Picture := nil;
end;

procedure TFinputBarang.AdvSmoothButton3Click(Sender: TObject);
begin
  FinputKategori.ShowModal;
end;

procedure TFinputBarang.btnSimpanClick(Sender: TObject);
var
  

  JenisSet : String;
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin

     ls := TStringList.Create;

     try

             addParam('itemno', EnoBarang.Text,ls,'str');
             addParam('description', EnamaBarang.Text,ls,'str');

             if cbJenis.ItemIndex <> - 1 then
             addParam('item_type', GetIdcmb(cbJenis),ls,'str');
             if cbJenisRakit.ItemIndex <> - 1 then
             addParam('jenis_rakit', GetIdcmb(cbJenisRakit),ls,'str');
             if cbBuyer.ItemIndex <> - 1 then
             addParam('buyer_id', GetIdcmb(cbBuyer),ls,'str');
             if cbKategori.ItemIndex <> - 1 then
             addParam('item_category', GetIdcmb(cbKategori),ls,'str');
             addParam('stok', StrToDecimal(Estok.Text),ls,'str');
             addParam('unit_price', StrToDecimal(EHargaJual.Text),ls,'str');
             addParam('cost', StrToDecimal(EhargaPokok.Text),ls,'str');
             addParam('discount', StrToDecimal(EDiskon.Text),ls,'str');
             addParam('weight', StrToDecimal(Eberat.Text),ls,'str');
             addParam('dim_height',StrToDecimal(Etinggi.Text),ls,'str');
             addParam('dim_width', StrToDecimal(Epanjang.Text),ls,'str');
             addParam('dim_depth', StrToDecimal(Elebar.Text),ls,'str');
             addParam('inventory_group', '3',ls,'str');
             if rbKD.Checked then JenisSet := 'KD' else
             JenisSet := 'SET UP';
             addParam('jenis_set', JenisSet,ls,'str');
             addParam('step_rakit', StrToDecimal(EStepRakit.Text),ls,'str');

             ExQry(Q1,'SELECT id FROM item WHERE id="'+idProduct+'"',False);

             if Q1.isEmpty then
                ExeDb(Q2,'item',ls)
             else
                UpdateDb(Q2,'item',ls,'id',idProduct);


             if image1.Picture.Graphic = nil then begin

                 Q2.Close;
                 Q2.SQL.Text := 'UPDATE item SET img=:img WHERE itemno="'+EnoBarang.Text+'"';
                 Q2.Params.ParamValues['img'] := null;
                 Q2.ExecSQL;
             end;
             if op.FileName <> '' then begin

                 Q2.Close;
                 Q2.SQL.Text := 'UPDATE item SET img=:img WHERE itemno="'+EnoBarang.Text+'"';
                 Q2.ParamByName('img').LoadFromFile(op.FileName,ftBlob);
                 Q2.ExecSQL;
             end;



           TampilanAwal;
           if Assigned(FDataBarang) then
           FDataBarang.LoadData('',
           StrToIntDef(FDataBarang.cbEntries.Text,10),
           0);
     finally
       ls.free;
     end;
  end;
end;

procedure TFinputBarang.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputBarang.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputBarang.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputBarang.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputBarang.TampilanAwal;
begin
  ClearText(Self);
  idProduct      := '';
  EnoBarang.text := GetCode(Q1,'item','itemno','ADW');
  Image1.Picture := nil;

end;

end.
