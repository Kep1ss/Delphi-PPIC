object FinputMaterialRelease: TFinputMaterialRelease
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 541
  ClientWidth = 1266
  Color = 13619151
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSmoothPanel1: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 1246
    Height = 41
    Cursor = crDefault
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
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
    Fill.Color = clWhite
    Fill.ColorTo = clWhite
    Fill.ColorMirror = clWhite
    Fill.ColorMirrorTo = clWhite
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clNone
    Fill.Rounding = 5
    Fill.RoundingType = rtTop
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Version = '1.6.0.1'
    Align = alTop
    TabOrder = 0
    TMSStyle = 4
    object Label3: TLabel
      Left = 16
      Top = 2
      Width = 193
      Height = 33
      Caption = 'Material Release'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object AdvSmoothPanel2: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 10
    Top = 51
    Width = 1246
    Height = 166
    Cursor = crDefault
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    ResizeHandle = False
    Transparent = False
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
    Fill.Color = 14806254
    Fill.ColorTo = 14806254
    Fill.ColorMirror = 14806254
    Fill.ColorMirrorTo = 14806254
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clNone
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Version = '1.6.0.1'
    Align = alTop
    TabOrder = 1
    TMSStyle = 0
    object AdvGroupBox1: TAdvGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 1236
      Height = 156
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      BorderColor = clGray
      RoundEdges = True
      Align = alTop
      ParentCtl3D = True
      TabOrder = 0
      DesignSize = (
        1236
        156)
      object Label1: TLabel
        Left = 20
        Top = 24
        Width = 54
        Height = 13
        Caption = 'No Release'
      end
      object Label2: TLabel
        Left = 20
        Top = 126
        Width = 56
        Height = 13
        Caption = 'Keterangan'
      end
      object Label4: TLabel
        Left = 20
        Top = 51
        Width = 56
        Height = 13
        Caption = 'Work Order'
      end
      object Label5: TLabel
        Left = 20
        Top = 102
        Width = 24
        Height = 13
        Caption = 'Divisi'
      end
      object Label8: TLabel
        Left = 284
        Top = 23
        Width = 38
        Height = 13
        Caption = 'Tanggal'
      end
      object Label9: TLabel
        Left = 20
        Top = 78
        Width = 48
        Height = 13
        Caption = 'Pekerjaan'
      end
      object Label7: TLabel
        Left = 511
        Top = 78
        Width = 18
        Height = 13
        Caption = 'Qty'
      end
      object Label10: TLabel
        Left = 383
        Top = 78
        Width = 40
        Height = 13
        Caption = 'BOM NO'
      end
      object Enomer: TAdvEdit
        Left = 128
        Top = 21
        Width = 145
        Height = 21
        EditType = etNumeric
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
        Text = '0'
        Visible = True
        Version = '3.5.0.1'
      end
      object Eketerangan: TAdvEdit
        Left = 128
        Top = 123
        Width = 465
        Height = 21
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
        Version = '3.5.0.1'
      end
      object AdvSmoothButton2: TAdvSmoothButton
        Left = 511
        Top = 46
        Width = 82
        Height = 25
        Anchors = [akLeft, akBottom]
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = []
        Appearance.SimpleLayout = True
        Appearance.Rounding = 2
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
        Caption = 'Cari WO'
        Color = clGreen
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA793000001B2494441543811C5523D
          4B034110DD5903E1CCC568A1A2B1D1560BB1131541F02FF81B0236A28D90D2D2
          42041BFD05EA6FB0B2F0A3101B0BB510FC40244D30BBEE895E6E7CB3498EA810
          EC0CFB66DFBE999D9B9D8952FFFDA3F6029C73C52449C63573A15D6FF184E895
          88AE72B9DC734B4B13D85A6D1DCE0D383240A7F5C9CCE5B0A767330D32C62CBC
          1993386B57C0072263E6717E0676D220906AB5DA8B9855E889C4406A2C6BCC36
          C4D3C6A961ADB56BD05E1AA7EFF6CDDA73DCD912D5978B770CE1F008285C629C
          9714F3032B3528DA2F30DF23A628BA16D30E265A44B38EDBB59F1CBD3A43820F
          D17D05425A08C3F048B83346B6145CA98451363B2142E0DC9EEAEFFF14AEC574
          C0BBF85CAD36E382E086B53E15805FA38953E2EB9C80F900230BF0AC7D4574A1
          E37854D7EB63E097A289EFD713246B0AA213FF25A211D27A3AE8EB7B125F1445
          CB491CDFC337991101B805CA3201EC7E6102B297D02CDDE4CD4D6140EC799D28
          80DF0B19CC7D0EDDED925B2D64E2F82E5B28BCE0CF7323650325EF63DE4596D9
          EE301CF609BCD8C14813F1E643840C03B22C4C0E1F5CFD530204AB748C445D41
          3E7F81E7AEA0A2C12FDDDACB73C5C968A20000000049454E44AE426082}
        TabOrder = 2
        ShowFocus = False
        Version = '2.1.3.0'
        OnClick = AdvSmoothButton2Click
        TMSStyle = 0
      end
      object ENoWo: TAdvEdit
        Left = 128
        Top = 48
        Width = 97
        Height = 21
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
        OnChange = ENoWoChange
        Version = '3.5.0.1'
      end
      object EDeskripsi: TAdvEdit
        Left = 231
        Top = 48
        Width = 274
        Height = 21
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
        Version = '3.5.0.1'
      end
      object cbDivisi: TAdvComboBox
        Left = 128
        Top = 99
        Width = 465
        Height = 21
        Color = clWindow
        Version = '1.9.4.0'
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
        TabOrder = 5
        OnChange = cbDivisiChange
      end
      object dtRelease: TDateTimePicker
        Left = 332
        Top = 21
        Width = 109
        Height = 21
        Date = 44140.000000000000000000
        Time = 0.892900902777910200
        TabOrder = 6
      end
      object cbJOBS: TAdvGridDropDown
        Left = 128
        Top = 75
        Width = 249
        Height = 21
        LineColor = 15855083
        FixedLineColor = clSilver
        ColumnSizeWithDropDown = False
        Columns = <
          item
            Width = 100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Header = 'Item No'
          end
          item
            Width = 200
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Header = 'Keterangan'
          end
          item
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Header = 'Qty'
          end
          item
            Width = 100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Header = 'No SO'
          end
          item
            Width = 120
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Header = 'BOM NO'
          end>
        HeaderColor = clWhite
        HeaderColorTo = clGray
        HeaderHeight = 25
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = 7485192
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        Items = <
          item
            Text.Strings = (
              'JON LENON'
              'BAGONG'
              'MADANG')
          end
          item
            Text.Strings = (
              'OKE'
              'BRO'
              'DOWN'
              'KE')
          end
          item
          end
          item
          end
          item
          end>
        LookupColumn = 1
        Navigation.HomeEndKey = heFirstLastRow
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
        Style = dsDropDown
        DropDownBorderColor = clNone
        DropDownHeight = 200
        LabelMargin = 0
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Version = '6.1.1.0'
        SelectionColor = 14155773
        SelectionColorTo = 5821692
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
        TabOrder = 7
        OnChange = cbJOBSChange
        SelectionColorStyle = 1
        TMSStyle = 4
      end
      object EQty: TAdvEdit
        Left = 535
        Top = 75
        Width = 58
        Height = 21
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
        TabOrder = 8
        Text = ''
        Visible = True
        Version = '3.5.0.1'
      end
      object EBomNo: TAdvEdit
        Left = 429
        Top = 75
        Width = 76
        Height = 21
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
        TabOrder = 9
        Text = ''
        Visible = True
        Version = '3.5.0.1'
      end
    end
  end
  object AdvSmoothPanel3: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 10
    Top = 443
    Width = 1251
    Height = 88
    Cursor = crDefault
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 5
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
    Fill.Color = 14806254
    Fill.ColorTo = 14806254
    Fill.ColorMirror = 14806254
    Fill.ColorMirrorTo = 14806254
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = clNone
    Fill.Rounding = 5
    Fill.RoundingType = rtBottom
    Fill.ShadowOffset = 6
    Fill.Glow = gmNone
    Version = '1.6.0.1'
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      1251
      88)
    TMSStyle = 4
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1245
      Height = 32
      Align = alTop
      Shape = bsBottomLine
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 1257
    end
    object btnTutup: TAdvSmoothButton
      Left = 1110
      Top = 45
      Width = 118
      Height = 33
      Anchors = [akRight, akBottom]
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
      Caption = 'Selesai'
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
      TabOrder = 0
      ShowFocus = False
      Version = '2.1.3.0'
      OnClick = btnTutupClick
      TMSStyle = 0
    end
    object btnSimpan: TAdvSmoothButton
      Left = 988
      Top = 45
      Width = 116
      Height = 33
      Anchors = [akRight, akBottom]
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
      Version = '2.1.3.0'
      OnClick = btnSimpanClick
      TMSStyle = 0
    end
  end
  object sgMaterial: TAdvStringGrid
    AlignWithMargins = True
    Left = 10
    Top = 220
    Width = 1246
    Height = 220
    Cursor = crDefault
    Margins.Left = 10
    Margins.Right = 10
    Align = alClient
    DrawingStyle = gdsClassic
    ScrollBars = ssBoth
    TabOrder = 3
    HoverRowCells = [hcNormal, hcSelected]
    OnCanEditCell = sgPekerjaanCanEditCell
    OnGetFloatFormat = sgPekerjaanGetFloatFormat
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
    Version = '8.4.7.0'
  end
  object QM1: TZQuery
    SQL.Strings = (
      'select * from item')
    Params = <>
    Left = 352
    Top = 227
  end
  object DataSource1: TDataSource
    DataSet = ZTable1
    Left = 402
    Top = 228
  end
  object ZTable1: TZTable
    TableName = 'item'
    Left = 506
    Top = 252
  end
end
