unit uBeritaAcara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, AdvEdit, uComCtrl, uEngine, Data.DB, MemDS, DBAccess,
  MyAccess, uOvEdit;

type
  TFBeritaAcara = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EnoHasilKerja: TAdvEdit;
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
  FBeritaAcara: TFBeritaAcara;

implementation

{$R *.dfm}

uses uMarCon, uInputHasilKerja;

procedure TFBeritaAcara.btnSimpanClick(Sender: TObject);
var
  ls : TStringList;
begin
  if Not CheckEdit(Self) then begin
     ls := TStringLIst.Create;
     try
        addParam('nomer_hasil_kerja', EnoHasilKerja.Text,ls,'str');
        addParam('description', Edescription.Text,ls,'str');
        addParam('qty', StrToDecimal(Eqty.Text),ls,'str');
        addParam('mh', StrToDecimal(EMh.Text),ls,'str');
        addParam('cost', StrToDecimal(ECost.Text),ls,'str');
        addParam('total_cost', StrToDecimal(EtotalCost.Text),ls,'str');
        exeDb(Q1,'temp_by_accident',ls);

     finally
       ls.Free;
       FinputHasilKerja.LoadBA;
       TampilanAwal;

     end;
     EnoHasilKerja.Text := FinputHasilKerja.Enomer.Text;
  end;

end;

procedure TFBeritaAcara.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFBeritaAcara.EqtyChange(Sender: TObject);
var
  qty , Cost : Real;
begin
  Qty   := StrToFloatDef(nilai(Eqty.Text),0);
  Cost  := StrToFloatDef(nilai(ECost.Text),0);

  EtotalCost.Text := Format('%.0n',[qty * Cost]);


end;

procedure TFBeritaAcara.FormCreate(Sender: TObject);
begin
  Eqty.isRupiah       := True;
  ECost.isRupiah      := True;
  EtotalCost.isRupiah := True;
end;

procedure TFBeritaAcara.TampilanAwal;
begin
  ClearText(Self);
end;

end.
