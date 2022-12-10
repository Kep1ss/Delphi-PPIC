unit uPatchForm;

interface
  uses
    Forms,Classes;

  type
    TForm = class (Forms.TForm)
      public
        Fid : Integer;
        FCanEdit : Boolean;
        constructor create(AOwner :TComponent);override;

    end;
  

implementation

{ TForm }

constructor TForm.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ TFormClass }



end.
