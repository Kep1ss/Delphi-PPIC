unit uAccountant;

interface
  uses
    AnnabaDB,uMarCon;

    type
      TTrx = (acKredit,acDebit);
      TAccountant = class
        private
          FTrx          : TTrx;
          FAkunRekening : String;
          FNoBukti      : String;
          FKeterangan   : String;
          Ftgl          : TDate;
          FNominal      : Real;
          yDb           : TYDb;
        public
          constructor create;
          destructor destroy;override;
          function FindRekening(TrxName : String):String;
          procedure Posting;
          procedure DeletePost(nobukti:String);
          property Trx : TTrx read FTrx write FTrx;
          property Rekening : String read FAkunRekening write FAkunRekening;
          property NoBukti   : String read FNobukti write FNobukti;
          property Keterangan : String read FKeterangan write Fketerangan;
          property tgl : TDate read Ftgl write Ftgl;
          property Nominal : Real read FNominal write Fnominal;
      end;



implementation

{ TAccountant }

constructor TAccountant.create;
begin
  yDB := TYDb.Create(MariaCon.ZMy);

end;

procedure TAccountant.DeletePost(nobukti: String);
begin
  yDb.Table := 'saldo_akun';
  yDb.SQL   := 'DELETE FROM saldo_akun WHERE nobukti="'+Nobukti+'"';
  yDb.ExSQL;
end;

destructor TAccountant.destroy;
begin
  yDb.Free;
  inherited;
end;

function TAccountant.FindRekening(TrxName: String): String;
var
  varRekening : String;
begin
  varRekening := yDb.FindValue('config','trx_name',TrxName,'no_akun');
  Result      := varRekening;

end;

procedure TAccountant.Posting;
begin

    case FTrx of
      acKredit  : begin
                    yDb.Table   := 'saldo_akun';
                    yDb.FieldString('no_akun',    FAkunRekening);
                    yDb.FieldString('nobukti',    FNoBukti);
                    yDb.FieldString('keterangan', FKeterangan);
                    yDb.FieldDate('tgl',          Ftgl);
                    yDb.FieldFloat('kredit',      FNominal);
                    yDb.Save(0);
                  end;
      acDebit   : begin
                    yDb.Table   := 'saldo_akun';
                    yDb.FieldString('no_akun',    FAkunRekening);
                    yDb.FieldString('nobukti',    FNoBukti);
                    yDb.FieldString('keterangan', FKeterangan);
                    yDb.FieldDate('tgl',          Ftgl);
                    yDb.FieldFloat('debet',       FNominal);
                    yDb.Save(0);


                  end;
    end;

end;

end.
