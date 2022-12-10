unit AnnabaDB;

interface
  uses
    classes,DB,Dialogs,Messages,ZConnection,
    System.UITypes,  uEngine,IniFiles,SysUtils,ZDataset, uComCtrl;


    Type
      TArrayField = Array of String;
      TOpenTableWith = (toField,toSQL);

      TYDb = class (TObject)
        private
        FConn     : TZConnection;
        FParamList: TStringList;
        FZQuery   : TZQuery;
        FZQuery2   : TZQuery;
        FTable    : String;
        FSQL      : String;
        FFilter   : String;
        FFieldArray : TArrayField;
        FOpenTableWith : TOpenTableWith;
        FSelect   : String;
        FWhere    : String;
        FLike     : String;


      protected

      public
           Constructor Create(ACon : TZConnection);
           destructor destroy;override;
           function AutoInc(aField : string):string;
           procedure RollBackTrans;
           function Save(id:Integer):Boolean;
           procedure Del(id:Integer);
           procedure DeleteWhere(varTable:String;varField:String;varValue:String);
           procedure setKoneksi(aCon : TZConnection);
           procedure FieldString(aField:string;aValue:string);
           procedure FieldInt(aField:String;aValue:Integer);
           procedure FieldFloat(aField:String;aValue:Real);
           procedure FieldBool(aField:String;aValue:Boolean);
           procedure FieldDate(aField:String;aValue:TDate);
           procedure FieldPass(aField:String;aValue:String);
           procedure OpenData(var Q :TZQuery);
           procedure getData(varField:String;id : Integer);
           procedure ExQuery;
           procedure ExSQL;
           procedure NextRec;
           procedure EmptyTable(varTable : String);
           function DataCount:Integer;
           function Find(aField:String;aValue:String):Integer;
           function LastId:Integer;
           function FindIdTable(aTable:String;aField:String;aValue:String;FindFIeld:String):integer;
           function FindValue(aTable:String;aField:String;aValue:String;FindFIeld:String):String;
           function ValString(aField:String):String;
           function ValStringR(aField:String):String;
           function ValInt(aField:String):Integer;
           function ValFLoat(aFIeld:String):Real;
           function ValBool(aField:String):Boolean;
           function ValDate(aField:String):TDateTime;
           function genField:String;
           procedure Select(aTable:String);
           procedure Where(aField:String;aValue:String);
           procedure Like(aField:String;aValue:String);
           procedure RunQuery;
           function getField(s:TArrayField):String;
           function Code(aField:String;s:String):String;
           property Table:String read Ftable write FTable;
           property SQL  :String read FSQL write FSQL;
           property Filter:String write FFilter;
           property Conn:TZConnection read FConn write FConn;
           property ArrayField : TArrayField read FFieldArray write FFieldArray ;
           property OpenTableWith : TOpenTableWith read FOpenTableWith write FOpenTableWith;

      end;

implementation

{ TYDb }

function TYDb.AutoInc(aField : string):string;
begin
  With FZQuery do begin
    Close;
    SQL.Text := Format(' SELECT %s as jml  '+
          ' FROM %s ORDER BY %s DESC',
          [aField,FTable,aField]);
    open;
    Result := IntToStr(StrToIntDef(Fields[0].AsString,0)+1);
  end;

end;



function TYDb.Code(aField, s: String): String;
var
  x : integer;
  k : String;
begin
  With FZQuery do begin
    Close;
    SQL.Text := Format(' SELECT MAX(RIGHT(%s,3)) as jml  '+
          ' FROM %s WHERE %s '+
          ' LIKE %s ',
          [aField,FTable,aField,'"%'+s+FormatDateTime('yymmdd',now)+'%"']);
    open;

    if StrToIntDef(Fields[0].AsString,0) =0 then
       x := 1
    else
      x := Fields[0].AsInteger +1;

    k := IntToStr(x);
    k:= Copy('000'+k,length('000'+k)-2,3);
    result :=s+ FormatDateTime('yymmdd',now)+k;
  end;

end;


constructor TYDb.Create(ACon : TZConnection);
begin

  FZQuery               := TZQuery.Create(nil);
  FZQuery2               := TZQuery.Create(nil);
  FConn                 := ACon;
  FZQuery.Connection    := ACon;
  FZQuery2.Connection   := ACon;

  FParamList            := TStringList.Create;
  FParamList.Duplicates := dupIgnore;
end;

function TYDb.DataCount: Integer;
begin
  Result := FZQuery.RecordCount;

end;

procedure TYDb.Del(id: Integer);
var
  Q : TZQuery;
begin
  Q := TZQuery.Create(nil);

  try
    Q.Connection := FConn;
    Q.Close;
    Q.SQL.Text := Format('DELETE FROM %s ',[FTable]);
    if FFilter <> '' then
    Q.SQL.Add(Format(' WHERE %s=%d ',[FFilter,id]));
    Q.ExecSQL;
  finally
    Q.Free;
  end;

end;

procedure TYDb.DeleteWhere(varTable, varField, varValue: String);
begin
  FZQuery.Close;
  FZQuery.SQL.Text := 'DELETE FROM '+varTable+' WHERE '+varField+'="'+varValue+'"';
  FZQuery.ExecSQL;
end;

destructor TYDb.destroy;
begin

  if Assigned(FZQuery) then
  FZQuery.Free;
  if Assigned(FParamList) then
  FParamList.Free;
  if Assigned(FZQuery2) then
  FZQuery2.Free;
  inherited;
end;


procedure TYDb.EmptyTable(varTable: String);
begin
  with FZQuery do begin
    Close;
    SQL.Text := 'TRUNCATE TABLE '+varTable;
    try
      ExecSQL;
    Except
      on E:Exception do
        raise Exception.Create(E.Message+#13+' SQL : '+SQL.Text);
    end;
  end;
end;

procedure TYDb.ExQuery;
begin
  with FZQuery do begin
    Close;
    SQL.Text := FSQL;
    try
      Open;
    Except
      on E:Exception do
        raise Exception.Create(E.Message+#13+' SQL : '+SQL.Text);
    end;
  end;
end;

procedure TYDb.ExSQL;
begin
  with FZQuery do begin
    Close;
    SQL.Text := FSQL;
    try
      ExecSQL;
    Except
      on E:Exception do
        raise Exception.Create(E.Message+#13+' SQL : '+SQL.Text);
    end;
  end;
end;

procedure TYDb.FieldBool(aField: String; aValue: Boolean);
var
  BoolStr : String;
begin
  if aValue = True then BoolStr := '1' else BoolStr := '0';

  if aField <> '' then
  FParamList.Add(aField+','+BoolStr);

end;

procedure TYDb.FieldDate(aField: String; aValue: TDate);
begin
  if aField <> '' then
  FParamList.Add(aField+',"'+FormatDateTime('yyyy-mm-dd',aValue)+'"');
end;

procedure TYDb.FieldFloat(aField: String; aValue: Real);
begin
  if aField <> '' then
  FParamList.Add(aField+','+StrToDecimal(FloatToSTr(aValue)));
end;

procedure TYDb.FieldInt(aField: String; aValue: Integer);
begin
  if aField <> '' then
  FParamList.Add(aField+','+IntToStr(aValue));
end;

procedure TYDb.FieldPass(aField, aValue: String);
begin
  FParamList.Add(aField+',MD5('+QuotedStr(aValue)+')');

end;

procedure TYDb.FieldString(aField, aValue: string);
begin
  if aField <> '' then
  FParamList.Add(aField+','+QuotedStr(aValue));
end;

function TYDb.Find(aField, aValue: String): Integer;
begin
  if (aFIeld <> '') and (aValue <> '') then begin
     FZQuery.Close;
     FZQuery.SQL.Text := 'SELECT id FROM '+FTable+' WHERE '+aField+'='+QuotedStr(aValue)+' ';
     FZQuery.Open;
     Result := FZQuery.Fields[0].AsInteger;
  end;

end;

function TYDb.FindIdTable(aTable, aField, aValue: String;FindFIeld:String): integer;
begin
  FZQuery2.Connection := Conn;
  FZQuery2.Close;
  FZQuery2.SQL.Text := 'SELECT '+FindField+' FROM '+aTable+' WHERE '+aField+'='+QuotedStr(aValue)+' ';
  FZQuery2.Open;

  if FZQuery2.IsEmpty then
     Result := 0 else
     Result := FZQuery2.Fields[0].AsInteger;
end;

function TYDb.FindValue(aTable, aField, aValue, FindFIeld: String): String;
var
  Q : TZQuery;
begin
  Q := TZQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.Close;
    Q.SQL.Text := 'SELECT '+FindField+' FROM '+aTable+' WHERE '+aField+'='+QuotedStr(aValue)+' ';
    Q.Open;

    if Q.IsEmpty then begin
     //  MessageDlg('Akun tidak ditemukan',mtError,[MbOk],0);
       Result :='';
    end else
       Result := Q.Fields[0].AsString;
  finally
    Q.Free;
  end;
end;


function TYDb.genField: String;
var
  i : integer;
  S : String;
begin
  S := '';
  for i := Low(FFieldArray) to High(FFieldArray) do
    S := S + FFieldArray[i] + ',';
  Delete(S,Length(S),1);

  Result := S;
end;

procedure TYDb.getData(varField:String;id:Integer);
begin
   try
     FZQuery.Close;
     FZQuery.SQL.Text := Format(' %s WHERE %s=%d ',[FSQL,VarField,id]);
     FZQuery.Open;
   except
    on E:Exception do
      raise Exception.Create('Error : '+E.Message+#13+'SQL : '+FZQuery.SQL.Text);
   end;
end;

function TYDb.getField(S: TArrayField): String;
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



function TYDb.LastId: Integer;
begin
  FZQuery.Close;
  FZQuery.SQL.Text := 'SELECT id FROM '+FTable+' ORDER BY id DESC LIMIT 1';
  FZQuery.Open;

  Result := FZQuery.Fields[0].AsInteger;
end;

procedure TYDb.Like(aField: String; aValue:String);
begin
  Flike :=  aField+' LIKE "%'+aValue+'%"';
end;

procedure TYDb.NextRec;
begin
  FZQuery.Next;
end;

procedure TYDb.OpenData(var Q:TZQuery);
begin


      Q.Connection := FConn;
      try
          Q.Close;
          Q.SQL.Text := FSQL;
          Q.Open ;
      Except
        on E:Exception do begin
          raise Exception.Create('Error : '+ E.Message+#13+'SQL : '+Q.SQL.Text);
        end;
      end;

end;

procedure TYDb.RollBackTrans;
begin
  FConn.Rollback;
end;

procedure TYDb.RunQuery;
var
  _SQL : String;
begin

  if FSelect <> '' then begin
     if OpenTableWith = toField then
        _SQL := 'SELECT '+getField(FFieldArray)+' FROM '+FSelect
     else if OpenTableWith = toSQL then
        _SQL := getSQL(FSelect);

        if FWhere <> '' then
           _SQL := _SQL + FWhere;

        if FLike <> '' then begin
           if FWhere <> '' then
             _SQL := _SQL + ' OR '+FLike
        else
             _SQL := _SQL + ' WHERE '+FLike;

        end;
  end;

    FZQuery.Close;
    FZQuery.SQL.Text := _SQL;
    try
      FZQuery.Open;
    except
      Error('No Query Execute');
    end;

end;

function TYDb.Save(id: Integer):Boolean;
var
  i       : Integer;
  _SQL    : String;
  aFIeld  : string;
  aValue  : String;
  bField  : String;
  vField  : String;
  aQ1     : TZQuery;
begin
    aFIeld := '';
    aValue := '';


    for i:= 0 to FParamList.Count -1 do begin
      aFIeld  := aField+Copy(FParamList[i],1,Pos(',',FParamList[i])-1)+',';
      aValue  := aValue+Copy(FParamList[i],Pos(',',FParamList[i])+1,Length(FParamList[i]))+',';
      bFIeld  := Copy(FParamList[i],1,Pos(',',FParamList[i])-1);
      vField  := Copy(FParamList[i],Pos(',',FParamList[i])+1,Length(FParamList[i]));
      _SQL    := _SQL+ bField+'='+vFIeld+',';
    end;
    Delete(aFIeld,Length(aFIeld),1);
    Delete(aValue,Length(aValue),1);
    Delete(_SQL,Length(_SQL),1);


    aQ1            := TZQuery.Create(nil);
    aQ1.Connection := FConn;
    Try
      try
      with aQ1 do begin
        Close;
        SQL.Text := Format('SELECT id FROM %s WHERE id=%d',[FTable,id]);
        Open;

        if isEmpty then begin
           Close;
           SQL.Text := 'INSERT INTO '+FTable+' ('+aField+') Values ('+aValue+')';
           ExecSQL;

        end else begin
           Close;
           SQL.Text := 'UPDATE '+FTable+' SET '+_SQL+' WHERE id='+IntToStr(id)+'';
           ExecSQL;
        end;
        Result := True;
      end;

      except
   //
        on E:Exception do begin
          Result := False;
          MessageDlg('Gagal input Data : '+#13+' Pesan Error : '+E.Message +#13+
          ' SQL Script : '+#13+aQ1.SQL.Text,
          mtError,[mbOK],0);
        end;
      end;
    Finally
      FParamList.Clear;
      aQ1.Free;
    End;

end;

procedure TYDb.Select(aTable: String);
begin
  FSelect := aTable;
end;

procedure TYDb.setKoneksi(aCon :TZConnection);
var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  try
    with aCon do
    begin

        Properties.Add('CLIENT_MULTI_STATEMENTS=1');
        HostName    := Aini.ReadString('Database','Host','');
        port        := Strtoint(Aini.ReadString('Database','Port','0'));
        Database    := Aini.ReadString('Database','DB','');
        User        := aini.ReadString('Database','User','');
        Password    := Aini.ReadString('Database','Pass','');
        LibraryLocation:= ExtractFilePath(ParamStr(0))+'libmySQL.dll';
        Protocol    := 'mysql-5';
      end;
  finally
    Aini.Free;
  end;
end;

function TYDb.ValBool(aField: String): Boolean;
var
  Bool : Boolean;
begin
  if FZQuery.FieldByName(aField).AsInteger = 0 then
     Bool := False else Bool := True;
  Result := Bool;
end;

function TYDb.ValDate(aField: String): TDateTime;
begin
  Result := FZQuery.FieldByName(aField).AsDateTime;
end;

function TYDb.ValFLoat(aFIeld: String): Real;
begin
  Result := FZQuery.FieldByName(aField).AsFloat;
end;

function TYDb.ValInt(aField: String): Integer;
begin
  Result := FZQuery.FieldByName(aField).AsInteger;
end;

function TYDb.ValString(aField: String): String;
begin
  Result := FZQuery.FieldByName(aField).AsString;
end;

function TYDb.ValStringR(aField: String): String;
begin
 Result := Format('%.2n',[FZQuery.FieldByName(aField).AsFloat]);
end;

procedure TYDb.Where(aField: String; aValue:String);
begin
 FWhere := ' WHERE '+aField+'="'+aValue+'" ';
end;

end.
