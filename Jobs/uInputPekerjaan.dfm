object FinputPekerjaan: TFinputPekerjaan
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 598
  ClientWidth = 910
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
    Width = 910
    Height = 598
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
      910
      598)
    TMSStyle = 0
    object AdvSmoothPanel1: TAdvSmoothPanel
      Left = 0
      Top = 0
      Width = 910
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
        Width = 107
        Height = 25
        Caption = 'Pekerjaan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15987699
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object btnSimpan: TAdvSmoothButton
      Left = 209
      Top = 554
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
      Top = 554
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
      Width = 904
      Height = 489
      BorderColor = clGray
      RoundEdges = True
      Align = alTop
      ParentCtl3D = True
      TabOrder = 3
      object Label1: TLabel
        Left = 20
        Top = 24
        Width = 24
        Height = 13
        Caption = 'Divisi'
      end
      object Label2: TLabel
        Left = 20
        Top = 50
        Width = 48
        Height = 13
        Caption = 'Pekerjaan'
      end
      object Label9: TLabel
        Left = 20
        Top = 78
        Width = 53
        Height = 13
        Caption = 'Jenis Biaya'
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
      object cbDivisi: TAdvComboBox
        Left = 128
        Top = 21
        Width = 369
        Height = 21
        Color = clWindow
        Version = '1.9.1.0'
        Visible = True
        ButtonWidth = 17
        EmptyTextStyle = []
        DropWidth = 0
        Enabled = True
        ItemIndex = -1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        TabOrder = 0
      end
      object rbByComponent: TAdvOfficeRadioButton
        Left = 128
        Top = 77
        Width = 105
        Height = 20
        TabOrder = 2
        OnClick = rbByComponentClick
        Alignment = taLeftJustify
        Caption = 'By Component'
        ReturnIsTab = False
        Version = '1.5.0.9'
      end
      object rbByProduct: TAdvOfficeRadioButton
        Left = 500
        Top = 78
        Width = 105
        Height = 20
        TabOrder = 3
        OnClick = rbByProductClick
        Alignment = taLeftJustify
        Caption = 'By Item Product'
        ReturnIsTab = False
        Version = '1.5.0.9'
      end
      object G1: TAdvGroupBox
        Left = 20
        Top = 103
        Width = 229
        Height = 154
        Caption = 'Biaya Per Component'
        ParentCtl3D = True
        TabOrder = 4
        object Label4: TLabel
          Left = 12
          Top = 31
          Width = 26
          Height = 13
          Caption = 'Biaya'
        end
        object Label5: TLabel
          Left = 12
          Top = 58
          Width = 34
          Height = 13
          Caption = 'Satuan'
        end
        object Label6: TLabel
          Left = 12
          Top = 85
          Width = 75
          Height = 13
          Caption = 'Biaya Set Mesin'
        end
        object Label8: TLabel
          Left = 12
          Top = 112
          Width = 26
          Height = 13
          Caption = 'KOEF'
        end
        object Ebiaya: TAdvEdit
          Tag = 1
          Left = 116
          Top = 28
          Width = 105
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
        object Esatuan: TAdvEdit
          Tag = 1
          Left = 116
          Top = 55
          Width = 105
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
        object EbiayaSetMesin: TAdvEdit
          Tag = 1
          Left = 116
          Top = 82
          Width = 105
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
        object EKoef: TAdvEdit
          Tag = 1
          Left = 116
          Top = 107
          Width = 105
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
      end
      object G3: TAdvGroupBox
        Left = 500
        Top = 104
        Width = 353
        Height = 382
        Caption = 'Biaya Per Item Product'
        ParentCtl3D = True
        TabOrder = 5
        object sg: TAdvStringGrid
          AlignWithMargins = True
          Left = 6
          Top = 19
          Width = 341
          Height = 357
          Cursor = crDefault
          Align = alClient
          DrawingStyle = gdsClassic
          ScrollBars = ssBoth
          TabOrder = 0
          HoverRowCells = [hcNormal, hcSelected]
          OnCanEditCell = sgCanEditCell
          OnGetFloatFormat = sgGetFloatFormat
          ActiveCellFont.Charset = DEFAULT_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Tahoma'
          ActiveCellFont.Style = [fsBold]
          ControlLook.FixedGradientHoverFrom = clGray
          ControlLook.FixedGradientHoverTo = clWhite
          ControlLook.FixedGradientDownFrom = clGray
          ControlLook.FixedGradientDownTo = clSilver
          ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
          ControlLook.DropDownHeader.Font.Color = clWindowText
          ControlLook.DropDownHeader.Font.Height = -11
          ControlLook.DropDownHeader.Font.Name = 'Tahoma'
          ControlLook.DropDownHeader.Font.Style = []
          ControlLook.DropDownHeader.Visible = True
          ControlLook.DropDownHeader.Buttons = <>
          ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
          ControlLook.DropDownFooter.Font.Color = clWindowText
          ControlLook.DropDownFooter.Font.Height = -11
          ControlLook.DropDownFooter.Font.Name = 'Tahoma'
          ControlLook.DropDownFooter.Font.Style = []
          ControlLook.DropDownFooter.Visible = True
          ControlLook.DropDownFooter.Buttons = <>
          Filter = <>
          FilterDropDown.Font.Charset = DEFAULT_CHARSET
          FilterDropDown.Font.Color = clWindowText
          FilterDropDown.Font.Height = -11
          FilterDropDown.Font.Name = 'Tahoma'
          FilterDropDown.Font.Style = []
          FilterDropDown.TextChecked = 'Checked'
          FilterDropDown.TextUnChecked = 'Unchecked'
          FilterDropDownClear = '(All)'
          FilterEdit.TypeNames.Strings = (
            'Starts with'
            'Ends with'
            'Contains'
            'Not contains'
            'Equal'
            'Not equal'
            'Larger than'
            'Smaller than'
            'Clear')
          FixedRowHeight = 22
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -11
          FixedFont.Name = 'Tahoma'
          FixedFont.Style = [fsBold]
          FloatFormat = '%.2f'
          HoverButtons.Buttons = <>
          HoverButtons.Position = hbLeftFromColumnLeft
          HTMLSettings.ImageFolder = 'images'
          HTMLSettings.ImageBaseName = 'img'
          PrintSettings.DateFormat = 'dd/mm/yyyy'
          PrintSettings.Font.Charset = DEFAULT_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'Tahoma'
          PrintSettings.Font.Style = []
          PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
          PrintSettings.FixedFont.Color = clWindowText
          PrintSettings.FixedFont.Height = -11
          PrintSettings.FixedFont.Name = 'Tahoma'
          PrintSettings.FixedFont.Style = []
          PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
          PrintSettings.HeaderFont.Color = clWindowText
          PrintSettings.HeaderFont.Height = -11
          PrintSettings.HeaderFont.Name = 'Tahoma'
          PrintSettings.HeaderFont.Style = []
          PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
          PrintSettings.FooterFont.Color = clWindowText
          PrintSettings.FooterFont.Height = -11
          PrintSettings.FooterFont.Name = 'Tahoma'
          PrintSettings.FooterFont.Style = []
          PrintSettings.PageNumSep = '/'
          SearchFooter.FindNextCaption = 'Find &next'
          SearchFooter.FindPrevCaption = 'Find &previous'
          SearchFooter.Font.Charset = DEFAULT_CHARSET
          SearchFooter.Font.Color = clWindowText
          SearchFooter.Font.Height = -11
          SearchFooter.Font.Name = 'Tahoma'
          SearchFooter.Font.Style = []
          SearchFooter.HighLightCaption = 'Highlight'
          SearchFooter.HintClose = 'Close'
          SearchFooter.HintFindNext = 'Find next occurrence'
          SearchFooter.HintFindPrev = 'Find previous occurrence'
          SearchFooter.HintHighlight = 'Highlight occurrences'
          SearchFooter.MatchCaseCaption = 'Match case'
          SearchFooter.ResultFormat = '(%d of %d)'
          SortSettings.DefaultFormat = ssAutomatic
          Version = '8.4.2.2'
          RowHeights = (
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22)
        end
      end
      object RBSatuanProduk: TAdvOfficeRadioButton
        Left = 260
        Top = 78
        Width = 105
        Height = 20
        TabOrder = 6
        OnClick = RBSatuanProdukClick
        Alignment = taLeftJustify
        Caption = 'By Satuan Produk'
        ReturnIsTab = False
        Version = '1.5.0.9'
      end
      object G2: TAdvGroupBox
        Left = 255
        Top = 104
        Width = 229
        Height = 153
        Caption = 'Biaya Satuan Product'
        ParentCtl3D = True
        TabOrder = 7
        object Label10: TLabel
          Left = 12
          Top = 31
          Width = 34
          Height = 13
          Caption = 'Satuan'
        end
        object Label11: TLabel
          Left = 12
          Top = 58
          Width = 26
          Height = 13
          Caption = 'Biaya'
        end
        object Esatuan2: TAdvEdit
          Tag = 1
          Left = 116
          Top = 28
          Width = 105
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
        object Ebiaya2: TAdvEdit
          Tag = 1
          Left = 116
          Top = 55
          Width = 105
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
      end
    end
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 379
    Top = 8
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 427
    Top = 8
  end
  object Q3: TMyQuery
    Connection = MariaCon.con
    Left = 483
    Top = 8
  end
end
