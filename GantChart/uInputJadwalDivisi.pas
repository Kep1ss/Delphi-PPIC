unit uInputJadwalDivisi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, Vcl.ComCtrls, uJadwalDivisi, MemDS, DBAccess, MyAccess;
type
  TFinputJadwalDivisi = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox2: TAdvGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edivisi: TAdvEdit;
    AdvSmoothButton1: TAdvSmoothButton;
    EjmlPekerja: TAdvEdit;
    EtotalKapasitas: TAdvEdit;
    dt1: TDateTimePicker;
    EmanHour: TAdvEdit;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EnomerSO: TAdvEdit;
    Eitem: TAdvEdit;
    AdvSmoothButton3: TAdvSmoothButton;
    Ewaktuperitem: TAdvEdit;
    Etotalwaktujam: TAdvEdit;
    Label13: TLabel;
    Label14: TLabel;
    EmenitManHour: TAdvEdit;
    Label15: TLabel;
    Label16: TLabel;
    Eorder: TAdvEdit;
    AdvSmoothButton2: TAdvSmoothButton;
    Label18: TLabel;
    Label19: TLabel;
    EalokasiWaktuMenit: TAdvEdit;
    EitemNo: TAdvEdit;
    LidDivisi: TLabel;
    ETotalKapasitasJam: TAdvEdit;
    Label20: TLabel;
    Ewaktuitemperjam: TAdvEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Etotalwaktumenit: TAdvEdit;
    EalokasiWaktuJam: TAdvEdit;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    EDialokasikanMenit: TAdvEdit;
    EDialokasikanJam: TAdvEdit;
    Label28: TLabel;
    Label29: TLabel;
    EsisaMenit: TAdvEdit;
    ESisaJam: TAdvEdit;
    Label30: TLabel;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure EmanHourKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EjmlPekerjaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EDialokasikanJamChange(Sender: TObject);
    procedure EmanHourExit(Sender: TObject);
    procedure EalokasiWaktuMenitKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EalokasiWaktuJamKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
   

    procedure TampilanAwal;


    { Private declarations }
  public


    { Public declarations }
  end;

var
  FinputJadwalDivisi: TFinputJadwalDivisi;


implementation
  uses
    uDataBarang,uInputKategori, uMarCon, uListSOJadwal;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputJadwalDivisi.AdvSmoothButton2Click(Sender: TObject);
begin
  FDataSoJadwal.ShowModal;
end;

procedure TFinputJadwalDivisi.AdvSmoothButton3Click(Sender: TObject);
begin
  FinputKategori.ShowModal;
end;

procedure TFinputJadwalDivisi.btnSimpanClick(Sender: TObject);
var
  KapasitasOrder : Integer;
  JumlahAlokasi  : Integer;
  JumlahHari     : Integer;
  SisaHari       : Integer;
  i              : Integer;
  TglAwal        : TDate;
  idJadwal       : Integer;
  SudahAlokasi   : Integer;
  ls :TStringList;

begin
  if not CheckEdit(Self) then begin
     ls := TStringList.Create;

     try
           TglAwal        := dt1.Date;
           KapasitasOrder := ROUND(Etotalwaktumenit.AsFLoat);
           JumlahAlokasi  := ROUND(EalokasiWaktuMenit.AsFLoat);

           JumlahHari     := KapasitasOrder div JumlahAlokasi;
           if KapasitasOrder div JumlahAlokasi > 0 then
              SisaHari    := 1 else SisaHari :=  0;


           for i := 0 to JumlahHari + SisaHari -1 do begin
              ExQry(Q1,'SELECT * FROM jadwaldivisi WHERE id_divisi="'+LidDivisi.Caption+'" '+
              ' AND tgl="'+Tanggal(TglAwal + i)+'"',True);
              if Q1.IsEmpty then begin
                 idJadwal     := 0;
                 SudahAlokasi := 0;
              end else begin
                 idJadwal     := GetValInt(Q1,'id');
                 SudahAlokasi := GetValInt(Q1,'kapasitas_terpakai');
              end;

               if KapasitasOrder > JumlahAlokasi then begin

                   AddParam('id_divisi', LidDivisi.Caption,ls,'str');
                   AddParam('tgl', frmTgl(TglAwal + i),ls,'date');
                   AddParam('manhour', EmanHour.isAngka,ls,'str');
                   AddParam('jml_pekerja', EjmlPekerja.isAngka,ls,'str');
                   AddParam('kapasitas_divisi',EtotalKapasitas.isAngka,ls,'str');
                   AddParam('kapasitas_terpakai',IntToStr(SudahAlokasi),ls,'str');
                   if idJadwal = 0 then
                        ExeDB(Q3,'jadwaldivisi',ls)
                     else
                        UpdateDB(Q3,'jadwaldivisi',ls,'id',IntToStr(idJadwal));



                     AddParam('id_divisi', LidDivisi.Caption,ls,'str');
                     AddParam('tgl', frmTgl(TglAwal + i),ls,'date');
                     AddParam('sono', EnomerSO.Text,ls,'str');
                     AddParam('itemno', EitemNo.Text,ls,'str');
                     AddParam('itemdescription', Eitem.Text,ls,'str');
                     AddParam('qty_order', Eorder.isAngka,ls,'str');
                     AddParam('total_menit',IntToStr(jumlahAlokasi),ls,'str');
                     AddParam('item_permenit', Ewaktuperitem.isAngka,ls,'str');
                     ExeDB(Q3,'detailjadwal',ls);


                   KapasitasOrder := KapasitasOrder - JumlahAlokasi;
               end else begin
                     AddParam('id_divisi', LidDivisi.Caption,ls,'str');
                     AddParam('tgl', FrmTgl(TglAwal + i),ls,'date');
                     AddParam('manhour', EmanHour.isAngka,ls,'str');
                     AddParam('jml_pekerja', EjmlPekerja.isAngka,ls,'str');
                     AddParam('kapasitas_divisi',EtotalKapasitas.isAngka,ls,'str');
                     AddParam('kapasitas_terpakai',IntToStr(KapasitasOrder),ls,'str');
                     if idJadwal = 0 then
                        ExeDB(Q3,'jadwaldivisi',ls)
                     else
                        UpdateDB(Q3,'jadwaldivisi',ls,'id',IntToStr(idJadwal));




                     AddParam('id_divisi', LidDivisi.Caption,ls,'str');
                     AddParam('tgl', frmTgl(TglAwal + i),ls,'date');
                     AddParam('sono', EnomerSO.Text,ls,'str');
                     AddParam('itemno', EitemNo.Text,ls,'str');
                     AddParam('itemdescription', Eitem.Text,ls,'str');
                     AddParam('qty_order', Eorder.isAngka,ls,'str');
                     AddParam('total_menit',IntToStr(KapasitasOrder),ls,'str');
                     AddParam('item_permenit', Ewaktuperitem.isAngka,ls,'str');
                     ExeDB(Q3,'detailjadwal',ls);
               end;

           end;

           if Assigned(FJadwalDivisi) then
              FJadwalDivisi.CreateButtonGrid;
           TampilanAwal;
     finally
       ls.Free;
     end;
  end;
end;

procedure TFinputJadwalDivisi.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputJadwalDivisi.EalokasiWaktuJamKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if EalokasiWaktuJam.AsInteger > ESisaJam.AsInteger then begin
       Error('Jumlah alokasi melebihi kapasitas');
       Exit;
    end else if (EalokasiWaktuJam.AsInteger = ESisaJam.AsInteger) then begin
            EalokasiWaktuJam.Text   := ESisaJam.Text;
            EalokasiWaktuMenit.Text := EsisaMenit.Text;
    end else if (EalokasiWaktuJam.AsInteger < ESisaJam.AsInteger) then
      EalokasiWaktuMenit.Text := IntToStr(EalokasiWaktuJam.AsInteger * 60);
end;

procedure TFinputJadwalDivisi.EalokasiWaktuMenitKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if EalokasiWaktuMenit.AsInteger > EsisaMenit.AsInteger then begin
       Error('Jumlah alokasi melebihi kapasitas');
       Exit;
    end else
    EalokasiWaktuJam.Text := IntToStr(EalokasiWaktuMenit.AsInteger div 60);
end;

procedure TFinputJadwalDivisi.EDialokasikanJamChange(Sender: TObject);
begin
  if EDialokasikanJam.Text <> ''  then begin
     ESisaJam.Text    := IntToStr(ETotalKapasitasJam.AsInteger - EDialokasikanJam.AsInteger);
     EsisaMenit.Text  := IntToStr(EtotalKapasitas.AsInteger - EDialokasikanMenit.AsInteger);

  end;
end;

procedure TFinputJadwalDivisi.EjmlPekerjaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if EjmlPekerja.Text <> '' then begin
     ETotalKapasitasJam.Text  := IntToStr(EjmlPekerja.AsInteger * EmanHour.AsInteger);
     EtotalKapasitas.Text     := IntToStr(EjmlPekerja.AsInteger * EmenitManHour.AsInteger);


     if EalokasiWaktuMenit.AsInteger > EjmlPekerja.AsInteger * EmenitManHour.AsInteger then begin
        EalokasiWaktuJam.Text   := IntToStr((EjmlPekerja.AsInteger * EmenitManHour.AsInteger) div 60);
        EalokasiWaktuMenit.Text := IntToStr(EjmlPekerja.AsInteger * EmenitManHour.AsInteger);
     end;
  end;
  if EDialokasikanJam.AsInteger = 0 then
  begin
    ESisaJam.Text   := ETotalKapasitasJam.Text;
    EsisaMenit.Text := EtotalKapasitas.Text;
  end else begin
    ESisaJam.Text   := IntToStr(ETotalKapasitasJam.AsInteger - EDialokasikanJam.AsInteger);
    EsisaMenit.Text := IntToStr(EtotalKapasitas.AsInteger - EDialokasikanMenit.AsInteger);
  end;
end;

procedure TFinputJadwalDivisi.EmanHourExit(Sender: TObject);
begin
  if EDialokasikanJam.AsInteger = 0 then begin
     ESisaJam.Text   := ETotalKapasitasJam.Text;
     EsisaMenit.Text := EtotalKapasitas.Text;
  end else begin
     ESisaJam.Text   := IntToStr(ETotalKapasitasJam.AsInteger - EDialokasikanJam.AsInteger);
     EsisaMenit.Text := IntToStr(EtotalKapasitas.AsInteger - EDialokasikanMenit.AsInteger);
  end;
end;

procedure TFinputJadwalDivisi.EmanHourKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    Jam , Menit : Integer;
begin
   if EmanHour.Text <> '' then begin
      Jam                 := StrToIntDef(nilai(EmanHour.Text),0);
      Menit               := jam * 60;
      EmenitManHour.Text  := IntToStr(Menit);
      ETotalKapasitasJam.Text := IntToStr(Jam * EjmlPekerja.AsInteger);
      EtotalKapasitas.Text    := IntToStr(ETotalKapasitasJam.AsInteger * 60);
      ESisaJam.Text           := IntToStr(ETotalKapasitasJam.AsInteger - EDialokasikanJam.AsInteger);
      EsisaMenit.Text         := IntToStr(ESisaJam.AsInteger * 60);
   end;

end;

procedure TFinputJadwalDivisi.FormCreate(Sender: TObject);
begin
  EmanHour.isRupiah           := True;
  EjmlPekerja.isRupiah        := True;
  EmenitManHour.isRupiah      := True;
  EtotalKapasitas.isRupiah    := True;
  Etotalwaktujam.isRupiah     := True;
  ETotalKapasitasJam.isRupiah := True;
  Etotalwaktumenit.isRupiah   := True;
  Eorder.isRupiah             := True;
  Ewaktuperitem.isRupiah      := True;
  Ewaktuitemperjam.isRupiah   := True;
  EalokasiWaktuMenit.isRupiah := True;
end;


procedure TFinputJadwalDivisi.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  if ACol > 1 then
     CanEdit := True else CanEdit := False;
end;

procedure TFinputJadwalDivisi.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputJadwalDivisi.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL > 2 then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputJadwalDivisi.TampilanAwal;
begin
  ClearText(Self);


end;

end.
