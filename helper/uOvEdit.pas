unit uOvEdit;

interface
  uses
    Classes,Controls,Graphics,Windows,Forms,
    StdCtrls,Messages,uComCtrl,SysUtils,AdvEdit,AdvCombo;

    type
      TAdvEdit = Class(AdvEdit.TAdvEdit)
        protected

          procedure KeyPress(var Key : Char);Override;
          procedure KeyUp(var  Key: Word;Shift: TShiftState);Override;
          procedure KeyDown(var  Key: Word;Shift: TShiftState);Override;
          procedure DoExit;override;
          Procedure DoEnter;override;


        public
          DefaultColor  : TColor;
          FcsColor    : TColor;
          DefaultFontColor : TColor;
          FocusFontColor : TColor;
          DefaultFontStyles:TFontStyles;
          FocusFontStyles:TFontStyles;
      //    NextFocus : TWinControl;
          FocusNextOnEnter : Boolean;
          isRupiah : Boolean;
          isPersen : Boolean;
          isCari   : Boolean;
          isPassword : Boolean;


          Constructor Create(AOwner:TComponent);Override;

          function stencecase(aWord : String) : String;
          function isAngka:String;
          function AsFLoat : Real;
          function AsInteger : Integer;
      End;
      type
      TAdvCombobox = class (AdvCombo.TAdvCombobox)
      protected
        procedure KeyDOwn(var  Key: Word;Shift: TShiftState);Override;
        procedure DoExit; override;
        procedure DoEnter;override;
      public
        NextFOcus : boolean;
        FocusColor : TColor;
        DefaultColor : TColor;
        constructor Create(aOwner:TComponent);override;

      end;
      TMemo = class (StdCtrls.TMemo)
        protected
        procedure KeyDown(var  Key: Word;Shift: TShiftState);Override;
        procedure DoExit; override;
        procedure DoEnter;override;
      public
        NextFOcus : boolean;
        FocusColor : TColor;
        DefaultColor : TColor;
        constructor Create(aOwner:TComponent);override;

      end;


      TCheckBox = class (StdCtrls.TCheckBox)
        protected
          procedure KeyUp(var Key :Word;Shift:TShiftState);override;
        public
          NextFocus : Boolean;
          constructor create(aOwNer:TComponent);override;
        end;


implementation

{ TsEdit }

function TAdvEdit.AsFLoat: Real;
begin
  Result := StrToFloatDef(nilai(Text),0);
end;

function TAdvEdit.AsInteger: Integer;
begin
  Result := StrToIntDef(nilai(Text),0);
end;

constructor TAdvEdit.Create(AOwner: TComponent);
begin
  inherited;

  DefaultColor      := Color;
  DefaultFontColor  := Font.Color;

  FcsColor        := Clyellow;
  FocusFontColor    := DefaultFontColor ;
  FocusFontStyles   := [fsBold];

  FocusNextOnEnter  := True;
  isRupiah          := False;
  isPassword        := False;

end;

procedure TAdvEdit.DoEnter;
begin
  inherited;

  FocusColor := FcsColor;
  Font.Color := FocusFontColor;
  Font.Style := FocusFontStyles;
  SetFocus;

end;

procedure TAdvEdit.DoExit;
begin
  inherited;

  Color := clWhite;
  Font.Color := clBlack;
  Font.Style := DefaultFontStyles;
  

end;



function TAdvEdit.isAngka: String;
begin
  Result := StrToDecimal(Text);
end;

procedure TAdvEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (FocusNextOnEnter) AND ( not isCari) then
    if Key = VK_RETURN then begin
      PostMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, Ord((ssShift in Shift)), 0);
      Key := 0;
    end;
end;

procedure TAdvEdit.KeyPress(var Key: Char);
begin
  inherited;

  if (isPersen = True) or (isRupiah=True) then begin
    if not (Key in['0'..'9',#10,#13,#8,',','.']) then
       Key := #0;
  end;

end;

procedure TAdvEdit.KeyUp(var Key: Word;Shift: TShiftState);
begin
  inherited;
  if ( isRupiah = True) then
      Rupiah(self.Text,self);

  if (isPersen) and (StrToFloatDef(Text,0) > 99) then begin
      MessageBox(Handle,'Angka harus kurang 100','Error',MB_ICONERROR);
      Text :='';
  end;


end;



function TAdvEdit.stencecase(aWord: String): String;
var
  i:integer;
  s : String;
begin
  if aWord = '' then Exit;
  s := UpperCase(aWord[1]);
  for i := 2 to Length(aWord) do
    if (Aword[i-1] in [' ',';','.',',',':']) then
      s:=s+UpperCase(aWord[i])
    else
      s:=s+UpperCase(aWord[i]);
  Result := s;
end;



{ TAdvCombobox }

constructor TAdvCombobox.Create(aOwner: TComponent);
begin
  inherited;
  NextFOcus := True;
  DefaultColor      := Color;
  FocusColor        := Clyellow;
end;

procedure TAdvCombobox.DoEnter;
begin
  inherited;
  Color := FocusColor;
  SetFocus;
end;

procedure TAdvCombobox.DoExit;
begin
  inherited;
  Color := clWhite;
  Font.Color := clBlack;
end;

procedure TAdvCombobox.KeyDOwn(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if NextFOcus then begin
    if Key = VK_RETURN then begin
 //      SelectNext(ActiveControl as TWinControl,True,ssShift in Shift);
      PostMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, Ord((ssShift in Shift)), 0);
      Key := 0;
    end;
  end;
end;

{ TMemo }

constructor TMemo.Create(aOwner: TComponent);
begin
  inherited;
  NextFOcus := True;
  DefaultColor      := Color;
  FocusColor        := Clyellow;
end;

procedure TMemo.DoEnter;
begin
  inherited;
  Color := FocusColor;
  SetFocus;
end;

procedure TMemo.DoExit;
begin
  inherited;
  Color := clWhite;
  Font.Color := clBlack;
end;

procedure TMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if NextFOcus then
    if Key = VK_RETURN then begin
      PostMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, Ord((ssShift in Shift)), 0);
      Key := 0;
    end;
end;


{ TCheckBox }

constructor TCheckBox.create(aOwNer: TComponent);
begin
  inherited;
  NextFOcus := True;
end;

procedure TCheckBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if NextFOcus then
    if Key = VK_RETURN then begin
      PostMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, Ord((ssShift in Shift)), 0);
      Key := 0;
    end;
end;

end.
