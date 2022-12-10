unit uDaftarRencanaKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess,
  VirtualTable, Vcl.ComCtrls;


type
  TFDaftarRencanaKerja = class(TForm)
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
    Q1: TMyQuery;
    Q2: TMyQuery;
    btnPilih: TAdvSmoothButton;
    vt: TVirtualTable;
    vtnomer: TStringField;
    vttgl: TStringField;
    vtdivisi: TStringField;
    vtitem: TStringField;
    vtqty: TIntegerField;
    vthasil_kerja: TIntegerField;
    vtid: TIntegerField;
    vtmetode_perhitungan: TStringField;
    vtno_container: TStringField;
    vtrencana_id: TIntegerField;
    vtno_so: TStringField;
    vtitem_id: TIntegerField;
    Label2: TLabel;
    dtRencana: TDateTimePicker;
    vtpekerjaan: TStringField;
    vtid_divisi: TIntegerField;
    vtid_pekerjaan: TIntegerField;
    vtsub_divisi: TStringField;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure btnPilihClick(Sender: TObject);
    procedure sgBarangCheckBoxChange(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure dtRencanaChange(Sender: TObject);
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
  FDaftarRencanaKerja: TFDaftarRencanaKerja;


implementation



{$R *.dfm}

uses uInputHasilKerja, uMarCon;



{ TFinputMotif }

procedure TFDaftarRencanaKerja.btnFindClick(Sender: TObject);
begin
  LoadGrid(' WHERE (d.name LIKE "%'+Ecari.Text+'%" OR '+
  ' rk.nomer LIKE "%'+Ecari.Text+'%" OR '+
  ' rk.no_container LIKE "%'+Ecari.Text+'%" '+
  ' OR i.description LIKE "%'+ECari.Text+'%") '+
  ' AND rk.jenis="SET" AND p.id_divisi=r.id_divisi ');
end;

procedure TFDaftarRencanaKerja.btnPilihClick(Sender: TObject);
var
  i : integer;
  parent_id : string;
  itemname : String;
  isCheck : boolean;
  x : Integer;
begin


    vt.First;

    while not vt.Eof do begin

         ExQry(Q1,getSQL('TableRencanaKerja')+' '+
         '  WHERE r.nomer="'+vtnomer.AsString+'"',True);
     

         if vtmetode_perhitungan.AsString = 'PER SET' then begin
          ExQry(Q2,GetSQL('TableRencanaKerjaDetail')+' WHERE nomer="'+vtnomer.AsString+'" '+
         ' AND jenis="SET" AND item_id="'+vtitem_id.AsString+'" '+
         ' AND no_container="'+vtno_container.AsString+'" '+
         ' AND no_so="'+vtno_so.AsString+'"',True);
         itemname := '';
         parent_id := '';
         end else begin
           ExQry(Q2,GetSQL('TableRencanaKerjaDetail')+' WHERE nomer="'+vtnomer.AsString+'" '+
           ' AND jenis="COMPONENT" AND parent_name="'+vtitem.AsString+'" '+
           'AND no_container="'+vtno_container.AsString+'" '+
           ' AND no_so="'+vtno_so.AsString+'"',True);
           itemname := '['+vtitem.AsString+']';
           parent_id := vtid.AsString;
         end;


       //  FinputHasilKerja.GridHasilKerja;
         while Q2.Eof = False do begin
            if FinputHasilKerja.checkItem(GetVal(Q2,'item_id'),
            GetVal(Q2,'no_so'),GetVal(Q2,'no_container'),
            vtid_divisi.AsString,vtid_pekerjaan.AsString) = false then begin
              FinputHasilKerja.sg.Cells[0,FinputHasilKerja.sg.RowCount -1]  := GetVal(Q2,'no_so');
              FinputHasilKerja.sg.Cells[1,FinputHasilKerja.sg.RowCount -1]  := GetVal(Q2,'no_container');
              FinputHasilKerja.sg.Cells[2,FinputHasilKerja.sg.RowCount -1]  := GetVal(Q2,'itemno');
              FinputHasilKerja.sg.Cells[3,FinputHasilKerja.sg.RowCount -1]  := itemname+GetVal(Q2,'description')+'-'+vtsub_divisi.AsString;
              FinputHasilKerja.sg.Cells[4,FinputHasilKerja.sg.RowCount -1]  := GetValR(Q2,'qty');
              FinputHasilKerja.sg.Cells[5,FinputHasilKerja.sg.RowCount -1]  := '';
              FinputHasilKerja.sg.Cells[6,FinputHasilKerja.sg.RowCount -1]  := '';
              FinputHasilKerja.sg.Cells[7,FinputHasilKerja.sg.RowCount -1]  := Format('%.0n',[(vthasil_kerja.AsFloat / GetValF(Q2,'qty')) * 200]);
              FinputHasilKerja.sg.Cells[8,FinputHasilKerja.sg.RowCount -1]  := '';
              FinputHasilKerja.sg.Cells[9,FinputHasilKerja.sg.RowCount -1]  := GetVal(Q2,'jenis');
              FinputHasilKerja.sg.Cells[10,FinputHasilKerja.sg.RowCount -1] := GetVal(Q2,'item_id');
              FinputHasilKerja.sg.Cells[11,FinputHasilKerja.sg.RowCount -1] := itemname;
              FinputHasilKerja.sg.Cells[12,FinputHasilKerja.sg.RowCount -1] := parent_id;
              FinputHasilKerja.sg.Cells[13,FinputHasilKerja.sg.RowCount -1] := vtrencana_id.AsString;
              FinputHasilKerja.sg.Cells[14,FinputHasilKerja.sg.RowCount -1] := vtid_divisi.AsString;
              FinputHasilKerja.sg.Cells[15,FinputHasilKerja.sg.RowCount -1] := vtid_pekerjaan.AsString;
              FinputHasilKerja.sg.RowCount                                   := FinputHasilKerja.sg.RowCount + 1;
            end;

            Q2.Next;




         end;
         vt.Next;

   end;
   vt.Clear;
  Close;
end;

procedure TFDaftarRencanaKerja.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarRencanaKerja.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 17;
    RowCount := 2;

    Cells[0,0] := 'Nomer';
    Cells[1,0] := 'Tgl';
    Cells[2,0] := 'Divisi';
    Cells[3,0] := 'Divisi Job Order';
    Cells[4,0] := 'Item';
    Cells[5,0] := 'Qty';
    Cells[6,0] := 'MH';
    Cells[7,0] := 'id';
    Cells[8,0] := 'Metode Perhitungan';
    Cells[9,0] := 'No Container';
    Cells[10,0] := 'Rencana ID';
    Cells[11,0] := 'No So';
    Cells[12,0] := '';
    Cells[13,0] := 'Divisi';
    Cells[14,0] := 'IdPekerjaan';
    Cells[15,0] := 'IdPekerjaan';
    Cells[16,0] := 'Hasil';


    ColWidths[0] := 100;
    ColWidths[1] := 80;
    ColWidths[2] := 150;
    ColWidths[3] := 200;
    ColWidths[4] := 200;
    ColWidths[5] := 80;
    ColWidths[6] := 80;
    ColWidths[7] := 0;
    ColWidths[8] := 0;
    ColWidths[9] := 80;
    ColWidths[10]:= 0;
    ColWidths[11]:= 150;
    ColWidths[12]:= 30;
    ColWidths[13]:= 0;
    ColWidths[14]:= 0;
    ColWidths[15]:= 0;
    ColWidths[16]:= 0;

    ColumnSize.StretchColumn := 4;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarRencanaKerja.dtRencanaChange(Sender: TObject);
begin
  if FinputHasilKerja.cbSubdivisi.ItemIndex >= 0 then

    FDaftarRencanaKerja.LoadGrid(' WHERE rk.jenis="SET" AND '+
    '  r.divisi_planned="'+GetIdcmb(FinputHasilKerja.cbDivisi)+'"  '+
    ' AND r.tgl="'+Tanggal(dtRencana.Date)+'" '+
    ' AND sp.id_pekerjaan="'+GetIdCmb(FinputHasilKerja.CbSubdivisi)+'" ')
  else
    FDaftarRencanaKerja.LoadGrid(' WHERE rk.jenis="SET" AND '+
    '  r.divisi_planned="'+GetIdcmb(FinputHasilKerja.cbDivisi)+'"  '+
    ' AND r.tgl="'+Tanggal(dtRencana.Date)+'" ');
end;

procedure TFDaftarRencanaKerja.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
     btnFind.Click;

  end;
end;

procedure TFDaftarRencanaKerja.FormShow(Sender: TObject);
begin

  dtRencana.Date := now;
  TampilanAwal;
end;

procedure TFDaftarRencanaKerja.LoadGrid(Filter: String);
var
  i : integer;

begin
      CreateGrid;


      ExQry(Q1,getSQL('TableListRencanaKerja')+ FIlter,True);
      i := 0;
      vt.Active := true;
      while not Q1.Eof do begin
        with sgBarang do begin
             Cells[0,i+1]  := GetVal(Q1,'nomer');
             Cells[1,i+1]  := GetVal(Q1,'tgl');
             Cells[2,i+1]  := GetVal(Q1,'name');
             Cells[3,i+1]  := GetVal(Q1,'pekerjaan')+ ' - '+GetVal(Q1,'deskripsi');
             Cells[4,i+1]  := GetVal(Q1,'description') ;
             Cells[5,i+1]  := Format('%.0n',[GetValF(Q1,'qty')-GetValF(Q1,'qty_hasil')]);
             Cells[6,i+1]  := GetValR(Q1,'mh_detail');
             Cells[7,i+1]  := GetVal(Q1,'item_id');
             Cells[8,i+1]  := GetVal(Q1,'metode_perhitungan');
             Cells[9,i+1]  := GetVal(Q1,'no_container');
             Cells[10,i+1] := GetVal(Q1,'id');
             Cells[11,i+1] := GetVal(Q1,'no_so');
             Cells[13,i+1] := GetVal(Q1,'id_divisi');
             Cells[14,i+1] := GetVal(Q1,'id_pekerjaan');
             Cells[15,i+1] := GetVal(Q1,'deskripsi');
             Cells[16,i+1] := GetVal(Q1,'qty_hasil');
             if vt.Locate('item_id;no_so;no_container;divisi;id_pekerjaan',
             VarArrayOf([GetVal(Q1,'item_id'),GetVal(Q1,'no_so'),
             GetVal(Q1,'no_container'),GetVal(Q1,'name'),GetVal(Q1,'id_pekerjaan')]),[]) = true then
             AddCheckBox(12,i+1,true,false) else
             AddCheckBox(12,i+1,false,false);
             sgBarang.RowCount := sgBarang.RowCount + 1;
             Inc(i);
           end;

           Q1.Next;
        end;

end;

procedure TFDaftarRencanaKerja.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 12;
end;

procedure TFDaftarRencanaKerja.sgBarangCheckBoxChange(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  if State = true then begin
    if vt.Locate('item_id;no_so;no_container;divisi;id_pekerjaan',
     VarArrayOf([sgBarang.Cells[7,Arow],sgBarang.Cells[11,Arow],
       sgBarang.Cells[9,Arow],sgBarang.Cells[2,Arow],sgBarang.Cells[14,Arow]]),[]) = false then begin

       vt.Append;
       vtnomer.AsString               := sgBarang.Cells[0,ARow];
       vttgl.AsString                 := sgBarang.Cells[1,ARow];
       vtdivisi.AsString              := sgBarang.Cells[2,Arow];
       vtitem.AsString                := sgBarang.Cells[4,Arow];
       vtqty.AsInteger                := StrToIntDef(nilai(sgBarang.Cells[5,Arow]),0);
       vthasil_kerja.AsInteger        := StrToIntDef(nilai(sgBarang.Cells[6,Arow]),0);
       vtitem_id.AsString             := sgBarang.Cells[7,Arow];
       vtmetode_perhitungan.AsString  := sgBarang.Cells[8,Arow];
       vtno_container.AsString        := sgBarang.Cells[9,Arow];
       vtid.AsString                  := sgBarang.Cells[7,Arow];
       vtrencana_id.AsString          := sgBarang.Cells[10,Arow];
       vtno_so.AsString               := sgBarang.Cells[11,Arow];
       vtpekerjaan.AsString           := sgBarang.Cells[3,Arow];
       vtid_divisi.AsString           := sgBarang.Cells[13,Arow];
       vtid_pekerjaan.AsString        := sgBarang.Cells[14,Arow];
       vtsub_divisi.AsString          := sgBarang.Cells[15,Arow];
       vt.Post;
     end;
  end else begin
     if vt.Locate('item_id;no_so;no_container;divisi;id_pekerjaan',
     VarArrayOf([sgBarang.Cells[7,Arow],sgBarang.Cells[11,Arow],
     sgBarang.Cells[9,Arow],sgBarang.Cells[2,Arow],sgBarang.Cells[14,Arow]]),[]) = true then begin
        vt.Delete;
     end;
  end;
end;

procedure TFDaftarRencanaKerja.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarRencanaKerja.TampilanAwal;
begin
  ClearText(Self);

  vt.Active := True;


end;

end.
