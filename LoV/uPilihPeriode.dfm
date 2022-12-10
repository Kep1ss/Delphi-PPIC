object FPilihPeriode: TFPilihPeriode
  Left = 0
  Top = 0
  ClientHeight = 112
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 145
    Height = 13
    Caption = 'Silahkan Pilh Periode Tanggal :'
  end
  object Label2: TLabel
    Left = 159
    Top = 43
    Width = 17
    Height = 13
    Caption = 'S/D'
  end
  object dt1: TDateTimePicker
    Left = 8
    Top = 40
    Width = 145
    Height = 21
    Date = 44476.000000000000000000
    Time = 0.528281400460400600
    TabOrder = 0
  end
  object dt2: TDateTimePicker
    Left = 182
    Top = 40
    Width = 145
    Height = 21
    Date = 44476.000000000000000000
    Time = 0.528281400460400600
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 79
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 79
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
end
