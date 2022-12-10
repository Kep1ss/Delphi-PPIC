object MariaCon: TMariaCon
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 117
  Width = 184
  object con: TMyConnection
    Port = 3309
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object QCon: TFDConnection
    LoginPrompt = False
    Left = 104
    Top = 8
  end
end
