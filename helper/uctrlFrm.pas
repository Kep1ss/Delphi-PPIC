unit uctrlFrm;

interface
uses
  Classes, stdctrls,Windows,Vcl.ComCtrls,dateUtils, SysUtils, Forms, Dialogs,MEnus,
  uComCtrl,Vcl.WinXCtrls;

  type
    TForm = class (forms.TForm)
    private
      btnBaru   : TButton;
      btnUbah   : TButton;
      btnCariBarang   : TButton;
      btnHapus  : TButton;
      btnTutup  : TButton;
      btnPrint  : TButton;
      btnSetting: TButton;
      btnSimpan : TButton;
      btnRefresh : TButton;
      btnSupplier:TButton;
      btnCariSales :TButton;
      btnCariPelanggan :TButton;
      T1        : TMenuItem;
      U1        : TMenuItem;
      H1        : TMenuItem;
      Epencarian : TSearchBox;
      procedure SetTanggal;
      procedure KeyUpHook(Sender: TObject; var Key: Word; Shift: TShiftState);
    public
      aPathRpt : String;
      apathExe : string;
      constructor Create(AOwner : TComponent);override;
    end;

implementation

{ TForm }



constructor TForm.Create(AOwner: TComponent);
begin
  inherited;
  KeyPreview        := True;
  btnBaru           := TButton(FindComponent('btnBaru'));
  btnUbah           := TButton(FindComponent('btnUbah'));
  btnCariBarang     := TButton(FindComponent('btnCariBarang'));
  btnHapus          := TButton(FindComponent('btnHapus'));
  btnPrint          := TButton(FindComponent('btnPrint'));
  btnTutup          := TButton(FindComponent('btnTutup'));
  btnSetting        := TButton(FindComponent('btnSetting'));
  btnSimpan         := TButton(FindComponent('btnSimpan'));
  btnSupplier       := TButton(FindComponent('btnSupplier'));
  btnRefresh        := TButton(FindComponent('btnRefresh'));
  btnCariSales      := TButton(FindComponent('btnCariSales'));
  btnCariPelanggan  := TButton(FindComponent('btnCariPelanggan'));
  T1                := TMenuItem(FindComponent('T1'));
  U1                := TMenuItem(FindComponent('U1'));
  H1                := TMenuItem(FindComponent('H1'));
  Epencarian        := TSearchBox(FindComponent('Epencarian'));
  OnKeyUp           := KeyUpHook;
  aPathRpt          := ExtractFilePath(ParamStr(0))+'rpt';
  apathExe          := ExtractFilePath(ParamStr(0));
  FormatSettings.ThousandSeparator  := '.';
  FormatSettings.DecimalSeparator   := ',';
  SetTanggal;


  {with dm.Q1 do begin
    Close;
    SQL.Text := ' SELECT * FROM hakakes where iduser="'+setIdKom+'"';
    Open;

    while not Eof do begin
      if Self.Caption = TRIM(FieldByName('submenu').AsString) then
      begin
        if btnBaru <> nil then begin
            if FieldByName('tambah').AsBoolean = True then
               btnBaru.Enabled := True else
               btnBaru.Enabled := False;
            if T1 <> nil then
               T1.Enabled  := btnBaru.Enabled;
        end;
        if btnUbah <> nil then begin
            if FieldByName('ubah').AsBoolean = True then
               btnUbah.Enabled := True else
               btnUbah.Enabled := False;
            if U1 <> nil then
               U1.Enabled  := btnUbah.Enabled;
        end;
       if btnHapus <> nil then begin
            if FieldByName('hapus').AsBoolean = True then
               btnHapus.Enabled := True else
               btnHapus.Enabled := False;
            if H1 <> nil then
               H1.Enabled  := btnHapus.Enabled;
        end;
        if (btnSetting <> nil) and (btnUbah <> nil) and (btnBaru <> nil) then
              btnSetting.Enabled := btnUbah.Enabled and btnBaru.Enabled;
      end;

      Next;
      end;
  end;    }
end;

procedure TForm.KeyUpHook(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_F1 : if btnBaru <> nil then btnBaru.Click;
  VK_F2 : if btnUbah <> nil then btnUbah.Click;
  VK_F3 : if btnSetting <> nil then  btnSetting.Click;
  VK_DELETE : if btnHapus <>  nil then btnHapus.Click;
  VK_ESCAPE : if btnTutup <> nil then btnTutup.Click else Close;
  VK_F4     : if btnPrint <> nil then btnPrint.Click;
  VK_F5     : if btnRefresh <> nil then btnRefresh.Click;

  end;
  if (Key = 70) and (Shift = [ssCtrl]) then
  begin
    if Epencarian <> nil then Epencarian.SetFocus;

  end;
  if (Key = 83) and (Shift = [ssCtrl]) then
  begin
    if btnSimpan <> nil then btnSimpan.Click;
  end;
  if (Key = 82) and (Shift = [ssCtrl]) then
  begin
    if btnCariBarang <> nil then btnCariBarang.Click;
  end;
  if (Key = 68) and (Shift = [ssCtrl]) then
  begin
    if btnSupplier <> nil then btnSupplier.Click;
  end;
  if (Key = 80) and (Shift = [ssCtrl]) then
  begin
    if btnCariSales <> nil then btnCariSales.Click;
  end;
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
    if btnCariPelanggan <> nil then btnCariPelanggan.Click;
  end;
  
end;

procedure TForm.SetTanggal;
begin

 { for i := 0 to ComponentCount -1 do
    begin
      if Components[i] is TcxDateEdit then  begin

         TcxDateEdit(Components[i]).Date := now ;
         TcxDateEdit(Components[i]).Properties.MaxDate := EncodeDate(tahun2,bulan2,tgl2);
         TcxDateEdit(Components[i]).Properties.MinDate := EncodeDate(tahun1,bulan1,tgl1);

      end
    else
      if Components[i] is TDateTimePicker then begin
         TDateTimePicker(Components[i]).Date := Now;
         TDateTimePicker(Components[i]).MaxDate := EncodeDate(tahun2,bulan2,tgl2);
         TDateTimePicker(Components[i]).MinDate := EncodeDate(tahun1,bulan1,tgl1);
      end;
    end;   }
end;

end.
