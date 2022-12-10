unit ufbacces;

interface
  uses
    windows,SysUtils,Classes,Dialogs,ZDataset,ZConnection,
    DB,IniFiles,ComCtrls, uComCtrl;
    Type
      TFBdb = class
          FCon : TZConnection;
          FQ   : TZQuery;
          FTable    : String;
          FTableId  : String;
          FParamList: TStringList;

          function fbCon(ACon:TZConnection):TZConnection;
          procedure fbSetCon;
          procedure FieldString(aField:string;aValue:string);
           procedure FieldInt(aField:String;aValue:Integer);
           procedure FieldFloat(aField:String;aValue:Real);
           procedure FieldBool(aField:String;aValue:Boolean);
           procedure FieldDate(aField:String;aValue:TDate);
           procedure FieldPass(aField:String;aValue:String);
          procedure ExQry(Q:TZQuery;_SQL:String;isCari:Boolean);
          procedure InsertOrUpdate(id:String);
          function GetIdKategori(Kategori:String):String;



          protected

      public
           Constructor Create;
           destructor destroy;override;

           property Table:String read Ftable write FTable;
           property IDTable:String read FTableId write FTableId;
      end;

implementation

{ TFBdb }

constructor TFBdb.Create;
begin
  FCon := TZConnection.Create(nil);
  fbSetCon;
  FCon.Connect;
  FQ   := TZQuery.Create(nil);
  FQ.Connection := Fcon;

  FParamList            := TStringList.Create;
  FParamList.Duplicates := dupIgnore;
end;

destructor TFBdb.destroy;
begin
  if Assigned(FCon) then
     FCon.Free;
  if Assigned(FQ) then
     FQ.Free;
  FParamList.Free;
  inherited;
end;

procedure TFBdb.ExQry(Q: TZQuery; _SQL: String; isCari: Boolean);
begin
  try
    Q.Connection := FCon;
    with Q do begin
      Close;
      SQL.Text :=_SQL;
      if isCari then
         Open
      else
         ExecSQL;
    end;

  except
    on E:Exception do
    MessageDlg('Perintah Query gagal'+#13+' Pesan Error '+
    #13+' '+E.Message,mtError,[mbYes],0);
    end;
end;

function TFBdb.fbCon(ACon: TZConnection): TZConnection;
begin

end;

procedure TFBdb.fbSetCon;
var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'ConfigFb.Ini');
  try
    with FCon do
    begin

        Database    := Aini.ReadString('Database','DB','');
        User        := aini.ReadString('Database','User','');
        Password    := Aini.ReadString('Database','Pass','');
        LibraryLocation:= ExtractFilePath(ParamStr(0))+'\fbclient.dll';
        Protocol    := Aini.ReadString('Database','Protocol','');
      end;
  finally
    Aini.Free;
  end;
end;


procedure TFBdb.FieldBool(aField: String; aValue: Boolean);
var
  BoolStr : String;
begin
  if aValue = True then BoolStr := '1' else BoolStr := '0';

  if aField <> '' then
  FParamList.Add(aField+','+BoolStr);

end;

procedure TFBdb.FieldDate(aField: String; aValue: TDate);
begin
  if aField <> '' then
  FParamList.Add(aField+',"'+FormatDateTime('yyyy-mm-dd',aValue)+'"');
end;

procedure TFBdb.FieldFloat(aField: String; aValue: Real);
begin
  if aField <> '' then
  FParamList.Add(aField+','+StrToDecimal(FloatToSTr(aValue)));
end;

procedure TFBdb.FieldInt(aField: String; aValue: Integer);
begin
  if aField <> '' then
  FParamList.Add(aField+','+IntToStr(aValue));
end;

procedure TFBdb.FieldPass(aField, aValue: String);
begin
  FParamList.Add(aField+',MD5('+QuotedStr(aValue)+')');
end;

procedure TFBdb.FieldString(aField, aValue: string);
begin
 if aField <> '' then
  FParamList.Add(aField+','+QuotedStr(aValue));
end;

function TFBdb.GetIdKategori(Kategori: String): String;
var
  Q : TZQuery;
begin
  Q := TZQuery.Create(nil);

  try
    Q.Connection := FCon;

    With Q do begin
      Close;
      SQL.Text := 'SELECT CATEGORYID FROM ITEMCATEGORY WHERE NAME='''+Kategori+'''';
      Open;

      Result   := FIeldByname('CATEGORYID').AsString;
    end;
  finally
    Q.Free;
  end;

end;

procedure TFBdb.InsertOrUpdate(id: String);
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
    aQ1.Connection := FCon;
    Try
      try
      with aQ1 do begin
        Close;
        SQL.Text := 'SELECT '+FTableId+' FROM '+FTable+' WHERE '+FTableId+'='+QuotedStr(id)+'';
        Open;


        if isEmpty then begin

           Close;
           SQL.Text := 'INSERT INTO '+FTable+' ('+aField+') Values ('+aValue+')';
           ExecSQL;
        end else begin
           Close;
           SQL.Text := 'UPDATE '+FTable+' SET '+_SQL+' WHERE '+FTableId+'='+QuotedStr(id)+'';
           ExecSQL;
        end;

      end;

      except
   //
        on E:Exception do begin

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

end.
