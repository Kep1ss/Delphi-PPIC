unit uInputRencanaKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,DateUtils,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;
type
  TFinputRencanaKerja = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    dt1: TDateTimePicker;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label4: TLabel;
    EHasilKerja: TAdvEdit;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvGroupBox2: TAdvGroupBox;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    sg: TAdvStringGrid;
    Label7: TLabel;
    cbDivisi: TAdvComboBox;
    Label8: TLabel;
    Egaji: TAdvEdit;
    Elembur: TAdvEdit;
    Label9: TLabel;
    Label10: TLabel;
    EtotalGaji: TAdvEdit;
    EPlusmin: TAdvEdit;
    Label11: TLabel;
    Label12: TLabel;
    Eprosentase: TAdvEdit;
    EjmlTenagaKerja: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Label13: TLabel;
    cbPerhitungan: TAdvComboBox;
    Label14: TLabel;
    cbDivisiPlan: TAdvComboBox;
    AdvSmoothButton2: TAdvSmoothButton;
    Q3: TMyQuery;
    AdvGroupBox4: TAdvGroupBox;
    sgBa: TAdvStringGrid;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EjmlTenagaKerjaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EHasilKerjaChange(Sender: TObject);
    procedure EgajiChange(Sender: TObject);
    procedure EjmlTenagaKerjaChange(Sender: TObject);
    procedure ElemburChange(Sender: TObject);
    procedure EtotalGajiChange(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure cbDivisiPlanChange(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
  private


    procedure TampilanAwal;

    function ValidasiQty(AdditionalQty : Integer;NoSo:String;ItemId : String) : Boolean;



    { Private declarations }
  public
    id : String;
    isEdit : Boolean;
    procedure GridRencanaKerja;
    procedure SumCost(isComponent:Boolean);

    procedure Counter;
    procedure GridBA;
    procedure LoadBA;

    { Public declarations }
  end;

var
  FinputRencanaKerja: TFinputRencanaKerja;


implementation
 uses
   uListofSO, uMarCon, uListSoRencanKerja, uJadwalKerjaDivisi,
  uRencanaBeritaAcara;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputRencanaKerja.AdvSmoothButton1Click(Sender: TObject);
var

  I: Integer;
begin
      if cbDivisi.ItemIndex = -1 then begin
     Error('Divisi Belum dipilih');
     Exit;
  end else begin


      FDaftarSORencanaKerja.idDivisi :=GetIdcmb(cbDivisi);
      FDaftarSORencanaKerja.LoadGrid(' AND so.id_divisi="'+GetIdcmb(cbDivisi)+'" ');

      FDaftarSORencanaKerja.ShowMOdal;
  end;
end;

function toBool(str:String):boolean;
begin
  if str = 'true' then
     Result := True
  else
     Result := False;
end;

procedure TFinputRencanaKerja.AdvSmoothButton2Click(Sender: TObject);
begin
  FjadwalKerjaDivisi.Showmodal;
end;

procedure TFinputRencanaKerja.AdvSmoothButton3Click(Sender: TObject);
begin
    FRencanaBeritaAcara.TampilanAwal;
    FRencanaBeritaAcara.EnoRencana.Text := Enomer.Text;
    FRencanaBeritaAcara.ShowModal;
end;

procedure TFinputRencanaKerja.AdvSmoothButton4Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin BA akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = MrYes then
  begin
    ExQry(Q1,'DELETE FROM temp_rencana_berita_acara WHERE id="'+sgBa.Cells[6,sgBa.Row]+'"',False);
    LoadBA;
  end;
end;

procedure TFinputRencanaKerja.btnSimpanClick(Sender: TObject);
var
  i  ,item_id , x : integer;
  ls : TStringList;
  parent_name : String;
  parent_id : string;
  mh : real;

  tglMulai : TDate;
  Hari : integer;


begin
  if not CheckEdit(Self) then begin
     ls := TStringList.Create;

     try

             AddParam('nomer',       Enomer.Text,ls,'str');
             AddParam('tgl',         frmTgl(Dt1.Date),ls,'date');
             AddParam('id_divisi',   GetIdCmb(cbDivisi),ls,'str');
             AddParam('jml_tenaga_kerja', Ejmltenagakerja.Text,ls,'str');
             AddParam('gaji',        EGaji.IsAngka,ls,'str');
             AddParam('lembur',      Elembur.IsAngka,ls,'str');
             AddParam('total_gaji',  EtotalGaji.IsAngka,ls,'str');
             AddParam('hasil_kerja', EhasilKerja.IsAngka,ls,'str');
             AddParam('plus_minus',  EPlusmin.IsAngka,ls,'str');
             AddParam('prosentase',  Eprosentase.IsAngka,ls,'str');
             AddParam('metode_perhitungan',  cbPerhitungan.Text,ls,'str');
             AddParam('id_user',     GetIdUser,ls,'str');
             AddParam('divisi_planned',     GetIdCmb(cbDivisiPlan),ls,'str');
             if isEdit then
             addParam('is_proses',BolStr(False), ls,'str');
             ExQry(Q2,'SELECT id FROM rencana_kerja WHERE nomer="'+Enomer.Text+'"',True);

             if Q2.isEmpty then
                ExeDB(Q1,'rencana_kerja',ls)
             else
                UpdateDB(Q1,'rencana_kerja',ls,'id',GetVal(Q2,'id'));


             if sg.Cells[2,sg.RowCount -1] <> '' then
                    sg.RowCount := sg.RowCount + 1;

             ExQry(Q1,'DELETE FROM rencana_kerja_detail WHERE nomer="'+Enomer.Text+'"',False);
             ExQry(Q1,'DELETE FROM jadwal_divisi WHERE nomer_rencana="'+Enomer.Text+'"',False);


             for i := 1 to sg.RowCount -1 do begin
                if (sg.Cells[11,i] <> '') AND (StrToFloatDef(sg.Cells[6,i],0) > 0) then begin
                   if sg.Cells[13,i] = 'true' then begin
                      parent_name    := sg.Cells[4,i];
                   end;

                   mh := Round(CellF(sg.Cells[7,i]) / CellF(sg.Cells[5,i])) * CellF(sg.Cells[6,i]);
                   AddParam('nomer', Enomer.Text,ls,'str');
                   AddParam('no_job_order', sg.Cells[0,i],ls,'str');
                   AddParam('no_so', sg.Cells[1,i],ls,'str');
                   AddParam('no_container', sg.Cells[2,i],ls,'str');
                   AddParam('item_id', sg.Cells[12,i],ls,'str');
                   AddParam('qty_order', StrToDecimal(sg.Cells[5,i]),ls,'str');
                   AddParam('qty', StrToDecimal(sg.Cells[6,i]),ls,'str');
                   AddParam('mh', FloatToStr(mh),ls,'str');
                   AddParam('harga_satuan', StrToDecimal(sg.Cells[8,i]),ls,'str');
                   AddParam('subtotal', StrToDecimal(sg.Cells[9,i]),ls,'str');
                   AddParam('jenis', StrToDecimal(sg.Cells[11,i]),ls,'str');
                   AddParam('is_parent', BolStr(toBool(sg.Cells[13,i])),ls,'str');
                   AddParam('parent_name', parent_name,ls,'str');
                   if (parent_name <> '') and (sg.Cells[14,i] <> '') then
                   addParam('parent_id', sg.Cells[14,i],ls,'str');
                   addParam('id_divisi', sg.Cells[15,i],ls,'str');
                   ExeDB(Q1,'rencana_kerja_detail',ls);

                   if sg.Cells[14,i]<>'' then
                      item_id := StrToInt(sg.Cells[14,i]) else
                      item_id := StrToInt(sg.Cells[12,i]);



                       tglMulai := dt1.Date;


                       ExQry(Q2,'SELECT id FROM jadwal_divisi WHERE '+
                       ' item_id="'+IntToStr(item_id)+'" '+
                       ' AND nomer_rencana="'+Enomer.Text+'" '+
                       ' AND no_so="'+sg.Cells[1,i]+'" '+
                       ' AND nomer_container="'+sg.Cells[2,i]+'" '+
                       ' AND tgl="'+Tanggal(tglmulai)+'"',True);

                       if Q2.IsEmpty then begin
                         addParam('id_divisi', GetIdcmb(cbDivisiPlan),ls,'str');
                         addParam('nomer_rencana', Enomer.Text,ls,'str');
                         addParam('no_so', sg.Cells[1,i],ls,'str');
                         addParam('nomer_container', sg.Cells[2,i],ls,'str');
                         if sg.Cells[14,i] <> '' then
                         addParam('item_id', sg.Cells[14,i],ls,'str') else
                         addParam('item_id', sg.Cells[12,i],ls,'str');
                         addParam('tgl', frmTgl(tglMulai),ls,'date');
                         ExeDB(Q1,'jadwal_divisi',ls);
                       end;

                end;


             end;
         ExQry(Q1,'DELETE FROM rencana_berita_acara WHERE nomer_rencana_kerja="'+Enomer.Text+'"',False);

         ExQry(Q2,'SELECT * FROM temp_rencana_berita_acara WHERE nomer_rencana_kerja="'+Enomer.Text+'"',True);

         if not Q2.IsEmpty then begin
           while not Q2.Eof do begin

               addParam('tgl', frmTgl(dt1.Date), ls,'date');
               addParam('id_divisi',GetIdCmb(cbDivisiPlan), ls,'str');
               addParam('nomer_rencana_kerja', Enomer.Text,ls,'str');
               addParam('description', GetVal(Q2,'description'),ls,'str');
               addParam('qty', GetVal(Q2,'qty'),ls,'str');
               addParam('mh', GetVal(Q2,'mh'),ls,'str');
               addParam('cost', GetVal(Q2,'cost'),ls,'str');
               addParam('total_cost', GetVal(Q2,'total_cost'),ls,'str');
               exeDb(Q1,'rencana_berita_acara',ls);
               Q2.Next;
           end;
         end;


         Informasi('Rencana Kerja Berhasil Disimpan');
         ExQry(Q1,'DELETE FROM temp_rencana_berita_acara WHERE nomer_rencana_kerja="'+Enomer.Text+'"',False);

         TampilanAwal;

     finally
       ls.Free;
     end;
  end;
end;

procedure TFinputRencanaKerja.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputRencanaKerja.cbDivisiPlanChange(Sender: TObject);
var
  i : integer;
  cost : real;
  mh : real;
begin
  if cbDivisiPlan.ItemIndex >= 0 then begin
     ExQry(Q1,'SELECT jmlkaryawan,gaji_karyawan FROM divisi WHERE id="'+GetIdcmb(cbDivisiPlan)+'"',True);

     EjmlTenagaKerja.Text := GetVal(Q1,'jmlkaryawan');
     Egaji.Text           := GetValR(Q1,'gaji_karyawan');

     EtotalGaji.Text      := Format('%.0n',[GetValF(Q1,'jmlkaryawan') * GetValF(Q1,'gaji_karyawan')]);
  end;

end;

procedure TFinputRencanaKerja.Counter;
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

procedure TFinputRencanaKerja.EgajiChange(Sender: TObject);
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

procedure TFinputRencanaKerja.EHasilKerjaChange(Sender: TObject);
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

procedure TFinputRencanaKerja.EjmlTenagaKerjaChange(Sender: TObject);
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

procedure TFinputRencanaKerja.EjmlTenagaKerjaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  EtotalGaji.Text := Format('%.2n',[((Egaji.AsFLoat+Elembur.AsFLoat)* EjmlTenagaKerja.AsFLoat)]);
end;

procedure TFinputRencanaKerja.ElemburChange(Sender: TObject);
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

procedure TFinputRencanaKerja.EtotalGajiChange(Sender: TObject);
begin
  EHasilKerjaChange(Sender);
end;

procedure TFinputRencanaKerja.FormCreate(Sender: TObject);
begin
  FinputRencanaKerja := Self;
end;

procedure TFinputRencanaKerja.FormShow(Sender: TObject);
begin
  GridRencanaKerja;
  TampilanAwal;
end;

procedure TFinputRencanaKerja.GridBA;
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

procedure TFinputRencanaKerja.GridRencanaKerja;
begin
  with sg do begin
     ClearAll;
     ColCount := 16;
     RowCount := 2;
     FixedCols := 0;

     Cells[0,0] := 'No JO';
     Cells[1,0] := 'No So';
     Cells[2,0] := 'No Container';
     Cells[3,0] := 'Item No';
     Cells[4,0] := 'Deskripsi';
     Cells[5,0] := 'Qty Order';
     Cells[6,0] := 'Qty Rencana';
     Cells[7,0] := 'MH';
     Cells[8,0] := 'Harga Satuan';
     Cells[9,0] := 'Total Harga';
     Cells[10,0] := 'No SO';
     Cells[11,0] := 'Jenis';
     Cells[12,0] := 'item_id';
     Cells[13,0] := 'is_parent';
     Cells[14,0] := 'parent_id';
     Cells[15,0] := 'id_divisi';



     ColWidths[0] := 80;
     ColWidths[1] := 80;
     ColWidths[2] := 100;
     ColWidths[3] := 150;
     ColWidths[4] := 150;
     ColWidths[5] := 80;
     ColWidths[6] := 80;
     ColWidths[7] := 50;
     ColWidths[8] := 150;
     ColWidths[9] := 150;
     ColWidths[10] := 0;
     ColWidths[11] := 0;
     ColWidths[12] := 0;
     ColWidths[13] := 0;
     ColWidths[14] := 0;
     ColWidths[15] := 0;

     ColumnSize.StretchColumn := 2;
     ColumnSize.Stretch       := True;

  end;
end;

procedure TFinputRencanaKerja.LoadBA;
var
  i : integer;
begin
  GridBA;
  ExQry(Q1,'SELECT * FROM temp_rencana_berita_acara WHERE nomer_rencana_kerja="'+Enomer.Text+'"',True);

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
procedure TFinputRencanaKerja.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if cbPerhitungan.Text = 'PER COMPONENT' then

      CanEdit := (ACol  in [6,8]) and (sg.Cells[11,Arow] = 'COMPONENT')
  else
      CanEdit := (ACol in [6,8]);
end;

procedure TFinputRencanaKerja.sgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 
begin
  case key of
  VK_DELETE : begin
                sg.RemoveRows(sg.Row,1);
              end;
  end;

end;

procedure TFinputRencanaKerja.sgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    ItemId : String;

begin
  if (sg.Col = 6)  then begin

      if cbPerhitungan.Text = 'PER COMPONENT' then begin
         if (sg.Cells[11,sg.Row] = 'COMPONENT') then begin

           ItemId := getData(Q1,'item WHERE itemno="'+sg.Cells[3,sg.Row]+'"','id');
           if ValidasiQty(StrToIntDef(nilai(sg.Cells[6,sg.Row]),0),sg.Cells[1,sg.Row],sg.Cells[12,sg.Row]) = False then
           begin
             Error('Input QTY melebihi Total Order ');
             sg.Cells[6,sg.Row] := '0';
             Exit
           end else begin

                 if CellF(sg.Cells[6,sg.Row]) > CellF(sg.Cells[5,sg.Row]) then
                 begin
                   Error('Jumlah input melebihi jumlah order');
                   sg.Cells[6,sg.Row] := sg.Cells[5,sg.Row];
                 end else begin
                   sg.Cells[9,sg.Row] := Format('%.2n',[CellF(sg.Cells[6,sg.Row])* CellF(sg.Cells[8,sg.Row])]);

                   EHasilKerja.Text   := Format('%.2n',[SumGrid(sg,9)]);
                 end;
           end;
      end;
     end else begin
        if (sg.Cells[11,sg.Row] = 'SET') then begin

           ItemId := getData(Q1,'item WHERE itemno="'+sg.Cells[3,sg.Row]+'"','id');
           if ValidasiQty(StrToIntDef(nilai(sg.Cells[6,sg.Row]),0),sg.Cells[1,sg.Row],sg.Cells[12,sg.Row]) = False then
           begin
             Error('Input QTY melebihi Total Order ');
             sg.Cells[6,sg.Row] := '0';
             Exit
           end else begin

                 if CellF(sg.Cells[6,sg.Row]) > CellF(sg.Cells[5,sg.Row]) then
                 begin
                   Error('Jumlah input melebihi jumlah order');
                   sg.Cells[6,sg.Row] := sg.Cells[5,sg.Row];
                 end else begin
                   sg.Cells[9,sg.Row] := Format('%.2n',[CellF(sg.Cells[6,sg.Row])* CellF(sg.Cells[8,sg.Row])]);

                   EHasilKerja.Text   := Format('%.2n',[SumGrid(sg,9)]);
                 end;
           end;
      end;
     end;
  end;
end;

procedure TFinputRencanaKerja.SumCost(isComponent: Boolean);
var
  i : integer;
  sum : real;
begin
  if isComponent then begin
     sum := 0;
     for i := 1 to sg.RowCount -1 do begin
        if sg.Cells[11,i] = 'COMPONENT' then begin
          sum := sum + CellF(sg.Cells[9,i]);

        end;
     end;

     EHasilKerja.Text := Format('%.0n',[sum]);

  end else begin
     sum := 0;
     for i := 1 to sg.RowCount -1 do begin
        if sg.Cells[11,i] = 'SET' then begin
          sum := sum + CellF(sg.Cells[9,i]);

        end;
     end;

     EHasilKerja.Text := Format('%.0n',[sum]);
  end;
end;

procedure TFinputRencanaKerja.TampilanAwal;
begin
  ClearText(Self);
  isEdit        := False;
  dt1.date      := Now;
  Enomer.Text   := GetCode(Q1,'rencana_kerja','nomer','RK');
  GridRencanaKerja;
  GridBA;

  isiCmb(Q1,'divisi where is_active=true',['id','name'],cbDivisi);
  isiCmb(Q1,'divisi_pengerjaan ',['id','name'],cbDivisiPlan);
  cbPerhitungan.Clear;
  cbPerhitungan.Items.Add('PER SET');
  cbPerhitungan.Items.Add('PER COMPONENT');
  cbPerhitungan.ItemIndex := 0;

end;

function TFinputRencanaKerja.ValidasiQty(AdditionalQty: Integer; NoSo,
  ItemId: String): Boolean;
var
  TotalOrder : Integer;
  TotalInput : Integer;
  QtyBefore  : integer;
begin


  if cbPerhitungan.Text = 'PER SET' then begin

        ExQry(Q1,'SELECT d.jumlah FROM detail_sales_order d LEFT JOIN '+
        ' sales_order s ON d.no_input=s.no_input WHERE d.item_id="'+ItemId+'" '+
        ' AND s.no_sales_order="'+NoSo+'"',True);

        //ShowMessage(Q1.SQL.Text);

        TotalOrder := GetValInt(Q1,'jumlah');

        ExQry(Q1,'SELECT SUM(d.qty) as totalqtyFinis FROM detail_hasil_kerja d '+
        ' LEFT JOIN hasil_kerja r ON r.nomer=d.nomer '+
        ' WHERE d.item_id="'+ItemId+'" AND d.no_so="'+NoSo+'" '+
        ' AND d.id_divisi="'+getIdCmb(cbDivisi)+'" ',True);

        TotalInput := GetValInt(Q1,'totalqtyFinis');

        if isEdit  then begin
           ExQry(Q1,'SELECT qty FROM rencana_kerja_detail WHERE '+
           ' item_id="'+ItemId+'" AND no_so="'+NoSo+'" '+
           ' AND nomer="'+Enomer.Text+'" ',True);

           QtyBefore := GetValInt(Q1,'qty');
        end else
           QtyBefore := 0;


        if TotalOrder < (TotalInput - QtyBefore) + AdditionalQty then
           Result := False else
           Result := True;
  end else begin
     ExQry(Q1,'SELECT d.jumlah FROM detail_sales_order d LEFT JOIN '+
        ' sales_order s ON d.no_input=s.no_input WHERE d.item_id="'+sg.Cells[14,sg.Row]+'" '+
        ' AND s.no_sales_order="'+NoSo+'"',True);

     ExQry(Q2,'SELECT c.component_id,c.nama,c.itemno,c.jumlah FROM material_product c '+
        ' LEFT JOIN item i ON i.itemno=c.itemno WHERE i.id="'+sg.Cells[14,sg.Row]+'" '+
        ' AND component_id="'+sg.Cells[12,sg.Row]+'"',True);


     TotalOrder := GetValInt(Q1,'jumlah') * GetValInt(Q2,'jumlah');
     ExQry(Q1,'SELECT SUM(d.qty) as totalqtyFinis FROM detail_hasil_kerja d '+
        ' LEFT JOIN hasil_kerja r ON r.nomer=d.nomer LEFT JOIN item i ON i.id=d.parent_id '+
        ' WHERE d.item_id="'+ItemId+'" AND no_so="'+NoSo+'" '+
        ' AND d.id_divisi="'+getIdCmb(cbDivisi)+'" '+
        ' AND i.itemno="'+sg.Cells[14,sg.Row]+'" ',True);

        TotalInput := GetValInt(Q1,'totalqtyFinis');

     if isEdit  then begin
          ExQry(Q1,'SELECT SUM(d.qty) as qtyBefore FROM rencana_kerja_detail d '+
        ' LEFT JOIN rencana_kerja r ON r.nomer=d.nomer LEFT JOIN item i ON i.id=d.parent_id '+
        ' WHERE d.item_id="'+ItemId+'" AND no_so="'+NoSo+'" '+
        ' AND r.nomer="'+Enomer.Text+'" '+
        ' AND i.itemno="'+sg.Cells[14,sg.Row]+'" ',True);

           QtyBefore := GetValInt(Q1,'qtyBefore');
        end else
           QtyBefore := 0;

     if TotalOrder < (TotalInput - QtyBefore) + AdditionalQty then
           Result := False else
           Result := True;
  end;
end;

end.
