unit uInputProcess;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl, uPatchForm,AnnabaDB,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, Vcl.ComCtrls;
type
  TFinputProcess = class(TForm)
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
    QM1: TZQuery;
    Label4: TLabel;
    Enama: TAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    Etelepon: TAdvEdit;
    AdvEdit1: TAdvEdit;
    DateTimePicker1: TDateTimePicker;
    cbDivisi: TAdvComboBox;
    Label8: TLabel;
    AdvEdit2: TAdvEdit;
    sg: TAdvStringGrid;
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
    procedure GridProcess;


    { Private declarations }
  public


    { Public declarations }
  end;

var
  FinputProcess: TFinputProcess;


implementation
 uses
  uDataKaryawan;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputProcess.btnSimpanClick(Sender: TObject);


begin
  if not CheckEdit(Self) then begin
     with yDB do begin
       Table := 'karyawan';

       FieldString('id_divisi', GetIdcmb(cbDivisi));
       FieldString('nama', Enama.Text);
       FieldString('telpon', Etelepon.Text);
       Save(Fid);
     end;


     TampilanAwal;
  end;
end;

procedure TFinputProcess.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputProcess.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  yDb.Free;
end;

procedure TFinputProcess.FormShow(Sender: TObject);
begin
  yDb       := TYDb.Create;
  yDb.Table := 'divisi';
  QM1.Connection := yDb.Conn;
  GridProcess;

  isiCmb(QM1,'divisi',['id','name'],cbDivisi);

  if FCanEdit then
     SetKaryawan else
     TampilanAwal;
end;

procedure TFinputProcess.GridProcess;
begin
  with sg do begin

    ColCOunt := 3;
    RowCount := 2;

    Cells[0,0] := 'Pekerjaan';
    Cells[1,0] := 'Masuk';
    Cells[2,0] := 'Selesai';

    ColWidths[0] := 200;
    Colwidths[1] := 80;
    Colwidths[2] := 80;

    ColumnSize.StretchColumn := 0;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFinputProcess.SetKaryawan;
begin
  yDb.SQL := 'SELECT * FROM karyawan';
  yDb.getData('id',Fid);

  cbDivisi.ItemIndex  := idxCmb(cbDivisi,yDb.ValInt('id_divisi'));
  Enama.Text          := yDb.ValString('nama');
  Etelepon.Text       := yDb.ValString('telpon');
end;

procedure TFinputProcess.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputProcess.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputProcess.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputProcess.TampilanAwal;
begin
  ClearText(Self);
  Fid       := 0;

  FCanEdit       := False;
  if Assigned(FDataKaryawan) then
     FDataKaryawan.LoadData(
     StrToIntDef(FDataKaryawan.cbEntries.Text,10),
     0);
end;

end.
