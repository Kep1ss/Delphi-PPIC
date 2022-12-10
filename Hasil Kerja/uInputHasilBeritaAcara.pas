unit uInputHasilBeritaAcara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFInputHasilBeritaAcara = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    dt1: TDateTimePicker;
    AdvGroupBox2: TAdvGroupBox;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Label7: TLabel;
    AdvSmoothButton2: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    AdvGroupBox3: TAdvGroupBox;
    Label6: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    EHasilKerja: TAdvEdit;
    Egaji: TAdvEdit;
    Elembur: TAdvEdit;
    EtotalGaji: TAdvEdit;
    EPlusmin: TAdvEdit;
    Eprosentase: TAdvEdit;
    EjmlTenagaKerja: TAdvEdit;
    Q3: TMyQuery;
    Label8: TLabel;
    cbDivisiPengerjaan: TAdvComboBox;
    sgBa: TAdvStringGrid;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure EjmlTenagaKerjaChange(Sender: TObject);
    procedure EgajiChange(Sender: TObject);
    procedure ElemburChange(Sender: TObject);
    procedure EHasilKerjaChange(Sender: TObject);
    procedure cbDivisiPengerjaanChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure sgBaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure sgBaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  

    procedure TampilanAwal;



    { Private declarations }
  public
    id : String;
    procedure GridBA;
    procedure Counter;

    { Public declarations }
  end;

var
  FInputHasilBeritaAcara: TFInputHasilBeritaAcara;


implementation
 uses
   uListofSO, uMarCon, uListSoRencanKerja, uDaftarRencanaKerja, uBeritaAcara,
  uDaftarItemFails;


{$R *.dfm}

{ TFInputSupplier }

procedure TFInputHasilBeritaAcara.AdvSmoothButton1Click(Sender: TObject);
begin
  FBeritaAcara.TampilanAwal;
  FBeritaAcara.EnoHasilKerja.Text := Enomer.Text;
  FBeritaAcara.ShowModal;
end;

procedure TFInputHasilBeritaAcara.AdvSmoothButton2Click(Sender: TObject);
begin
  FDaftarItemFails.ShowModal;
end;

procedure TFInputHasilBeritaAcara.AdvSmoothButton3Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin BA akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = MrYes then
  begin
    ExQry(Q1,'DELETE FROM temp_by_accident WHERE id="'+sgBa.Cells[6,sgBa.Row]+'"',False);

  end;
end;

procedure TFInputHasilBeritaAcara.btnSimpanClick(Sender: TObject);
var
  i , item_id: integer;
  ls  :TStringList;
begin
  if not CheckEdit(Self) then begin
     ls := TStringList.Create;

     try

         addParam('nomer',       Enomer.Text,ls,'str');
         addParam('tgl',         frmTgl(Dt1.Date),ls,'date');
         addParam('id_divisi',   GetIdCmb(cbDivisiPengerjaan),ls,'str');
         AddParam('jml_tenaga_kerja', Ejmltenagakerja.Text,ls,'str');
         AddParam('gaji',        EGaji.IsAngka,ls,'str');
         AddParam('lembur',      Elembur.IsAngka,ls,'str');
         AddParam('total_gaji',  EtotalGaji.IsAngka,ls,'str');
         AddParam('hasil_kerja', EhasilKerja.IsAngka,ls,'str');
         AddParam('plus_minus',  EPlusmin.IsAngka,ls,'str');
         AddParam('prosentase',  Eprosentase.IsAngka,ls,'str');
         addParam('id_user',     GetIdUser,ls,'str');
         addParam('divisi_process',GetIdcmb(cbDivisiPengerjaan),ls,'str');
         ExQry(Q2,'SELECT id FROM hasil_kerja WHERE nomer="'+Enomer.Text+'"',True);

         if Q2.isEmpty then
            ExeDB(Q1,'hasil_kerja',ls)
         else
            UpdateDB(Q1,'hasil_kerja',ls,'id',GetVal(Q2,'id'));

         ExQry(Q1,'DELETE FROM by_accident WHERE nomer_hasil_kerja="'+Enomer.Text+'"',False);


         for I := 1 to sgBa.RowCount -1 do begin
          if sgBa.Cells[2,i] <> '' then begin

               addParam('tgl', frmTgl(dt1.Date), ls,'date');
               addParam('id_divisi',GetIdCmb(cbDivisiPengerjaan), ls,'str');
               addParam('nomer_hasil_kerja', Enomer.Text,ls,'str');
               addParam('no_so', sgBa.Cells[1,i],ls,'str');
               addParam('nomer_container',sgBa.Cells[2,i],ls,'str');
               addParam('item_id', sgBa.Cells[9,i],ls,'str');
               addParam('description', sgBa.Cells[4,i],ls,'str');
               addParam('qty', StrToDecimal(sgBa.Cells[5,i]),ls,'str');
               addParam('mh', StrToDecimal(sgBa.Cells[6,i]),ls,'str');
               addParam('cost', StrToDecimal(sgBa.Cells[7,i]),ls,'str');
               addParam('total_cost', StrToDecimal(sgBa.Cells[8,i]),ls,'str');
               exeDb(Q1,'by_accident',ls);

               ExQry(Q1,'UPDATE item_finished SET qty_failed=qty_failed-"'+StrToDecimal(sgBa.Cells[5,i])+'",'+
               'qty_pass=qty_pass+"'+StrToDecimal(sgBa.Cells[5,i])+'" '+
               ' WHERE no_so="'+sgBa.Cells[1,i]+'" '+
               ' AND nomer_container="'+sgBa.Cells[2,i]+'" '+
               ' AND item_id="'+sgBa.Cells[9,i]+'"',False);

         end;
         end;


         Informasi('Hasil Kerja Berhasil Disimpan');
         TampilanAwal;

     finally
       ls.Free;
     end;
  end;
end;

procedure TFInputHasilBeritaAcara.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFInputHasilBeritaAcara.cbDivisiPengerjaanChange(Sender: TObject);
begin
  if cbDivisiPengerjaan.ItemIndex >= 0 then begin
     ExQry(Q1,'SELECT jmlkaryawan,gaji_karyawan FROM divisi WHERE id="'+GetIdcmb(cbDivisiPengerjaan)+'"',True);

     EjmlTenagaKerja.Text := GetVal(Q1,'jmlkaryawan');

  end;
end;


procedure TFInputHasilBeritaAcara.Counter;
var
  i : integer;
  TotalBA : Real;
begin
  TotalBA         := SumGrid(sgBa,8);
  EHasilKerja.Text := Format('%.0n',[TotalBA]);

end;

procedure TFInputHasilBeritaAcara.EgajiChange(Sender: TObject);
var
  persen : real;
begin
  if (Egaji.AsFLoat > 0) and (EjmlTenagaKerja.AsFLoat > 0) then

  EtotalGaji.Text := Format('%.2n',[((Egaji.AsFLoat+Elembur.AsFLoat)* EjmlTenagaKerja.AsFLoat)]);

  if (EtotalGaji.AsFLoat > 0) and (EHasilKerja.AsFLoat > 0) then begin
     EPlusmin.Text      := Format('%.2n',[EHasilKerja.AsFLoat - EtotalGaji.AsFLoat]);

     if EPlusmin.AsFLoat <> 0 then

     persen             := EPlusmin.AsFLoat / EtotalGaji.AsFLoat  * 100 else
     persen             := 0;
     Eprosentase.Text   := Format('%.2n',[persen]);

  end;
end;

procedure TFInputHasilBeritaAcara.EHasilKerjaChange(Sender: TObject);
var
  persen : real;
begin
  if (EtotalGaji.AsFLoat > 0) and (EHasilKerja.AsFLoat > 0) then begin
     EPlusmin.Text      := Format('%.2n',[EHasilKerja.AsFLoat - EtotalGaji.AsFLoat]);

     if EPlusmin.AsFLoat <> 0 then

     persen             := EPlusmin.AsFLoat / EtotalGaji.AsFLoat  * 100 else
     persen             := 0;
     Eprosentase.Text   := Format('%.2n',[persen]);

  end;
end;

procedure TFInputHasilBeritaAcara.EjmlTenagaKerjaChange(Sender: TObject);
var
  persen : real;
begin
  if (Egaji.AsFLoat > 0) and (EjmlTenagaKerja.AsFLoat > 0) then

  EtotalGaji.Text := Format('%.2n',[((Egaji.AsFLoat+Elembur.AsFLoat)* EjmlTenagaKerja.AsFLoat)]);

  if (EtotalGaji.AsFLoat > 0) and (EHasilKerja.AsFLoat > 0) then begin
     EPlusmin.Text      := Format('%.2n',[EHasilKerja.AsFLoat - EtotalGaji.AsFLoat]);

     if EPlusmin.AsFLoat <> 0 then

     persen             := EPlusmin.AsFLoat / EtotalGaji.AsFLoat  * 100 else
     persen             := 0;
     Eprosentase.Text   := Format('%.2n',[persen]);

  end;
end;
procedure TFInputHasilBeritaAcara.ElemburChange(Sender: TObject);
var
  persen : real;
begin
  if (Egaji.AsFLoat > 0) and (EjmlTenagaKerja.AsFLoat > 0) then

  EtotalGaji.Text := Format('%.2n',[((Egaji.AsFLoat+Elembur.AsFLoat)* EjmlTenagaKerja.AsFLoat)]);

  if (EtotalGaji.AsFLoat > 0) and (EHasilKerja.AsFLoat > 0) then begin
     EPlusmin.Text      := Format('%.2n',[EHasilKerja.AsFLoat - EtotalGaji.AsFLoat]);

     if EPlusmin.AsFLoat <> 0 then

     persen             := EPlusmin.AsFLoat / EtotalGaji.AsFLoat  * 100 else
     persen             := 0;
     Eprosentase.Text   := Format('%.2n',[persen]);

  end;
end;

procedure TFInputHasilBeritaAcara.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ExQry(Q1,'DELETE FROM temp_by_accident ',False);
end;

procedure TFInputHasilBeritaAcara.FormCreate(Sender: TObject);
begin
  FInputHasilBeritaAcara   := Self;

end;

procedure TFInputHasilBeritaAcara.FormShow(Sender: TObject);
begin
  GridBA;
  TampilanAwal;
end;

procedure TFInputHasilBeritaAcara.GridBA;
begin
  with sgBa do begin
    ClearAll;
     ColCount := 10;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'No';
     Cells[1,0] := 'No So';
     Cells[2,0] := 'Nomer Container';
     Cells[3,0] := 'Item';
     Cells[4,0] := 'Deskripsi';
     Cells[5,0] := 'Qty';
     Cells[6,0] := 'MH';
     Cells[7,0] := 'Cost';
     Cells[8,0] := 'Total Cost';
     Cells[9,0] := 'ID';

     ColWidths[0] := 50;
     ColWidths[1] := 120;
     ColWidths[2] := 120;
     ColWidths[3] := 200;
     ColWidths[4] := 150;
     ColWidths[5] := 50;
     ColWidths[6] := 80;
     ColWidths[7] := 80;
     ColWidths[8] := 80;
     ColWidths[9] := 80;


     ColumnSize.StretchColumn := 4;
     ColumnSize.Stretch       := True;
  end;
end;


procedure TFInputHasilBeritaAcara.sgBaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_DELETE : begin
                sgBa.ClearRows(sgBa.Row,1);
                sgBa.RowCount := sgBa.RowCount -1;
              end;
  end;
end;

procedure TFInputHasilBeritaAcara.sgBaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    Qty , Mh ,Cost ,TotalCost : Real;
begin
  if sgBa.Col in [5,6] then begin
     Qty := StrToFloatDef(nilai(sgBa.Cells[5,sgBa.Row]),0);
     Mh  := StrToFloatDef(nilai(sgBa.Cells[6,sgBa.Row]),0);
     Cost := Mh * 200 ;
     TotalCost := Qty * Cost;


     sgBa.Cells[7,sgBa.Row] := Format('%.2n',[Cost]);
     sgBa.Cells[8,sgBa.Row] := Format('%.2n',[TotalCost]);

     Counter;


  end;
end;

procedure TFInputHasilBeritaAcara.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
   CanEdit := (ACol in [4,5,6,7]);
end;

procedure TFInputHasilBeritaAcara.TampilanAwal;
begin
  ClearText(Self);

  dt1.date      := Now;

  Enomer.Text   := GetCode(Q1,'hasil_kerja','nomer','HK');
  GridBA;
  isiCmb(Q1,'divisi_pengerjaan',['id','name'],cbDivisiPengerjaan);

end;

end.
