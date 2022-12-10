unit uInputKaryawan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox;
type
  TFinputKaryawan = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    QFB1: TZQuery;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    QM1: TZQuery;
    cbDivisi: TAdvComboBox;
    Label4: TLabel;
    Enama: TAdvEdit;
    Label5: TLabel;
    Ealamat: TAdvEdit;
    Label6: TLabel;
    Etelepon: TAdvEdit;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    yDb : TYDb;


    procedure TampilanAwal;
    procedure SetKaryawan;


    { Private declarations }
  public


    { Public declarations }
  end;

var
  FinputKaryawan: TFinputKaryawan;


implementation
 uses
  uDataKaryawan, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputKaryawan.btnSimpanClick(Sender: TObject);


begin
  if not CheckEdit(Self) then begin
     with yDB do begin
       Table := 'karyawan';

       FieldString('id_divisi', GetIdcmb(cbDivisi));
       FieldString('karyawan_no', Enomer.Text);
       FieldString('nama', Enama.Text);
       FieldString('alamat', Ealamat.Text);
       FieldString('telpon', Etelepon.Text);
       Save(Fid);
     end;


     TampilanAwal;
     if Assigned(FDataKaryawan) then
     FDataKaryawan.LoadData(
     StrToIntDef(FDataKaryawan.cbEntries.Text,10),
     0);
  end;
end;

procedure TFinputKaryawan.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputKaryawan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  yDb.Free;
end;

procedure TFinputKaryawan.FormShow(Sender: TObject);
begin
  yDb       := TYDb.Create(MariaCon.ZMy);
  yDb.Table := 'divisi';
  QM1.Connection := yDb.Conn;

  isiCmb(QM1,'divisi',['id','name'],cbDivisi);

  if FCanEdit then
     SetKaryawan else
     TampilanAwal;
end;

procedure TFinputKaryawan.SetKaryawan;
begin
  yDb.SQL := 'SELECT * FROM karyawan';
  yDb.getData('id',Fid);

  cbDivisi.ItemIndex  := idxCmb(cbDivisi,yDb.ValInt('id_divisi'));
  Enomer.Text         := yDb.ValString('karyawan_no');
  Enama.Text          := yDb.ValString('nama');
  Ealamat.Text        := yDb.ValString('alamat');
  Etelepon.Text       := yDb.ValString('telpon');
end;

procedure TFinputKaryawan.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputKaryawan.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputKaryawan.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputKaryawan.TampilanAwal;
begin
  ClearText(Self);
  Fid       := 0;

  FCanEdit       := False;

end;

end.
