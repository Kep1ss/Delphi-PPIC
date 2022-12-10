unit uDataWIP;

interface

uses
  Winapi.Windows, Vcl.Forms, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothPanel,Math,
  AdvSmoothButton, Vcl.ExtCtrls, AdvEdit, uOvEdit, uEngine, uComCtrl, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid,StrUtils, AdvGrid, AdvCombo, tmsAdvGridExcel,
  Data.DB, frxClass, frxDBSet, AdvGroupBox, AdvSmoothListBox, AdvTreeViewBase,
  AdvTreeViewData, AdvCustomTreeView, AdvTreeView, AdvOfficeButtons, MemDS,
  DBAccess, MyAccess, Vcl.Menus;

type
  TFDataWIP = class(TForm)
    Label1: TLabel;
    P1: TAdvSmoothPanel;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label4: TLabel;
    AdvGridExcelIO1: TAdvGridExcelIO;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothPanel2: TAdvSmoothPanel;
    sg: TAdvStringGrid;
    sg1: TAdvStringGrid;
    AdvGroupBox1: TAdvGroupBox;
    rbSO: TAdvOfficeRadioButton;
    rbContainer: TAdvOfficeRadioButton;
    Q1: TMyQuery;
    Q2: TMyQuery;
    Q3: TMyQuery;
    Q4: TMyQuery;
    frWIPProgress: TfrxDBDataset;
    frxReport1: TfrxReport;
    QWIPProgress: TMyQuery;
    EPencarian: TAdvEdit;
    AdvOfficeCheckBox1: TAdvOfficeCheckBox;
    sgDetail: TAdvStringGrid;
    PopupMenu1: TPopupMenu;
    K1: TMenuItem;
    H1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure rbSOClick(Sender: TObject);
    procedure rbContainerClick(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure EPencarianKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure sg1DblClick(Sender: TObject);
    procedure AdvOfficeCheckBox1Click(Sender: TObject);
    procedure sgDblClick(Sender: TObject);
    procedure H1Click(Sender: TObject);
    procedure K1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GridProsess;
    procedure GridSO;
    procedure LoadDataProcess(Filter:String);
    procedure GridDetail;



  public
    { Public declarations }


  end;



var
  FDataWIP: TFDataWIP;

implementation

{$R *.dfm}

uses  uMainMenu, uMarCon, uInputWIP, uLoading, uKoreksiHasilKerja;


procedure TFDataWIP.AdvOfficeCheckBox1Click(Sender: TObject);
begin
  sgDetail.Visible := not sgDetail.Visible;

  GridDetail;
end;

procedure TFDataWIP.AdvSmoothButton1Click(Sender: TObject);

begin


  ExQry(QWIPProgress,'SELECT * FROM v_finish_total WHERE '+
  'no_so="'+sg1.Cells[3,sg1.Row]+'" OR nomer_container="'+sg1.Cells[7,sg1.Row]+'" ',True);

  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Report\frProgress.fr3');
  frxReport1.ShowReport();
end;

procedure TFDataWIP.AdvSmoothButton3Click(Sender: TObject);
begin
  AdvGridExcelIO1.XLSExport(ExtractFilePath(Application.exeName)+'Exported\Data Progress PO_'+sg1.Cells[3,sg1.Row]+' Container_'+sg1.Cells[7,sg1.Row]+'.xls');
end;

procedure TFDataWIP.btnAddClick(Sender: TObject);
begin
   FinputProgress.TampilanAwal;
   FinputProgress.ShowModal;
end;

procedure TFDataWIP.EPencarianKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LoadDataProcess(' WHERE (s.nomer_container LIKE "%'+EPencarian.Text+'%" OR '+
  ' s.no_sales_order LIKE "%'+EPencarian.Text+'%" OR i.description LIKE "%'+EPencarian.Text+'%")' );
end;

procedure TFDataWIP.FormCreate(Sender: TObject);
begin
  FDataWIP  := Self;

end;



procedure TFDataWIP.FormShow(Sender: TObject);
begin

  GridProsess;
  rbSO.Checked := True;
  rbSO.OnClick(Sender);

end;

procedure TFDataWIP.GridDetail;
begin
  with sgDetail do begin
    ClearAll;

    ColCount := 4;
    RowCount := 2;
    FixedCols := 0;
    Cells[0,0] := 'Tgl';
    Cells[1,0] := 'Pengerjaan';
    Cells[2,0] := 'Qty';
    Cells[3,0] := 'ID';

    ColWidths[0] := 80;
    ColWidths[1] := 100;
    ColWidths[2] := 50;
    ColWidths[3] := 0;
  end;
end;

procedure TFDataWIP.GridProsess;
begin
  with sg do begin

    ClearAll;
    ColCount := 7;
    RowCount := 2;
    FixedCols := 0;

    Cells[0,0] := 'Nomer SO';
    Cells[1,0] := 'Container';
    Cells[2,0] := 'Item ';
    Cells[3,0] := 'Order ';
    Cells[4,0] := 'Finish ';
    Cells[5,0] := 'Id Divisi';
    Cells[6,0] := 'Item Id';

    ColWidths[0] := 0;
    ColWidths[1] := 100;
    ColWidths[2] := 100;
    ColWidths[3] := 50;
    ColWidths[4] := 50;
    ColWidths[5] := 0;
    ColWidths[6] := 0;

    ColumnSize.StretchColumn := 2;
    ColumnSize.Stretch       := True;


  end;
end;


procedure TFDataWIP.GridSO;
begin
  with sg1 do begin
    ClearAll;
    ColCount := 8;
    FixedCols:= 0;
    RowCount := 2;

    if rbSO.Checked then begin
      Cells[0,0] := 'Nomer SO';
      Cells[1,0] := 'Qty Order';
      Cells[2,0] := 'Progress';

    end else begin
      Cells[0,0] := 'Container';
      Cells[1,0] := 'Qty Order';
      Cells[2,0] := 'Progress';
    end;

    Cells[3,0]   := 'SO';
    Cells[4,0]   := 'item_id';

    Cells[5,0]   := 'Waktu(Menit)';
    Cells[6,0]   := 'IsHeader';
    Cells[7,0]   := 'Container';

    ColWidths[3] := 0;
    ColWidths[4] := 0;
    ColWidths[0] := 200;
    ColWidths[1] := 50;
    ColWidths[2] := 80;
    ColWidths[5] := 0;
    ColWidths[6] := 0;
    ColWidths[7] := 0;

    ColumnSize.StretchColumn := 0;
    ColumnSize.Stretch       := True;

  end;
end;


procedure TFDataWIP.H1Click(Sender: TObject);
begin
  if MessageDlg('Apakah yakin data akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    ExQry(Q1,'DELETE FROM detail_hasil_kerja WHERE id="'+sgDetail.Cells[3,sgDetail.Row]+'"',False);
    sg.OnDblClick(Sender);
  end;
end;

procedure TFDataWIP.K1Click(Sender: TObject);
begin
  FKoreksiInputHasilKerja.idDetail      := sgDetail.Cells[3,sgDetail.Row];
  FKoreksiInputHasilKerja.EqtyLama.Text := sgDetail.Cells[2,sgDetail.Row];
  FKoreksiInputHasilKerja.Showmodal;
end;

procedure TFDataWIP.LoadDataProcess(Filter:String);
var
  i , c , x: integer;
  qtyFinish : Integer;
  Persen    : Integer;
  ToTalProses : Integer;
  TotalMenit : real;
begin
  GridSO;

  if rbSO.Checked then begin
      try
          ExQry(Q1,'SELECT DISTINCT no_sales_order,nomer_container FROM sales_order s LEFT JOIN detail_sales_order d   '+
                      '      ON s.`no_input` = d.`no_input` '+
                      ' LEFT JOIN item i ON i.`id`=d.`item_id` '+Filter+' ',True);

          i := 1;
          while not Q1.Eof do begin
             sg1.RowCount         := sg1.RowCount + 1;
             sg1.Cells[0,i]       := GetVal(Q1,'no_sales_order');

             sg1.Cells[6,i]       := '1';
             sg1.Cells[7,i]       := GetVal(Q1,'nomer_container');
             sg1.FontStyles[0,i]  := [fsBold];

             ExQry(Q2,' SELECT                      '+
                      '    s.no_input,              '+
                      '    s.tgl_input,             '+
                      '    s.customer,              '+
                      '    s.no_sales_order,        '+
                      '    s.nomer_container,       '+
                      '    i.description,           '+
                      '    d.item_id,               '+
                      '    i.itemno,                '+
                      '    d.jumlah as totalqty                 '+
                      '  FROM                       '+
                      '    sales_order s            '+
                      '    LEFT JOIN detail_sales_order d   '+
                      '      ON s.`no_input` = d.`no_input` '+
                      ' LEFT JOIN item i ON i.`id`=d.`item_id` '+
                      ' WHERE s.no_sales_order="'+GetVal(Q1,'no_sales_order')+'"',True);
             x := i + 1;

             for c := 0 to Q2.RecordCount -1 do begin
               sg1.RowCount         := sg1.RowCount + 1;
               sg1.Cells[0,x] := GetVal(Q2,'itemno')+' | '+GetVal(Q2,'description');
               sg1.Cells[1,x] := GetVal(Q2,'totalqty');
               sg1.Cells[3,i] := GetVal(Q2,'no_sales_order');
               sg1.Cells[3,x] := GetVal(Q2,'no_sales_order');
               sg1.Cells[4,x] := GetVal(Q2,'item_id');
               sg1.Cells[6,x] := '0';
               sg1.Cells[7,x] := GetVal(Q1,'nomer_container');
               ExQry(Q4,'SELECT COUNT(distinct d.id) as totalprocess,SUM(cost) / 200 as menit FROM setting_process s '+
               ' LEFT JOIN pekerjaan p ON p.id=s.id_pekerjaan  '+
               ' LEFT JOIN divisi d ON d.id=p.id_divisi WHERE s.item_id="'+GetVal(Q2,'item_id')+'" ',True );
               ToTalProses := GetValInt(Q2,'totalqty');
               TotalMenit  := GetValF(Q4,'menit') * GetValF(Q2,'totalqty');
               sg1.Cells[5,x] := Format('%.0n',[TotalMenit]);


                ExQry(Q3,'SELECT fc_qtyreadypacking("'+Getval(Q2,'item_id')+'", '+
                '"'+GetVal(Q2,'no_sales_order')+'","'+GetVal(Q1,'nomer_container')+'") as qty',True);

                if ToTalProses > 0 then begin
                  qtyFinish     :=  floor(GetValInt(Q3,'qty') );
                  Persen        :=  floor( (qtyFinish / ToTalProses) * 100);
                  sg1.Ints[2,x] := Persen;
                end;
                sg1.AddProgress(2,x,clGreen,clWhite);

               Q2.Next;
               inc(x);
             end;
             i := x ;
             Q1.Next;

          end;
      except

      end;
  end else if rbContainer.Checked = true then begin

     try
         ExQry(Q1,'SELECT DISTINCT nomer_container FROM sales_order s LEFT JOIN detail_sales_order d   '+
                      '      ON s.`no_input` = d.`no_input` '+
                      ' LEFT JOIN item i ON i.`id`=d.`item_id` '+Filter+' ',True);

          i := 1;
          while not Q1.Eof do begin
             sg1.RowCount         := sg1.RowCount + 1;
             sg1.Cells[0,i]       := GetVal(Q1,'nomer_container');
             sg1.Cells[7,i]       := GetVal(Q1,'nomer_container');

             sg1.Cells[6,i]       := '1';
             sg1.FontStyles[0,i]  := [fsBold];

             ExQry(Q2,' SELECT                      '+
                      '    s.no_input,              '+
                      '    s.tgl_input,             '+
                      '    s.customer,              '+
                      '    s.no_sales_order,        '+
                      '    s.nomer_container,       '+
                      '    i.description,           '+
                      '    d.item_id,               '+
                      '    i.itemno,                '+
                      '    d.jumlah as totalqty                  '+
                      '  FROM                       '+
                      '    sales_order s            '+
                      '    LEFT JOIN detail_sales_order d   '+
                      '      ON s.`no_input` = d.`no_input` '+
                      ' LEFT JOIN item i ON i.`id`=d.`item_id` '+
                      ' WHERE s.nomer_container="'+GetVal(Q1,'nomer_container')+'"',True);

             x := i + 1;
             if Q2.RecordCount > 0 then begin
                 for c := 0 to Q2.RecordCount -1 do begin
                   sg1.RowCount   := sg1.RowCount + 1;
                   sg1.Cells[0,x] := '['+GetVal(Q2,'no_sales_order')+'] '+GetVal(Q2,'itemno')+' | '+GetVal(Q2,'description');
                   sg1.Cells[1,x] := GetVal(Q2,'totalqty');
                   sg1.Cells[3,x] := GetVal(Q2,'no_sales_order');
                   sg1.Cells[4,x] := GetVal(Q2,'item_id');
                   ExQry(Q3,'SELECT COUNT(distinct d.id) as totalprocess,SUM(cost) / 200 as menit FROM setting_process s '+
                   ' LEFT JOIN pekerjaan p ON p.id=s.id_pekerjaan  '+
                   ' LEFT JOIN divisi d ON d.id=p.id_divisi WHERE s.item_id="'+GetVal(Q2,'item_id')+'" ',True );
                   ToTalProses := GetValInt(Q2,'totalqty');
                   TotalMenit  := GetValF(Q3,'menit') * GetValF(Q2,'totalqty');
                   sg1.Cells[5,x] := Format('%.0n',[TotalMenit]);
                   ExQry(Q3,'SELECT fc_qtyreadypacking("'+Getval(Q2,'item_id')+'", '+
                   '"'+GetVal(Q2,'no_sales_order')+'","'+GetVal(Q1,'nomer_container')+'") as qty',True);

                    if ToTalProses > 0 then begin

                        qtyFinish := floor(GetValInt(Q3,'qty') );
                        Persen    := floor(qtyFinish /  ToTalProses * 100);
                        sg1.Ints[2,x] := Persen;
                    end;

                    sg1.AddProgress(2,x,clGreen,clWhite);

                   Q2.Next;
                   inc(x);
                 end;
             end;

             i := x ;
             Q1.Next;


          end;
     except

     end;
  end;



end;

procedure TFDataWIP.rbContainerClick(Sender: TObject);
begin
  LoadDataProcess('');
end;

procedure TFDataWIP.rbSOClick(Sender: TObject);
begin
  LoadDataProcess('');
end;

procedure TFDataWIP.sg1DblClick(Sender: TObject);
var
  i , x , F,j ,a: integer;
  TotalMenit, TotalQty, Menit : Integer;
begin

  GridProsess;
 // if sg1.Cells[1,sg1.Row] <> '' then begin
      try
          if sg1.Cells[6,sg1.Row] = '1' then begin

            ExQry(Q1,GetSQL('TableDetailJobOrder')+' WHERE '+
            ' dso.no_so="'+sg1.Cells[0,sg1.Row]+'" OR '+
            ' dso.nomer_container="'+sg1.Cells[0,sg1.Row]+'" '+
            ' GROUP BY dso.item_id',True);



          end else  begin
            ExQry(Q1,GetSQL('TableDetailJobOrder')+' WHERE '+
            ' dso.no_so="'+sg1.Cells[3,sg1.Row]+'" AND '+
            ' dso.nomer_container="'+sg1.Cells[7,sg1.Row]+'" '+
            ' AND dso.item_id="'+sg1.Cells[4,sg1.Row]+'" '+
            ' GROUP BY dso.item_id',True);


          end;

          sg.RowCount := Q1.RecordCount + 2;
          sg.ColCount :=  5;
          TotalMenit  :=  StrToIntDef(nilai(sg1.Cells[5,sg1.Row]),0);
          TotalQty    :=  StrToIntDef(nilai(sg1.Cells[1,sg1.Row]),0);
          if TotalMenit > 0 then
              Menit       :=  Round(TotalMenit / TotalQty)
          else
              Menit       := 0;
          j := 1;
          sg.BeginUpdate;
          Floading.Show;
          Floading.pgbar.Maximum := Q1.RecordCount;
          Floading.Lprocess.Caption := 'Sedang mengambil data ....';
          for I := 0 to Q1.RecordCount -1 do begin
            sg.Cells[0,j] := GetVal(Q1,'no_so');
            sg.Cells[1,j] := GetVal(Q1,'nomer_container');
            sg.Cells[2,j] := GetVal(Q1,'description');
            sg.Cells[3,j] := GetVal(Q1,'qty_order');

            sg.FontStyles[0,j] := [fsBold];
            sg.FontStyles[1,j] := [fsBold];
            sg.FontStyles[2,j] := [fsBold];
            sg.FontStyles[3,j] := [fsBold];

            x := j+1;
            ExQry(Q2, getSQL('TableDivisiProses') +  ' WHERE '+
            ' itemno="'+GetVal(Q1,'itemno')+'" GROUP BY d.id ORDER BY s.no_urut ASC',True);
            a := 1;
            while not Q2.Eof do begin
               sg.Cells[1,x] := IntToStr(a);
               sg.Cells[2,x] := GetVal(Q2,'name');
               sg.Cells[3,x] := GetVal(Q1,'qty_order');
               ExQry(Q3,' SELECT SUM(qty) as qty FROM detail_hasil_kerja WHERE no_so="'+GetVal(Q1,'no_so')+'" '+
               ' AND no_container="'+GetVal(Q1,'nomer_container')+'" '+
               ' AND item_id="'+GetVal(Q1,'item_id')+'" '+
               ' AND id_divisi="'+GetVal(Q2,'id_divisi')+'" ',True);

               sg.Cells[4,x] := GetVal(Q3,'qty');
               sg.Cells[5,x] := GetVal(Q2,'id_divisi');
               sg.Cells[6,x] := GetVal(Q1,'item_id');
               Q2.Next;
               inc(x);
               inc(a);
               sg.RowCount := sg.RowCount + 1;
            end;
            j := x;

            Q1.Next;
            Floading.pgbar.Position := Q1.RecNo;
            Application.ProcessMessages;
          end;
          sg.EndUpdate;
          Floading.Close;
       //   sg.ColCount :=  sg.ColCount - Q1.RecordCount;
      finally
        Floading.Close;
      end;
 // end;


end;


procedure TFDataWIP.sgDblClick(Sender: TObject);
var
  i : integer;
begin

  GridDetail;

  ExQry(Q2,'SELECT d.id,h.tgl,p.deskripsi,d.qty FROM detail_hasil_kerja d JOIN '+
  ' hasil_kerja h ON h.nomer=d.nomer JOIN pekerjaan p ON p.id=d.id_pekerjaan '+
  ' WHERE  (d.no_so="'+sg1.Cells[3,sg1.Row]+'" OR '+
  ' d.no_container="'+sg1.Cells[7,sg1.Row]+'") '+
  ' AND d.id_divisi="'+sg.Cells[5,sg.Row]+'" '+
  ' AND d.item_id="'+sg.Cells[6,sg.Row]+'"',True);

  //Memo1.Lines.Add(Q2.SQL.Text);
  sgDetail.RowCount := Q2.RecordCount + 1;
  i := 1;
  while not Q2.Eof do begin
     sgDetail.Cells[0,i] := GetVal(Q2,'tgl');
     sgDetail.Cells[1,i] := GetVal(Q2,'deskripsi');
     sgDetail.Cells[2,i] := GetVal(Q2,'qty');
     sgDetail.Cells[3,i] := GetVal(Q2,'id');
     Q2.Next;
     Inc(i);
  end;

end;

end.
