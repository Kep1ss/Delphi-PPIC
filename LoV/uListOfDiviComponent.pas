unit uListOfDiviComponent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarDivisiComponent = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgBarang: TAdvStringGrid;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private


    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isForm : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarDivisiComponent: TFDaftarDivisiComponent;


implementation



{$R *.dfm}

uses uSettingComponentProduct, uMarCon;

{ TFinputMotif }

procedure TFDaftarDivisiComponent.AdvSmoothButton1Click(Sender: TObject);
var
  i : integer;
  isCheck : Boolean;
  RowG    : integer;

  CostProduksi : Real;
  JenisBiaya   : String;
  ProductCategory : String;
  JenisSet     : String;
  id_category_product : String;
  StepRakit,item_id    : integer;
  Divisi : String;
  id_category_rakit : String;
begin
  RowG := FSettingComponentProduct.sgCost.RowCount -1;

    item_id := StrToInt(GetData(Q2,'item WHERE itemno="'+FSettingComponentProduct.LItemNo.Caption+'"','id'));
   
      for i := 1 to sgBarang.RowCount -1 do begin
         sgBarang.GetCheckBoxState(3,i,isCheck);

         if isCheck then begin
            with FSettingComponentProduct.sgCost do begin
              Cells[0,RowG] := IntToStr(RowG);
              Cells[1,RowG] := sgBarang.Cells[1,i];
              Cells[2,RowG] := sgBarang.Cells[2,i];
              ExQry(Q1,'INSERT INTO temp_cost_component (item_id,component_id,idpekerjaan) '+
              ' VALUES ("'+IntToStr(item_id)+'","'+FSettingComponentProduct.Lcomponentid.Caption+'",'+
              '"'+sgBarang.Cells[4,i]+'")',False);
              Cells[3,RowG] := '';
              Cells[4,RowG] := sgBarang.Cells[4,i];
              RowCount      := RowCount + 1;
              Inc(RowG);

            end;

         end;

      end;
      FSettingComponentProduct.sgCost.Row   := FSettingComponentProduct.sgCost.RowCount -1;
  
  Close;
end;

procedure TFDaftarDivisiComponent.btnFindClick(Sender: TObject);
begin
  LoadGrid(' AND (j.dekripsi LIKE "%'+Ecari.Text+'%" ) ');
end;

procedure TFDaftarDivisiComponent.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarDivisiComponent.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 5;
    RowCount := 2;

    Cells[0,0] := 'No';
    Cells[1,0] := 'Divisi';
    Cells[2,0] := 'Pekerjaan';
    Cells[3,0] := 'Pilih';
    Cells[4,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 300;
    ColWidths[3] := 100;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarDivisiComponent.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;

procedure TFDaftarDivisiComponent.LoadGrid(Filter: String);
var
  i , c : integer;
begin
  CreateGrid;
     ExQry(Q1,getSQL('TableJobs')+' WHERE d.is_active=true '+ Filter,True);
      for I := 0 to Q1.RecordCount -1 do begin
        sgBarang.RowCount     := sgBarang.RowCount + 1;
        sgBarang.Cells[0,i+1] := IntToStr(i+1);
        sgBarang.Cells[1,i+1] := GetVal(Q1,'name');
        sgBarang.Cells[2,i+1] := GetVal(Q1,'deskripsi');
        sgBarang.AddCheckBox(3,i+1,False,False);
        sgBarang.Cells[4,i+1] := GetVal(Q1,'id');
        for c := 1 to FSettingComponentProduct.sgCost.RowCount -1 do begin
           if FSettingComponentProduct.sgCost.Cells[4,c] = GetVal(Q1,'id') then
           begin
             sgBarang.RowColor[i+1] := clYellow;
             sgBarang.RowColorTo[i+1] := clYellow;
           end;
        end;
        Q1.Next;
      end;

end;


procedure TFDaftarDivisiComponent.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 3;
end;

procedure TFDaftarDivisiComponent.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarDivisiComponent.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid('');

end;

end.
