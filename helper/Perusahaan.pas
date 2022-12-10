unit Perusahaan;

interface
  uses
    AnnabaDb,uMarCon;
  Type
    TPerusahaan = class
      private
        FNama     : String;
        FAlamat   : String;
        FNoTelepon: String;
        FKota     : String;
        FWa       : String;
        FWa2      : String;
        FWa3      : String;
        FEmail    : String;
        FWebsite  : String;
        FFooter   : String;
        FFooter2  : String;
        FFooter3  : String;
      public
        constructor create;
        property Nama:String read FNama;
        property Alamat:String read FAlamat;
        property Kota :String read FKota;
        property Notelpon : String read FNoTelepon;
        property Wa:String read FWa;
        property Wa2:String read FWa2;
        property Wa3:String read FWa3;
        property Email:String read FEmail;
        property Website:String read FWebsite;
        property Footer   : String read FFooter;
        property Footer2  : String read FFooter2;
        property Footer3  : String read FFooter3;


    end;

implementation

{ TPerusahaan }

constructor TPerusahaan.create;
var
  yDB : TYDb;
begin
  yDB := TYDb.Create(MariaCon.ZMy);
  try
      yDB.SQL := 'SELECT * FROM profile WHERE id=1';
      yDB.ExQuery;

      FNama       := yDB.ValString('nama');
      FAlamat     := yDB.ValString('alamat');
      FKota       := yDB.ValString('kota');
      FNoTelepon  := yDB.ValString('notelepon');
      FWa         := yDB.ValString('wa');
      FWa2        := yDB.ValString('wa2');
      FWa3        := yDB.ValString('wa3');
      FEmail      := yDB.ValString('email');
      FWebsite    := yDB.ValString('website');
      FFooter     := yDB.ValString('footernota');
      FFooter2     := yDB.ValString('footernota2');
      FFooter3     := yDB.ValString('footernota3');
  finally
    yDB.Free;
  end;
end;


end.
