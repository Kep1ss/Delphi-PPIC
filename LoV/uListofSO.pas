unit uListofSO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, DBAccess, MyAccess, DBAdvGrid, MemDS,
  Vcl.ComCtrls;


type
  TFDaftarSO = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    QLoV: TMyQuery;
    Q1: TMyQuery;
    DLoV: TMyDataSource;
    Label2: TLabel;
    Lnamadivisi: TLabel;
    Liddivisi: TLabel;
    sgSo: TAdvStringGrid;
    btnPilih: TAdvSmoothButton;
    Label4: TLabel;
    dtTgl1: TDateTimePicker;
    Label5: TLabel;
    dtTgl2: TDateTimePicker;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBAdvGrid1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure btnPilihClick(Sender: TObject);
    procedure sgSoCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure dtTgl1CloseUp(Sender: TObject);
  private


    procedure TampilanAwal;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);

    function checkData(itemno:String;no_so:string;no_container:string):boolean;
  end;

var
  FDaftarSO: TFDaftarSO;


implementation



{$R *.dfm}

uses  uMarCon, uInputJobOrder;



{ TFinputMotif }

procedure TFDaftarSO.btnFindClick(Sender: TObject);
begin

  LoadGrid(' WHERE ( g.so_no LIKE "%'+Ecari.Text+'%" '+
  ' OR g.nomer_container LIKE "%'+Ecari.Text+'%" OR gd.deskripsi LIKE "%'+Ecari.Text+'%" ) '+
  ' AND gd.id_divisi="'+LidDivisi.Caption+'" ');
end;

procedure TFDaftarSO.btnPilihClick(Sender: TObject);
var
  SisaManHour : Integer;
  ItemPermenit: Integer;
  Manhour     : Integer;
  TotalAlokasi: Integer;
  Target      : Integer;
  i : integer;
  isCheck : boolean;
begin
  With FinputJobOrder do begin

     for i := 1 to sgSo.RowCount -1 do begin
         sgSo.GetCheckBoxState(8,i,isCheck);
         if isCheck = True then begin
             ExQry(QLoV,getSQL('GantChart')+' WHERE g.so_no="'+sgSo.Cells[0,i]+'" '+
             ' AND g.nomer_container="'+sgSo.Cells[1,i]+'" '+
             ' AND gd.itemno="'+sgSo.Cells[2,i]+'" AND gd.id_divisi="'+LidDivisi.Caption+'"',True);

             if checkData(GetVal(QLoV,'itemno'),GetVal(QLov,'so_no'),GetVal(QLov,'nomer_container')) then begin
                Error('Item Sudah '+GetVal(QLov,'deskripsi')+#13' No SO '+GetVal(QLov,'so_no')+#13+
                ' Container '+GetVal(QLov,'nomer_container')+' Dimasukan');
                Continue;
             end;
              begin
                 sg.Cells[0,sg.RowCount -1] := IntToStr(sg.RowCount -2);
                 sg.Cells[1,sg.RowCount -1] := GetVal(QLov,'nomer_container');
                 sg.Cells[2,sg.RowCount -1] := GetVal(QLov,'itemno');
                 sg.Cells[3,sg.RowCount -1] := GetVal(QLov,'deskripsi');
                 sg.Cells[4,sg.RowCount -1] := GetVal(QLov,'qty_order');
                 sg.Cells[5,sg.RowCount -1] := Format('%.0n',[GetValF(QLov,'manhour') / GetValF(QLov,'qty_order')]);
                 sg.Cells[6,sg.RowCount -1] := GetValR(QLov,'manhour');
                 sg.Cells[7,sg.RowCount -1] := GetVal(QLov,'alokasi_tng_kerja');
                 sg.Cells[8,sg.RowCount -1] := Format('%.0n',[GetValF(QLov,'alokasi_tng_kerja') * GetValF(Qlov,'jam_kerja') * 60]) ;

                 ItemPermenit := Round(GetValF(QLov,'manhour') / GetValF(QLov,'qty_order'));
                 Manhour      := GetValInt(QLov,'manhour');
                 TotalAlokasi := GetValInt(QLov,'alokasi_tng_kerja') * GetValInt(Qlov,'jam_kerja') * 60;
                 SisaManHour  := TotalAlokasi - Manhour;
                 Target       := Round(SisaManHour / ItemPermenit) + GetValInt(QLov,'qty_order');

                 sg.Cells[9,sg.RowCount -1]  := IntToStr(Target);
                 sg.Cells[10,sg.RowCount -1] := GetVal(Qlov,'tgl_mulai');
                 sg.Cells[11,sg.RowCount -1] := GetVal(Qlov,'tgl_akhir');
                 sg.Cells[12,sg.RowCount -1] := GetVal(QLov,'item_id');
                 sg.Cells[13,sg.RowCount -1] := GetVal(QLov,'so_no');
                 sg.Cells[14,sg.RowCount -1] := GetVal(QLov,'id');
                 sg.RowCount := sg.RowCount + 1;
                 sg.Row      := sg.RowCount -1;
                 sg.SetFocus;
                 sg.Col    := 1;
             end;
         end;
     end;


  end;
  Close;
end;

procedure TFDaftarSO.btnTutupClick(Sender: TObject);
begin
  Close;
end;



function TFDaftarSO.checkData(itemno:String;no_so:string;no_container:string): boolean;
var
  i : integer;
begin
  Result := False;
  with FinputJobOrder do begin
     for i := 2 to sg.RowCount -1 do begin
        if (sg.Cells[2,i] = itemNo) and (sg.Cells[1,i] = no_container) and  (sg.Cells[13,i] = no_so) then
        begin
          Result := True;
          break;
        end else begin
          Result:= false;
        end;


     end;
  end;
end;

procedure TFDaftarSO.DBAdvGrid1CanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol = 8;

end;

procedure TFDaftarSO.dtTgl1CloseUp(Sender: TObject);
begin
  LoadGrid(' WHERE gd.tgl_mulai>="'+Tanggal(dtTgl1.Date)+'" AND gd.tgl_mulai<="'+Tanggal(dtTgl2.Date)+'" '+
  ' AND gd.id_divisi="'+LidDivisi.Caption+'" AND gd.id NOT IN(SELECT gant_detail_id FROM detail_job_order)');
end;

procedure TFDaftarSO.FormShow(Sender: TObject);
begin


  TampilanAwal;
  dtTgl1.Date := Now;
  dtTgl2.Date := Now + 30;
end;

procedure TFDaftarSO.LoadGrid(Filter: String);
var
  i : integer;


begin
   with sgSo Do begin
     ClearAll;

     ColCount := 10;
     RowCount := 2;
     FixedCols:= 0;

     Cells[0,0] := 'No SO';
     Cells[1,0] := 'No Container';
     Cells[2,0] := 'Item No';
     Cells[3,0] := 'Deskripsi';
     Cells[4,0] := 'Qty';
     Cells[5,0] := 'Divisi';
     Cells[6,0] := 'Tgl Mulai';
     Cells[7,0] := 'Tgl Selesai';
     Cells[8,0] := 'Pilih';
     Cells[9,0] := 'Gant Detail Id';

     ColWidths[0] := 100;
     ColWidths[1] := 100;
     ColWidths[2] := 100;
     ColWidths[3] := 200;
     ColWidths[4] := 70;
     ColWidths[5] := 100;
     ColWidths[6] := 100;
     ColWidths[7] := 100;
     ColWidths[8] := 50;
     ColWidths[9] := 0;

     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;
   end;

   ExQry(QLov,getSQL('GantChart')+ Filter+' ORDER BY gd.tgl_mulai ASC',True);

   i := 1;
   sgSo.RowCount := QLoV.RecordCount + 1;
   while not QLoV.Eof do begin
      sgSo.Cells[0,i] := GetVal(QLoV,'so_no');
      sgSo.Cells[1,i] := GetVal(QLoV,'nomer_container');
      sgSo.Cells[2,i] := GetVal(QLoV,'itemno');
      sgSo.Cells[3,i] := GetVal(QLoV,'deskripsi');
      sgSo.Cells[4,i] := GetVal(QLoV,'qty_order');
      sgSo.Cells[5,i] := GetVal(QLoV,'keterangan');
      sgSo.Cells[6,i] := GetVal(QLoV,'tgl_mulai');
      sgSo.Cells[7,i] := GetVal(QLoV,'tgl_akhir');
      sgSo.Cells[9,i] := GetVal(QLoV,'id');
      sgSo.AddCheckBox(8,i,false,false);
      Inc(i);
      QLoV.Next;
   end;

end;

procedure TFDaftarSO.sgSoCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit := ACol = 8;
end;

procedure TFDaftarSO.TampilanAwal;
begin
  ClearText(Self);



end;

end.
