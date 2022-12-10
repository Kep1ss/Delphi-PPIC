unit uDatatables;

interface
  uses
    advGrid,SysUtils,Windows,Forms,uPatchForm,System.UITypes,
    Controls,Dialogs,AdvEdit,DB,uComCtrl,ZConnection,
    AdvSmoothButton,AdvSmoothPanel,Classes,AnnabaDB,ZDataset,graphics,
  uEngine;


    type
      TActSQL = (asTable,asSQL,asSP);
      TModeForm = (mfDocked,mfModal);
      TBtnArray = Array Of String;
      TAdvStringGrid = class(AdvGrid.TAdvStringGrid)
        private
        
        FStrecthIndex : Integer;
        FPagination   : Boolean;
        FCheckBox     : Integer;
        FRowStart     : Integer;
        FFBTable      : String;
        FFBField      : String;
        AColSg        : integer;
        FHeaderList  : TStringList;
        FButtonCount : Integer;
        FBtnType : TBtnArray;
        FidData  : Integer;
        FLimit   : Integer;
        FOffset  : Integer;
        FTotalData : Integer;
        FFields  : TArrayField;
        FSQL     : String;
        FTable   : String;
        FForm    : TForm;
        FvarFormView: TForm;
        FAutoBuildHeader : Boolean;
        FActSQL  : TActSQL;
        FModeForm : TModeForm;
        FParent  : TAdvSmoothPanel;
      public
        FLentris : String;

        procedure AddButton(Index:Integer;isTag:Integer;btnType : TBtnArray);

        procedure addHeader(aField:String;aWidth : Integer);
        procedure buildHeader;
        procedure ClearHeader;
        procedure Pagination(pPagination : TAdvSmoothPanel;RowNumber : Integer);
        procedure LoadContent(Filter:String);
        procedure ButtonClick(Sender:TObject);
        procedure ButtonPage(Sender:TObject);
        procedure DeleteData(ACol : Integer; ARow : Integer);
        constructor Create(aOwner:TComponent);Override;
        destructor destroy;override;
        property ButtonType:TBtnArray Write FBtnType;
        property id:Integer read FidData Write FidData;
        property Totaldata : Integer read FTotalData write FTotalData;
      published
        property StrecthIndex:integer Write FStrecthIndex;
        property ButtonCount:Integer write FButtonCount;
        property Limit : Integer Write Flimit;
        property OffSet : Integer write FOffset;
        property Fields : TArrayField write FFields;
        property aTable : String Write FTable;
        property varForm : TForm read FForm write FForm;
        property varFormView : TForm read FvarFormView write FvarFormView;
        property SQL : String read FSQL write FSQL;
        property ColCheck : Integer read FCheckBox write FCheckBox;
        property RowStart : Integer read FRowStart write FRowStart;
        property AutoBuilHeader : Boolean read FAutoBuildHeader write FAutoBuildHeader;
        property StatPagination : Boolean read FPagination write FPagination;
        property ActSQL:TActSQL read FActSQL write FActSQL;
        property ModeForm :TModeForm read FModeForm write FModeForm;
        property aParent  :TAdvSmoothPanel read FParent write FParent;
        property FBTable:String read FFBTable write FFBTable;
        property FBField:String read FFBField write FFBField;
        property SgCol : Integer read AColSg  write AColSg;


      end;
  var

    id  : Integer;
    Q   : TZQuery;
    con : TZConnection;
implementation


{ TAdvStringGrid }

uses  uMainMenu, uMarCon;

procedure TAdvStringGrid.AddButton(Index, isTag: Integer;btnType : TBtnArray);
var
  i        : Integer;
  btnCount : Integer;
  r        : TRect;
  abtn      : TAdvSmoothButton;
  Const
    warna : array [0..2] of TColor = ($00073CED,$00FFC855,clGreen);
begin

  btnCount := High(btnType) + 1;



  for i := low(btnType) to High(btnType) do begin
      if FindComponent(btnType[i]+IntToStr(index)) <> nil then
       FindComponent(btnType[i]+IntToStr(index)).Free;

       r := CellRect(ColCount - btnCount ,Index);

       if r.Left > 0 then begin

           abtn        := TAdvSmoothButton.Create(self);
           abtn.Parent := Self;
           abtn.Top    := r.Top  + 3;
           abtn.Left   := r.Left;
           abtn.Height := 24;
           abtn.Width  := 46;
           abtn.Color  := warna[btnCount-1];
           abtn.Appearance.Rounding := 3;
           abtn.Appearance.SimpleLayout := True;
           abtn.Appearance.SimpleLayoutBorder := True;
           abtn.BevelColor := clWhite;
           abtn.Appearance.Font.Color := clBlack;
           abtn.Name   := btnType[i]+IntToStr(Index);
           abtn.Caption := '';

           abtn.ShowFocus := False;
           abtn.Appearance.PictureAlignment := taCenter;
           abtn.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'icon\'+btnType[i]+'.png');
           abtn.Visible := True;
           abtn.OnClick := ButtonClick;
           abtn.Tag     := isTag;
       end;
     
       Objects[ColCount - btnCount , Index] := abtn;
       Invalidate;
       btnCount :=  btnCount -1;

  end;

end;

procedure TAdvStringGrid.addHeader(aField: String; aWidth: Integer);
begin
  FHeaderList.Duplicates := dupIgnore;
  FHeaderList.Add(aField+':'+IntToStr(aWidth));
end;

procedure TAdvStringGrid.buildHeader;
var
  i : integer;
  aHeader : String;
  aWidth  : Integer;
begin

    ClearAll;
    RowCount :=  2;
    ColCount := FHeaderList.Count + FButtonCount;


        for i := 0 to FHeaderList.Count + FButtonCount -1 do begin
            if i <= FHeaderList.Count -1 then begin
                aHeader := Copy(FHeaderList[i],1,Pos(':',FHeaderList[i])-1);
                aWidth  := StrToInt(Copy(FHeaderList[i],Pos(':',FHeaderList[i])+1,Length(FHeaderList[i])));
                Cells[i,0]   := aHeader;
                ColWidths[i] := aWidth;
            end else begin
                if FButtonCount > 0 then begin
                    Cells[i,0]   := 'Action';
                    ColWidths[i] := 50;
                end;
            end;

        end;
       if FButtonCount > 0 then
        MergeCells(FHeaderList.Count,0,FButtonCount,1);
        if FStrecthIndex <> -1 then begin
          ColumnSize.StretchColumn := FStrecthIndex;
          ColumnSize.Stretch       := True;
        end;


end;


procedure TAdvStringGrid.ButtonClick(Sender: TObject);
var
  yDb : TYDb;
begin
  if (Sender is TAdvSmoothButton) and  ((Sender as TAdvSmoothButton).Tag <> 0) then begin

     yDb := TYDb.Create(MariaCon.ZMy);

     try
        FidData := StrToIntDef(nilai(Self.Cells[Self.ColCount -3,Self.Row]),0);
         if Pos('btnEdit',(Sender as TAdvSmoothButton).Name) > 0 then begin

                    if Assigned(FForm) then begin
               
                        FForm.Fid       := FidData;

                        FForm.FCanEdit  := True;
                        case FModeForm of
                          mfDocked: begin
                                        FForm.Parent    := FParent;
                                        FForm.Align     := alClient;
                                        FForm.BorderStyle := bsNone;
                                        FForm.Position  := poOwnerFormCenter;
                                        FForm.visible := True;
                                    end;
                          mfModal: FForm.ShowModal;
                        end;
                   end;

         end else if Pos('btnHapus',(Sender as TAdvSmoothButton).Name) > 0 then begin
            if MessageDlg('Hapus data ?',mtConfirmation,[mbYes,mbNo],0) = MrYes then begin
               yDb.Table  := FTable;
               yDB.Filter := 'id';
               yDB.Del(FidData);
               LoadContent('');
            end;
        end else if Pos('btnView',(Sender as TAdvSmoothButton).Name) > 0 then begin

                    if Assigned(FvarFormView) then begin

                        FvarFormView.Fid       := FidData;
                        case FModeForm of
                          mfDocked: begin
                                        FvarFormView.Parent    := FParent;
                                        FvarFormView.Align     := alClient;
                                        FvarFormView.BorderStyle:= bsNone;
                                        FvarFormView.Position  := poOwnerFormCenter;
                                        FvarFormView.visible   := True;
                                    end;
                          mfModal: FvarFormView.ShowModal;
                        end;
                   end;

        end;


      finally
        yDb.Free;
      end;
      
  end;       
end;

procedure TAdvStringGrid.ButtonPage(Sender: TObject);
var
  isPage : Integer;
begin
  if (Sender is TAdvSmoothButton) then begin
     isPage   := StrToIntDef((Sender as TAdvSmoothButton).Caption,1)-1;
     FOffset  := FLimit  * isPage;
     LoadContent('');
  end;
end;

procedure TAdvStringGrid.ClearHeader;
begin
  FHeaderList.Clear;
end;


constructor TAdvStringGrid.Create(aOwner: TComponent);
begin
  inherited;
  con         := TZConnection.Create(owner);
  Q           := TZQuery.Create(owner);
  SetKoneksi(Con);
  Q.Connection:= Con;
  FRowStart   := 1;
  FAutoBuildHeader := True;
  FPagination := True;
  FCheckBox   := 0;
  FHeaderList := TStringList.Create;
  FModeForm   := mfModal;
end;

procedure TAdvStringGrid.DeleteData(ACol : Integer; ARow : Integer);
var
  yDB : TYDb;
begin

  yDB         := TYDb.Create(MariaCon.ZMy);

  try
      yDB.Filter := 'id';
      FidData    := StrToIntDef(Cells[Acol,Arow],0);
      yDB.Table  := FTable;
      if yDB.Table = 'Motif' then begin
          yDB.SQL  := getSQL('TableMotif');
          yDB.getData('id',FidData);
          if UPPERCASE(yDB.ValString('nama')) = 'ALL MOTIF' then
             MessageDlg('Data ALL Motif tidak boleh di hapus !!',mtError,[MbOK],0)
          else
            yDB.Del(FidData);
       end else
       yDB.Del(FidData);
  finally
    yDB.Free;
  end;
end;

destructor TAdvStringGrid.destroy;
begin
  if Assigned(Con) then
      try
        con.Free;
      Except

      end;
  if Assigned(Q) then
      try
        Q.Free;
      Except
      end;
  if Assigned(FHeaderList) then
     FHeaderList.Free;
     inherited;
end;

Function getField(S: TArrayField): String;
var
  i : integer;
  S2 : String;
begin

  S2 := '';
  for i := Low(S) to High(S) do
    S2 := S2 + S[i] + ',';
  Delete(S2,Length(S2),1);

  Result := S2;
end;

procedure TAdvStringGrid.LoadContent(Filter: String);
var


  j,i : integer;
  Fields : String;
  _SQL  : String;
begin


  if FAutoBuildHeader = True then
     buildHeader;

     for i := ComponentCount -1 downto 0 do  begin
      if Components[i] is TAdvSmoothButton then
       TAdvSmoothButton(Components[i]).Free;
     end;

    try
     if FFields <> nil then
     Fields := getField(FFields);
     if FActSQL = asTable then
         _SQL      := Format('SELECT %s FROM %s ',[Fields,FTable]);
     if FActSQL = asSQL then
         _SQL      := FSQL;
     if FActSQL = asSP then
        _SQL      := FSQL;

    if Filter <> '' then
    _SQL       := Format(' %s WHERE %s ',[_SQL,Filter]);
    if FPagination = True then
    _SQL       := Format(' %s LIMIT %d OFFSET %d ',[_SQL,FLimit,FOffSet]);

    Q.Close;
    Q.SQL.Text := _SQL;
    Q.Open;

    if Q.RecordCount > 0 then begin

        RowCount := Q.RecordCount + FRowStart;
        i := FRowStart;
        while not Q.Eof  do begin
          for j := 0 to Q.FieldCount -1 do
          if Q.Fields[j].DataType in [ftFloat,ftCurrency] then
            Cells[j,i] :=  Format('%.2n',[Q.Fields[j].AsFloat])
          else if Q.Fields[j].DataType in [ftInteger] then
            Cells[j,i] :=  Format('%.0n',[Q.Fields[j].AsFloat])
          else
            Cells[j,i] :=  Q.Fields[j].AsString;

          if (FButtonCount > 0) then
             AddButton(i,Q.FieldByName('id').AsInteger,FBtnType);
          if FCheckBox > 0 then
             AddCheckBox(FCheckBox,i,False,False);

             Row := RowCount -1;

          Q.Next;
          Inc(i);
        end;
    end else begin
        for i := 2 to RowCount -1 do
        for j := 0 to ColCount -1 do
          Cells[j,i] := '';
        RowCount := 4;
    end;
    Except
  
    end;





end;


procedure TAdvStringGrid.Pagination(pPagination: TAdvSmoothPanel;
  RowNumber: Integer);
  var
    jmlPage : Integer;
    btnPriv : TAdvSmoothButton;
    btn     : TAdvSmoothButton;
    RowOf   : INteger;
    i       : Integer;
    totalWidht : integer;
begin
  jmlPage := FTotalData div FLimit;
  jmlPage := jmlPage + 1;


  pPagination.Visible := False;
  btnPriv             := Owner.FindComponent('btnPriv') as TAdvSmoothButton;

  if btnPriv <> nil then

  btnPriv.Align       := alLeft ;

  for i := pPagination.ComponentCount -1 Downto 0 do begin
      if pPagination.Components[i] is TAdvSmoothButton then
      TAdvSmoothButton(pPagination.Components[i]).Free;
  end;
  totalWidht := 0;
  for i := jmlPage  Downto 1  do  begin
   
          btn := TAdvSmoothButton.Create(pPagination);
          btn.Parent := pPagination;
          btn.Height := 28;
          btn.Width  := 30;
          btn.Name   := 'btn'+IntToStr(i);
          btn.Align  := alRight;
          btn.Caption := IntToStr(i);
          btn.Color   :=  $003B3B3B;
          btn.AlignWithMargins  :=  True;
          btn.Appearance.SimpleLayout := True;
          btn.Appearance.Rounding     := 3;
          btn.AlignWithMargins        := True;
          btn.Appearance.Font.Color   := $009A9A9A;
          btn.Margins.Top             := 0;
          btn.Margins.Bottom          := 0;
          btn.Margins.Left            := 1;
          btn.Margins.Right           := 1;
          btn.OnClick                 := ButtonPage;
          pPagination.Width           := pPagination.Width + btn.Width;
       //   pPagination.Left            := pPagination.Left - btn.Width;
          totalWidht                  := totalWidht + btn.Width;
  end;
  btnPriv.Align := alRight;

  if FLimit > FTotalData then
          RowOf := FTotalData else RowOf := FLimit;
       FLentris := 'Showing '+IntToStr(RowNumber)+' to '+IntToStr(RowOf)+' of '+ IntToStr(FTotalData)+' entries';

       pPagination.Left    := 200;
       pPagination.Width   := 870;
       pPagination.Visible := True;


end;

end.
