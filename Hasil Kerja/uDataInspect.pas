unit uDataInspect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet,DateUtils,
  DBAdvGrid, DBAccess, MyAccess, MemDS, Vcl.ComCtrls, frxExportBaseDialog,
  frxExportImage;

type
  TFDataInspect = class(TForm)
    Label1: TLabel;
    btnAdd: TAdvSmoothButton;
    P1: TAdvSmoothPanel;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbEntries: TAdvComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Ecari: TAdvEdit;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton1: TAdvSmoothButton;
    frxReport1: TfrxReport;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    Q1: TMyQuery;
    DBAdvGrid1: TDBAdvGrid;
    Label2: TLabel;
    Label8: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    btnFilter: TAdvSmoothButton;
    pPagination: TAdvSmoothPanel;
    Lentries: TLabel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    Q2: TMyQuery;
    QInsepect: TMyQuery;
    DInspect: TMyDataSource;
    AdvSmoothButton5: TAdvSmoothButton;
    QdetailInspect: TMyQuery;
    DDetailInspect: TMyDataSource;
    frInspect: TfrxDBDataset;
    frDetailInspect: TfrxDBDataset;
    frxJPEGExport1: TfrxJPEGExport;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure AdvSmoothButton4Click(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton5Click(Sender: TObject);
    procedure DBAdvGrid1DblClick(Sender: TObject);
  private
    { Private declarations }

    varIsLimit : Integer;
    varIsPage  : Integer;
    procedure ButtonPage(Sender: TObject);
    procedure Pagination(RowStart:Integer);


  public
    { Public declarations }
    procedure LoadData(isCari:String;isLimit : Integer;isOffSet:integer);

  end;



var
  FDataInspect: TFDataInspect;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputInspect, uProcessInspect;




procedure TFDataInspect.AdvSmoothButton1Click(Sender: TObject);
begin
  ExQry(QInsepect,getSQL('TableInspect')+' WHERE nomer="'+GetVal(QInsepect,'nomer')+'"',True);

  ExQry(QdetailInspect,getSQL('TableDetailInspect')+' WHERE nomer="'+GetVal(QInsepect,'nomer')+'"',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frInspect.fr3');
  frxReport1.ShowReport();

  LoadData(
  ' WHERE ins.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataInspect.AdvSmoothButton2Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data inspect '+GetVal(QInsepect,'buyer')+' Akan dihapus ?',mtConfirmation,[Mbyes,Mbno],0) = mrYes then
  begin
    ExQry(Q1,'DELETE FROM detail_inspect WHERE nomer="'+GetVal(QInsepect,'nomer')+'"',False);
    ExQry(Q1,'DELETE FROM inspect where nomer="'+GetVal(QInsepect,'nomer')+'"',False);

    LoadData(' WHERE  ins.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  pagination(0);
  end;
end;

procedure TFDataInspect.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Inspect.xls');
end;

procedure TFDataInspect.AdvSmoothButton4Click(Sender: TObject);
var
  nomer : String;
  i : integer;
  Ls : TStringList;
begin

  if  Assigned(FinputInspect) then
        FreeAndNil(FinputInspect);
   Application.CreateForm(TFinputInspect,FinputInspect);
   FinputInspect.Parent      := FMainMenu.pg;
   FinputInspect.Align       := AlClient;
   FinputInspect.BorderStyle := bsNone;
   FinputInspect.Position    := poOwnerFormCenter ;
   FinputInspect.visible     := True;
   FinputInspect.TampilanAwal;
   Nomer := GetVal(QInsepect,'nomer');
   ExQry(QInsepect,getSQL('TableInspect')+' WHERE nomer="'+Nomer+'"',True);

   ExQry(QdetailInspect,GetSQL('TableDetailInspect')+' WHERE nomer="'+Nomer+'"',True);
   FinputInspect.id                    := GetVal(QInsepect,'id');
   FinputInspect.cbCustomer.ItemIndex  := FinputInspect.cbCustomer.Items.IndexOf(GetVal(QInsepect,'buyer'));
   FinputInspect.dtMulai.Date          := GetValDate(QInsepect,'tgl');
   FinputInspect.dtInspect.Date        := GetValDate(QInsepect,'tgl_plan');
   FinputInspect.Enomer.Text           := GetVal(QInsepect,'nomer');


   FinputInspect.GridInspect;
   while QdetailInspect.Eof = False do begin

      FinputInspect.sg.Cells[0,FinputInspect.sg.RowCount -1] := GetVal(QdetailInspect,'no_so');
      FinputInspect.sg.Cells[1,FinputInspect.sg.RowCount -1] := GetVal(QdetailInspect,'no_container');
      FinputInspect.sg.Cells[2,FinputInspect.sg.RowCount -1] := GetVal(QdetailInspect,'itemno');
      FinputInspect.sg.Cells[3,FinputInspect.sg.RowCount -1] := GetVal(QdetailInspect,'description');
      FinputInspect.sg.Cells[4,FinputInspect.sg.RowCount -1] := 'SET';
      FinputInspect.sg.Cells[5,FinputInspect.sg.RowCount -1] := GetValR(QdetailInspect,'qty_order');
      FinputInspect.sg.Cells[6,FinputInspect.sg.RowCount -1] := GetValR(QdetailInspect,'qty_ready');
      FinputInspect.sg.Cells[7,FinputInspect.sg.RowCount -1] := GetValR(QdetailInspect,'qty_plan');
      FinputInspect.sg.Cells[8,FinputInspect.sg.RowCount -1] := GetVal(QdetailInspect,'item_id');
      QdetailInspect.Next;
      FinputInspect.sg.RowCount                               := FinputInspect.sg.RowCount + 1;

   end;
end;

procedure TFDataInspect.AdvSmoothButton5Click(Sender: TObject);
var
  nomer : String;
  i : integer;
begin

   Nomer := GetVal(QInsepect,'nomer');
   ExQry(QInsepect,getSQL('TableInspect')+' WHERE nomer="'+Nomer+'"',True);
  if GetValBol(QInsepect,'processed') = True then begin
      Error('Data sudah dilakukan process inspect !!');
      Exit;

   end else begin
  if  Assigned(FProsesInspect) then
        FreeAndNil(FProsesInspect);
         Application.CreateForm(TFProsesInspect,FProsesInspect);
         FProsesInspect.Parent      := FMainMenu.pg;
         FProsesInspect.Align       := AlClient;
         FProsesInspect.BorderStyle := bsNone;
         FProsesInspect.Position    := poOwnerFormCenter ;
         FProsesInspect.visible     := True;
         FProsesInspect.TampilanAwal;




       ExQry(QdetailInspect,GetSQL('TableDetailInspect')+' WHERE nomer="'+Nomer+'"',True);
       FProsesInspect.id                    := GetVal(QInsepect,'id');
       FProsesInspect.cbCustomer.ItemIndex  := FProsesInspect.cbCustomer.Items.IndexOf(GetVal(QInsepect,'buyer'));
       FProsesInspect.dtMulai.Date          := GetValDate(QInsepect,'tgl');
       FProsesInspect.Enomer.Text           := GetVal(QInsepect,'nomer');


       FProsesInspect.GridInspect;
       while QdetailInspect.Eof = False do begin

          FProsesInspect.sg.Cells[0,FProsesInspect.sg.RowCount -1] := GetVal(QdetailInspect,'no_so');
          FProsesInspect.sg.Cells[1,FProsesInspect.sg.RowCount -1] := GetVal(QdetailInspect,'no_container');
          FProsesInspect.sg.Cells[2,FProsesInspect.sg.RowCount -1] := GetVal(QdetailInspect,'itemno');
          FProsesInspect.sg.Cells[3,FProsesInspect.sg.RowCount -1] := GetVal(QdetailInspect,'description');
          FProsesInspect.sg.Cells[4,FProsesInspect.sg.RowCount -1] := 'SET';
          FProsesInspect.sg.Cells[5,FProsesInspect.sg.RowCount -1] := GetValR(QdetailInspect,'qty_plan');
          FProsesInspect.sg.Cells[6,FProsesInspect.sg.RowCount -1] := '';
          FProsesInspect.sg.Cells[7,FProsesInspect.sg.RowCount -1] := '';
          FProsesInspect.sg.Cells[8,FProsesInspect.sg.RowCount -1] := '';
          FProsesInspect.sg.Cells[9,FProsesInspect.sg.RowCount -1] := GetVal(QdetailInspect,'item_id');
          QdetailInspect.Next;
          FProsesInspect.sg.RowCount                               := FProsesInspect.sg.RowCount + 1;

       end;
   end;
end;

procedure TFDataInspect.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputInspect) then
        FreeAndNil(FinputInspect);
   Application.CreateForm(TFinputInspect,FinputInspect);

   FinputInspect.Parent      := FMainMenu.pg;
   FinputInspect.Align       := AlClient;
   FinputInspect.BorderStyle := bsNone;
   FinputInspect.Position    := poOwnerFormCenter ;
   FinputInspect.visible     := True;

   FinputInspect.GridInspect;
   FinputInspect.TampilanAwal;
end;

procedure TFDataInspect.btnFilterClick(Sender: TObject);
begin
  LoadData(
  ' WHERE ins.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins.tgl <="'+Tanggal(dt2.date)+'"',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataInspect.ButtonPage(Sender: TObject);
var
  varisPages : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     varisPages   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;

     LoadData(' WHERE ins.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,0),varisPages );
  end;
end;

procedure TFDataInspect.cbEntriesChange(Sender: TObject);
begin

LoadData(
  ' WHERE ins.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,1),0);

  Pagination(0);
end;

procedure TFDataInspect.DBAdvGrid1DblClick(Sender: TObject);
begin
  AdvSmoothButton4.Click;
end;

procedure TFDataInspect.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Ecari.Text <> '' then
  LoadData(' WHERE (ins.buyer LIKE "%'+ECari.Text+'%" )',StrToIntDef(cbEntries.Text,10),0)
  else
  LoadData(' WHERE ins..tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins..tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  Pagination(0);
end;

procedure TFDataInspect.FormCreate(Sender: TObject);
begin
  FDataInspect:= Self;

  dt1.Date := EncodeDate(YearOf(now),MonthOf(now),1);
  dt2.Date := EncodeDate(YearOf(now),MonthOf(now),DayOf(EndOfTheMonth(now)));
end;

procedure TFDataInspect.FormShow(Sender: TObject);
begin
  dt1.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),1);
  dt2.Date := EncodeDate(YearOf(dt1.Date),MonthOf(dt1.Date),DayOf(EndOfTheMonth(dt1.Date)));

  LoadData(' WHERE  ins.tgl >="'+Tanggal(dt1.date)+'" '+
  'AND ins.tgl <="'+Tanggal(dt2.date)+'" ',StrToIntDef(cbEntries.Text,10),0);
  pagination(0);
end;

procedure TFDataInspect.LoadData(isCari:String;isLimit : Integer;isOffSet:integer);
begin
   ExQry(QInsepect,getSQL('TableInspect')+ isCari+' '+
  ' LIMIT '+IntToStr(isLimit)+' OFFSET '+IntToStr(isLimit * isOffset)+' ',True);

  varIsLimit := isLimit;
  varIsPage  := isOffSet;
end;


procedure TFDataInspect.Pagination(RowStart: Integer);
var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    TotalData : integer;
begin
  ExQry(Q1,'SELECT COUNT(*) as totaldata FROM inspect   '+
  ' WHERE  tgl >="'+Tanggal(dt1.date)+'" '+
  'AND tgl <="'+Tanggal(dt2.date)+'"',True);
  TotalData := GetValInt(Q1,'totaldata');
  jmlPage := TotalData div varIsLimit;
  jmlPage := jmlPage + 1;
  pPagination.Visible := False;
  btnPriv             := FindComponent('btnPriv') as TAdvSmoothButton;

  if btnPriv <> nil then

  btnPriv.Align       := alLeft ;

  for i := pPagination.ComponentCount -1 Downto 0 do begin
      if pPagination.Components[i] is TAdvSmoothButton then
      TAdvSmoothButton(pPagination.Components[i]).Free;
  end;

  for i := jmlPage  Downto 1  do  begin

          btn := TAdvSmoothButton.Create(pPagination);
          btn.Parent := pPagination;
          btn.Height := 28;
          btn.Width  := 30;
          btn.Name   := 'btn'+IntToStr(i);
          btn.Align  := alRight;
          btn.Caption := IntToStr(i);
          btn.Color   :=  $003B3B3B;
          btn.AlignWithMargins  :=  True;
          btn.Appearance.SimpleLayout := True;
          btn.Appearance.Rounding     := 3;
          btn.AlignWithMargins        := True;
          btn.Appearance.Font.Color   := $009A9A9A;
          btn.Margins.Top             := 0;
          btn.Margins.Bottom          := 0;
          btn.Margins.Left            := 1;
          btn.Margins.Right           := 1;
          btn.OnClick                 := ButtonPage;
       //   pPagination.Width           := pPagination.Width + btn.Width;
       //   pPagination.Left            := pPagination.Left - btn.Width;

  end;
  btnPriv.Align := alRight;

  if varIsLimit > TotalData then
          RowOf := TotalData else RowOf := varIsLimit;
       Lentries.Caption := 'Showing '+IntToStr(QInsepect.RecNo)+' to '+IntToStr(RowOf)+' of '+ IntToStr(TotalData)+' entries';

      // pPagination.Left    := 200;
  //     pPagination.Width   := 870;
       pPagination.Visible := True;



end;

end.
