unit uDataWorkOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel, AnnabaDB,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, frxClass, frxDBSet;

type
  TFDataWorkOrder = class(TForm)
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
    Lentries: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    pPagination: TAdvSmoothPanel;
    btnNext: TAdvSmoothButton;
    btnPriv: TAdvSmoothButton;
    sg: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    QFB1: TZQuery;
    AdvSmoothButton1: TAdvSmoothButton;
    QMasterWO: TZQuery;
    QDetailWO: TZQuery;
    DmasterWO: TDataSource;
    frxReport1: TfrxReport;
    frDetailWO: TfrxDBDataset;
    frMasterWO: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEntriesChange(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
  private
    { Private declarations }

    procedure CreateGrid;

  public
    { Public declarations }
    procedure LoadData(isLimit : Integer;isOffSet:integer);

  end;



var
  FDataWorkOrder: TFDataWorkOrder;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInpuWorkOrder;




procedure TFDataWorkOrder.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QMasterWO,'SELECT * FROM wo WHERE no_wo="'+sg.Cells[0,sg.Row]+'"',True);


  QDetailWO.Active := False;
  QDetailWO.Active := True;

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frWO.fr3');
  frxReport1.ShowReport();

end;

procedure TFDataWorkOrder.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data WO.xls');
end;

procedure TFDataWorkOrder.btnAddClick(Sender: TObject);
begin
    if  Assigned(FinputWo) then
        FreeAndNil(FinputWo);
   Application.CreateForm(TFinputWo,FinputWo);

   FinputWo.Parent      := FMainMenu.pg;
   FinputWo.Align       := AlClient;
   FinputWo.BorderStyle := bsNone;
   FinputWo.Position    := poOwnerFormCenter ;
   FinputWo.visible     := True;
end;

procedure TFDataWorkOrder.cbEntriesChange(Sender: TObject);
begin
  LoadData(StrToIntDef(cbEntries.Text,1),1);
end;

procedure TFDataWorkOrder.CreateGrid;

begin
  with sg do begin
     ClearAll;
     ColCount   := 5;
     RowCount   := 2;
     FixedRows  := 1;


     Cells[0,0] := 'No WO';
     Cells[1,0] := 'Tgl Input';
     Cells[2,0] := 'Tgl Mulai';
     Cells[3,0] := 'Keterangan';
     Cells[4,0] := 'PIC';

     ColWidths[0] := 200;
     ColWidths[1] := 100;
     ColWidths[2] := 150;
     ColWidths[3] := 250;
     ColWidths[4] := 120;


     ColumnSize.StretchColumn := 3;
     ColumnSize.Stretch       := True;
  end;
end;

procedure TFDataWorkOrder.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  sg.LoadContent(' w.deskripsi LIKE "%'+ECari.Text+'%"');
end;

procedure TFDataWorkOrder.FormCreate(Sender: TObject);
begin
  FDataWorkOrder:= Self;

end;

procedure TFDataWorkOrder.FormShow(Sender: TObject);
begin

  CreateGrid;

  sg.AutoBuilHeader := False;
  sg.ButtonCount    := 0;
  sg.RowStart       := 1;
  sg.SQL            := getSQL('TableWO');
  sg.ActSQL         := asSQL;
  sg.StatPagination := True;
  LoadData(StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataWorkOrder.LoadData(isLimit : Integer;isOffSet:integer);
begin
  CreateGrid;
  sg.Limit        := isLimit;
  sg.Offset       := isOffSet;
  sg.LoadContent('');
  sg.Pagination(pPagination,1);
  Lentries.Caption := sg.FLentris;
end;


procedure TFDataWorkOrder.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if ACol in [0..11] then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;



end.
