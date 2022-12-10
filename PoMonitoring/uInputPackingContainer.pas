unit uInputPackingContainer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFinputPackingContainer = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ECodeContainer: TAdvEdit;
    Label13: TLabel;
    ESONo: TAdvEdit;
    Label4: TLabel;
    EitemNo: TAdvEdit;
    Label5: TLabel;
    EDeskripsi: TAdvEdit;
    Label6: TLabel;
    ENomerKirim: TAdvEdit;
    Label8: TLabel;
    EqtyReady: TAdvEdit;
    Label9: TLabel;
    EQtyInput: TAdvEdit;
    dt1: TDateTimePicker;
    Label10: TLabel;
    ECbm: TAdvEdit;
    Label11: TLabel;
    ETotalCbm: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure EQtyInputChange(Sender: TObject);
  private
   

    procedure TampilanAwal;


    { Private declarations }
  public


    { Public declarations }
  end;

var
  FinputPackingContainer: TFinputPackingContainer;


implementation


{$R *.dfm}

uses uMarCon;

{ TFInputSupplier }

procedure TFinputPackingContainer.btnSimpanClick(Sender: TObject);
var
  varNomer : String;
  ls : TStringList;
  itemId : String;
begin
  if not CheckEdit(Self) then begin

     ls := TStringList.Create;
     try
         if EqtyReady.AsFLoat < EQtyInput.AsFLoat then begin
           Error('Input melebihi jumlah yang tersedia');
           Exit;
         end;

         varNomer :=GetCode(Q2,'shippment','nomer','');
         ExQry(Q3,'SELECT id FROM item WHERE itemno="'+EitemNo.Text+'"',True);
         itemId := GetVal(Q3,'id');
         AddParam('nomer', varNomer,ls,'str');
         AddParam('tgl',frmTgl(dt1.Date),ls,'date');
         AddParam('nomer_container',ECodeContainer.Text,ls,'str');
         AddParam('no_so', ESONo.Text,ls,'str');
         AddParam('item_id', itemId,ls,'str');
         AddParam('no_urut', ENomerKirim.Text,ls,'str');
         AddParam('qty_packing', EQtyInput.Text,ls,'str');
         AddParam('cbm',StrToDecimal(FloatToStr(EQtyInput.AsFLoat * (ECbm.AsFLoat/1000/1000/1000))),ls,'str');
         AddParam('stts','Packing',ls,'str');

         ExQry(Q1,'SELECT id FROM shippment WHERE nomer="'+varNomer+'"',True);

         if Q1.IsEmpty then
            exeDb(Q2,'shippment',ls)
         else
            updatedb(Q2,'shippment',ls,'id',GetVal(Q1,'id'));


         Informasi('Data berhasil disimpan');
         TampilanAwal;
     finally

     end;
  end;
end;

procedure TFinputPackingContainer.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputPackingContainer.EQtyInputChange(Sender: TObject);
begin
  if EQtyInput.AsInteger > EqtyReady.AsInteger then
  begin
    Error('Input melebihi Qty yang tersedia');
    Exit;
  end else begin
    ETotalCbm.Text := Format('%.2n',[EQtyInput.AsFLoat * ECbm.AsFLoat]);
  end;
end;

procedure TFinputPackingContainer.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputPackingContainer.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputPackingContainer.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputPackingContainer.TampilanAwal;
begin
  ClearText(Self);

end;

end.
