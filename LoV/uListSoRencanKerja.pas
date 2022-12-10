unit uListSoRencanKerja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess,
  VirtualTable;


type
  TFDaftarSORencanaKerja = class(TForm)
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
    vtjob_order: TStringField;
    vtdivisi: TStringField;
    vtno_so: TStringField;
    vtno_container: TStringField;
    vtitem: TStringField;
    vtqty: TIntegerField;
    vtmh: TIntegerField;
    vtunit_price: TIntegerField;
    vtid: TIntegerField;
    vtqty_order: TIntegerField;
    vtitemno: TStringField;
    vtitem_id: TIntegerField;
    vtid_divisi: TStringField;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EcariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPilihClick(Sender: TObject);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgBarangCheckBoxChange(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
  private

    procedure TampilanAwal;
    procedure CreateGrid;


    { Private declarations }
  public


    { Public declarations }
    isFokus : integer;
    idDivisi : String;
    procedure LoadGrid(Filter:String);
  end;

var
  FDaftarSORencanaKerja: TFDaftarSORencanaKerja;


implementation



{$R *.dfm}

uses UinputRencanaKerja, uMarCon;



{ TFinputMotif }

procedure TFDaftarSORencanaKerja.btnFindClick(Sender: TObject);
begin
  LoadGrid(' AND (dso.no_so LIKE "%'+Ecari.Text+'%" '+
  ' OR i.itemno LIKE "%'+Ecari.Text+'%" OR '+
  ' i.description LIKE "%'+Ecari.Text+'%" OR '+
  ' dso.nomer_container LIKE "%'+ECari.Text+'%") '+
  ' ');
end;

procedure TFDaftarSORencanaKerja.btnPilihClick(Sender: TObject);
var
  order , MH , Cost : real;
  qty_component : real;
  total_component : real;
  i , x , c : integer;
  isCheck : boolean;
begin

     vt.First;
     while not vt.Eof do begin


        With FinputRencanaKerja do begin


           sg.Cells[0,sg.RowCount -1] := vtjob_order.AsString;
           sg.Cells[1,sg.RowCount -1] := vtno_so.AsString;
           sg.Cells[2,sg.RowCount -1] := vtno_container.AsString;
           sg.Cells[3,sg.RowCount -1] := vtitemno.AsString;
           sg.Cells[4,sg.RowCount -1] := vtitem.AsString;
           sg.Cells[5,sg.RowCount -1] := vtqty.AsString;
           sg.Cells[6,sg.RowCount -1] := vtqty.AsString;
           sg.Cells[7,sg.RowCount -1] := vtmh.AsString;
           sg.Cells[8,sg.RowCount -1] := vtunit_price.AsString;
           sg.Cells[9,sg.RowCount -1] := Format('%.0n',[vtunit_price.AsFloat * vtqty.AsFloat]) ;
           sg.Cells[11,sg.RowCount -1] := 'SET';
           sg.Cells[12,sg.RowCount -1] := vtitem_id.AsString;
           sg.Cells[15,sg.RowCount -1] := vtid_divisi.AsString;

           if cbPerhitungan.Text = 'PER COMPONENT' then begin
              sg.Cells[13,sg.RowCount -1] := 'true';
              for i := 0 to sg.ColCount-1 do begin
                 sg.FontStyles[i,sg.RowCount-1] := sg.FontStyles[i,sg.RowCount-1] + [fsBold];

              end;
              ExQry(Q2,'SELECT c.component_id,c.nama,c.itemno,c.jumlah FROM material_product c '+
              ' WHERE itemno="'+vtitemno.AsString+'" ',True);

              i := sg.RowCount -1;
              x := i + 1;
              while  not Q2.Eof do begin
                 sg.Cells[0,x]   := vtjob_order.AsString;
                 sg.Cells[1,x]   := vtno_so.AsString;
                 sg.Cells[2,x]   := vtno_container.AsString;
                 sg.Cells[3,x]   := vtitemno.AsString;
                 sg.Cells[4,x]   := GetVal(Q2,'nama');
                 order           := vtqty.AsFloat;
                 qty_component   := GetValF(Q2,'jumlah');
                 total_component := Order * qty_component;
                 sg.Cells[5,x]   := Format('%.0n',[total_component]);
                 sg.Cells[6,x]   := Format('%.0n',[total_component]);

                 ExQry(Q1,'SELECT                                    '+
                            '      s.item_id,                          '+
                            '      s.component_id,                          '+
                            '      d.name,                             '+
                            '      TRIM(SUM(s.cost))+0 AS total_cost   '+
                            '    FROM                                  '+
                            '      process_component s                   '+
                            '      LEFT JOIN pekerjaan p               '+
                            '        ON p.`id` = s.`idpekerjaan`      '+
                            '      LEFT JOIN divisi d                  '+
                            '        ON d.`id` = p.`id_divisi`         '+
                            '    WHERE p.id_divisi="'+GetIdcmb(FinputRencanaKerja.cbDivisi)+'" '+
                            '    AND s.component_id="'+GetVal(Q2,'component_id')+'" '+
                            '    AND s.itemno="'+vtitemno.AsString+'" '+
                            '    GROUP BY p.`id_divisi`',True );

                 MH             := GetValF(Q1,'total_cost') / 200;
                 sg.Cells[7,x]  := Format('%.0n',[mh * total_component]);
                 sg.Cells[8,x]  := format('%.0n',[GetValF(Q1,'total_cost')]);
                 sg.Cells[9,x]  := format('%.0n',[total_component * GetValF(Q1,'total_cost')]);
                 sg.Cells[11,x] := 'COMPONENT';
                 sg.Cells[12,x] := GetVal(Q2,'component_id');
                 sg.Cells[14,x] := vtitem_id.AsString;
                 inc(x);
                 Q2.Next;
                 sg.RowCount := sg.RowCount + 1;
              end;
              i := x;

           end;
           if cbPerhitungan.Text = 'PER COMPONENT' then
             FinputRencanaKerja.sumcost(True)
           else
             FinputRencanaKerja.sumcost(false);

           sg.RowCount := sg.RowCount + 1;
           sg.Row      := sg.RowCount -1;
           sg.SetFocus;
           sg.Col    := 1;

        end;
        vt.Next;
     end;
     vt.Clear;

  Close;
end;

procedure TFDaftarSORencanaKerja.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFDaftarSORencanaKerja.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 15;
    RowCount := 2;

    Cells[0,0] := 'Job Order';
    Cells[1,0] := 'Divisi';
    Cells[2,0] := 'No SO';
    Cells[3,0] := 'No Container';
    Cells[4,0] := 'Item';
    Cells[5,0] := 'Qty Sisa';
    Cells[6,0] := 'MH';
    Cells[7,0] := 'Unit Price';
    Cells[8,0] := 'id';
    Cells[9,0] := 'QtyOrder';
    Cells[10,0] := 'Itemno';
    Cells[11,0] := 'item_Id';
    Cells[12,0] := '';
    Cells[13,0] := 'Qty Finish';
    Cells[14,0] := 'Id Divisi';

    ColWidths[0] := 100;
    ColWidths[1] := 200;
    ColWidths[2] := 100;
    ColWidths[3] := 100;
    ColWidths[4] := 150;
    ColWidths[5] := 80;
    ColWidths[6] := 50;
    ColWidths[7] := 50;
    ColWidths[8] := 0;
    ColWidths[9] := 0;
    ColWidths[10] := 0;
    ColWidths[11] := 0;
    ColWidths[12] := 30;
    ColWidths[13] := 0;
    ColWidths[14] := 0;

    ColumnSize.StretchColumn := 1;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarSORencanaKerja.EcariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin

    btnFind.Click;
  end;
end;

procedure TFDaftarSORencanaKerja.FormShow(Sender: TObject);
begin


  TampilanAwal;
end;

procedure TFDaftarSORencanaKerja.LoadGrid(Filter: String);
var
  i : integer;

begin
  CreateGrid;
    ExQry(Q1,' SELECT                   '+
             ' dso.no_input,            '+
             ' dso.nomer_container,     '+
             ' so.id_divisi,            '+
             ' d.name,                  '+
             ' dso.id,         '+
             ' i.id as item_id,         '+
             ' i.itemno,                '+
             ' i.description,           '+
             ' dso.qty_order,           '+
             ' dso.alokasi_per_menit,   '+
             ' dso.total_alokasi,       '+
             ' dso.jml_karyawan,        '+
             ' dso.total_alokasi_perhari,  '+
             ' dso.target_perolehan,       '+
             ' dso.tgl_mulai,              '+
             ' dso.tgl_akhir,              '+
             ' dso.no_so,                  '+
             ' ifnull(qr.qty_finish,0) as qty_finish               '+
             ' FROM                        '+
             ' detail_job_order dso        '+
             ' LEFT JOIN item i            '+
             '   ON i.`id` = dso.`item_id` '+
             ' LEFT JOIN master_job_order so  '+
             '   ON so.no_input=dso.no_input  '+
             ' LEFT JOIN divisi d ON d.id=so.id_divisi '+
             ' LEFT JOIN (SELECT SUM(IFNULL(rd.qty,0)) as qty_finish,'+
             ' rd.item_id,rd.id_divisi,rd.no_so,rd.no_container FROM detail_hasil_kerja rd  '+
             ' WHERE rd.id_divisi="'+idDivisi+'" GROUP BY rd.item_id,rd.id_divisi,rd.no_so,rd.no_container) '+
             ' qr ON qr.id_divisi=so.id_divisi '+
             ' and qr.item_id=dso.item_id AND qr.no_container=dso.nomer_container '+
             ' AND qr.no_so=dso.no_so WHERE so.id_divisi="'+idDivisi+'" AND dso.qty_order > ifnull(qr.qty_finish,0)  '+
             ' '+Filter+' GROUP BY dso.no_so,dso.nomer_container,so.id_divisi,i.id',True);
      i := 0;
      vt.Active := True;

      while not Q1.Eof do begin
        with sgBarang do begin
             Cells[0,i+1] := GetVal(Q1,'no_input');
             Cells[1,i+1] := GetVal(Q1,'name');
             Cells[2,i+1] := GetVal(Q1,'no_so');
             Cells[3,i+1] := GetVal(Q1,'nomer_container');
             Cells[4,i+1] := GetVal(Q1,'description');

             Cells[5,i+1] := Format('%.0n',[GetValF(Q1,'qty_order') - GetValF(Q1,'qty_finish')]);
             Cells[6,i+1] := GetValR(Q1,'total_alokasi');

             ExQry(Q2,'SELECT                                    '+
                      '      s.item_id,                          '+
                      '      d.name,                             '+
                      '      TRIM(SUM(s.cost))+0 AS total_cost   '+
                      '    FROM                                  '+
                      '      setting_process s                   '+
                      '      LEFT JOIN pekerjaan p               '+
                      '        ON p.`id` = s.`id_pekerjaan`      '+
                      '      LEFT JOIN divisi d                  '+
                      '        ON d.`id` = p.`id_divisi`         '+
                      '    WHERE id_divisi="'+GetVal(Q1,'id_divisi')+'" '+
                      '    AND s.item_id="'+GetVal(Q1,'item_id')+'" '+
                      '    GROUP BY p.`id_divisi`',True );
             Cells[7,i+1] := Format('%.0n',[GetValF(Q2,'total_cost')]);
             Cells[8,i+1] := GetVal(Q1,'id');
             Cells[9,i+1] := Format('%.0n',[GetValF(Q1,'qty_order')]);
             Cells[10,i+1] := GetVal(Q1,'itemno');
             Cells[11,i+1] := GetVal(Q1,'item_id');
             Cells[13,i+1] := GetVal(Q1,'qty_finish');
             Cells[14,i+1] := GetVal(Q1,'id_divisi');
             if vt.Locate('id',GetVal(Q1,'id'),[]) = true then
             AddCheckBox(12,i+1,true,false) else
             AddCheckBox(12,i+1,false,false);
             sgBarang.RowCount := sgBarang.RowCount + 1;
             Inc(i);
           end;

           Q1.Next;


        end;


end;

procedure TFDaftarSORencanaKerja.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol = 12
end;

procedure TFDaftarSORencanaKerja.sgBarangCheckBoxChange(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin

  if State = true then begin
    if vt.Locate('item_id;no_so;no_container;divisi',
     VarArrayOf([sgBarang.Cells[11,Arow],sgBarang.Cells[2,Arow],
       sgBarang.Cells[3,Arow],sgBarang.Cells[1,Arow]]),[]) = false then begin

         vt.Append;
         vtjob_order.AsString   := sgBarang.Cells[0,ARow];
         vtdivisi.AsString      := sgBarang.Cells[1,ARow];
         vtno_so.AsString       := sgBarang.Cells[2,Arow];
         vtno_container.AsString:= sgBarang.Cells[3,Arow];
         vtitem.AsString        := sgBarang.Cells[4,Arow];
         vtqty.AsInteger        := StrToIntDef(nilai(sgBarang.Cells[5,Arow]),0);
         vtmh.AsInteger         := StrToIntDef(nilai(sgBarang.Cells[6,Arow]),0);
         vtunit_price.AsInteger         := StrToIntDef(nilai(sgBarang.Cells[7,Arow]),0);
         vtid.AsInteger         := StrToIntDef(nilai(sgBarang.Cells[8,Arow]),0);
         vtqty_order.AsInteger         := StrToIntDef(nilai(sgBarang.Cells[9,Arow]),0);
         vtitemno.AsString         := sgBarang.Cells[10,Arow];
         vtitem_id.AsString         := sgBarang.Cells[11,Arow];
         vtid_divisi.AsString         := sgBarang.Cells[14,Arow];
         vt.Post;
       end;
  end else begin
     if vt.Locate('item_id;no_so;no_container;divisi',
       VarArrayOf([sgBarang.Cells[11,Arow],sgBarang.Cells[2,Arow],
       sgBarang.Cells[3,Arow],sgBarang.Cells[1,Arow]]),[]) = True then begin
        vt.Delete;
     end;
  end;
end;

procedure TFDaftarSORencanaKerja.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarSORencanaKerja.TampilanAwal;
begin
  ClearText(Self);
  vt.Active := True;
  vt.Clear;


end;

end.
