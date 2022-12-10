unit uInputDivisi;

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
  TFinputDivisi = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edivno: TAdvEdit;
    EDeskripsi: TAdvEdit;
    Label13: TLabel;
    EPIC: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Label4: TLabel;
    ETenagaKerja: TAdvEdit;
    Label5: TLabel;
    Egaji: TAdvEdit;
    Label6: TLabel;
    cbColor: TAdvColorPickerDropDown;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private





    { Private declarations }
  public
    id : String;
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FinputDivisi: TFinputDivisi;


implementation
  uses
    uDataDivisi, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputDivisi.btnSimpanClick(Sender: TObject);
 var
  ls :TStringList;

begin
  if not CheckEdit(Self) then begin

       if cbColor.ItemIndex = -1 then begin
          Error('Warna inisial belum dipilih');
          Exit;

       end;
       ls := TStringList.Create;

       try

           AddParam('divno', Edivno.Text,ls,'str');
           AddParam('name', EDeskripsi.Text,ls,'str');
           AddParam('pic', Epic.Text,ls,'str');
           AddParam('jmlkaryawan', ETenagaKerja.Text,ls,'str');
           AddParam('gaji_karyawan', Egaji.isAngka,ls,'str');
           AddParam('initial_color', IntToStr(cbColor.SelectedColor),ls,'str');

           ExQry(Q1,'SELECT id FROM divisi WHERE id="'+id+'"',True);

           if Q1.isEmpty then
              exeDb(Q2,'divisi',ls)
           else
              UpdateDb(Q2,'divisi',ls,'id',GetVal(Q1,'id'));
           if Assigned(FDataDivisi) then begin
               FDataDivisi.QDivisi.Active := False;
               FDataDivisi.QDivisi.Active := True;
           end;
           TampilanAwal;
       finally
        ls.Free;
      end;



    
  end;
end;

procedure TFinputDivisi.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputDivisi.FormCreate(Sender: TObject);
begin
  Egaji.isRupiah := True;
end;

procedure TFinputDivisi.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputDivisi.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputDivisi.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputDivisi.TampilanAwal;
begin
  ClearText(Self);
end;

end.
