unit uEngine;

interface
  uses
    windows,SysUtils,Classes,Dialogs,AdvGrid,MyAccess,AdvCombo,
    DB,IniFiles,ComCtrls,Controls,StdCtrls,Grids, ClipBrd,uComCtrl,System.UITypes;

    function newCon(ACon:TMyConnection):TMyConnection;
    procedure getParams(var params : TStringlist);
    procedure SetKoneksi(aCon : TMyConnection);
    function OpenTable(Q:TMyQuery;aField: array of string;aTable:string;isCari:String):TMyQuery;
    procedure addParam(aField:string;aValue:string; var Params:TStringList;fType:string);
    procedure exeDb(Q:TMyQuery;aTable:string;aList: TStringList);
    procedure updatedb(Q:TMyQuery;aTable:string;aList:TStringList;aField,aValue:string);
    procedure DelDb(Q:TMyQuery;aTable:string;S,Key1:String;Val1:string);
    procedure ExQry(Q:TMyQuery;_SQL:String;isCari:Boolean);
    procedure isiCmb(Q:TMyQuery;aTable:string;aField:array of string;cb:TAdvCombobox);
    function GetIdcmb(cmb:TAdvCombobox):String;
    function idxCmb(cb:TAdvCombobox;idx:Integer):Integer;
    function AnyStringToDate(fmt, dt: String) : TDateTime;
    function GetVal(Q:TMyQuery;aFIeld:string):String;
    function GetValF(Q:TMyQuery;aFIeld:string):Extended;
    function GetValBol(Q:TMyQuery;aField:string):Boolean;
    function GetValInt(Q:TMyQuery;AField:string):Integer;
    function GetValDate(Q:TMyQuery;aFIeld:string):TDateTime;
    function getData(Q:TMyQuery;aTable:string;aField:string):String;
    function GetCode(Q:TMyQuery;aTable:string;aField:string;s:string):string;
    function GetValR(Q:TMyQuery;aFIeld:string):String;
    procedure Post(Q:TMyQuery;aTable:string;aList: TStringList);
    procedure updatePOST(Q:TMyQuery;aTable:string;aList:TStringList;aField,aValue:string);
    function GetIdUser:String;
    function GetIdPelanggan:String;
    function GetNamaPelanggan:String;
    procedure SaveIdPelanggan(id:String;varNama:String);
    procedure CopyGridSelectionToClipBoard(Grid: TStringGrid);
    procedure FilterDac(aQ:TMyQuery;aStr :string);
    function ConnectionType:String;


implementation





function GetIdUser:String;
var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'UserAktif.Ini');
  try
     Result := Aini.ReadString('LOG USER','USER','1');
  finally
    Aini.Free;
  end;
end;

function ConnectionType:String; var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'ConType.Ini');
  try
     Result := Aini.ReadString('TypeConnection','Type','local');
  finally
    Aini.Free;
  end;
end;

function GetIdPelanggan:String;
var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'SelCus.Ini');
  try
     Result := Aini.ReadString('SELECTED','cust','1');
  finally
    Aini.Free;
  end;
end;

function getNamaPelanggan:String;
var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'SelCus.Ini');
  try
     Result := Aini.ReadString('SELECTED','custName','');
  finally
    Aini.Free;
  end;
end;



procedure SaveIdPelanggan(id:String;varNama:String);
var
  Aini : TINIFIle;
begin
   aIni := TIniFile.Create(ExtractFilePath(ParamStr(0))+'SelCus.ini');
  try
      Aini.WriteString('SELECTED','cust',id);
      Aini.WriteString('SELECTED','custName',varNama);
  finally
    Aini.Free;
  end;
end;


procedure CopyGridSelectionToClipBoard(Grid: TStringGrid);
const
  TAB = Chr(VK_TAB);
  CR = #13;
var
  r, c: integer;
  S: string;
begin
  S := '';
  for r := Grid.Selection.Top to Grid.Selection.Bottom do
  begin
    for c := Grid.Selection.Left to Grid.Selection.Right do
    begin
      S := S + Grid.Cells[c, r];
      if c < Grid.Selection.Right then
        S := S + TAB;
    end;
    if r < Grid.Selection.Bottom then
      S := S + CR;
  end;
  ClipBoard.SetTextBuf(PChar(S));
end;



function AnyStringToDate(fmt, dt: String) : TDateTime;
var
  fs : TFormatSettings;
Begin
 // dt := StringReplace(dt,'/','-',[rfReplaceAll]);
  fs := TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := fmt;

  result := StrToDateDef(dt, 0, fs);
End;

function GetValR(Q:TMyQuery;aFIeld:string):String;
begin
  Result := GetRupiah(Q.FieldByName(aFIeld).AsString);
end;

function GetValF(Q:TMyQuery;aFIeld:string):Extended;
begin
  Result := Q.FieldByName(aField).AsFloat;
end;
function GetValDate(Q:TMyQuery;aFIeld:string):TDateTime;
begin
  Result := Q.FieldByName(aFIeld).AsDateTime;
end;
function GetValBol(Q:TMyQuery;aField:string):Boolean;
begin
  Result := Q.FieldByName(aFIeld).AsBoolean;
end;
function GetValInt(Q:TMyQuery;AField:string):Integer;
begin
  Result :=Q.FieldbyName(AField).AsInteger;
end;
function idxCmb(cb:TAdvCombobox;idx:Integer):Integer;
begin
  cb.ItemIndex  := cb.Items.IndexOfObject(TObject(idx));
  Result        := cb.ItemIndex;
end;


procedure getParams(var params : TStringlist);
var
  Aini : TINIFIle;
begin
  Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  try
    params.Add('Server='+Aini.ReadString('Database','Host',''));
    params.Add('User_Name='+Aini.ReadString('Database','User',''));
    params.Add('Port='+Aini.ReadString('Database','Port',''));
    params.Add('Password='+Aini.ReadString('Database','Pass',''));
    params.Add('Database='+Aini.ReadString('Database','DB',''));

  finally
    Aini.Free;
  end;
end;
procedure SetKoneksi(aCon : TMyConnection);
var
  Aini : TINIFIle;
begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  try
    with aCon do
    begin

        if ConnectionType = 'local' then begin

            Server      := Aini.ReadString('DatabaseOffLine','Host','');
            port        := Strtoint(Aini.ReadString('DatabaseOffLine','Port','0'));
            Database    := Aini.ReadString('DatabaseOffLine','DB','');
            Username    := aini.ReadString('DatabaseOffLine','User','');
            Password    := Aini.ReadString('DatabaseOffLine','Pass','');
        end else  if ConnectionType = 'online' then  begin
            Server      := Aini.ReadString('DatabaseOnLine','Host','');
            port        := Strtoint(Aini.ReadString('DatabaseOnLine','Port','0'));
            Database    := Aini.ReadString('DatabaseOnLine','DB','');
            Username    := aini.ReadString('DatabaseOnLine','User','');
            Password    := Aini.ReadString('DatabaseOnLine','Pass','');
        end;
      end;
  finally
    Aini.Free;
  end;
end;


function newCon(ACon:TMyConnection):TMyConnection;

begin

  ACon := TMyConnection.Create(nil);
  Try
    SetKoneksi(ACon);

    Result := ACon;
  Except
    on e:Exception do
      raise Exception.Create(e.Message);
  End;
end;

function OpenTable(Q:TMyQuery;aFIeld:array of String;aTable:string;isCari:String):TMyQuery;
var
  i     : integer;
  str   : string;

begin

  for i:=Low(aField) to High(aFIeld) do
      str := str + aField[i]+',';
  Delete(str,Length(str),1);
  try
    with Q do begin
      Close;
      SQL.Text  := ' SELECT ';
      SQL.Add(str);
      SQL.Add(' FROM '+aTable);
      if isCari <> '' then
      SQL.Add(' WHERE '+isCari);
      Open;
    end;

    Result := Q;
  Except
    Result := nil;
  end;


end;

function GetVal(Q:TMyQuery;aFIeld:string):string;
begin
  if Q.FieldByName(aFIeld).AsString = '0' then
  Result := ' ' else
  Result := Q.FieldByName(aFIeld).AsString;
end;

procedure addParam(aField:string;aValue:string; var Params:TStringList;fType:string);
begin
  if fType = 'date' then
     aValue := 'STR_TO_DATE("'+aValue+'","%d/%m/%Y")'
  else if fType ='int' then
     aValue := aValue
  else if fType ='str' then

     aValue := '"'+aValue+'"'
  else if fType ='pwd' then
     aValue := 'MD5("'+aValue+'")';
  Params.Duplicates := dupIgnore;
  Params.Add(aField+','+aValue);
end;

procedure exeDb(Q:TMyQuery;aTable:string;aList   : TStringList);
var
  i       : Integer;
  aFIeld  : string;
  aValue  : String;
begin
    aFIeld := '';
    aValue := '';
    for i:= 0 to aList.Count -1 do begin
      aFIeld  := aField+Copy(aList[i],1,Pos(',',aList[i])-1)+',';
      aValue  := aValue+Copy(aList[i],Pos(',',aList[i])+1,Length(aList[i]))+',';
    end;
    Delete(aFIeld,Length(aFIeld),1);
    Delete(aValue,Length(aValue),1);
    Try
      Q.Connection.StartTransaction;
      try
      with Q do begin
        Close;
        SQL.Text := 'INSERT INTO '+Atable+' ('+aField+') Values ('+aValue+')';
        ExecSQL;
      end;
      Q.Connection.Commit;
      except
   //
        on E:Exception do begin
          Q.Connection.Rollback;
          MessageDlg('Gagal input Data : '+#13+' Pesan Error : '+E.Message +#13+
          ' SQL Script : '+#13+Q.SQL.Text,
          mtError,[mbOK],0);
        end;
      end;
    Finally
      aList.Clear;
    End;

end;

procedure Post(Q:TMyQuery;aTable:string;aList: TStringList);
var
  i       : Integer;
  aFIeld  : string;
  aValue  : String;
begin
    for i:= 0 to aList.Count -1 do begin
      aFIeld  := aField+Copy(aList[i],1,Pos(',',aList[i])-1)+',';
      aValue  := aValue+Copy(aList[i],Pos(',',aList[i])+1,Length(aList[i]))+',';
    end;
    Delete(aFIeld,Length(aFIeld),1);
    Delete(aValue,Length(aValue),1);


    try
    with Q do begin
      Close;
      SQL.Text := 'INSERT INTO '+Atable+' ('+aField+') Values ('+aValue+')';
      ExecSQL;
    end;

    except
 //
      on E:Exception do begin

        MessageDlg('Gagal input Data : '+#13+' Pesan Error : '+E.Message,
        mtError,[mbOK],0);
      end;
    end;

    aList.Clear;

end;

procedure updatedb(Q:TMyQuery;aTable:string;aList:TStringList;aField,aValue:string);
var
  i       : Integer;
  _SQL  : string;
  bField : String;
  vField : String;

begin
    for i:= 0 to aList.Count -1 do begin
      bFIeld  := Copy(aList[i],1,Pos(',',aList[i])-1);
      vField  := Copy(aList[i],Pos(',',aList[i])+1,Length(aList[i]));
      _SQL  := _SQL+ bField+'='+vFIeld+',';
    end;
    Delete(_SQL,Length(_SQL),1);
    Q.Connection.StartTransaction;
    try
    with Q do begin
      Close;
      SQL.Text := 'UPDATE '+Atable+' SET '+_SQL+' WHERE '+aField+'='+avalue+'';
      ExecSQL;
    end;

    Q.Connection.Commit;
    aList.Clear;
    except

      on E:Exception do begin
        Q.Connection.Rollback;
        MessageDlg('Gagal simpan data '+#13+' Pesan error : '+ E.Message,
               mtError,[mbYes],0);
      end;
    end;

end;

procedure updatePOST(Q:TMyQuery;aTable:string;aList:TStringList;aField,aValue:string);
var
  i       : Integer;
  _SQL  : string;
  bField : String;
  vField : String;

begin
    for i:= 0 to aList.Count -1 do begin
      bFIeld  := Copy(aList[i],1,Pos(',',aList[i])-1);
      vField  := Copy(aList[i],Pos(',',aList[i])+1,Length(aList[i]));
      _SQL  := _SQL+ bField+'='+vFIeld+',';
    end;
    Delete(_SQL,Length(_SQL),1);

    try
    with Q do begin
      Close;
      SQL.Text := 'UPDATE '+Atable+' SET '+_SQL+' WHERE '+aField+'='+avalue+'';
      ExecSQL;
    end;

    aList.Clear;
    except

      on E:Exception do begin

        MessageDlg('Gagal simpan data '+#13+' Pesan error : '+ E.Message,
               mtError,[mbYes],0);
      end;


    end;

end;

function getData(Q:TMyQuery;aTable:string;aField:string):String;
begin
  with Q do begin
    Close;
    SQL.Text := ' SELECT '+aField+' from '+Atable+' ';
    Open;
  end;
   Result := Q.Fields[0].AsString;
end;

procedure ExQry(Q:TMyQuery;_SQL:String;isCari:Boolean);
begin
  try

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
procedure DelDb(Q:TMyQuery;aTable:string;S,Key1:String;Val1:string);
begin
  if MessageDlg('Yakin data '+S+' Akan dihapus?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
     Q.Connection.StartTransaction;
    try
    with Q do  begin
      Close;
      SQL.Text := 'UPDATE '+aTable+' SET aktiv=FALSE WHERE '+Key1+'="'+Val1+'"';
      ExecSQL;
    end;
    Q.Connection.Commit;
    except

    on E:Exception do
    begin
      MessageDlg('Gagal Hapus data '+#13+' Pesan error : '+#13+'Data masih digunakan di tabel lain '+#13#13+
      'SQL ERROR : '+#13+E.Message,
               mtError,[mbYes],0);
      Q.Connection.Rollback;
    end;
  end;
  end;
end;

procedure isiCmb(Q:TMyQuery;aTable:string;aField:array of string;cb:TAdvCombobox);
var
  i       : integer;
  idx     : integer;
  aValue  : string;
  _SQl    : string;
begin

  for i:=Low(aField) to High(aFIeld) do
      _SQL:=_SQL+ aFIeld[i]+',';
  Delete(_SQl,Length(_SQl),1);

  with Q do begin
    Close;
    SQL.Text := 'SELECT '+_SQL+' FROM '+aTable;
    Open;

    cb.Items.Clear;

    while not Eof do begin
      idx     := Fields[0].AsInteger;
      aValue  := Fields[1].AsString;

      cb.Items.AddObject(aValue,TObject(idx));
      Next;
    end;
  end;
end;

function Getidcmb(cmb:TAdvCombobox):String;
begin
  Result := Inttostr(integer(cmb.Items.Objects[cmb.ItemIndex]));
end;


function GetCode(Q:TMyQuery;aTable:string;aField:string;s:string):string;
var
  x : Integer;
  k : string;
begin
  ExQry(Q,' SELECT MAX(RIGHT('+aField+',3)) as jml  '+
          ' FROM '+aTable+' WHERE '+aField+' '+
          ' LIKE"%'+s+setIdKom+FormatDateTime('yymmdd',now)+'%" ',True);
    if StrToIntDef(Q.Fields[0].AsString,0) =0 then x := 1
    else
       x := Q.Fields[0].AsInteger +1;
  k := IntToStr(x);
  k:= Copy('000'+k,length('000'+k)-2,3);
  result :=s+setIdKom+FormatDateTime('yymmdd',Now)+ k;

end;

procedure FilterDac(aQ:TMyQuery;aStr :string);
begin
  aQ.Active    := False;
  aQ.Filter    := aStr;
  aQ.Filtered  := True;
  aQ.Active    := True;
end;

end.
