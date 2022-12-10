unit uListOfDivisi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarDivisi = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  FDaftarDivisi: TFDaftarDivisi;


implementation



{$R *.dfm}

uses uInputBom, uSettingProsesProduksi, uMarCon;

{ TFinputMotif }

procedure TFDaftarDivisi.AdvSmoothButton1Click(Sender: TObject);
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
  RowG := FSettingProsesProduksi.sg.Row;

    item_id := StrToInt(GetData(Q2,'item WHERE itemno="'+FSettingProsesProduksi.LItemNo.Caption+'"','id'));
    ExQry(Q2,'SELECT c.nama_category,i.jenis_set,i.item_type,i.step_rakit,i.jenis_rakit FROM category_product c '+
         ' LEFT JOIN item i ON i.item_type=c.id WHERE i.id="'+IntToStr(item_id)+'"',True );

     ProductCategory    := GetVal(Q2,'nama_category');
     JenisSet           := GetVal(Q2,'jenis_set');
     id_category_product:= GetVal(Q2,'item_type');
     StepRakit          := GetValInt(Q2,'step_rakit');
     id_category_rakit  := GetVal(Q2,'jenis_rakit');
      for i := 1 to sgBarang.RowCount -1 do begin
         sgBarang.GetCheckBoxState(3,i,isCheck);

         if isCheck then begin
            with FSettingProsesProduksi.sg do begin
              Cells[0,RowG] := IntToStr(RowG);
              Cells[1,RowG] := sgBarang.Cells[1,i];
              Cells[2,RowG] := sgBarang.Cells[2,i];
              ExQry(Q1,'SELECT p.jenis_biaya,d.name FROM pekerjaan p  '+
                 ' LEFT JOIN divisi d on d.id=p.id_divisi WHERE p.id="'+sgBarang.Cells[4,i]+'"',True);
                 JenisBiaya := GetVal(Q1,'jenis_biaya');
                 Divisi     := GetVal(Q1,'name');

                 if JenisBiaya = 'Component' then begin
                    ExQry(Q1,'SELECT SUM(cost) as cost,SUM(biaya_set_mesin*jumlah) as biaya_set_mesin FROM process_component '+
                    ' WHERE idpekerjaan="'+sgBarang.Cells[4,i]+'" AND itemno="'+FSettingProsesProduksi.Litemno.Caption+'" ',True);
                    CostProduksi := GetValF(Q1,'cost') + GetValF(Q1,'biaya_set_mesin');
                 end else if JenisBiaya = 'Product' then begin
                    if JenisSet = 'KD' then begin
                       ExQry(Q1,'SELECT kd FROM biaya_pekerjaan_category WHERE '+
                       ' id_pekerjaan="'+sgBarang.Cells[4,i]+'" AND '+
                       ' id_category_product="'+id_category_product+'" ',True);

                       CostProduksi := GetValF(Q1,'kd');
                    end else begin
                       ExQry(Q1,'SELECT set_up FROM biaya_pekerjaan_category WHERE '+
                       ' id_pekerjaan="'+sgBarang.Cells[4,i]+'" AND '+
                       ' id_category_product="'+id_category_product+'" ',True);

                       CostProduksi := GetValF(Q1,'set_up');
                    end;
                    if POS('RAKIT',UpperCase(Divisi)) > 0 then begin
                       ExQry(Q1,'SELECT biaya FROM biaya_category_rakit WHERE id_category_rakit="'+id_category_rakit+'" '+
                       ' AND id_pekerjaan="'+sgBarang.Cells[4,i]+'"',True);
                       CostProduksi := GetValF(Q1,'biaya');

                    end;
                 end else if JenisBiaya = 'Satuan' then begin
                      ExQry(Q1,' SELECT biaya FROM pekerjaan WHERE id="'+sgBarang.Cells[4,i]+'"',True);
                      CostProduksi := GetValF(Q1,'biaya') * StepRakit;
                 end;
              Cells[3,RowG] := Format('%.2n',[CostProduksi]);
              Cells[4,RowG] := sgBarang.Cells[4,i];
              RowCount      := RowCount + 1;
              Inc(RowG);

            end;

         end;

      end;


  Close;
end;

procedure TFDaftarDivisi.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (j.dekripsi LIKE "%'+Ecari.Text+'%" ) ');
end;

procedure TFDaftarDivisi.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarDivisi.CreateGrid;
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

procedure TFDaftarDivisi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSettingProsesProduksi.sg.Row := FSettingProsesProduksi.sg.RowCount -1;
end;

procedure TFDaftarDivisi.FormShow(Sender: TObject);
begin
  TampilanAwal;
end;

procedure TFDaftarDivisi.LoadGrid(Filter: String);
var
  i , c : integer;
begin
  CreateGrid;
     ExQry(Q1,getSQL('TableJobs')+ Filter,True);
      for I := 0 to Q1.RecordCount -1 do begin
        sgBarang.RowCount     := sgBarang.RowCount + 1;
        sgBarang.Cells[0,i+1] := IntToStr(i+1);
        sgBarang.Cells[1,i+1] := GetVal(Q1,'name');
        sgBarang.Cells[2,i+1] := GetVal(Q1,'deskripsi');
        sgBarang.AddCheckBox(3,i+1,False,False);
        sgBarang.Cells[4,i+1] := GetVal(Q1,'id');
        for c := 1 to FSettingProsesProduksi.sg.RowCount -1 do begin
           if FSettingProsesProduksi.sg.Cells[4,c] = GetVal(Q1,'id') then
           begin
             sgBarang.RowColor[i+1] := clYellow;
             sgBarang.RowColorTo[i+1] := clYellow;
           end;
        end;
        Q1.Next;
      end;

end;


procedure TFDaftarDivisi.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 3;
end;

procedure TFDaftarDivisi.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarDivisi.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid('');

end;

end.
