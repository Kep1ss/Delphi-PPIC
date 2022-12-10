unit uComCtrl;

interface
uses

  SysUtils,Windows,dialogs,Forms,stdCtrls,AdvGrid,
  Controls,Classes,Graphics,IniFIles,AdvEdit,System.UITYPEs,
  Grids,DBgrids,ComCtrls,System.Math,frxClass,AdvCombo ,Xml.XmlIntf,
    Xml.XMLDoc,
    Xml.XMLDom,
    Xml.omnixmldom;


  function CheckEdit(aForm:TForm):Boolean;
  procedure ClearText(Aform:TForm);
  function GetRupiah(text:String):string;
  function Rupiah(Text:String;nEdit:TAdvEdit):String;
  function nilai(Text:String):String;
  function Bulat(Text:String):String;
  function koma(Text:String):String;
  function pesan(s : string ):Boolean;
  Procedure Peringatan(s : PChar);
  function SumGrid(Grid:TStringGrid;aCol:integer):Real;
  function Tanggal(dt:TDateTime) : string;
  procedure setTanggal(aForm:TForm);
  function BolStr(Abol:Boolean):String;
  procedure PesanErr(str:string);
  function frmTgl(dt:TDateTime):string;
  function frmTime(dt:TDateTime):string;
  function ToGaji(value:Real):String;
  procedure Warning(s:String);
  procedure Error(s:String);
  procedure Informasi(S:string);
  function StrToDecimal(text:string):String;
  function CellF(str : String):Real;
  function setIdKom:string;
  procedure DeleteRow(AdvG:TAdvStringGrid;RowStart:Integer);
  Function Freport(Fastreport:TFrxReport;ObjectName:String):TObject;
  Function FMemo(FastReport:TFrxReport;ObjectName:String):TFrxMemoView;
  Function FImage(FastReport:TFrxReport;ObjectName:String):TFrxPictureView;
  function getSQL(AName : String):String;
  function GetIdUser:String;


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
procedure DeleteRow(AdvG:TAdvStringGrid;RowStart:Integer);
var
  i , c: integer;
begin
  with AdvG do begin
    for i := RowStart to RowCount -1 do begin
       for c := 0 to ColCount -1 do
       Cells[c,i] := Cells[c,i+1];
    end;

    RowCount := RowCount -1;
  end;

end;

function getSQL(AName : String):String;
var
  NodeXml , SQLNode ,QueryNode: IXMLNode;
  Path    : String;
  aXMLFIle : IXMLDocument;
  _SQL , AttValue   : String;
  i   : Integer;
begin
  Path :=  ExtractFilePath(ParamStr(0))+'SQLDatabase.xml';
  aXMLFIle := TXMLDocument.Create(nil);
  try
      aXMLFIle.LoadFromFile(Path);
      NodeXml := aXMLFIle.ChildNodes['DATASET'];

      for  i := 0 to NodeXml.ChildNodes.Count -1 do begin
          SQLNode := NodeXml.ChildNodes[i];

          if SQLNode.HasAttribute('QUERYNAME') then begin
             AttValue := SQLNode.AttributeNodes['QUERYNAME'].Text;
             if AttValue = AName then begin
                QueryNode := SQLNode.ChildNodes.FindNode('Query');

                if QueryNode <> nil then begin
                    _SQL    := QueryNode.Text;
                  Result  := _SQL;
                end;
             end;

          end;
    end;
  finally
    aXMLFIle := nil;
  end;

end;
function frmTime(dt:TDateTime):string;
begin

  Result := FormatDateTime('hh:nn:ss',dt);
end;


Function Freport(Fastreport:TFrxReport;ObjectName:String):TObject;
var
  i:Integer;
  Ketemu:Boolean;
begin
  Ketemu:=False;
  For i:=0 to FastReport.ComponentCount -1 do
    begin
      if lowercase(FastReport.Components[i].Name)=Lowercase(ObjectName) then
        begin
          Result:=Tobject(FastReport.Components[i]);
          Ketemu:=True;
          Break;
        end;
      end;
    if not ketemu then
      begin
        Result:=nil;
      end;
end;

Function FMemo(FastReport:TFrxReport;ObjectName:String):TFrxMemoView;
begin
  Result:=TFrxMemoView(Freport(FastReport,ObjectName));
end;

Function FImage(FastReport:TFrxReport;ObjectName:String):TFrxPictureView;
begin
  Result:=TFrxPictureView(Freport(FastReport,ObjectName));
end;



function setIdKom:string;
var
  aIni : TIniFile;

begin
   Aini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'SetKasir.Ini');
   try
      Result := aIni.ReadString('KOMPUTER','ComputerID','1');
   finally
     Aini.Free;
   end;

end;
function StrToDecimal(text:string):String;
begin
  text := StringReplace(text,FormatSettings.ThousandSeparator,'',[rfReplaceAll]);
  text := StringReplace(text,FormatSettings.DecimalSeparator,'.',[rfReplaceAll]);
  if (text = ' ') or (text ='') then
     Result :='0'
  else
     Result :=text;

end;



procedure Warning(s:String);
begin
  MessageDlg(s,mtWarning,[mbYes],0);
end;
procedure Error(s:String);
begin
  MessageDlg(s,mtError,[mbYes],0);
end;
procedure Informasi(s:String);
begin
  MessageDlg(s,mtInformation,[mbYes],0);
end;

function ToGaji(value:Real):String;
begin
  Result := FloatToStrF(value,ffNumber,20,2);
end;
function frmTgl(dt:TDateTime):string;
begin
  Result := FormatDateTime('dd/mm/yyyy',dt);
end;

procedure PesanErr(str:string);
begin
  MessageDlg(str,mtError,[mbYes],0);
end;

function BolStr(Abol:Boolean):String;
begin
  if Abol = True then
     Result := '1' else
     Result := '0';
end;


function Tanggal(dt:TDateTime) : string;
begin
  Result := FormatDateTime('yyyy-mm-dd',dt);
end;

procedure setTanggal(aForm:TForm);
var
  i : integer;
begin
  with aForm do begin
    for i:=0 to ComponentCount -1 do begin
      if Components[i] is TDateTimePicker then
      TDateTimePicker(Components[i]).Date := now;
    end;
  end;
end;

function SumGrid(Grid:TStringGrid;aCol:integer):Real;
var
  sum:real;
  i:integer;
begin
  sum := 0;
  for I := 1 to Grid.RowCount -1 do
  begin

    if Grid.Cells[aCol,i] <> '' then

    sum:=sum+strtofloat(Nilai(Grid.Cells[aCol,i]));
  end;

  Result := Sum;
end;

function koma(Text:String):String;
begin
   if Text <> '' then

   Result := StringReplace(text,',','.',[RfReplaceAll])
else
  Result := '0';
end;


function GetRupiah(text:String):string;
var
  tulis:String;
  curr:Currency;
begin
  tulis:=text;
  Tulis:=StringReplace(tulis,',','',[RfreplaceAll,Rfignorecase]);
  tulis:=StringReplace(tulis,'.','',[RfReplaceAll,RfignoreCase]);
  curr:=StrtoCurrdef(tulis,0);
  Result:=FormatCurr('#,###',curr);
end;

function Rupiah(Text:String;nEdit:TAdvEdit):String;
var
  tulis:String;
  Curr:Currency;
begin
  Tulis:=Text;
  tulis:=StringReplace(tulis,',','',[RfReplaceAll,RfignoreCase]);
  Tulis:=StringReplace(tulis,'.','',[RfReplaceAll,RfIgnoreCase]);
  curr:=StrtoCurrDef(tulis,0);
  nEdit.Text:=FormatCurr('#,###',curr);
  nEdit.SelStart:=Length(nEdit.Text);
end;


Function Nilai(Text:String):String;
begin
  if text = '' then text:='0';

  Result:=StringReplace(Text,'.','',[rfReplaceAll,rfIgnoreCase]);
end;




procedure ClearText(Aform:TForm);
var
  i:integer;
begin
  with Aform do
  begin
    For i:=0 to ComponentCount -1 do
    begin
      if (Components[i] is TAdvEdit)
       then
       if (TAdvEdit(Components[i]).Tag <> 9) then

      begin
        TAdvEdit(Components[i]).Text:='';
        TAdvEdit(Components[i]).Color :=clWhite;

      end;
      if (components[i] is TAdvComBobox) then begin
          if (TAdvComBobox(Components[i]).Tag <> 12) then
            TAdvComBobox(Components[i]).Text := '';
      end;
      if (components[i] is TMemo) then begin
        if (TMemo(Components[i]).Tag <> 12) then
          TMemo(Components[i]).Text :='';
        end;
    end;
  end;
end;


Procedure Peringatan(s : PChar);
begin
    MessageBox(Application.handle,s,PChar('Warning'),MB_ICONWARNING);
end;




function pesan(s : string ):Boolean;
begin
  case MessageDlg('Apakah Yakin data '+ s+' akan dihapus?',mtConfirmation,[mbYes,mbNo],0) of
      mryes: Result:=True;
      mrNo:Result:=False;
  end;
end;


function Bulat(Text:String):String;
var
  angka : real;
  bil : real;
begin
  angka := StrToint(Copy(text,length(text)-1,2));
  //ShowMessage(FloatToStr(angka));
  if   (angka <100) and (angka <>0)then
  begin
    bil := 100 - angka;
    Result := GetRupiah(FloatTostr(StrToFLoatDef(Text,0)+bil));
  end else
    Result := GetRupiah(Text);
end;

function CellF(str : String):Real;
begin
  Result := StrToFloatDef(nilai(str),0);
end;

function CheckEdit(aForm:TForm):Boolean;
var
	I: integer;
begin
	with AForm do
	begin
		for I := 0 to ComponentCount -1 do
		begin
      if Components[I] is TAdvComBobox then
			begin
				Result := (TAdvComBobox(Components[I]).Tag = 0) AND (TAdvComBobox(Components[I]).Text = '')
        AND (TAdvComBobox(Components[I]).Enabled = True);
				if Result then
				begin
					MessageDLg('Data "'+UPPERCASE(TAdvComBobox(Components[i]).Hint) +'" masih kosong ',
                      mtError,[mbOK],0);
					TAdvComBobox(Components[i]).SetFocus;
					Break;
				end;
			end else
			if Components[I] is TAdvEdit then
			begin
				Result := (TAdvEdit(Components[I]).Tag = 0) AND (TAdvEdit(Components[I]).Text = '') AND
        (TAdvEdit(Components[I]).Enabled = True);
				if Result then
				begin
					MessageDLg('Data "'+UPPERCASE(TAdvEdit(Components[i]).Hint) +'" masih kosong ',
                      mtError,[mbOK],0);
					TAdvEdit(Components[i]).SetFocus;
					Break;
				end;
			end else

      if Components[I] is TMemo then
			begin
				Result := (TMemo(Components[I]).Tag = 0) AND (TMemo(Components[I]).Text = '') AND
        (TMemo(Components[I]).Enabled = True);
				if Result then
				begin
					MessageDLg('Data "'+UPPERCASE(TMemo(Components[i]).Hint) +'" masih kosong ',
                      mtError,[mbOK],0);
					TMemo(Components[i]).SetFocus;
					Break;
				end;
			end;
		end;
	end;
end;


end.
