unit uInputPekerjaan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB,uOvEdit, Vcl.ExtCtrls,
  AdvGroupBox, AdvOfficeButtons, MemDS, DBAccess, MyAccess;
type
  TFinputPekerjaan = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    btnSimpan: TAdvSmoothButton;
    btnTutup: TAdvSmoothButton;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EDeskripsi: TAdvEdit;
    cbDivisi: TAdvComboBox;
    Label9: TLabel;
    rbByComponent: TAdvOfficeRadioButton;
    rbByProduct: TAdvOfficeRadioButton;
    G1: TAdvGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Ebiaya: TAdvEdit;
    Esatuan: TAdvEdit;
    EbiayaSetMesin: TAdvEdit;
    EKoef: TAdvEdit;
    G3: TAdvGroupBox;
    sg: TAdvStringGrid;
    RBSatuanProduk: TAdvOfficeRadioButton;
    G2: TAdvGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Esatuan2: TAdvEdit;
    Ebiaya2: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
      var IsFloat: Boolean; var FloatFormat: string);
    procedure btnSimpanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbByProductClick(Sender: TObject);
    procedure rbByComponentClick(Sender: TObject);
    procedure RBSatuanProdukClick(Sender: TObject);
  private

    procedure GridCategory;

    { Private declarations }
  public
    id : String;
    procedure TampilanAwal;

    { Public declarations }
  end;

var
  FinputPekerjaan: TFinputPekerjaan;


implementation
 uses
    uDataJobs, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputPekerjaan.rbByComponentClick(Sender: TObject);
begin
  GridCategory;
  G1.Enabled := true;
  G2.Enabled := False;
  G3.Enabled := False;
  Esatuan2.Text         := '';
  Ebiaya2.Text          := '';
end;

procedure TFinputPekerjaan.rbByProductClick(Sender: TObject);
var
  i : integer;
begin
  GridCategory;
  G1.Enabled := False;
  G2.Enabled := False;
  G3.Enabled := True;

  EDeskripsi.Text       := '';
  Ebiaya.Text           := '';
  Esatuan.Text          := '';
  EbiayaSetMesin.Text   := '';
  EKoef.Text            := '';
  Esatuan2.Text         := '';
  Ebiaya2.Text          := '';




      if Pos('RAKIT',UPPERCASE(cbDivisi.Text)) > 0 then begin
         ExQry(Q1,'SELECT * FROM category_rakit',True);
        sg.RowCount := Q1.RecordCount + 1;
        for i := 0 to Q1.RecordCount -1 do begin

         ExQry(Q2,'SELECT * FROM biaya_category_rakit WHERE id_pekerjaan="'+id+'" '+
         ' AND id_category_rakit="'+GetVal(Q1,'id')+'"',True);

         if Q2.IsEmpty = False then begin
            sg.Cells[1,i+1] :=  GetVal(Q2,'biaya');

         end else
         begin
            sg.Cells[1,i+1] :=  '0';
            sg.Cells[2,i+1] :=  '';
         end;
         sg.Cells[0,i+1] :=  GetVal(Q1,'deskripsi');
         sg.Cells[3,i+1] :=  GetVal(Q1,'id');
         Q1.Next;

        end;
      end else begin
            ExQry(Q1,'SELECT * FROM category_product',True);

            sg.RowCount := Q1.RecordCount + 1;
            for i := 0 to Q1.RecordCount -1 do begin

               ExQry(Q2,'SELECT * FROM biaya_pekerjaan_category WHERE id_pekerjaan="'+Id+'" '+
               ' AND id_category_product="'+GetVal(Q1,'id')+'"',True);

               if Q2.IsEmpty = False then begin
                  sg.Cells[1,i+1] :=  GetVal(Q2,'kd');
                  sg.Cells[2,i+1] :=  GetVal(Q2,'set_up');

               end else
               begin
                  sg.Cells[1,i+1] :=  '0';
                  sg.Cells[2,i+1] :=  '0';
               end;
               sg.Cells[0,i+1] :=  GetVal(Q1,'nama_category');
               sg.Cells[3,i+1] :=  GetVal(Q1,'id');
               Q1.Next;

          end;
      end;

end;

procedure TFinputPekerjaan.RBSatuanProdukClick(Sender: TObject);
begin
  GridCategory;
  G1.Enabled := False;
  G2.Enabled := True;
  G3.Enabled := False;
  EDeskripsi.Text       := '';
  Ebiaya.Text           := '';
  Esatuan.Text          := '';
  EbiayaSetMesin.Text   := '';
  EKoef.Text            := '';
end;

procedure TFinputPekerjaan.btnSimpanClick(Sender: TObject);

var
  idPekerjaan , i : Integer;
  ls : TStringList;
begin
  if not CheckEdit(Self) then begin
       ls := TStringList.Create;

       try
             addParam('id_divisi', GetIdcmb(cbDivisi),ls,'str');
             addParam('deskripsi', EDeskripsi.Text,ls,'str');
             if rbByComponent.Checked then begin
               addParam('biaya',     Ebiaya.isAngka,ls,'str');
               addParam('satuan',    Esatuan.Text,ls,'str');
               addParam('biaya_set_mesin',    EbiayaSetMesin.isAngka,ls,'str');
               addParam('koef',      StrToDecimal(Ekoef.text),ls,'str');
             end else if RBSatuanProduk.Checked then begin
               addParam('biaya',     Ebiaya2.isAngka,ls,'str');
               addParam('satuan',    Esatuan2.Text,ls,'str');
             end;
             if rbByProduct.Checked then
             addParam('jenis_biaya','Product',ls,'str')
             else if rbByComponent.Checked then
             addParam('jenis_biaya','Component',ls,'str')
             else if RBSatuanProduk.Checked then
             addParam('jenis_biaya','Satuan',ls,'str');

             ExQry(Q2,'SELECT id FROM pekerjaan WHERE id="'+id+'"',True);

             if Q2.IsEmpty then begin
                exeDb(Q1,'pekerjaan',ls);
                idPekerjaan := StrToInt(GetData(Q1,'pekerjaan ORDER BY id DESC limit 1','id'));
             end else
                 updatedb(Q1,'pekerjaan',ls,'id',GEtVal(Q2,'id'));

           if rbByProduct.Checked then begin

               if Pos('RAKIT',UPPERCASE(cbDivisi.Text)) > 0 then begin


                 ExQry(Q1,' DELETE FROM biaya_category_rakit WHERE id_pekerjaan="'+IntToStr(IdPekerjaan)+'"',False);

                 for i := 1 to sg.RowCount -1 do begin

                     addParam('id_pekerjaan', IntToStr(idPekerjaan),ls,'str');
                     addParam('id_category_rakit', sg.Cells[3,i],ls,'str');
                     addParam('biaya',             sg.Cells[1,i],ls,'str');
                     exeDb(Q1,'biaya_category_rakit',ls);
                 end;

               end end else begin

                 ExQry(Q1,' DELETE FROM biaya_pekerjaan_category WHERE id_pekerjaan="'+IntToStr(IdPekerjaan)+'"',False);

                 for i := 1 to sg.RowCount -1 do begin
                     if sg.Cells[3,i] <> '' then begin

                         addParam('id_pekerjaan', IntToStr(idPekerjaan),ls,'str');
                         addParam('id_category_product', sg.Cells[3,i],ls,'str');
                         addParam('kd',                  sg.Cells[1,i],ls,'str');
                         addParam('set_up',              sg.Cells[2,i],ls,'str');
                         exeDb(Q1,'biaya_pekerjaan_category',ls);
                     end;
                 end;
               end;



           TampilanAwal;
           if Assigned(FDataPekerjaan) then
           FDataPekerjaan.LoadData('',
           StrToIntDef(FDataPekerjaan.cbEntries.Text,10),
           0);
       finally
         ls.Free;
       end;
  end;

end;

procedure TFinputPekerjaan.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFinputPekerjaan.FormCreate(Sender: TObject);
begin
  Ebiaya.isRupiah := True;
end;

procedure TFinputPekerjaan.GridCategory;
begin
  with sg do begin
    ClearAll;

    ColCount := 4;
    RowCount := 2;

    if Pos('RAKIT',UPPERCASE(cbDivisi.Text)) > 0 then begin
        Cells[0,0] := 'Category';
        Cells[1,0] := 'Biaya';
        Cells[2,0] := '';
        Cells[3,0] := 'id';

        ColWidths[0] := 200;
        ColWidths[1] := 100;
        ColWidths[2] := 0;
        ColWidths[3] := 0;

    end else begin

        Cells[0,0] := 'Category';
        Cells[1,0] := 'KD';
        Cells[2,0] := 'SET UP';
        Cells[3,0] := 'id';

        ColWidths[0] := 200;
        ColWidths[1] := 70;
        ColWidths[2] := 70;
        ColWidths[3] := 0;
    end;

    ColumnSize.StretchColumn := 0;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFinputPekerjaan.sgCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  CanEdit :=  ACol in [1,2];
end;

procedure TFinputPekerjaan.sgGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,1,2,3] then begin
     VAlign := vtaCenter;
     HAlign := taCenter;
  end;
end;

procedure TFinputPekerjaan.sgGetFloatFormat(Sender: TObject; ACol, ARow: Integer;
  var IsFloat: Boolean; var FloatFormat: string);
begin
  if ACOL in [1,2] then
  begin
    IsFloat := True;
    FloatFormat := '%.0n';
  end else isFLoat := False;

end;

procedure TFinputPekerjaan.TampilanAwal;
begin
  ClearText(Self);
  GridCategory;
end;

end.
