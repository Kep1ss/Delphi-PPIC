unit uListOfProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, DBAccess, MyAccess, MemDS, DBAdvGrid;


type
  TFDaftarBarang = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    Label1: TLabel;
    Ecari: TAdvEdit;
    btnFind: TAdvSmoothButton;
    btnAdd: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    DBAdvGrid1: TDBAdvGrid;
    Q1: TMyQuery;
    QLoV: TMyQuery;
    DLoV: TMyDataSource;
    Q2: TMyQuery;
    Q3: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure DBAdvGrid1DblClick(Sender: TObject);
    procedure DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private


    procedure TampilanAwal;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarBarang: TFDaftarBarang;


implementation



{$R *.dfm}

uses uInputBom, uInputProduct, uMarCon, uEngine;

{ TFinputMotif }

procedure TFDaftarBarang.btnAddClick(Sender: TObject);
begin
  FinputBarang.ShowModal;
end;

procedure TFDaftarBarang.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (description LIKE "%'+Ecari.Text+'%" '+
  ' OR itemno LIKE "%'+Ecari.Text+'%" ) AND inventory_group=3 ');
end;

procedure TFDaftarBarang.btnTutupClick(Sender: TObject);
begin
  Close;
end;



procedure TFDaftarBarang.DBAdvGrid1DblClick(Sender: TObject);
var
  i , ii , Urut: integer;
  ls : TStringList;
begin

  ls := TStringList.Create;

  try
  with FinputBOM do begin
      EitemNo.Text      := GetVal(Qlov,'itemno');
      Enamabarang.Text  := GetVal(Qlov,'description');


         ExQry(Q2, getSQL('CostingComponentProduct') + ' WHERE pc.itemno="'+EitemNo.Text +'" GROUP BY p.`id_divisi`,p.`id` ORDER BY p.id_divisi ASC',True);

          i    := 1;
          sgPekerjaan.RowCount := 2 ;
         // FinputBom.GridPekerjaan;

         if GetVal(Q2,'id_divisi') <> '' then begin

              while not Q2.Eof  do begin

                if lb1.Items[lb1.SelectedItemIndex].Info = GetVal(Q2,'id_divisi') then begin

                    sgPekerjaan.Cells[0,i] := GetVal(Q2,'deskripsi');
                    sgPekerjaan.Cells[1,i] := GetVal(Q2,'jumlah');
                    sgPekerjaan.Cells[2,i] := '-';
                    sgPekerjaan.Cells[3,i] := GetVal(Q2,'biaya');
                    sgPekerjaan.Cells[4,i] := GetVal(Q2,'cost');
                    sgPekerjaan.Cells[5,i] := GetVal(Q2,'idpekerjaan');
                    sgPekerjaan.RowCount        := sgPekerjaan.RowCount + 1;

                    if GetValF(Q2,'biaya_set_mesin') > 0 then begin
                      ii := i + 1;

                      sgPekerjaan.Cells[0,ii] := 'Biaya Set Mesin [ '+GetVal(Q2,'deskripsi')+ ']';
                      sgPekerjaan.Cells[1,ii] := '1';
                      sgPekerjaan.Cells[2,ii] := '-';
                      sgPekerjaan.Cells[3,ii] := GetVal(Q2,'biaya_set_mesin');
                      sgPekerjaan.Cells[4,ii] := GetVal(Q2,'biaya_set_mesin');
                      sgPekerjaan.Cells[5,ii] := GetVal(Q2,'idpekerjaan');
                      sgPekerjaan.RowCount    := sgPekerjaan.RowCount + 1;
                      i := ii + 1;
                    end else
                    inc(i);


                end;


                ExQry(Q1,'SELECT id FROM temp_bom_pekerjaan WHERE id_pekerjaan="'+GetVal(Q2,'idpekerjaan')+'" '+
                                    ' AND id_divisi="'+GetVal(Q2,'id_divisi')+'" AND iduser="'+GetIdUser+'"',True);

                if Q1.IsEmpty then begin
                    AddParam('id_divisi',GetVal(Q2,'id_divisi'),ls,'str');
                    AddParam('id_pekerjaan',GetVal(Q2,'idpekerjaan'),ls,'str');
                    AddParam('jumlah','1',ls,'str');
                    AddParam('unit','-',ls,'str');
                    AddParam('biaya_standart',StrToDecimal(GetVal(Q2,'biaya')),ls,'str');
                    AddParam('total_biaya',StrToDecimal(GetVal(Q2,'biaya')),ls,'str');
                    AddParam('iduser',GetIdUser,ls,'str');
                    ExeDB(Q3,'temp_bom_pekerjaan',ls);
                end;

                Q2.Next;
              end;

      end;

      LtotalMaterial.Caption := Format('%.2n',[TotalMaterial]);
      LtotalBiaya.Caption    := Format('%.2n',[TotalPekerjaan]);
  end;
  finally
    ls.Free;
  end;
  Close;
end;

procedure TFDaftarBarang.DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     DBAdvGrid1DblClick(Sender);
end;

procedure TFDaftarBarang.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
     btnFind.Click;

  end;
end;

procedure TFDaftarBarang.FormCreate(Sender: TObject);
begin
  Ecari.isCari := True;

end;

procedure TFDaftarBarang.FormShow(Sender: TObject);
begin
  TampilanAwal;

end;

procedure TFDaftarBarang.LoadGrid(Filter: String);
begin

  ExQry(Qlov, getSQL('TableProduct')+ Filter,True);
end;

procedure TFDaftarBarang.TampilanAwal;
begin
  ClearText(Self);

  LoadGrid(' WHERE inventory_group=3 LIMIT 500');

end;

end.
