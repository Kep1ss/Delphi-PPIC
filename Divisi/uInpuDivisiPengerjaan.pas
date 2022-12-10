unit uInpuDivisiPengerjaan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, MemDS, DBAccess, MyAccess, AsgCombo, ColorCombo, Vcl.Mask,
  AdvDropDown, AdvColorPickerDropDown;
type
  TFinputDivisiPengerjaan = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label2: TLabel;
    EDeskripsi: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Label4: TLabel;
    ETenagaKerja: TAdvEdit;
    Label1: TLabel;
    Egaji: TAdvEdit;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
  private





    { Private declarations }
  public
    id : String;
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FinputDivisiPengerjaan: TFinputDivisiPengerjaan;


implementation
  uses
    uDataDivisi, uMarCon, uDataDivisiPengerjaan;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputDivisiPengerjaan.btnSimpanClick(Sender: TObject);
 var
  ls :TStringList;

begin
  if not CheckEdit(Self) then begin

       ls := TStringList.Create;

       try


           AddParam('name', EDeskripsi.Text,ls,'str');
           AddParam('jml_karyawan', StrToDecimal(ETenagaKerja.Text),ls,'str');
           AddParam('gaji_karyawan', StrToDecimal(Egaji.Text),ls,'str');

           ExQry(Q1,'SELECT id FROM divisi_pengerjaan WHERE id="'+id+'"',True);

           if Q1.isEmpty then
              exeDb(Q2,'divisi_pengerjaan',ls)
           else
              UpdateDb(Q2,'divisi_pengerjaan',ls,'id',GetVal(Q1,'id'));
           if Assigned(FDataDivisiPengerjaan) then begin
               FDataDivisiPengerjaan.QDivisi.Active := False;
               FDataDivisiPengerjaan.QDivisi.Active := True;
           end;
           TampilanAwal;
       finally
        ls.Free;
      end;



    
  end;
end;

procedure TFinputDivisiPengerjaan.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputDivisiPengerjaan.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputDivisiPengerjaan.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputDivisiPengerjaan.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputDivisiPengerjaan.TampilanAwal;
begin
  ClearText(Self);
end;

end.
