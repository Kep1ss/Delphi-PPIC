unit uSettingProsesProduksi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, MemDS, DBAccess, MyAccess;
type
  TFSettingProsesProduksi = class(TForm)
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
    LItemNo: TLabel;
    Lproduct: TLabel;
    sg: TAdvStringGrid;
    Label6: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    Label8: TLabel;
    Q1: TMyQuery;
    Q2: TMyQuery;
    PopupMenu1: TPopupMenu;
    InsertRow1: TMenuItem;
    DeleteRow1: TMenuItem;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InsertRow1Click(Sender: TObject);
    procedure DeleteRow1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private





    { Private declarations }
  public
    function checkDivisi(idDivisi:String):Boolean;
    function listIdPekerjaan:String;
    procedure TampilanAwal;
    procedure GridProses;
    procedure upDateNumber;

    { Public declarations }
  end;

var
  FSettingProsesProduksi: TFSettingProsesProduksi;


implementation
 uses
    uDataJobs, uListOfDivisi, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFSettingProsesProduksi.AdvSmoothButton1Click(Sender: TObject);
begin
  FDaftarDivisi.isForm := 2;
  FDaftarDivisi.ShowModal;
end;

procedure TFSettingProsesProduksi.btnSimpanClick(Sender: TObject);
var
  item_id , i : Integer;
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin

       ls := TStringList.Create;

       try
           item_id := StrToIntDef(getData(Q1,'item WHERE itemno="'+LItemNo.Caption+'"','id'),0);
           ExQry(Q2,'DELETE FROM setting_process WHERE item_id="'+IntToStr(Item_Id)+'"',False);

           for i := 1 to sg.RowCount -1 do begin
              if sg.Cells[1,i] <> '' then begin
                 addParam('item_id',IntToStr(item_id),ls,'str');
                 addParam('no_urut',sg.Cells[0,i],ls,'str');
                 addParam('id_pekerjaan',sg.Cells[4,i],ls,'str');
                 addParam('cost',StrToDecimal(sg.Cells[3,i]),ls,'str');
                 ExeDb(Q1,'setting_process',ls);
              end;
           end;
           Informasi('Setting Process Berhasil Disimpan');
           TampilanAwal;
       finally
        ls.Free;
       end;
     end;

end;

procedure TFSettingProsesProduksi.btnTutupClick(Sender: TObject);
begin
  Close;
end;


function TFSettingProsesProduksi.checkDivisi(idDivisi:String): Boolean;
var
  i : integer;
begin
  Result := False;

  for i := 1 to sg.RowCount -1 do begin
     if sg.Cells[3,i] <> '' then begin
        if sg.Cells[3,i] = idDivisi then
        begin
          Result := True;
          Break;
        end;

     end;

  end;

end;

procedure TFSettingProsesProduksi.DeleteRow1Click(Sender: TObject);
  var
  i : integer;
begin
  sg.RemoveRows(sg.Row,1);
  for i := sg.Row to sg.RowCount -1 do
    sg.MoveRow(sg.Row+1,sg.Row);
  upDateNumber;
end;

procedure TFSettingProsesProduksi.FormCreate(Sender: TObject);
begin
  GridProses;
end;

procedure TFSettingProsesProduksi.FormShow(Sender: TObject);
begin
  sg.Row := sg.RowCount -1;
end;

procedure TFSettingProsesProduksi.GridProses;
begin
  with sg do begin

    ClearAll;

    ColCount := 5;
    RowCount := 2;
    FixedCols := 0;

    Cells[0,0] := 'No Urut';
    Cells[1,0] := 'Divisi';
    Cells[2,0] := 'Pekerjaan';
    Cells[3,0] := 'Cost';
    Cells[4,0] := 'id';

    ColWidths[0] := 50;
    ColWidths[1] := 150;
    ColWidths[2] := 250;
    ColWidths[3] := 100;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;

  end;
end;



procedure TFSettingProsesProduksi.InsertRow1Click(Sender: TObject);
begin
  sg.InsertRows(sg.Row + 1,1);
  sg.Row := sg.Row + 1;
  upDateNumber;
  FDaftarDivisi.isForm := 2;
  FDaftarDivisi.ShowModal;
end;

function TFSettingProsesProduksi.listIdPekerjaan: String;
var
  i : integer;

  str : String;
begin

  str := '';

  for i := 1 to sg.RowCount -1 do begin
     if sg.Cells[3,i] <> '' then
        str := str + '"'+sg.Cells[3,i]+'",';
  end;
  Delete(str,length(str),1);
  Result := str;

end;


procedure TFSettingProsesProduksi.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin

     CanEdit := ACol > 1;
end;

procedure TFSettingProsesProduksi.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFSettingProsesProduksi.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL = 3 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFSettingProsesProduksi.sgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    i : integer;
begin
  if Key = VK_DELETE then begin
      sg.ClearRows(sg.Row,1);
      for I := sg.Row to sg.RowCount - 1 do
      sg.MoveRow(I + 1, i);
      sg.RowCount := sg.RowCount - 1;
  end;
end;

procedure TFSettingProsesProduksi.TampilanAwal;
begin
  ClearText(Self);
  GridProses;
end;

procedure TFSettingProsesProduksi.upDateNumber;
var
  i : integer;
begin
  for i := 1 to sg.RowCount -1 do begin
     sg.Cells[0,i] := IntToStr(i);

  end;

end;

end.
