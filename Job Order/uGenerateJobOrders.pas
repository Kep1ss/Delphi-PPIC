unit uGenerateJobOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvOfficeButtons, MemDS, DBAccess, MyAccess, Vcl.ComCtrls;
type
  TFGenerateJobOrders = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    cbDivisi: TAdvComboBox;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    Label2: TLabel;
    dtAwal: TDateTimePicker;
    Label4: TLabel;
    dtAkhir: TDateTimePicker;
    pb1: TProgressBar;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private



    { Private declarations }
  public
    id : String;
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FGenerateJobOrders: TFGenerateJobOrders;


implementation
 uses
    uDataJobs, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFGenerateJobOrders.btnSimpanClick(Sender: TObject);

var
  idPekerjaan , i : Integer;
  ls : TStringList;
  Nomer : String;
  Tgl   : TDate;
  Description : String;
  itemPermenit : Integer;
  ManHour : INteger;
  TotalALokasi : integer;
  SisaManHour : integer;
  Target : Integer;
begin
  if not CheckEdit(Self) then begin
       ls := TStringList.Create;

       if cbDivisi.ItemIndex = -1 then begin
          Error('Divisi Belum Dipilh');
          Exit;
       end;

       try

            ExQry(Q1,getSQL('GantChart')+
            '  LEFT JOIN v_job_order v                      '+
            '  ON g.`nomer_container` = v.nomer_container   '+
            '  AND g.`so_no` = v.no_so                      '+
            '  AND gd.`item_id` = v.item_id                 '+
            '  AND gd.`id_divisi` = v.id_divisi  WHERE      '+
            '  gd.tgl_mulai>="'+Tanggal(dtAwal.Date)+'" '+
            '  AND gd.tgl_mulai<="'+Tanggal(dtAkhir.Date)+'" '+
            '  AND gd.id_divisi="'+GetIdcmb(cbDivisi)+'" '+
            '  AND v.no_input IS NULL ORDER BY gd.tgl_mulai ASC',True);

            if Q1.RecordCount > 0 then  begin


                    pb1.Max := Q1.RecordCount;
                    pb1.Position := 0;

                    Nomer := GetCode(Q2,'master_job_order','no_input','JO');
                    Tgl   := Now;
                    Description := 'Jo Produksi';

                    addParam('no_input',Nomer,ls,'str');
                    addParam('tgl_input', frmTgl(Tgl),ls,'date');
                    addParam('id_divisi',GetIdcmb(cbDivisi),ls,'str');
                    addParam('keterangan',Description,ls,'str');

                    exeDb(Q3,'master_job_order',ls);

                    while not Q1.Eof do begin

                       AddParam('no_input',           Nomer, ls,'str');
                       AddParam('nomer_container',    GetVal(Q1,'nomer_container'), ls,'str');
                       AddParam('item_id',            GetVal(Q1,'item_id'), ls,'str');
                       AddParam('qty_order',          GetVal(Q1,'qty_order'), ls,'str');
                       AddParam('alokasi_per_menit',  StrToDecimal(Format('%.0n',[GetValF(Q1,'manhour')/GetValF(Q1,'qty_order')])), ls,'str');
                       AddParam('total_alokasi',      GetVal(Q1,'manhour'), ls,'str');
                       AddParam('jml_karyawan',       GetVal(Q1,'alokasi_tng_kerja'), ls,'str');
                       AddParam('total_alokasi_perhari', StrToDecimal(Format('%.0n',[GetValF(Q1,'alokasi_tng_kerja') * GetValF(Q1,'jam_kerja') * 60])) , ls,'str');


                         ItemPermenit := Round(GetValF(Q1,'manhour') / GetValF(Q1,'qty_order'));
                         Manhour      := GetValInt(Q1,'manhour');
                         TotalAlokasi := GetValInt(Q1,'alokasi_tng_kerja') * GetValInt(Q1,'jam_kerja') * 60;
                         SisaManHour  := TotalAlokasi - Manhour;
                         Target       := Round(SisaManHour / ItemPermenit) + GetValInt(Q1,'qty_order');

                       AddParam('target_perolehan',      IntToStr(Target), ls,'str');
                       AddParam('tgl_mulai',             frmTgl(GetValDate(Q1,'tgl_mulai')), ls,'date');
                       AddParam('tgl_akhir',             frmTgl(GetValDate(Q1,'tgl_akhir')), ls,'date');
                       AddParam('no_so',                 GetVal(Q1,'so_no'), ls,'str');
                       AddParam('gant_detail_id',        GetVal(Q1,'id'), ls,'str');
                       exeDb(Q2,'detail_job_order',ls);
                       pb1.Position := Q1.RecNo;
                       Application.ProcessMessages;
                       Q1.Next;

                    end;
                    pb1.Position := pb1.Max;
            end else begin
              Informasi('Range tanggl tidak ditemukan di data GC, Silahkan Cek pemilihan DIVISI dan Range Tanggal');
            end;


       finally
         ls.Free;
       end;
  end;

end;

procedure TFGenerateJobOrders.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFGenerateJobOrders.FormShow(Sender: TObject);
begin
  isiCmb(Q1,'divisi WHERE is_active=true',['id','name'],cbDivisi);
end;

procedure TFGenerateJobOrders.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit :=  ACol in [1,2];
end;

procedure TFGenerateJobOrders.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFGenerateJobOrders.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL in [1,2] then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFGenerateJobOrders.TampilanAwal;
begin
  ClearText(Self);
end;

end.
