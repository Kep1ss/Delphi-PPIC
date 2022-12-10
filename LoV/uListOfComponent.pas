unit uListOfComponent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarComponent = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgBarang: TAdvStringGrid;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private


    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarComponent: TFDaftarComponent;


implementation



{$R *.dfm}

uses uSettingComponentProduct, uMarCon;

{ TFinputMotif }

procedure TFDaftarComponent.AdvSmoothButton1Click(Sender: TObject);
var
  i : integer;
  isCheck : Boolean;
  RowG    : integer;
  itemId  : string;
begin
  RowG := FSettingComponentProduct.sg.Row;

  
  for i := 1 to sgBarang.RowCount -1 do begin
     sgBarang.GetCheckBoxState(2,i,isCheck);

     if isCheck then begin


        with FSettingComponentProduct.sg do begin
          Cells[0,RowG] := IntToStr(RowG);
          Cells[1,RowG] := sgBarang.Cells[1,i];
          Cells[11,RowG]:= sgBarang.Cells[3,i];

          RowCount            := RowCount + 1;
          Inc(RowG);

        end;

     end;

  end;
  FSettingComponentProduct.upDateNumber;
  FSettingComponentProduct.sg.Row   := FSettingComponentProduct.sg.RowCount -1;
  Close;
end;

procedure TFDaftarComponent.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (description LIKE "%'+Ecari.Text+'%" or itemno LIKE "%'+Ecari.Text+'%") AND item_category=140');
end;

procedure TFDaftarComponent.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarComponent.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 4;
    RowCount := 2;

    Cells[0,0] := 'Item No';
    Cells[1,0] := 'Deskripsi';
    Cells[2,0] := 'Select';
    Cells[3,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 60;
    ColWidths[3] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarComponent.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
     btnFind.Click;
end;

procedure TFDaftarComponent.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;
end;

procedure TFDaftarComponent.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;

procedure TFDaftarComponent.LoadGrid(Filter: String);
var
  i , c: integer;
  ListComponent : TStringList;
begin
      CreateGrid;



      try
          ExQry(Q1,getSQL('TableComponent')+ Filter,True);

          for I := 0 to Q1.RecordCount -1 do begin
            sgBarang.RowCount         := sgBarang.RowCount + 1;
            sgBarang.Cells[0,i+1]     := IntToStr(i+1);
            sgBarang.Cells[1,i+1]     := GetVal(Q1,'description');
            sgBarang.Cells[3,i+1]     := GetVal(Q1,'id');
            for c := 1 to FSettingComponentProduct.sg.RowCount -1 do begin
              if GetVal(Q1,'description') = FSettingComponentProduct.sg.Cells[1,c] then
              begin
                sgBarang.RowColor[i] := clYellow;
                sgBarang.RowColorTo[i] := clYellow;
              end;
            end;


            sgBarang.AddCheckBox(2,i+1,False,False);
            Q1.Next;
          end;
      finally
        ListComponent.Free;
      end;


end;

procedure TFDaftarComponent.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := (ACol = 2);
end;

procedure TFDaftarComponent.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarComponent.TampilanAwal;
begin
  ClearText(Self);

  LoadGrid(' WHERE item_category=140 LIMIT 500');

end;

end.
