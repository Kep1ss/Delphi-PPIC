unit uInputHasilKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFinputHasilKerja = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    Label5: TLabel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    dt1: TDateTimePicker;
    AdvGroupBox2: TAdvGroupBox;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    Label7: TLabel;
    cbDivisi: TAdvComboBox;
    AdvSmoothButton2: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    AdvGroupBox3: TAdvGroupBox;
    sg: TAdvStringGrid;
    AdvGroupBox4: TAdvGroupBox;
    sgBa: TAdvStringGrid;
    AdvSmoothButton1: TAdvSmoothButton;
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
    AdvSmoothButton3: TAdvSmoothButton;
    cbSubdivisi: TAdvComboBox;
    Label13: TLabel;
    Q4: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure EjmlTenagaKerjaChange(Sender: TObject);
    procedure EgajiChange(Sender: TObject);
    procedure ElemburChange(Sender: TObject);
    procedure EHasilKerjaChange(Sender: TObject);
    procedure cbDivisiPengerjaanChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbDivisiChange(Sender: TObject);
  private
    { Private declarations }
    idDivisiProgress : Integer;
    procedure TampilanAwal;
  public
    id : String;
    isEdit : Boolean;
    procedure GridHasilKerja;
    procedure GridBA;
    procedure LoadBA;
    procedure Counter;
    function  ValidasiMH:Boolean;
    function checkItem(item_id:String;No_so:String;no_container:string;id_divisi:string;id_pekerjaan:string):boolean;


    { Public declarations }
  end;

var
  FinputHasilKerja: TFinputHasilKerja;


implementation
 uses
   uListofSO, uMarCon, uListSoRencanKerja, uDaftarRencanaKerja, uBeritaAcara;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputHasilKerja.AdvSmoothButton1Click(Sender: TObject);
begin
  FBeritaAcara.TampilanAwal;
  FBeritaAcara.EnoHasilKerja.Text := Enomer.Text;
  FBeritaAcara.ShowModal;
end;

procedure TFinputHasilKerja.AdvSmoothButton2Click(Sender: TObject);
begin
  if cbDivisi.ItemIndex = -1 then begin
     Error(' Divisi belum dipilih');
     Exit;
  end else begin
    if cbSubdivisi.ItemIndex >= 0 then

    FDaftarRencanaKerja.LoadGrid(' WHERE rk.jenis="SET" AND '+
    '  r.divisi_planned="'+GetIdcmb(cbDivisi)+'"  '+
    ' AND r.tgl="'+Tanggal(dt1.Date)+'" '+
    ' AND sp.id_pekerjaan="'+GetIdCmb(CbSubdivisi)+'" ')
    else
    FDaftarRencanaKerja.LoadGrid(' WHERE rk.jenis="SET" AND '+
    '  r.divisi_planned="'+GetIdcmb(cbDivisi)+'"  '+
    ' AND r.tgl="'+Tanggal(dt1.Date)+'" ');


    FDaftarRencanaKerja.ShowModal;

  end;
end;

procedure TFinputHasilKerja.AdvSmoothButton3Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin BA akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = MrYes then
  begin
    ExQry(Q1,'DELETE FROM temp_by_accident WHERE id="'+sgBa.Cells[6,sgBa.Row]+'"',False);
    LoadBA;
  end;
end;

procedure TFinputHasilKerja.btnSimpanClick(Sender: TObject);
var
  i , item_id: integer;
  ls  :TStringList;
begin
  if not CheckEdit(Self) then begin
    if cbSubdivisi.ItemIndex < 0 then begin
        Error('Silahkan pilih subdivisi terlebih dahulu');
        Exit;
     end;

     if ValidasiMH = False then begin
        Error('Terdapat baris MH masih kosong, Silahkan ulangi input qty hasil');
        Exit;
     end;
     ls := TStringList.Create;


     try
        // ExQry(Q1,'SELECT id_divisi FROM);
        // idDivisiProgress

         addParam('nomer',       Enomer.Text,ls,'str');
         addParam('tgl',         frmTgl(Dt1.Date),ls,'date');
         addParam('id_divisi',   GetIdCmb(cbDivisi),ls,'str');
         AddParam('jml_tenaga_kerja', Ejmltenagakerja.Text,ls,'str');
         AddParam('gaji',        EGaji.IsAngka,ls,'str');
         AddParam('lembur',      Elembur.IsAngka,ls,'str');
         AddParam('total_gaji',  EtotalGaji.IsAngka,ls,'str');
         AddParam('hasil_kerja', EhasilKerja.IsAngka,ls,'str');
         AddParam('plus_minus',  EPlusmin.IsAngka,ls,'str');
         AddParam('prosentase',  Eprosentase.IsAngka,ls,'str');
         addParam('id_user',     GetIdUser,ls,'str');
         addParam('divisi_process',GetIdcmb(cbDivisiPengerjaan),ls,'str');
         addParam('id_sub_divisi',GetIdcmb(cbSubdivisi),ls,'str');
         ExQry(Q2,'SELECT id FROM hasil_kerja WHERE nomer="'+Enomer.Text+'"',True);

         if Q2.isEmpty then
            ExeDB(Q1,'hasil_kerja',ls)
         else
            UpdateDB(Q1,'hasil_kerja',ls,'id',GetVal(Q2,'id'));



         if sg.Cells[2,sg.RowCount -1] <> '' then
                sg.RowCount := sg.RowCount + 1;

         ExQry(Q1,'DELETE FROM detail_hasil_kerja WHERE nomer="'+Enomer.Text+'"',False);


         for i := 1 to sg.RowCount -1 do begin
            if sg.Cells[1,i] <> '' then begin
               item_id  := StrToInt(GetData(Q1,'item WHERE itemno="'+sg.Cells[2,i]+'"','id'));
               addParam('nomer', Enomer.Text,ls,'str');
               addParam('no_so', sg.Cells[0,i],ls,'str');
               addParam('no_container', sg.Cells[1,i],ls,'str');
               addParam('item_id', sg.Cells[10,i],ls,'str');
               addParam('qty_rencana', StrToDecimal(sg.Cells[4,i]),ls,'str');
               addParam('qty', StrToDecimal(sg.Cells[5,i]),ls,'str');
               addParam('mh', StrToDecimal(sg.Cells[6,i]),ls,'str');
               addParam('harga_satuan', StrToDecimal(sg.Cells[7,i]),ls,'str');
               addParam('subtotal', StrToDecimal(sg.Cells[8,i]),ls,'str');
               addParam('jenis', sg.Cells[9,i],ls,'str');
               addParam('parent_name', sg.Cells[11,i],ls,'str');
               if sg.Cells[12,i] <> '' then

               addParam('parent_id', sg.Cells[12,i],ls,'str');
               addParam('rencana_id', sg.Cells[13,i],ls,'str');
               addParam('id_divisi', sg.Cells[14,i],ls,'str');
               addParam('id_pekerjaan', sg.Cells[15,i], ls,'str');
               ExeDB(Q1,'detail_hasil_kerja',ls);

               ExQry(Q2,'UPDATE rencana_kerja SET is_proses=true WHERE id="'+sg.Cells[13,i]+'"',False);

               if sg.Cells[12,i] <> '' then begin



                      addParam('nobukti',     Enomer.Text,ls,'str');
                      addParam('tgl',         frmTgl(Dt1.Date),ls,'date');
                      addParam('id_divisi',   sg.Cells[14,i],ls,'str');
                      addParam('no_so',       sg.Cells[0,i],ls,'str');
                      addParam('item_id',     sg.Cells[12,i],ls,'str');

                      ExQry(Q3,' SELECT SUM(qty) as qty FROM detail_hasil_kerja WHERE no_so="'+sg.Cells[0,i]+'" '+
                       ' AND no_container="'+sg.Cells[1,i]+'" '+
                       ' AND item_id="'+sg.Cells[12,i]+'" '+
                       ' AND id_divisi="'+sg.Cells[14,i]+'" ORDER BY SUM(qty) ASC LIMIT 1',True);

                    if GetVal(Q3,'qty') = '' then
                      addParam('qty',  StrToDecimal(sg.Cells[5,i]),ls,'str') else
                      addParam('qty',  GetVal(Q3,'qty'),ls,'str');
                      addParam('nomer_container',   sg.Cells[1,i],ls,'str');
                      addParam('id_user',   GetIdUser,ls,'str');
                      ExQry(Q4,'SELECT id FROM progress WHERE nobukti="'+Enomer.Text+'" '+
                      ' AND id_divisi="'+sg.Cells[14,i]+'" '+
                      ' AND item_id="'+sg.Cells[12,i]+'" '+
                      ' AND nomer_container="'+sg.Cells[1,i]+'" '+
                      ' AND no_so="'+sg.Cells[0,i]+'"',True);
                      if Q4.IsEmpty then begin
                        exeDb(Q2,'progress',ls);
                      end else
                        updatedb(Q2,'progress',ls,'id',GetVal(Q4,'id'));
               end else begin

                      addParam('nobukti',     Enomer.Text,ls,'str');
                      addParam('tgl',         frmTgl(Dt1.Date),ls,'date');
                      addParam('id_divisi',   sg.Cells[14,i],ls,'str');
                      addParam('no_so',       sg.Cells[0,i],ls,'str');
                      addParam('item_id',     sg.Cells[10,i],ls,'str');

                      ExQry(Q3,' SELECT SUM(qty) as qty FROM detail_hasil_kerja WHERE no_so="'+sg.Cells[0,i]+'" '+
                       ' AND no_container="'+sg.Cells[1,i]+'" '+
                       ' AND item_id="'+sg.Cells[10,i]+'" '+
                       ' AND id_divisi="'+sg.Cells[14,i]+'" ORDER BY SUM(qty) ASC LIMIT 1',True);


                      if GetVal(Q3,'qty') = '' then
                      addParam('qty',  StrToDecimal(sg.Cells[5,i]),ls,'str') else
                      addParam('qty',  GetVal(Q3,'qty'),ls,'str');
                      addParam('nomer_container',   sg.Cells[1,i],ls,'str');
                      addParam('id_user',   GetIdUser,ls,'str');

                      ExQry(Q4,'SELECT id FROM progress WHERE nobukti="'+Enomer.Text+'" '+
                      ' AND id_divisi="'+sg.Cells[14,i]+'" '+
                      ' AND item_id="'+sg.Cells[10,i]+'" '+
                      ' AND nomer_container="'+sg.Cells[1,i]+'" '+
                      ' AND no_so="'+sg.Cells[0,i]+'"',True);
                      if Q4.IsEmpty then begin
                        exeDb(Q2,'progress',ls);
                      end else
                        updatedb(Q2,'progress',ls,'id',GetVal(Q4,'id'));
               end;
            end;


         end;


         ExQry(Q1,'DELETE FROM by_accident WHERE nomer_hasil_kerja="'+Enomer.Text+'"',False);

         ExQry(Q2,'SELECT * FROM temp_by_accident WHERE nomer_hasil_kerja="'+Enomer.Text+'"',True);

         if not Q2.IsEmpty then begin
           while not Q2.Eof do begin

               addParam('tgl', frmTgl(dt1.Date), ls,'date');
               addParam('id_divisi',GetIdCmb(cbDivisiPengerjaan), ls,'str');
               addParam('nomer_hasil_kerja', Enomer.Text,ls,'str');
               addParam('description', GetVal(Q2,'description'),ls,'str');
               addParam('qty', GetVal(Q2,'qty'),ls,'str');
               addParam('mh', GetVal(Q2,'mh'),ls,'str');
               addParam('cost', GetVal(Q2,'cost'),ls,'str');
               addParam('total_cost', GetVal(Q2,'total_cost'),ls,'str');
               exeDb(Q1,'by_accident',ls);
               Q2.Next;
           end;
         end;


         Informasi('Hasil Kerja Berhasil Disimpan');
         ExQry(Q1,'DELETE FROM temp_by_accident WHERE nomer_hasil_kerja="'+Enomer.Text+'"',False);
         TampilanAwal;

     finally
       ls.Free;
     end;
  end;
end;

procedure TFinputHasilKerja.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputHasilKerja.cbDivisiChange(Sender: TObject);
var
  ListDivisi : TStringList;
  _Query_divisi : String;
  i : integer;

begin

  ListDivisi := TStringList.Create;

  try
      SplitString(' ',cbDivisi.Text,ListDivisi);

      for i := 0 to ListDivisi.Count -1 do
         _Query_divisi := _Query_divisi +' d.name LIKE "%'+ListDivisi[i]+'%" OR';

      Delete(_Query_divisi,Length(_Query_divisi)-1,2);

      ExQry(Q1,'SELECT p.id,p.deskripsi FROM pekerjaan p LEFT JOIN divisi d '+
      ' ON p.id_divisi=d.id WHERE ('+_Query_divisi+')',True);

      if not Q1.IsEmpty then begin
        while not Q1.Eof do begin

         cbSubdivisi.AddItem(GetVal(Q1,'deskripsi'),TObject(GetValInt(Q1,'id')));
         Q1.Next;
        end;
      end else
      begin
        cbSubdivisi.Items.Clear;
      end;
  finally
    ListDivisi.Free;
  end;
end;

procedure TFinputHasilKerja.cbDivisiPengerjaanChange(Sender: TObject);
begin
  if cbDivisiPengerjaan.ItemIndex >= 0 then begin
     ExQry(Q1,'SELECT jml_karyawan,gaji_karyawan FROM divisi_pengerjaan WHERE id="'+GetIdcmb(cbDivisiPengerjaan)+'"',True);

     EjmlTenagaKerja.Text := GetVal(Q1,'jml_karyawan');

  end;
end;


function TFinputHasilKerja.checkItem(item_id, No_so, no_container, id_divisi,
  id_pekerjaan: string): boolean;
  var
    i : integer;
begin
  result := false;
  for i := 1 to sg.RowCount -1 do begin

    if (sg.Cells[0,i] = No_so) and (sg.Cells[1,i] = no_container)
        and (sg.Cells[10,i] = item_id) and (sg.Cells[14,i] = id_divisi)
        and (sg.Cells[15,i] = id_pekerjaan) then
        begin
          result := true;
          break
        end;

  end;

end;

procedure TFinputHasilKerja.Counter;
var
  i : integer;
  TotalHasilKerja : real;
  TotalBA : Real;
begin

   TotalHasilKerja := 0;
   for I := 1 to sg.RowCount-1 do  begin
      TotalHasilKerja := TotalHasilKerja + Cellf(sg.Cells[8,i]);
   end;
  TotalBA         := SumGrid(sgBa,5);
  EHasilKerja.Text := Format('%.0n',[TotalHasilKerja + TotalBA]);

end;

procedure TFinputHasilKerja.EgajiChange(Sender: TObject);
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

procedure TFinputHasilKerja.EHasilKerjaChange(Sender: TObject);
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

procedure TFinputHasilKerja.EjmlTenagaKerjaChange(Sender: TObject);
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
procedure TFinputHasilKerja.ElemburChange(Sender: TObject);
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

procedure TFinputHasilKerja.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ExQry(Q1,'DELETE FROM temp_by_accident ',False);
end;

procedure TFinputHasilKerja.FormCreate(Sender: TObject);
begin
  FinputHasilKerja   := Self;

end;

procedure TFinputHasilKerja.FormShow(Sender: TObject);
begin
   FinputHasilKerja.GridHasilKerja;
   FinputHasilKerja.GridBA;
   FinputHasilKerja.TampilanAwal;
end;

procedure TFinputHasilKerja.GridBA;
begin
  with sgBa do begin
    ClearAll;
     ColCount := 7;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'No';
     Cells[1,0] := 'Deskripsi';
     Cells[2,0] := 'Qty';
     Cells[3,0] := 'MH';
     Cells[4,0] := 'Cost';
     Cells[5,0] := 'Total Cost';
     Cells[7,0] := 'ID';

     ColWidths[0] := 100;
     ColWidths[1] := 150;
     ColWidths[2] := 80;
     ColWidths[3] := 80;
     ColWidths[4] := 100;
     ColWidths[5] := 100;
     ColWidths[6] := 0;


     ColumnSize.StretchColumn := 1;
     ColumnSize.Stretch       := True;
  end;
end;

procedure TFinputHasilKerja.GridHasilKerja;
begin
  with sg do begin
     ClearAll;
     ColCount := 16;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'No So';
     Cells[1,0] := 'No Container';
     Cells[2,0] := 'Item No';
     Cells[3,0] := 'Deskripsi';
     Cells[4,0] := 'Qty Order';
     Cells[5,0] := 'Qty Hasil';
     Cells[6,0] := 'MH';
     Cells[7,0] := 'Harga Satuan';
     Cells[8,0] := 'Total Harga';
     Cells[9,0] := 'Jenis';
     Cells[10,0] := 'Item Id';
     Cells[11,0] := 'Parent Name';
     Cells[12,0] := 'Parent Id';
     Cells[13,0] := 'Rencana Id';
     Cells[14,0] := 'Divisi Process';
     Cells[15,0] := 'Pekerjaan';


     ColWidths[0] := 100;
     ColWidths[1] := 80;
     ColWidths[2] := 100;
     ColWidths[3] := 200;
     ColWidths[4] := 80;
     ColWidths[5] := 80;
     ColWidths[6] := 80;
     ColWidths[7] := 100;
     ColWidths[8] := 100;
     ColWidths[9] := 50;
     ColWidths[10] := 0;
     ColWidths[11] := 0;
     ColWidths[12] := 0;
     ColWidths[13] := 0;
     ColWidths[14] := 0;
     ColWidths[15] := 0;


     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;

  end;
end;

procedure TFinputHasilKerja.LoadBA;
var
  i : integer;
begin
  GridBA;
  ExQry(Q1,'SELECT * FROM temp_by_accident WHERE nomer_hasil_kerja="'+Enomer.Text+'"',True);

  i := 1;
  sgBa.RowCount := Q1.RecordCount + 2;
  while not Q1.Eof do begin
    sgBa.Cells[0,i] := IntToStr(i);
    sgBa.Cells[1,i] := GetVal(Q1,'description');
    sgBa.Cells[2,i] := GetValR(Q1,'qty');
    sgBa.Cells[3,i] := GetValR(Q1,'mh');
    sgBa.Cells[4,i] := GetValR(Q1,'cost');
    sgBa.Cells[5,i] := GetValR(Q1,'total_cost');
    sgBa.Cells[6,i] := GetValR(Q1,'id');
    Inc(i);
    Q1.Next;


  end;
  Counter;
end;

procedure TFinputHasilKerja.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
   CanEdit := (ACol in [5]);
end;

procedure TFinputHasilKerja.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_DELETE : begin
                sg.ClearRows(sg.Row,1);
                sg.RowCount := sg.RowCount -1;
              end;
  end;

end;

procedure TFinputHasilKerja.sgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    Cost : Real;
    Mh   : Real;
    TotalOrder : Integer;
    TotalFinis : integer;
    QtyBefore  : integer;
begin
  if sg.Col = 5 then begin

         if sg.Cells[9,sg.Row] = 'SET' then  begin

               ExQry(Q2,'SELECT                           '+
                        '        d.jumlah                  '+
                        '      FROM                        '+
                        '        detail_sales_order d      '+
                        '        LEFT JOIN sales_order s   '+
                        '          ON s.`no_input` = d.`no_input` '+
                        ' WHERE item_id="'+sg.Cells[10,sg.Row]+'" '+
                        ' AND s.no_sales_order="'+sg.Cells[0,sg.Row]+'"  '+
                        ' AND s.nomer_container="'+sg.Cells[1,sg.Row]+'" ',True);

               TotalOrder := GetValInt(Q2,'jumlah');
               ExQry(Q2,'SELECT                             '+
                        '    SUM(d.qty) AS total_finish     '+
                        '  FROM                             '+
                        '    detail_hasil_kerja d           '+
                        '  LEFT JOIN hasil_kerja h          '+
                        '    ON h.nomer=d.nomer             '+
                        ' WHERE item_id="'+sg.Cells[10,sg.Row]+'" '+
                        ' AND no_so="'+sg.Cells[0,sg.Row]+'" '+
                        ' AND d.id_divisi="'+sg.Cells[14,sg.Row]+'" '+
                        ' AND d.no_container="'+sg.Cells[1,sg.Row]+'" '+
                        ' AND d.id_pekerjaan="'+sg.Cells[15,sg.Row]+'"',True);

             //  Memo1.Lines.Add(Q2.SQL.Text);

               TotalFinis := GetValInt(Q2,'total_finish');
               if isEdit then begin
                  ExQry(Q2,' SELECT d.qty FROM '+
                           '    detail_hasil_kerja d '+
                           ' WHERE d.item_id="'+sg.Cells[10,sg.Row]+'" '+
                           ' AND d.no_so="'+sg.Cells[0,sg.Row]+'" '+
                           ' AND d.no_container="'+sg.Cells[1,sg.Row]+'" '+
                           ' AND d.nomer="'+Enomer.Text+'"  '+
                           ' AND d.id_divisi="'+sg.Cells[14,sg.Row]+'" '+
                           ' AND d.id_pekerjaan="'+sg.Cells[15,sg.Row]+'"',True);
                  QtyBefore := GetValInt(Q2,'qty');

               end else QtyBefore := 0;

               TotalFinis := TotalFinis - QtyBefore;
         end else begin

            ExQry(Q1,'SELECT                           '+
                        '        d.jumlah                  '+
                        '      FROM                        '+
                        '        detail_sales_order d      '+
                        '        LEFT JOIN sales_order s   '+
                        '          ON s.`no_input` = d.`no_input` '+
                        ' WHERE item_id="'+sg.Cells[12,sg.Row]+'" '+
                        ' AND s.no_sales_order="'+sg.Cells[0,sg.Row]+'" '+
                        ' AND s.nomer_container="'+sg.Cells[1,sg.ROw]+'"',True);

              ExQry(Q2,'SELECT c.component_id,c.nama,c.itemno,c.jumlah FROM material_product c '+
              ' LEFT JOIN item i ON i.itemno=c.itemno WHERE i.id="'+sg.Cells[12,sg.Row]+'" '+
              ' AND component_id="'+sg.Cells[10,sg.Row]+'"',True);

               TotalOrder := GetValInt(Q1,'jumlah') * GetValInt(Q2,'jumlah');
               ExQry(Q2,'SELECT                             '+
                        '    SUM(d.qty) AS total_finish     '+
                        '  FROM                             '+
                        '    detail_hasil_kerja d           '+
                        ' WHERE item_id="'+sg.Cells[10,sg.Row]+'" '+
                        ' AND d.no_so="'+sg.Cells[0,sg.Row]+'" '+
                        ' AND d.no_container="'+sg.Cells[1,sg.Row]+'"  '+
                        ' AND d.id_pekerjaan="'+sg.Cells[15,sg.Row]+'"',True);
               TotalFinis := GetValInt(Q2,'total_finish');

               if isEdit then begin
                  ExQry(Q2,' SELECT d.qty FROM '+
                           '    detail_hasil_kerja d '+
                           ' WHERE d.item_id="'+sg.Cells[10,sg.Row]+'" '+
                           ' AND d.no_so="'+sg.Cells[0,sg.Row]+'" '+
                           ' AND d.no_container="'+sg.Cells[1,sg.Row]+'" '+
                           ' AND d.nomer="'+Enomer.Text+'"  '+
                           ' AND d.id_pekerjaan="'+sg.Cells[15,sg.Row]+'"',True);
                  QtyBefore := GetValInt(Q2,'qty');

               end else QtyBefore := 0;

               TotalFinis := TotalFinis - QtyBefore;
         end;

         if StrToIntDef(nilai(sg.Cells[5,sg.Row]),0) > StrToIntDef(nilai(sg.Cells[4,sg.Row]),0) then
         begin
           Error('Jumlah input melebihi jumlah Order ');
           sg.Cells[5,sg.Row] := '0';
           sg.Cells[6,sg.Row] := '0';
           sg.Cells[8,sg.Row] := '0';
           exit;
         end;

         if TotalFinis + StrToIntDef(nilai(sg.Cells[5,sg.Row]),0) > TotalOrder  then
         begin
           Error('Jumlah input melebihi jumlah Order '+#13+'Total Order : '+IntToStr(TotalOrder)+#13+
           'Selesai : '+IntToStr(TotalFinis)+#13+'Input : '+sg.Cells[5,sg.Row]);

           sg.Cells[5,sg.Row] := '0';
           sg.Cells[6,sg.Row] := '0';
           sg.Cells[8,sg.Row] := '0';
         end else begin


             Cost := CellF(sg.Cells[7,sg.Row]) / 200;
             Mh   := Cost * CellF(sg.Cells[5,sg.Row]);
             sg.Cells[6,sg.Row] := Format('%.0n',[Mh]);
             sg.Cells[8,sg.Row] := Format('%.2n',[CellF(sg.Cells[5,sg.Row])* CellF(sg.Cells[7,sg.Row])]);

         end;

        end;

       Counter;

end;

procedure TFinputHasilKerja.TampilanAwal;
begin
  ClearText(Self);

  dt1.date      := Now;

  Enomer.Text   := GetCode(Q1,'hasil_kerja','nomer','HK');
  GridHasilKerja;
  GridBA;

  isiCmb(Q1,'divisi_pengerjaan',['id','name'],cbDivisi);
  isiCmb(Q1,'divisi_pengerjaan',['id','name'],cbDivisiPengerjaan);
  isEdit := False;

end;

function TFinputHasilKerja.ValidasiMH: Boolean;
var
  i : integer;
begin

  Result := True;
  for i := 1 to sg.RowCount -1 do begin
      if (sg.Cells[1,i] <> '') and (StrToIntDef(nilai(sg.Cells[6,i]),0) = 0) then begin
        Result := false;
        break;
      end;


  end;
end;

end.
