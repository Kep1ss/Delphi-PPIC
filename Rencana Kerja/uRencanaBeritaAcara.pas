unit uRencanaBeritaAcara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, AdvEdit, uComCtrl, uEngine, Data.DB, MemDS, DBAccess,
  MyAccess, uOvEdit;

type
  TFRencanaBeritaAcara = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EnoRencana: TAdvEdit;
    Edescription: TAdvEdit;
    Label4: TLabel;
    Eqty: TAdvEdit;
    Label5: TLabel;
    EMh: TAdvEdit;
    Label6: TLabel;
    ECost: TAdvEdit;
    Label8: TLabel;
    EtotalCost: TAdvEdit;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure EqtyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TampilanAwal;
  end;

var
  FRencanaBeritaAcara: TFRencanaBeritaAcara;

implementation

{$R *.dfm}

uses uMarCon, uInputRencanaKerja;

procedure TFRencanaBeritaAcara.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;
begin
  if Not CheckEdit(Self) then begin
     ls := TStringLIst.Create;
     try
        addParam('nomer_rencana_kerja', EnoRencana.Text,ls,'str');
        addParam('description', Edescription.Text,ls,'str');
        addParam('qty', StrToDecimal(Eqty.Text),ls,'str');
        addParam('mh', StrToDecimal(EMh.Text),ls,'str');
        addParam('cost', StrToDecimal(ECost.Text),ls,'str');
        addParam('total_cost', StrToDecimal(EtotalCost.Text),ls,'str');
        exeDb(Q1,'temp_rencana_berita_acara',ls);

     finally
       ls.Free;
       FinputRencanaKerja.LoadBA;
       TampilanAwal;
     end;

  end;

end;

procedure TFRencanaBeritaAcara.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFRencanaBeritaAcara.EqtyChange(Sender: TObject);
var
  qty , Cost : Real;
begin
  Qty   := StrToFloatDef(nilai(Eqty.Text),0);
  Cost  := StrToFloatDef(nilai(ECost.Text),0);

  EtotalCost.Text := Format('%.0n',[qty * Cost]);


end;

procedure TFRencanaBeritaAcara.FormCreate(Sender: TObject);
begin
  Eqty.isRupiah       := True;
  ECost.isRupiah      := True;
  EtotalCost.isRupiah := True;
end;

procedure TFRencanaBeritaAcara.TampilanAwal;
begin
  ClearText(Self);
end;

end.
