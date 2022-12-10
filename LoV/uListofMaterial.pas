unit uListofMaterial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarMaterial = class(TForm)
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
  FDaftarMaterial: TFDaftarMaterial;


implementation



{$R *.dfm}

uses uInputBom, uMarCon;

{ TFinputMotif }

procedure TFDaftarMaterial.AdvSmoothButton1Click(Sender: TObject);
var
  i , id: Integer;
  isCheck : Boolean;
  ls : TStringList;
begin

      ls := TStringList.Create;
      try
       With FinputBom do begin
         for i := 1 to sgBarang.RowCount -1 do begin

           sgBarang.GetCheckBoxState(3,i,isCheck);

           if isCheck then begin

               sgMaterial.Cells[0,sgMaterial.RowCount -1] := sgBarang.Cells[0,i];
               sgMaterial.Cells[1,sgMaterial.RowCount -1] := sgBarang.Cells[1,i];
               sgMaterial.Cells[2,sgMaterial.RowCount -1] := 'Unit';
               sgMaterial.Cells[3,sgMaterial.RowCount -1] := sgBarang.Cells[2,i];
               sgMaterial.Cells[4,sgMaterial.RowCount -1] := '1';
               sgMaterial.Cells[5,sgMaterial.RowCount -1] := sgBarang.Cells[2,i];
               sgMaterial.Cells[6,sgMaterial.RowCount -1] := '';
               sgMaterial.Cells[7,sgMaterial.RowCount -1] := sgBarang.Cells[4,i];


               ExQry(Q1,'SELECT id FROM temp_bom_detail WHERE item_id="'+sgBarang.Cells[4,i]+'" '+
               ' AND id_divisi="'+Lb1.Items[Lb1.SelectedItemIndex].Info+'" AND iduser="'+GetIdUser+'"',True);

               id := GetValInt(Q1,'id');
               AddParam('iduser',GetIdUser,ls,'str');
               AddParam('id_divisi',Lb1.Items[Lb1.SelectedItemIndex].Info,ls,'str');
               AddParam('item_id',sgBarang.Cells[4,i],ls,'str');
               AddParam('keterangan','',ls,'str');
               AddParam('jumlah','1',ls,'str');
               AddParam('unit','Unit',ls,'str');
               AddParam('standart_cost',StrToDecimal(sgBarang.Cells[2,i]),ls,'str');
               AddParam('total_biaya',StrToDecimal(sgBarang.Cells[2,i]),ls,'str');

               if id = 0 then
                  ExeDB(Q2,'temp_bom_detail',ls)
               else
                  UpdateDB(Q2,'temp_bom_detail',ls,'id',IntToStr(id));
               sgMaterial.RowCount                        := sgMaterial.RowCount + 1;



            end;
         end;
          sgMaterial.SetFocus;
          sgMaterial.Col    := 4;
          sgMaterial.Row    := 1;
       end;
   finally
     ls.Free;
   end;
  Close;
end;

procedure TFDaftarMaterial.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (description LIKE "%'+Ecari.Text+'%" or itemno LIKE "%'+Ecari.Text+'%")');
end;

procedure TFDaftarMaterial.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarMaterial.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 5;
    RowCount := 2;

    Cells[0,0] := 'Item No';
    Cells[1,0] := 'Deskripsi';
    Cells[2,0] := 'Harga';
    Cells[3,0] := 'Select';
    Cells[4,0] := 'id';

    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 100;
    ColWidths[3] := 100;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarMaterial.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
     btnFind.Click;
end;

procedure TFDaftarMaterial.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;
end;

procedure TFDaftarMaterial.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;

procedure TFDaftarMaterial.LoadGrid(Filter: String);
var
  i : integer;
begin
  CreateGrid;
     ExQry(Q1, getSQL('TableItems')+ Filter,True);

      for I := 0 to Q1.RecordCount -1 do begin
        sgBarang.RowCount     := sgBarang.RowCount + 1;
        sgBarang.Cells[0,i+1] := GetVal(Q1,'itemno');
        sgBarang.Cells[1,i+1] := GetVal(Q1,'description');
        sgBarang.Cells[2,i+1] := GetValR(Q1,'cost');
        sgBarang.AddCheckBox(3,i+1,False,False);
        sgBarang.Cells[4,i+1] := GetVal(Q1,'id');
        Q1.Next;
      end;

end;

procedure TFDaftarMaterial.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 3;
end;

procedure TFDaftarMaterial.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarMaterial.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' LIMIT 500');

end;

end.
