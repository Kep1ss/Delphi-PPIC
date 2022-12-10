unit uListofSoGant;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, uEngine, MemDS, DBAccess, MyAccess;


type
  TFDaftarSOGant = class(TForm)
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
    Q3: TMyQuery;
    Q4: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure sgBarangDblClick(Sender: TObject);
    procedure sgBarangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
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
  FDaftarSOGant: TFDaftarSOGant;


implementation



{$R *.dfm}

uses  uMarCon, uGanttChart, uLoading;



{ TFinputMotif }

procedure TFDaftarSOGant.btnFindClick(Sender: TObject);
begin
  LoadGrid(' AND (customer LIKE "%'+Ecari.Text+'%" '+
  ' OR no_sales_order LIKE "%'+Ecari.Text+'%")');
end;

procedure TFDaftarSOGant.btnTutupClick(Sender: TObject);
begin
  Close;
end;



procedure TFDaftarSOGant.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 5;
    RowCount := 2;

    Cells[0,0] := 'NO';
    Cells[1,0] := 'No SO';
    Cells[2,0] := 'No Container';
    Cells[3,0] := 'Customer';
    Cells[4,0] := 'soid';


    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 200;
    ColWidths[3] := 200;
    ColWidths[4] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;
  end;
end;

procedure TFDaftarSOGant.FormShow(Sender: TObject);
begin

 
  TampilanAwal;
end;

procedure TFDaftarSOGant.LoadGrid(Filter: String);
var
  i : integer;

begin
     CreateGrid;


      ExQry(Q1, getSQL('TableDataSalesOrder')+'  '+
      ' WHERE  so.no_sales_order NOT IN (SELECT so_no '+
      ' FROM gantt_chart ) '+Filter+' GROUP BY no_sales_order ',True);
      i := 0;


      while not Q1.Eof do begin
        with sgBarang do begin
             Cells[0,i+1] := IntToStr(i+1);
             Cells[1,i+1] := GetVal(Q1,'no_sales_order');
             Cells[2,i+1] := GetVal(Q1,'nomer_container');
             Cells[3,i+1] := GetVal(Q1,'customer');
             Cells[4,i+1] := GetVal(Q1,'id');
             sgBarang.RowCount := sgBarang.RowCount + 1;
             Inc(i);
           end;

           Q1.Next;

      end;

end;

procedure TFDaftarSOGant.sgBarangDblClick(Sender: TObject);
var
  i  , j: integer;
  r , x : integer;
  Jam  : integer;
  urut : integer;
  jml  : real;
  ItemNo : String;
begin
  With FGanttChart do begin

     CreateGrid;
     ENoSo.Text         := sgBarang.Cells[1,sgBarang.Row];
     EnoContainer.Text  := sgBarang.Cells[2,sgBarang.Row];
     Ecustomer.Text     := sgBarang.Cells[3,sgBarang.Row];


          Q2.Close;
          Q2.SQL.Text := ' SELECT                           '+
                         '     dso.no_input,                '+
                         '     so.no_sales_order,           '+
                         '     so.customer,                 '+
                         '     dso.item_id,                 '+
                         '     i.itemno,                    '+
                         '     i.description,               '+
                         '     dso.jumlah,                  '+
                         '     dso.jumlah - fc_counterSO(so.no_sales_order,dso.item_id) as sisaQty,'+
                         '     dso.unit,                                                           '+
                         '     ((SUM(sp.cost) / 200) * dso.jumlah) as manhour, '+
                         '     dso.id                                                              '+
                         '   FROM                                                                  '+
                         '     detail_sales_order dso                                              '+
                         '     LEFT JOIN item i                                                    '+
                         '       ON i.`id` = dso.`item_id`                                         '+
                         '     LEFT JOIN sales_order so                                            '+
                         '       ON dso.no_input=so.no_input '+
                         '     LEFT JOIN setting_process sp ON sp.item_id=i.id '+
                         ' WHERE so.no_sales_order="'+sgBarang.Cells[1,sgBarang.Row]+'"  '+
                         ' AND i.itemno NOT IN (SELECT d.itemno FROM gant_detail d LEFT JOIN gantt_chart c '+
                         ' ON c.code=d.gantt_code WHERE c.so_no="'+sgBarang.Cells[1,sgBarang.Row]+'") GROUP BY i.id '+
                         ' ORDER BY manhour ASC ';
          Q2.Open;

          i := 1;
          j := 1;
         Floading.Show;
         Floading.pgbar.Maximum := Q2.RecordCount;
         Floading.pgbar.Position:= 1;
         Floading.Lprocess.Caption := 'Processing Data....';
          while not Q2.Eof do begin

            with sg1 do begin
                 Cells[0,i] := IntToStr(j);
                 Cells[1,i] := GetVal(Q2,'itemno')+'|'+GetVal(Q2,'description');
                 Cells[2,i] := GetVal(Q2,'jumlah');


                 jml        := GetValF(Q2,'jumlah');
                 ItemNo     := GetVal(Q2,'itemno');
                 ExQry(Q1, getSQL('TableDivisiProses') +  ' WHERE itemno="'+GetVal(Q2,'itemno')+'" GROUP BY d.id ORDER BY s.no_urut ASC',True);

                 r := i + 1;
                 urut :=1 ;
                 while not Q1.Eof do begin
                   Cells[3,r]       := IntToStr(Urut);
                   Cells[4,r]       := GetVal(Q1,'name');
                   ExQry(Q3,'SELECT                                   '+
                            '    d.id,                        '+
                            '    SUM(sp.cost) as cost,                        '+
                            '    SUM(sp.cost) / 200 as menit   '+
                            '  FROM                                   '+
                            '    setting_process sp                     '+
                            '    LEFT JOIN pekerjaan p ON p.id=sp.id_pekerjaan '+
                            '    LEFT JOIN divisi d ON d.id=p.id_divisi   '+
                            '    LEFT JOIN item i ON i.id=sp.item_id '+
                            '  WHERE d.id="'+GetVal(Q1,'id_divisi')+'" '+
                            '  AND i.itemno="'+ItemNo+'" ',True);
                   Cells[5,r] := GetVal(Q1,'jmlkaryawan') +' [ '+ FloatToStr(GetValF(Q1,'jmlkaryawan') * 8 * 60)+' ]';
                   Cells[6,r] := Format('%.0n',[GetValF(Q3,'menit') * jml]);
                   Cells[7,r] := '7';

                   Cells[14,r] := GetVal(Q1,'id_divisi');
                   Cells[15,r] := GetVal(Q1,'jmlkaryawan');
                   Cells[16,r] := GetVal(Q2,'item_id');
                   Cells[17,r] := GetVal(Q2,'jumlah');
                   Cells[18,r] := GetVal(Q1,'no_urut');
                   inc(r);
                   Inc(urut);
                   Q1.Next;
                   sg1.RowCount := sg1.RowCount + 1;
                 //  Floading.pgbar.Position := Q2.RecNo;
                   Application.ProcessMessages;
                 end;


               end;
               i := r;
               Inc(j);
               sg1.RowCount := sg1.RowCount + 2;
               Q2.Next;
               Floading.pgbar.Position := Q2.RecNo;
               Application.ProcessMessages;

          end;
          Floading.pgbar.Maximum := Floading.pgbar.Maximum;
          Floading.Close;


  end;
  Close;
end;


procedure TFDaftarSOGant.sgBarangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13  then
     sgBarang.OnDblClick(Sender);

end;

procedure TFDaftarSOGant.TampilanAwal;
begin
  ClearText(Self);
  LoadGrid(' ');


end;

end.
