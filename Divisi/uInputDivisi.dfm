object FinputDivisi: TFinputDivisi
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 325
  ClientWidth = 643
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSmoothPanel2: TAdvSmoothPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 325
    Cursor = crDefault
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
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
    Fill.Color = 16053492
    Fill.ColorTo = 16053492
    Fill.ColorMirror = 16053492
    Fill.ColorMirrorTo = 16053492
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 10066329
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Version = '1.5.2.4'
    Align = alClient
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      643
      325)
    TMSStyle = 0
    object AdvSmoothPanel1: TAdvSmoothPanel
      Left = 0
      Top = 0
      Width = 643
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
        Width = 57
        Height = 25
        Caption = 'Divisi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15987699
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object btnSimpan: TAdvSmoothButton
      Left = 204
      Top = 281
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
      TabOrder = 1
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnSimpanClick
      TMSStyle = 0
    end
    object btnTutup: TAdvSmoothButton
      Left = 326
      Top = 281
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
      TabOrder = 2
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnTutupClick
      TMSStyle = 0
    end
    object AdvGroupBox1: TAdvGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 48
      Width = 637
      Height = 217
      BorderColor = clGray
      RoundEdges = True
      Align = alTop
      ParentCtl3D = True
      TabOrder = 3
      object Label1: TLabel
        Left = 20
        Top = 24
        Width = 40
        Height = 13
        Caption = 'No Divisi'
      end
      object Label2: TLabel
        Left = 20
        Top = 50
        Width = 42
        Height = 13
        Caption = 'Deskripsi'
      end
      object Label13: TLabel
        Left = 20
        Top = 77
        Width = 17
        Height = 13
        Caption = 'PIC'
      end
      object Label4: TLabel
        Left = 20
        Top = 104
        Width = 64
        Height = 13
        Caption = 'Tenaga Kerja'
      end
      object Label5: TLabel
        Left = 20
        Top = 131
        Width = 18
        Height = 13
        Caption = 'Gaji'
      end
      object Label6: TLabel
        Left = 20
        Top = 158
        Width = 62
        Height = 13
        Caption = 'Warna Inisial'
      end
      object Edivno: TAdvEdit
        Left = 128
        Top = 21
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
        TabOrder = 0
        Text = ''
        Visible = True
        Version = '3.4.7.0'
      end
      object EDeskripsi: TAdvEdit
        Left = 128
        Top = 47
        Width = 497
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
        TabOrder = 1
        Text = ''
        Visible = True
        Version = '3.4.7.0'
      end
      object EPIC: TAdvEdit
        Tag = 1
        Left = 128
        Top = 74
        Width = 369
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
      object ETenagaKerja: TAdvEdit
        Tag = 1
        Left = 128
        Top = 101
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
        Version = '3.4.7.0'
      end
      object Egaji: TAdvEdit
        Tag = 1
        Left = 128
        Top = 128
        Width = 145
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
      object cbColor: TAdvColorPickerDropDown
        Left = 128
        Top = 155
        Width = 200
        Height = 21
        Colors = <
          item
            Caption = 'Black'
            Color = clBlack
          end
          item
            Caption = 'Maroon'
            Color = clMaroon
          end
          item
            Caption = 'Green'
            Color = clGreen
          end
          item
            Caption = 'Olive'
            Color = clOlive
          end
          item
            Caption = 'Navy'
            Color = clNavy
          end
          item
            Caption = 'Purple'
            Color = clPurple
          end
          item
            Caption = 'Teal'
            Color = clTeal
          end
          item
            Caption = 'Gray'
            Color = clGray
          end
          item
            Caption = 'Silver'
            Color = clSilver
          end
          item
            Caption = 'Red'
            Color = clRed
          end
          item
            Caption = 'Lime'
            Color = clLime
          end
          item
            Caption = 'Yellow'
            Color = clYellow
          end
          item
            Caption = 'Blue'
            Color = clBlue
          end
          item
            Caption = 'Fuchsia'
            Color = clFuchsia
          end
          item
            Caption = 'Aqua'
            Color = clAqua
          end
          item
            Caption = 'White'
            Color = clWhite
          end
          item
            Caption = 'Custom 1'
            Color = 8453888
          end
          item
            Caption = 'Custom 2'
            Color = 13421568
          end
          item
            Caption = 'Custom 3'
            Color = 1447644
          end
          item
            Caption = 'Custom 4'
            Color = 16744448
          end
          item
            Caption = 'Custom 5'
            Color = 11993271
          end
          item
            Caption = 'Custom 6'
            Color = 65408
          end
          item
            Caption = 'Custom 7'
            Color = 16744703
          end
          item
            Caption = 'Custom 8'
            Color = 5504851
          end
          item
            Caption = 'Custom 8'
            Color = 4227327
          end
          item
            Caption = 'Custom 9'
            Color = 213
          end
          item
            Caption = 'Custom 10'
            Color = 2368767
          end
          item
            Caption = 'Custom 11'
            Color = 10485760
          end
          item
            Caption = 'Custom 12'
            Color = 3997695
          end
          item
            Caption = 'Custom 13'
            Color = 56797
          end
          item
            Caption = 'Custom 14'
            Color = 56797
          end
          item
            Caption = 'Custom 15'
            Color = 12374808
          end
          item
            Caption = 'Custom 16'
            Color = clGreen
          end
          item
            Caption = 'Custom 17'
            Color = 8453888
          end
          item
            Caption = 'Custom 18'
            Color = 151
          end
          item
            Caption = 'Custom 19'
            Color = 16741749
          end
          item
            Caption = 'Custom 20'
            Color = 10158158
          end
          item
            Caption = 'Custom 21'
            Color = 25542
          end>
        ItemAppearance.BorderColor = 9295827
        ItemAppearance.BorderColorTop = 16056063
        ItemAppearance.BorderColorBottom = 13302015
        ItemAppearance.ColorHot = 14155773
        ItemAppearance.ColorHotTo = 5821692
        ItemAppearance.ColorHotText = clBlack
        ItemAppearance.ColorMirrorHot = 5821692
        ItemAppearance.ColorMirrorHotTo = 11792892
        ItemAppearance.ColorSelected = 10944507
        ItemAppearance.ColorSelectedTo = 309748
        ItemAppearance.ColorMirrorSelected = 1425915
        ItemAppearance.ColorMirrorSelectedTo = 6874105
        ItemAppearance.ColorSelectedText = clBlack
        ItemAppearance.EdgeColor = 12835295
        ItemAppearance.Font.Charset = DEFAULT_CHARSET
        ItemAppearance.Font.Color = clWindowText
        ItemAppearance.Font.Height = -11
        ItemAppearance.Font.Name = 'Tahoma'
        ItemAppearance.Font.Style = []
        DropDownColor = 15984090
        DropDownBorderColor = clNone
        LabelMargin = 0
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Version = '1.4.6.0'
        ButtonAppearance.BorderColorHot = 10079963
        ButtonAppearance.BorderColorDown = 4370174
        ButtonAppearance.Color = 16773091
        ButtonAppearance.ColorTo = 16768452
        ButtonAppearance.ColorDisabledTo = 11974326
        ButtonAppearance.ColorDown = 11196927
        ButtonAppearance.ColorDownTo = 7257087
        ButtonAppearance.ColorHot = 15465983
        ButtonAppearance.ColorHotTo = 11332863
        ButtonAppearance.Font.Charset = DEFAULT_CHARSET
        ButtonAppearance.Font.Color = clWindowText
        ButtonAppearance.Font.Height = -11
        ButtonAppearance.Font.Name = 'Tahoma'
        ButtonAppearance.Font.Style = []
        DropDownHeader.Color = 16773091
        DropDownHeader.ColorTo = 16765615
        DropDownHeader.Font.Charset = DEFAULT_CHARSET
        DropDownHeader.Font.Color = 7485192
        DropDownHeader.Font.Height = -11
        DropDownHeader.Font.Name = 'Tahoma'
        DropDownHeader.Font.Style = []
        DropDownHeader.Visible = False
        DropDownHeader.BorderColor = 16765615
        DropDownHeader.Buttons = <>
        DropDownFooter.Color = 16773091
        DropDownFooter.ColorTo = 16765615
        DropDownFooter.Font.Charset = DEFAULT_CHARSET
        DropDownFooter.Font.Color = 7485192
        DropDownFooter.Font.Height = -11
        DropDownFooter.Font.Name = 'Tahoma'
        DropDownFooter.Font.Style = []
        DropDownFooter.Visible = False
        DropDownFooter.BorderColor = 16765615
        DropDownFooter.Buttons = <>
        TabOrder = 5
        SelectionColorStyle = 1
        TMSStyle = 4
      end
    end
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 451
    Top = 176
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 507
    Top = 176
  end
end
