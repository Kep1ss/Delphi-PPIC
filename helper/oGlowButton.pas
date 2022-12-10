unit oGlowButton;

interface
   uses
      sysUtils, Windows, Classes,Dialogs,AdvSmoothPanel,Controls,AdvGlowButton,Messages,AdvSmoothExpanderPanel,AdvOfficeImage,Graphics;

   type
    TAdvGlowButton = class (AdvGlowButton.TAdvGlowButton)
    FExpandePanel : TAdvSmoothExpanderPanel;
    Fimg          : TAdvOfficeImage;




    protected

    public
      FCapName      : String;
      function getNameParent : String;
      Constructor Create(AOwner:TCOmponent);Override;
      procedure RefreshButton;
      procedure Click;override;

    end;


implementation

{ TAdvGlowButton }

procedure TAdvGlowButton.Click;
var
  Path : String;
  imgName : String;
begin

  if Name <> 'btnDashboard' then begin

        if Name = 'btnExpand'+getNameParent then begin

            imgName       := 'img'+getNameParent;
            Fimg          := TAdvOfficeImage(Owner.FindComponent(imgName));
            Path          := ExtractFilePath(ParamStr(0))+'\img';
            FExpandePanel := TAdvSmoothExpanderPanel(Owner.FindComponent(Copy(Name,4,Length(Name))));
            FExpandePanel.Expanded := not FExpandePanel.Expanded;
            Transparent   := True;
            UseAppearance := False;

            if FExpandePanel.Expanded then begin
               if Fimg <> nil then
                 Fimg.Picture.LoadFromFile(Path+'\unexpand.png');
            end  else begin
               if Fimg <> nil then

               Fimg.Picture.LoadFromFile(Path+'\expand.png');
            end;

        end;


  end;
  if assigned(OnClick) then OnClick(Self);
        RefreshButton;

end;

constructor TAdvGlowButton.Create(AOwner: TCOmponent);
begin
  inherited;
  DoubleBuffered := True;

end;



function TAdvGlowButton.getNameParent: String;
begin
  FCapName := Name;
  Result   := StringReplace(FCapName,'btnExpand','',[rfReplaceAll]);
end;





procedure TAdvGlowButton.RefreshButton;
var
  i : integer;
begin
  for i := 0 to Owner.ComponentCount -1 do begin
     if Owner.Components[i] is TAdvGlowButton then begin
         TAdvGlowButton(Owner.Components[i]).DoubleBuffered := True;
     end;


  end;

end;

end.
