unit uGanttChatParameters;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls,
   uComCtrl,
   AdvSmoothButton, AdvSmoothPanel, AdvEdit, uOvEdit, AdvCombo, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Data.DB, Vcl.ComCtrls, MemDS, DBAccess, MyAccess;


type
  TFGanttChartParameters = class(TForm)
    AdvSmoothPanel2: TAdvSmoothPanel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Label3: TLabel;
    Label7: TLabel;
    AdvSmoothPanel3: TAdvSmoothPanel;
    sgBarang: TAdvStringGrid;
    btnTutup: TAdvSmoothButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Enoso: TAdvEdit;
    ECustomer: TAdvEdit;
    EjamKerja: TAdvEdit;
    dtMulai: TDateTimePicker;
    AdvSmoothButton1: TAdvSmoothButton;
    Q1: TMyQuery;
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgBarangCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure sgBarangGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgBarangKeyPress(Sender: TObject; var Key: Char);
    procedure sgBarangKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgBarangSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure AdvSmoothButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    procedure TampilanAwal;
    function SumAlokasi:Integer;



    { Private declarations }
  public


    { Public declarations }
    isForm : integer;
    procedure CreateGrid;
  end;

var
  FGanttChartParameters: TFGanttChartParameters;


implementation



{$R *.dfm}

uses uInputBom, uMarCon, uGanttChart, uLoading;

{ TFinputMotif }

procedure TFGanttChartParameters.AdvSmoothButton1Click(Sender: TObject);
var
  i , j , IndexCol, IndexRow,Counter: integer;
  Kapasitas : Integer;
  ItemNo1,ItemNo2 : String;
  ManHour , Hari, LamaHari,JmlPekerja,Menit,Jam : integer;
  rect : TRect;

  function getDivisi(DivName : String):integer;
  var
    i : integer;
  begin
    Result := 0;
    for i := 2 to sgBarang.RowCount -1 do begin
       if sgBarang.Cells[1,i] = divName then
       begin
         Result := i;
         Break;
       end;
    end;

  end;

  function IndexDivisi(DivName : String;Arow:Integer):integer;
  var
    i : integer;
  begin
    Result := 0;
    for i :=  Arow -1 downto 1 do begin
       if FGanttChart.sg1.Cells[5,i] = divName then
       begin
         Result := i;
         Break;
       end;
    end;

  end;
begin

  if EjamKerja.Text <>'' then begin


         Floading.Show;
         Floading.pgbar.Maximum := FGanttChart.sg1.RowCount;
         Floading.pgbar.Position:= 1;
         Floading.Lprocess.Caption := 'Processing Data....';
         for i := 1 to FGanttChart.sg1.RowCount -1 do begin
            if FGanttChart.sg1.Cells[5,i] <> '' then begin
                if FGanttChart.sg1.Cells[1,i-1] <> '' then begin
                  ItemNo1  := FGanttChart.sg1.Cells[1,i-1];
                  ItemNo1  := Copy(ItemNo1,1,POS('|',ItemNo1)-1);
                  IndexRow := i;
                end;

                for j := 4 to sgBarang.ColCount -1 do begin
                    ItemNo2 := sgBarang.Cells[j,1];
                    ItemNo2 := Copy(ItemNo2,2,Pos(']',ItemNo2)-2);

                    if ItemNo1 = ItemNo2 then begin

                       IndexCol :=  j;
                    end;

                    Application.ProcessMessages;
                end;

                FGanttChart.sg1.Cells[9,i]  := EjamKerja.Text;
                jmlPekerja      := StrToIntDef(sgBarang.Cells[IndexCol,getDivisi(FGanttChart.sg1.Cells[5,i])],0);
                if JmlPekerja > 0 then begin
                   FGanttChart.sg1.Cells[10,i] := IntToStr(jmlPekerja);

                  if IndexRow > 2 then begin
                      jmlPekerja      := StrToIntDef(sgBarang.Cells[IndexCol,getDivisi(FGanttChart.sg1.Cells[5,i])],0);

                      if IndexDivisi(FGanttChart.sg1.Cells[5,i],i) > 0 then
                         Kapasitas       := StrToIntDef(FGanttChart.sg1.Cells[6,IndexDivisi(FGanttChart.sg1.Cells[5,i],i)],0)
                      else
                         Kapasitas := StrToIntDef(sgBarang.Cells[3,getDivisi(FGanttChart.sg1.Cells[5,i])],0);

                      Counter         := StrToIntDef(FGanttChart.sg1.Cells[10,IndexDivisi(FGanttChart.sg1.Cells[5,i],i)],0);

                      //if Kapasitas > 0 then
                      if Kapasitas - Counter > 0 then begin
                         FGanttChart.sg1.Cells[6,i]  := IntToStr(Kapasitas - Counter);
                         if JmlPekerja > 0 then
                            FGanttChart.sg1.Cells[10,i] := IntToStr(jmlPekerja)
                         else
                            FGanttChart.sg1.Cells[10,i] := FGanttChart.sg1.Cells[6,i];
                      end else begin
                         FGanttChart.sg1.Cells[6,i]  := sgBarang.Cells[3,getDivisi(FGanttChart.sg1.Cells[5,i])];
                         if JmlPekerja > 0 then
                            FGanttChart.sg1.Cells[10,i] := IntToStr(jmlPekerja)
                         else
                            FGanttChart.sg1.Cells[10,i] := FGanttChart.sg1.Cells[6,i];
                      end;

                      Application.ProcessMessages;
                  end;

                    ManHour              := StrToIntDef(nilai(FGanttChart.sg1.Cells[9,i]),0);
                    Menit                := ROUND(StrToIntDef(nilai(FGanttChart.sg1.Cells[8,i]),0));


                    Jam                  := Menit div 60;
                    Hari                 := Round(Jam / ManHour);
                    lamahari             := Round(Hari / StrToIntDef(FGanttChart.sg1.Cells[10,i],0));
                    if lamahari < 1 then lamahari := 1;

                    FGanttChart.sg1.Cells[11,i] := IntToStr(lamahari);

                    FGanttChart.sg1.Dates[13,IndexRow ] := dtMulai.Date;
                    FGanttChart.sg1.Cells[17,i] := sgBarang.Cells[3,getDivisi(FGanttChart.sg1.Cells[5,i])];

                    Application.ProcessMessages;
                  end;



            end;
            Floading.pgbar.Position := i;
            Application.ProcessMessages;
         end;

         Floading.Close;
         FGanttChart.sg1.OnCellsChanged(Sender,rect);
         FGanttChart.CreateChart;
         Close;
       //  Floading.Lprocess.Caption := 'Creating Chart';
       //
      //

  end else
    Error('Jam Kerja Harus Diisi');

end;

procedure TFGanttChartParameters.btnTutupClick(Sender: TObject);
begin
  Close;
end;


procedure TFGanttChartParameters.CreateGrid;
begin
  with sgBarang do begin
    ClearAll;

    ColCount := 4;
    RowCount := 3;
    FixedRows:= 2;

    Cells[0,0] := 'No';
    Cells[1,0] := 'Divisi';
    Cells[2,0] := 'Id';
    Cells[3,0] := 'Kapasitas';

    ColWidths[0] := 60;
    ColWidths[1] := 120;
    ColWidths[2] := 0;
    ColWidths[3] := 80;

    MergeCells(0,0,1,2);
    MergeCells(1,0,1,2);
    MergeCells(2,0,1,2);
    MergeCells(3,0,1,2);
    FixedCols := 3;
  end;
end;

procedure TFGanttChartParameters.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FGanttChart.isFocusForm := True;
end;

procedure TFGanttChartParameters.FormShow(Sender: TObject);
begin
  TampilanAwal;
  dtMulai.Date := now;
end;

procedure TFGanttChartParameters.sgBarangCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);

begin
  CanEdit := ACol >=  3;
  


end;

procedure TFGanttChartParameters.sgBarangGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  HAlign := taCenter;
end;

procedure TFGanttChartParameters.sgBarangKeyPress(Sender: TObject;
  var Key: Char);
begin
  if sgBarang.Col >= 3 then begin
     if not (key in ['0'..'9',#13,#10,#8]) then
      Key := #0;

  end;
end;

procedure TFGanttChartParameters.sgBarangKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if SumAlokasi > StrToIntDef(sgBarang.Cells[3,sgBarang.Row],0) then
   begin
     Error('Jumlah Alokasi Melebihi Kapasitas');
     sgBarang.Cells[sgBarang.Col,sgBarang.Row] := '0';
     Exit;
   end;
end;

procedure TFGanttChartParameters.sgBarangSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
    var
    ItemNo : String;
    varString : String;
begin
  if ACol >= 4 then begin

          varString := sgBarang.Cells[ACol,1];
          ItemNo := Copy(varString,POS('[',varString)+1,Pos(']',varString)-2);


          Q1.CLose;
          Q1.SQL.Text:= getSQL('TableDivisiProses')+' WHERE d.id="'+sgBarang.Cells[2,Arow]+'" '+
          ' AND i.itemno="'+ItemNo+'"';
          Q1.Open;

        
          if Q1.IsEmpty then begin
             sgBarang.Options := sgBarang.Options - [goEditing];
             sgBarang.Colors[ACol,ARow]   := clRed;
             sgBarang.ColorsTo[ACol,ARow] := clRed;
             sgBarang.Cells[ACol,ARow]    := 'Tidak Ada Process';
           end  else begin
             sgBarang.Options             := sgBarang.Options + [goEditing];
             sgBarang.Colors[ACol,ARow]   := clWhite;
             sgBarang.ColorsTo[ACol,ARow] := clWhite;
           end;

  end;
end;

function TFGanttChartParameters.SumAlokasi: Integer;
var
  i : integer;
  TotalAlokasi : Integer;
begin

  TotalAlokasi := 0;
  for i := 4 to sgBarang.ColCount -1 do begin
     if CellF(sgBarang.Cells[i,sgBarang.Row]) <> 0 then begin
        TotalAlokasi := TotalAlokasi + StrToIntDef(sgBarang.Cells[i,sgBarang.Row],0);

     end;
  end;
  Result := TotalAlokasi;


end;

procedure TFGanttChartParameters.TampilanAwal;
begin

end;

end.
