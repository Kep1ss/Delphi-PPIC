object FRencanaBeritaAcara: TFRencanaBeritaAcara
  Left = 0
  Top = 0
  Caption = 'Berita Acara'
  ClientHeight = 315
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    407
    315)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 25
    Top = 64
    Width = 58
    Height = 13
    Caption = 'No Rencana'
  end
  object Label2: TLabel
    Left = 25
    Top = 93
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label4: TLabel
    Left = 25
    Top = 120
    Width = 42
    Height = 13
    Caption = 'Quantity'
  end
  object Label5: TLabel
    Left = 25
    Top = 147
    Width = 15
    Height = 13
    Caption = 'MH'
  end
  object Label6: TLabel
    Left = 25
    Top = 174
    Width = 22
    Height = 13
    Caption = 'Cost'
  end
  object Label8: TLabel
    Left = 25
    Top = 201
    Width = 49
    Height = 13
    Caption = 'Total Cost'
  end
  object AdvSmoothPanel1: TAdvSmoothPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 45
    Cursor = crDefault
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Caption.HTMLFont.Charset = DEFAULT_CHARSET
    Caption.HTMLFont.Color = clWindowText
    Caption.HTMLFont.Height = -11
    Caption.HTMLFont.Name = 'Tahoma'
    Caption.HTMLFont.Style = []
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -16
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Fill.Color = clGreen
    Fill.ColorTo = clGreen
    Fill.ColorMirror = clGreen
    Fill.ColorMirrorTo = clGreen
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clGreen
    Fill.Rounding = 0
    Fill.RoundingType = rtTop
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Version = '1.5.2.4'
    Align = alTop
    TabOrder = 0
    TMSStyle = 0
    object Label3: TLabel
      Left = 10
      Top = 8
      Width = 55
      Height = 25
      Caption = 'Input'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15987699
      Font.Height = -21
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 73
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Berita Acara'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15987699
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object EnoRencana: TAdvEdit
    Left = 109
    Top = 63
    Width = 164
    Height = 21
    DefaultHandling = True
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 1
    Text = ''
    Visible = True
    Version = '3.4.7.0'
  end
  object Edescription: TAdvEdit
    Left = 109
    Top = 90
    Width = 276
    Height = 21
    DefaultHandling = True
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 2
    Text = ''
    Visible = True
    Version = '3.4.7.0'
  end
  object Eqty: TAdvEdit
    Left = 109
    Top = 117
    Width = 81
    Height = 21
    DefaultHandling = True
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 3
    Text = ''
    Visible = True
    OnChange = EqtyChange
    Version = '3.4.7.0'
  end
  object EMh: TAdvEdit
    Left = 109
    Top = 144
    Width = 81
    Height = 21
    DefaultHandling = True
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 4
    Text = ''
    Visible = True
    Version = '3.4.7.0'
  end
  object ECost: TAdvEdit
    Left = 109
    Top = 171
    Width = 124
    Height = 21
    DefaultHandling = True
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 5
    Text = ''
    Visible = True
    OnChange = EqtyChange
    Version = '3.4.7.0'
  end
  object EtotalCost: TAdvEdit
    Left = 109
    Top = 198
    Width = 124
    Height = 21
    DefaultHandling = True
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    ReadOnly = True
    TabOrder = 6
    Text = ''
    Visible = True
    Version = '3.4.7.0'
  end
  object btnSimpan: TAdvSmoothButton
    Left = 60
    Top = 258
    Width = 116
    Height = 33
    Anchors = [akLeft, akBottom]
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -11
    Appearance.Font.Name = 'Tahoma'
    Appearance.Font.Style = []
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    BevelColor = 16744448
    Caption = 'Simpan'
    Color = clGreen
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      6100000006624B474400FF00FF00FFA0BDA79300000159494441543811AD933B
      4BC440148567A282AC0958588BE816595F6869B75AD989B895BFC25AF0970866
      B1B3B2F0D158692788A0D889DD2A3E0AC12D164177FCCE40428C661B1DF2E5DC
      7BEEDCECEC4C62CC1F87FDADDF39378BDF8071E8C00D1C5A6BEFD0F28BC61012
      E75C17EEE1044EA1051F50376583620497A0C9AB6890CE550CB17234802D1851
      9E81D1840718CDCC4240AD0F76E11D96B332490C9FB092998580DA201CC11BD4
      4D7E606C82966ED10A8485BA9A0FF0DBB094AFF91873078E95A07B7006FE21E8
      1068335FD105CDF90185C439973EA046ACBDB840AB206DA1B5B4917811E6D3DC
      90E82F3CA2814C740E5EA0033ACE49F982BC1F54DB50EEC188419BD8F00637F2
      19388709D2EC225F07CD1D33F981D9042DBDD7315699F304DBF95E1F6346D0EB
      455AA3FE0C5710F9A6E28D420889FBFE2AEB04F4AB5D7CAD7238DF57F6314D31
      496FDA343A00B7B0CFC7748DFEEFF505E08885744C39D9A00000000049454E44
      AE426082}
    Shadow = True
    TabOrder = 7
    ShowFocus = False
    Version = '2.1.1.9'
    OnClick = btnSimpanClick
    TMSStyle = 0
  end
  object btnTutup: TAdvSmoothButton
    Left = 182
    Top = 258
    Width = 118
    Height = 33
    Anchors = [akLeft, akBottom]
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -11
    Appearance.Font.Name = 'Tahoma'
    Appearance.Font.Style = []
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    BevelColor = 16744448
    Caption = 'Cancel'
    Color = clGreen
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      6100000006624B474400FF00FF00FFA0BDA79300000126494441543811CDD231
      6BC24014C0F18BD1A9C58E1D94DA2F503063A17470EBA6834BE70E05C1A19D0B
      924F908FE0E0500ADD0BDDBAF533640D2E8A6609D4A15CFFAFE42551223A89C7
      FDEEDDBD7739CC19638EB2596B2F1120C40273BCE366E70F6653170922F8B8C7
      109F901E30544A0FA2E0E107139C6C6E22D783D447A6AC51FC4AB9C4369A9BFB
      C80DB0426BAD46E2146FB89502B18F393AB256ACAB98E159728E0C2C5E88FF0F
      12B59F33B9C20A8F8EE38C4DDAD8FFC13422F75065223D6158A2D8F50E5C9275
      14BB655141DE39F50C72D31DC93297579812AF65AD58EB2B3C692E8B14E512BF
      8935C8255E64C574427E00F9271A692A0F143C48F195A8AF906D20D783D44766
      5B63C31D6244F0B1FF87A487F250CB5A1B20C42F62ECF729EB21078B7F18FB2C
      F2DB81B6DC0000000049454E44AE426082}
    Shadow = True
    TabOrder = 8
    ShowFocus = False
    Version = '2.1.1.9'
    OnClick = btnTutupClick
    TMSStyle = 0
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 280
    Top = 144
  end
end
