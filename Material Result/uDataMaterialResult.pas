unit uDataMaterialResult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel, AnnabaDB,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid,uDatatables, AdvCombo, tmsAdvGridExcel,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, frxClass,
  frxDBSet;

type
  TFDataMaterialResult = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
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
    QMasterRelease: TZQuery;
    QDetailRelease: TZQuery;
    frxReport1: TfrxReport;
    frMasterRelease: TfrxDBDataset;
    DMasterRelease: TDataSource;
    frDetailMasterRelease: TfrxDBDataset;
    AdvSmoothButton1: TAdvSmoothButton;
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
  FDataMaterialResult: TFDataMaterialResult;

implementation

{$R *.dfm}

uses uInputMaterial, uMainMenu, uInputMaterialRelease, uMarCon;




procedure TFDataMaterialResult.AdvSmoothButton1Click(Sender: TObject);
begin

  ExQry(QMasterRelease,'SELECT                    '+
                       '    r.id,                 '+
                       '     r.no_release,        '+
                       '     r.tgl,               '+
                       '     w.no_wo,             '+
                       '     d.name,              '+
                       '     w.deskripsi,         '+
                       '     r.keterangan         '+
                       '   FROM                   '+
                       '     material_release r   '+
                       '     LEFT JOIN wo w           '+
                       '       ON w.`id` = r.`id_wo`  '+
                       '     LEFT JOIN divisi d       '+
                       '       ON d.id = r.`id_divisi` '+
                       ' WHERE r.no_release="'+sg.Cells[0,sg.Row]+'"',True);


  QDetailRelease.Active := False;
  QDetailRelease.Active := True;

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frMaterialRelease.fr3');
  frxReport1.ShowReport();
end;



procedure TFDataMaterialResult.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(ParamStr(0))+'Exported\Data Material Release.xls');
end;

procedure TFDataMaterialResult.btnAddClick(Sender: TObject);
begin
  if Assigned(FinputMaterialRelease) then
     FreeAndNil(FinputMaterialRelease);
   Application.CreateForm(TFinputMaterialRelease,FinputMaterialRelease);

   FinputMaterialRelease.Parent      := FMainMenu.pg;
   FinputMaterialRelease.Align       := AlClient;
   FinputMaterialRelease.BorderStyle := bsNone;
   FinputMaterialRelease.Position    := poOwnerFormCenter ;
   FinputMaterialRelease.visible     := True;
   FinputMaterialRelease.TampilanAwal;
end;

procedure TFDataMaterialResult.cbEntriesChange(Sender: TObject);
begin
  LoadData(StrToIntDef(cbEntries.Text,1),1);
end;

procedure TFDataMaterialResult.CreateGrid;

begin
  with sg do begin
     ClearAll;
     ColCount   := 9;
     RowCount   := 2;
     FixedRows  := 1;


     Cells[0,0] := 'No Release';
     Cells[1,0] := 'Tgl';
     Cells[2,0] := 'Divisi';
     Cells[3,0] := 'No Wo';
     Cells[4,0] := 'Pekerjaan';
     Cells[5,0] := 'Keterangan';
     Cells[6,0] := 'id';
     Cells[7,0] := 'Action';
     Cells[8,0] := '';

     ColWidths[0] := 80;
     ColWidths[1] := 80;
     ColWidths[2] := 120;
     ColWidths[3] := 80;
     ColWidths[4] := 200;
     ColWidths[5] := 100;
     ColWidths[6] := 0;
     ColWidths[7] := 50;
     ColWidths[8] := 50;

     MergeCells(7,0,2,1);

     ColumnSize.StretchColumn := 5;
     ColumnSize.Stretch       := True;
  end;
end;

procedure TFDataMaterialResult.EcariKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  sg.LoadContent(' w.no_wo LIKE "%'+ECari.Text+'%" OR r.keterangan LIKE "%'+ECari.Text+'%"');
end;

procedure TFDataMaterialResult.FormCreate(Sender: TObject);
begin
  FDataMaterialResult := Self;
  sg.aTable   := 'material_release';
  sg.varForm  := FinputMaterial;
  sg.ModeForm := mfModal;



end;

procedure TFDataMaterialResult.FormShow(Sender: TObject);
begin

  CreateGrid;

  sg.AutoBuilHeader := False;
  sg.ButtonCount    := 2;
  sg.ButtonType     := ['btnEdit','btnHapus'];
  sg.RowStart       := 1;
  sg.SQL            := getSQL('DataMaterialRelease');
  sg.ActSQL         := asSQL;
  sg.StatPagination := True;
  LoadData(StrToIntDef(cbEntries.Text,10),0);
end;

procedure TFDataMaterialResult.LoadData(isLimit : Integer;isOffSet:integer);
begin
  CreateGrid;
  sg.Limit        := isLimit;
  sg.Offset       := isOffSet;
  sg.LoadContent('');
  sg.Pagination(pPagination,1);
  Lentries.Caption := sg.FLentris;
end;


procedure TFDataMaterialResult.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol in [0..11]) and (ARow = 0) then  begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;


end;

end.
