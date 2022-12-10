unit uInputWIP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,uEngine,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, AdvCombo, AdvUtil,uOvEdit,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst, Data.DB, Vcl.ExtCtrls,
  AdvGroupBox, AdvPageControl, Vcl.ComCtrls, AdvSmoothListBox, Vcl.ToolWin,
  MemDS, DBAccess, MyAccess;
type
  TFinputProgress = class(TForm)
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Enomer: TAdvEdit;
    AdvSmoothPanel3: TAdvSmoothPanel;
    btnTutup: TAdvSmoothButton;
    btnSimpan: TAdvSmoothButton;
    Bevel1: TBevel;
    dtInput: TDateTimePicker;
    Label4: TLabel;
    EnoWO: TAdvEdit;
    Label5: TLabel;
    EContainer: TAdvEdit;
    Label8: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    EqtyOrder: TAdvEdit;
    Label10: TLabel;
    EQtyWO: TAdvEdit;
    Label11: TLabel;
    Label7: TLabel;
    cbNoSo: TAdvComboBox;
    cbItems: TAdvComboBox;
    AdvGroupBox2: TAdvGroupBox;
    sg: TAdvStringGrid;
    EQtyMasuk: TAdvEdit;
    Label6: TLabel;
    EQtyFinish: TAdvEdit;
    Label9: TLabel;
    Label12: TLabel;
    EQtySisa: TAdvEdit;
    Label13: TLabel;
    EQtyInput: TAdvEdit;
    Q1: TMyQuery;
    Q2: TMyQuery;

    procedure FormCreate(Sender: TObject);

    procedure btnTutupClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure cbNoSoChange(Sender: TObject);
    procedure cbItemsChange(Sender: TObject);
    procedure EQtyMasukChange(Sender: TObject);
    procedure sgClick(Sender: TObject);
    procedure EQtyInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSimpanClick(Sender: TObject);
  private

    { Private declarations }

  public
    procedure TampilanAwal;
    Procedure CreateGrid;


    { Public declarations }
  end;

var
  FinputProgress: TFinputProgress;



implementation
 uses
   uListOfProduct, uListofMaterial, uListofPekerjaan,
  uDataWOWip, uMarCon;


{$R *.dfm}

{ TFInputSupplier }

procedure TFinputProgress.EQtyInputKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if EQtyInput.AsInteger > EQtySisa.AsInteger then begin
     Error('Jumlah input tidak boleh melebihi jumlah sisa');
     EQtyInput.Text := EQtySisa.Text;
  end;

end;

procedure TFinputProgress.AdvSmoothButton1Click(Sender: TObject);
begin
  FDataWOWip.ShowModal;
end;

procedure TFinputProgress.btnSimpanClick(Sender: TObject);
var
  id_wo , item_no ,item_id: String;

  TotalFinish : Integer;
  TotalProcess : Integer;
  ls : TStringList;
begin

  if not CheckEdit(Self) then begin

      if EQtyInput.AsInteger > EQtySisa.AsInteger then begin
         Error('Jumlah input melebihi jumlah sisa');
         Exit;
      end else begin
           ls := TStringList.Create;

           try
               TotalProcess := sg.RowCount -1;

               id_wo        := GetData(Q1,'wo WHERE no_wo="'+ENoWo.Text+'"','id');
               item_no      := Copy(cbItems.Text,1,POS('|',cbItems.Text)-2);
               item_id      := GetData(Q1,'item where itemno="'+Item_no+'"','id');

               addParam('tgl',frmTgl(dtInput.Date),ls,'date');
               addParam('nobukti',Enomer.Text,ls,'str');
               addParam('id_wo',id_wo,ls,'str');
               addParam('no_so', cbNoSo.Text,ls,'str');
               addParam('item_id',item_id,ls,'str');
               addParam('item_no',item_no,ls,'str');
               addParam('id_pekerjaan',sg.Cells[3,sg.Row],ls,'str');
               addParam('qty',EQtyInput.Text,ls,'str');

               ExQry(Q1,'SELECT SUM(qty) as totalfinish FROM progress WHERE '+
               'item_id='+item_id+' AND no_so="'+cbNoSo.Text+'" '+
               'AND id_wo="'+id_wo+'"',True);

               TotalFinish := GetValInt(Q1,'totalfinish') + EQtyInput.AsInteger;


               if (TotalFinish DIV TotalProcess) = EQtyWO.AsInteger then
                AddParam('stts','FINISH',ls,'str')
               else
                AddParam('stts','WIP',ls,'str');

                ExeDb(Q2,'progress',ls);

                Informasi('Data berhasil disimpan');
                cbItems.OnChange(Sender);



         finally
           ls.Free;
         end;





      end;
  end;
end;

procedure TFinputProgress.btnTutupClick(Sender: TObject);
begin
  Close;
end;

procedure TFinputProgress.cbItemsChange(Sender: TObject);
var
  i  , QtyFinish,Persen : integer;
  item_no ,id_wo : String;
begin


       id_wo        := GetData(Q1,'wo WHERE no_wo="'+ENoWo.Text+'"','id');
       item_no      := Copy(cbItems.Text,1,POS('|',cbItems.Text)-2);
       ExQry(Q2,getSQL('DaftarJOBSWo')+' WHERE '+
       ' wj.item_no="'+item_no+'" AND '+
       ' wj.so_no="'+cbNoSo.Text+'" '+
       ' AND w.no_wo="'+EnoWo.Text+'" ',True);

       EqtyOrder.Text := GetVal(Q2,'qtyorder');
       EQtyWO.Text    := GetVal(Q2,'qty');

       ExQry(Q2,getSQL('TableDivisiProses')+' WHERE i.itemno="'+item_no+'" ORDER BY s.no_urut ASC',True);

       sg.RowCount := Q2.RecordCount + 1;
       for i := 0 to Q2.RecordCount -1 do begin
         sg.Cells[0,i+1] := GetVal(Q2,'no_urut');
         sg.Cells[1,i+1] := GetVal(Q2,'deskripsi');
         sg.Cells[3,i+1] := GetVal(Q2,'idprocess');
         ExQry(Q1,'SELECT fc_qtyFinishProcess("'+item_no+'","'+cbNoSo.Text+'",'+
                ''+id_wo+','+GetVal(Q2,'idprocess')+') as qtyFinish',True);

         QtyFinish := GetValInt(Q1,'qtyFinish');
         Persen    := ROUND(QtyFinish / EQtyWO.AsInteger * 100);

         sg.Ints[2,i+1]  := Persen;
         sg.AddProgress(2,i+1,clGreen,clWhite);
         sg.Cells[4,i+1] := IntToStr(QtyFinish);
         Q2.Next;
       end;


end;

procedure TFinputProgress.cbNoSoChange(Sender: TObject);
var
  i : integer;
begin
   ExQry(Q1,getSQL('DaftarJOBSWo')+' WHERE wj.so_no="'+cbNoSo.Text+'" '+
                    ' AND w.no_wo="'+ENoWo.Text+'"',True);

   cbItems.Items.Clear;

   for I := 0 to Q1.RecordCount -1 do begin
      cbItems.Items.Add(GetVal(Q1,'item_no')+' | '+GetVal(Q1,'deskripsi'));
      Q1.Next;
   end;
   cbItems.ItemIndex := 0;
   cbItems.OnChange(Sender);
end;

procedure TFinputProgress.CreateGrid;
begin
  with sg do begin
    ClearAll;

    ColCount := 5;
    RowCount := 2;
    FixedCols:= 0;

    Cells[0,0] := 'Step';
    Cells[1,0] := 'Process';
    Cells[2,0] := 'Progress';
    Cells[3,0] := 'id';
    Cells[4,0] := 'qty';

    ColWidths[0] := 60;
    ColWidths[1] := 200;
    ColWidths[2] := 100;
    ColWidths[3] := 0;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;

  end;
end;

procedure TFinputProgress.EQtyMasukChange(Sender: TObject);
begin
  if (StrToIntDef(EQtyMasuk.Text,0) <> 0) then
     EQtySisa.Text := IntToStr(StrToIntDef(EQtyMasuk.Text,0) - StrToIntDef(EQtyFinish.Text,0))
  else
     EQtySisa.Text := '0';

end;

procedure TFinputProgress.FormCreate(Sender: TObject);
begin
  FinputProgress     := Self;
  //TampilanAwal;


end;

procedure TFinputProgress.sgClick(Sender: TObject);
var
  id_wo : String;
  no_so : String;
  item_no : String;
  id_process : String;
begin
  id_process := sg.Cells[3,sg.Row];

  id_wo        := GetData(Q1,'wo WHERE no_wo="'+ENoWo.Text+'"','id');
  no_so      := cbNoSo.Text;
  item_no    := Copy(cbItems.Text,1,POS('|',cbItems.Text)-2);

  ExQry(Q1,'SELECT fc_getQtyAwal("'+item_no+'","'+no_so+'",'+
                ''+id_wo+','+id_process+') as qtyAwal',True);

  EQtyMasuk.Text  := GetVal(Q1,'qtyAwal');
  EQtyFinish.Text := sg.Cells[4,sg.Row];
  EQtyInput.Text  := '';
end;

procedure TFinputProgress.TampilanAwal;

begin
  ClearText(Self);
  Enomer.Text := GetCode(Q1,'progress','nobukti','');

  CreateGrid;

end;



end.
