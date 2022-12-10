unit uMainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothPageSlider,
  AdvSmoothExpanderGroup, AdvSmoothPanel, AdvSmoothExpanderPanel, AdvGlowButton, AdvSmoothButton, AdvOfficeImage,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, AdvMenus,ShellApi, Vcl.Menus, Vcl.ExtCtrls,oGlowButton, AdvMenuStylers;

  Const
    NORMAL_COLOR = $00363636;
    CHANGE_COLOR = $00DBDBDB;


  type
  TFMainMenu = class(TForm)
    ImageList1: TImageList;
    AdvSmoothPanel1: TAdvSmoothPanel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    Luser: TLabel;
    Ladmin: TLabel;
    AdvOfficeImage1: TAdvOfficeImage;
    ImageList2: TImageList;
    pg: TAdvSmoothPanel;
    sv: TSaveDialog;
    Image1: TImage;
    ExpandSetting: TAdvSmoothExpanderPanel;
    imgSetting: TAdvOfficeImage;
    ExpandMaster: TAdvSmoothExpanderPanel;
    imgMaster: TAdvOfficeImage;
    btnExpandMaster: TAdvGlowButton;
    ExpandPembelian: TAdvSmoothExpanderPanel;
    imgPembelian: TAdvOfficeImage;
    btnExpandPembelian: TAdvGlowButton;
    btnExpandSetting: TAdvGlowButton;
    AdvGlowButton38: TAdvGlowButton;
    AdvGlowButton39: TAdvGlowButton;
    AdvGlowButton40: TAdvGlowButton;
    AdvGlowButton33: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    btnSatuan: TAdvGlowButton;
    btnSupplier: TAdvGlowButton;
    AdvGlowButton11: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton10: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvPopupMenu1: TAdvPopupMenu;
    BillofMaterial1: TMenuItem;
    WorkOrder1: TMenuItem;
    MaterialRelease1: TMenuItem;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    AdvGlowButton7: TAdvGlowButton;
    AdvGlowButton9: TAdvGlowButton;
    AdvGlowButton12: TAdvGlowButton;
    AdvGlowButton13: TAdvGlowButton;
    AdvGlowButton14: TAdvGlowButton;
    AdvGlowButton15: TAdvGlowButton;
    AdvGlowButton16: TAdvGlowButton;
    AdvGlowButton17: TAdvGlowButton;
    ExpandPenjualan: TAdvSmoothExpanderPanel;
    imgPenjualan: TAdvOfficeImage;
    btnExpandPenjualan: TAdvGlowButton;
    AdvGlowButton19: TAdvGlowButton;
    AdvGlowButton20: TAdvGlowButton;
    AdvGlowButton21: TAdvGlowButton;
    btnDashboard: TAdvGlowButton;
    AdvGlowButton18: TAdvGlowButton;
    AdvGlowButton22: TAdvGlowButton;
    AdvGlowButton8: TAdvGlowButton;
    AdvGlowButton23: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AdvGlowButton4Click(Sender: TObject);
    procedure AdvGlowButton5Click(Sender: TObject);
    procedure btnSatuanClick(Sender: TObject);
    procedure btnSupplierClick(Sender: TObject);
    procedure AdvGlowButton41Click(Sender: TObject);
    procedure AdvGlowButton33Click(Sender: TObject);
    procedure AdvGlowButton3Click(Sender: TObject);
    procedure AdvGlowButton10Click(Sender: TObject);
    procedure AdvGlowButton6Click(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure AdvGlowButton7Click(Sender: TObject);
    procedure AdvGlowButton39Click(Sender: TObject);
    procedure AdvGlowButton8Click(Sender: TObject);
    procedure AdvGlowButton9Click(Sender: TObject);
    procedure AdvGlowButton12Click(Sender: TObject);
    procedure AdvGlowButton13Click(Sender: TObject);
    procedure AdvGlowButton14Click(Sender: TObject);
    procedure AdvGlowButton15Click(Sender: TObject);
    procedure AdvGlowButton16Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AdvGlowButton40Click(Sender: TObject);
    procedure AdvGlowButton17Click(Sender: TObject);
    procedure AdvGlowButton11Click(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);
    procedure AdvGlowButton18Click(Sender: TObject);
    procedure AdvGlowButton22Click(Sender: TObject);
    procedure AdvGlowButton19Click(Sender: TObject);
    procedure AdvGlowButton20Click(Sender: TObject);
    procedure AdvGlowButton21Click(Sender: TObject);
    procedure AdvGlowButton23Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetImageBtn;
  public
    { Public declarations }
    id_pegawai : String;

    procedure disableAll;
    procedure EnableAll;
    procedure LoadForm(asForm : TFormClass);
    procedure CloseForm;
    procedure ChangeColor(Abtn : TAdvGlowButton);

  end;

var
  FMainMenu: TFMainMenu;
  aForm : TForm;

implementation

{$R *.dfm}

uses uDataBarang, uDataCategory, uDataMaterial, uDataDivisi,
  uDataJobs, uInputBom, uDataBom,
  uDataComponent, uDataWIP, uGanttChart, uDataGanttChart,
  uDataPOMonitoring, uJadwalDivisi, uDataTableCostingProduk,
  uDataCategoryProduct, uDataCategoryRakit, uDataRencanaKerja, uDataHasilKerja,
  uLapRencanaKerja, uLapHasilKerja, uDataSO,uLapCompare, uDataJobOrder, uEngine,
  uMarCon, uSettingConnection, uDataBuyer, uScheduleChart, uDataUser,
  uDashboard, uDataInspect, uDataBeritaAcara, uDataDivisiPengerjaan,
  uDataMutasiBarang;




procedure TFMainMenu.AdvGlowButton10Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton10);
  LoadForm(TFDataWIP);
end;

procedure TFMainMenu.AdvGlowButton11Click(Sender: TObject);
begin
   ChangeColor(AdvGlowButton11);
   LoadForm(TFDataUser);
end;

procedure TFMainMenu.AdvGlowButton12Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton12);
  LoadForm(TFDataCategoryProduct);
end;

procedure TFMainMenu.AdvGlowButton13Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton13);
  LoadForm(TFDataCategoryRakit);
end;

procedure TFMainMenu.AdvGlowButton14Click(Sender: TObject);
begin
   ChangeColor(AdvGlowButton14);
    LoadForm(TFDataRencanaKerja);
end;

procedure TFMainMenu.AdvGlowButton15Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton15);
  LoadForm(TFDataHasilKerja);
end;

procedure TFMainMenu.AdvGlowButton16Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton16);
  LoadForm(TFDataSO);
end;

procedure TFMainMenu.AdvGlowButton17Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton17);
  LoadForm(TFDataBuyer);
end;

procedure TFMainMenu.AdvGlowButton18Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton18);
  LoadForm(TFDataInspect);
end;

procedure TFMainMenu.AdvGlowButton19Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton19);
  LoadForm(TFLapRencanaKerja);
end;

procedure TFMainMenu.AdvGlowButton1Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton1);
  LoadForm(TFDataBarang);
end;

procedure TFMainMenu.AdvGlowButton20Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton20);
  LoadForm(TFLapHasilKerja);
end;

procedure TFMainMenu.AdvGlowButton21Click(Sender: TObject);
begin
    ChangeColor(AdvGlowButton21);
    LoadForm(TFLapRencanavsHasil);
end;

procedure TFMainMenu.AdvGlowButton22Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton22);
  LoadForm(TFDataBa);
end;

procedure TFMainMenu.AdvGlowButton23Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton23);
  LoadForm(TFDataMutasiBarang);
end;

procedure TFMainMenu.AdvGlowButton2Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton2);
  LoadForm(TFDataPOMonitoring);
end;

procedure TFMainMenu.AdvGlowButton33Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton33);
  LoadForm(TFDataBOM);
end;

procedure TFMainMenu.AdvGlowButton39Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFMainMenu.AdvGlowButton3Click(Sender: TObject);
begin
   ChangeColor(AdvGlowButton3);
   LoadForm(TFDataComponent);
end;

procedure TFMainMenu.AdvGlowButton40Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton40);
  FSettingConnection.ShowModal;
end;

procedure TFMainMenu.AdvGlowButton41Click(Sender: TObject);
begin
  LoadForm(TFDataPekerjaan);
end;

procedure TFMainMenu.AdvGlowButton4Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton4);
  if not Assigned(FGrafikJadwal) then
  Application.CreateForm(TFGrafikJadwal,FGrafikJadwal);
  FGrafikJadwal.ShowModal;
end;

procedure TFMainMenu.AdvGlowButton5Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton5);
  LoadForm(TFDataCategory);
end;

procedure TFMainMenu.AdvGlowButton6Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton6);
  LoadForm(TFDataPekerjaan);
end;

procedure TFMainMenu.AdvGlowButton7Click(Sender: TObject);
begin
  //ShowMessage('Masih dalam pengerjaan');
  ChangeColor(AdvGlowButton7);
  LoadForm(TFJadwalDivisi);
end;

procedure TFMainMenu.AdvGlowButton8Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton9);
  LoadForm(TFDataDivisiPengerjaan);
end;

procedure TFMainMenu.AdvGlowButton9Click(Sender: TObject);
begin
  ChangeColor(AdvGlowButton9);
  LoadForm(TFDataJobOrder);
end;

procedure TFMainMenu.btnDashboardClick(Sender: TObject);
begin
  LoadForm(TFDashboard);
end;

procedure TFMainMenu.btnSatuanClick(Sender: TObject);
begin
  ChangeCOlor(btnSatuan);
  LoadForm(TFDataMaterial);
end;

procedure TFMainMenu.btnSupplierClick(Sender: TObject);
begin
  ChangeColor(btnSupplier);
  LoadForm(TFDataDivisi);
end;

procedure TFMainMenu.ChangeColor(Abtn : TAdvGlowButton);
var
   i : integer;
begin
  for i := 0 to FMainMenu.ComponentCount -1 do begin
      if FMainMenu.Components[i] is TAdvGlowButton then
      begin
        TAdvGlowButton(FMainMenu.Components[i]).Transparent := True;
        TAdvGlowButton(FMainMenu.Components[i]).Font.Color  := $00B7B7B7;

      end;

  end;
  Abtn.Transparent      := false;
  Abtn.Appearance.Color := CHANGE_COLOR;
  Abtn.Appearance.ColorTo := CHANGE_COLOR;
  Abtn.Appearance.ColorMirror := CHANGE_COLOR;
  Abtn.Appearance.ColorMirrorTo := CHANGE_COLOR;
  Abtn.Font.Color       := NORMAL_COLOR;

end;

procedure TFMainMenu.CloseForm;
var
  frm : TComponent;

begin
  frm := pg.FindComponent(aFOrm.Name);
  if (frm <> nil) then
  FreeAndNil(frm);
end;
procedure TFMainMenu.disableAll;
var
  i : integer;
begin
  for i := 0 to FmainMenu.ComponentCount -1 do begin
     if FmainMenu.Components[i] is TAdvGlowButton then
        TAdvGlowButton(FmainMenu.Components[i]).Visible := False;

  end;

end;

procedure TFMainMenu.EnableAll;
var
  i : integer;
begin
  for i := 0 to FmainMenu.ComponentCount -1 do begin
     if FmainMenu.Components[i] is TAdvGlowButton then
        TAdvGlowButton(FmainMenu.Components[i]).Visible := True;

  end;

end;


procedure TFMainMenu.FormActivate(Sender: TObject);
begin
  if not Assigned(MariaCon) then
  Application.CreateForm(TMariaCon, MariaCon);
  SetKoneksi(MariaCon.con);
end;

procedure TFMainMenu.FormShow(Sender: TObject);

begin
  SetImageBtn;
  LoadForm(TFDashboard);
end;

procedure TFMainMenu.LoadForm(asForm: TFormClass);
begin
  if  Assigned(aForm) then
      CloseForm;
      Aform := asForm.Create(pg);
  with aForm do
    begin
       Align := AlClient;
       BorderStyle := bsNone;
       Position := poOwnerFormCenter ;
       Parent := pg;
       visible := True;
    end;
end;
procedure TFMainMenu.SetImageBtn;
var
  i : integer;
  isName , Path: String;
begin

  for i := 0 to FMainMenu.ComponentCount -1 do begin
     if FMainMenu.Components[i] is TAdvOfficeImage then begin
       isName :=(FMainMenu.Components[i] as TAdvOfficeImage).Parent.Name;

       if TAdvOfficeImage(FMainMenu.Components[i]).Name = 'img'+StringReplace(isName,'Expand','',[rfReplaceAll])  then  begin
        Path := ExtractFilePath(ParamStr(0))+'\img';
        TAdvOfficeImage(FMainMenu.Components[i]).Picture.LoadFromFile(Path+'\expand.png');
       end;
     end;

  end;

end;

end.
