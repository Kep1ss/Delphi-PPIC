object FinputBom: TFinputBom
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
    Version = '1.5.2.4'
    Align = alTop
    TabOrder = 0
    TMSStyle = 4
    object Label3: TLabel
      Left = 16
      Top = 2
      Width = 168
      Height = 33
      Caption = 'Bill of Material'
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
    Height = 150
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
    Version = '1.5.2.4'
    Align = alTop
    TabOrder = 1
    TMSStyle = 0
    object AdvGroupBox1: TAdvGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 1236
      Height = 140
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
        140)
      object Label1: TLabel
        Left = 20
        Top = 24
        Width = 42
        Height = 13
        Caption = 'BOM. No'
      end
      object Label2: TLabel
        Left = 20
        Top = 50
        Width = 56
        Height = 13
        Caption = 'Keterangan'
      end
      object Label4: TLabel
        Left = 20
        Top = 84
        Width = 97
        Height = 13
        Caption = 'Produk Referensi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 20
        Top = 112
        Width = 78
        Height = 13
        Caption = 'Deskripsi Produk'
      end
      object Enomer: TAdvEdit
        Left = 128
        Top = 21
        Width = 209
        Height = 21
        DefaultHandling = True
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
        Enabled = False
        TabOrder = 0
        Text = '0'
        Visible = True
        Version = '3.4.7.0'
      end
      object Enama: TAdvEdit
        Left = 128
        Top = 47
        Width = 465
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
      object Eitemno: TAdvEdit
        Left = 128
        Top = 109
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
        TabOrder = 2
        Text = ''
        Visible = True
        Version = '3.4.7.0'
      end
      object Enamabarang: TAdvEdit
        Left = 215
        Top = 109
        Width = 290
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
      object AdvSmoothButton2: TAdvSmoothButton
        Left = 511
        Top = 106
        Width = 98
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
        Caption = 'Cari Product '
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
        TabOrder = 4
        ShowFocus = False
        Version = '2.1.1.9'
        OnClick = AdvSmoothButton2Click
        TMSStyle = 0
      end
      object AdvSmoothButton1: TAdvSmoothButton
        Left = 1128
        Top = 109
        Width = 100
        Height = 25
        Anchors = [akRight, akBottom]
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
        Caption = 'Import BOM'
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
        TabOrder = 5
        Visible = False
        ShowFocus = False
        Version = '2.1.1.9'
        OnClick = AdvSmoothButton1Click
        TMSStyle = 0
      end
      object AdvSmoothButton3: TAdvSmoothButton
        Left = 615
        Top = 106
        Width = 98
        Height = 25
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
        Caption = 'Cari Material'
        Color = 15901696
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
        TabOrder = 6
        ShowFocus = False
        Version = '2.1.1.9'
        OnClick = AdvSmoothButton3Click
        TMSStyle = 0
      end
      object AdvSmoothButton4: TAdvSmoothButton
        Left = 717
        Top = 106
        Width = 82
        Height = 25
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
        Caption = 'Cari Biaya'
        Color = 4605695
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
        TabOrder = 7
        ShowFocus = False
        Version = '2.1.1.9'
        OnClick = AdvSmoothButton4Click
        TMSStyle = 0
      end
    end
  end
  object Pg: TAdvPageControl
    AlignWithMargins = True
    Left = 270
    Top = 206
    Width = 986
    Height = 227
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 10
    ActivePage = AdvTabSheet2
    ActiveFont.Charset = DEFAULT_CHARSET
    ActiveFont.Color = clWindowText
    ActiveFont.Height = -11
    ActiveFont.Name = 'Tahoma'
    ActiveFont.Style = []
    Align = alClient
    DoubleBuffered = True
    ParentShowHint = False
    ShowHint = False
    ShowFocus = True
    TabBorderColor = clSilver
    TabBackGroundColor = clBtnFace
    TabMargin.RightMargin = 0
    TabOverlap = 0
    RoundEdges = True
    TabStyle = tsDelphi
    Version = '2.0.1.5'
    PersistPagesState.Location = plRegistry
    PersistPagesState.Enabled = False
    TabOrder = 2
    object AdvTabSheet1: TAdvTabSheet
      Caption = 'Material'
      Color = 13619151
      ColorTo = clNone
      TabColor = clBtnFace
      TabColorTo = clNone
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sgMaterial: TAdvStringGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 972
        Height = 193
        Cursor = crDefault
        Align = alClient
        DrawingStyle = gdsClassic
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyDown = sgMaterialKeyDown
        OnKeyUp = sgMaterialKeyUp
        HoverRowCells = [hcNormal, hcSelected]
        OnCanEditCell = sgMaterialCanEditCell
        OnCellsChanged = sgMaterialCellsChanged
        OnGetFloatFormat = sgMaterialGetFloatFormat
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
        FloatFormat = '%.4f'
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
    object AdvTabSheet2: TAdvTabSheet
      Caption = 'Biaya Tenaga Kerja'
      Color = 13619151
      ColorTo = clNone
      TabColor = clBtnFace
      TabColorTo = clNone
      object sgPekerjaan: TAdvStringGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 972
        Height = 193
        Cursor = crDefault
        Align = alClient
        DrawingStyle = gdsClassic
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyDown = sgPekerjaanKeyDown
        OnKeyUp = sgPekerjaanKeyUp
        HoverRowCells = [hcNormal, hcSelected]
        OnCanEditCell = sgPekerjaanCanEditCell
        OnCellsChanged = sgPekerjaanCellsChanged
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
        FloatFormat = '%.4n'
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
    Version = '1.5.2.4'
    Align = alBottom
    TabOrder = 3
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
    object Label6: TLabel
      Left = 656
      Top = 11
      Width = 249
      Height = 13
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Total Material :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LtotalMaterial: TLabel
      Left = 911
      Top = 11
      Width = 7
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 8
      Width = 299
      Height = 13
      Caption = '* Untuk Menghapus Item tekan tombol DELETE pada keyboard'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LtotalBiaya: TLabel
      Left = 1143
      Top = 11
      Width = 7
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 988
      Top = 11
      Width = 149
      Height = 13
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Total Biaya :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnTutup: TAdvSmoothButton
      Left = 1110
      Top = 41
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
      Version = '2.1.1.9'
      OnClick = btnTutupClick
      TMSStyle = 0
    end
    object btnSimpan: TAdvSmoothButton
      Left = 988
      Top = 41
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
      Version = '2.1.1.9'
      OnClick = btnSimpanClick
      TMSStyle = 0
    end
  end
  object lb1: TAdvSmoothListBox
    AlignWithMargins = True
    Left = 10
    Top = 204
    Width = 250
    Height = 229
    Cursor = crDefault
    Margins.Left = 10
    Margins.Right = 0
    Margins.Bottom = 10
    Fill.Color = clGray
    Fill.ColorMirror = clGray
    Fill.ColorMirrorTo = clGray
    Fill.GradientType = gtSolid
    Fill.GradientMirrorType = gtSolid
    Fill.BorderColor = clGray
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Items = <>
    ItemAppearance.FillAlternate.Color = 16773091
    ItemAppearance.FillAlternate.ColorTo = 16768452
    ItemAppearance.FillAlternate.ColorMirror = 16765357
    ItemAppearance.FillAlternate.ColorMirrorTo = 16767936
    ItemAppearance.FillAlternate.GradientType = gtVertical
    ItemAppearance.FillAlternate.GradientMirrorType = gtVertical
    ItemAppearance.FillAlternate.BorderColor = 16765357
    ItemAppearance.FillAlternate.Rounding = 0
    ItemAppearance.FillAlternate.ShadowOffset = 0
    ItemAppearance.FillAlternate.Glow = gmNone
    ItemAppearance.Fill.Color = clGray
    ItemAppearance.Fill.ColorMirror = clGray
    ItemAppearance.Fill.ColorMirrorTo = clGray
    ItemAppearance.Fill.GradientType = gtVertical
    ItemAppearance.Fill.GradientMirrorType = gtVertical
    ItemAppearance.Fill.BorderColor = clGray
    ItemAppearance.Fill.Rounding = 0
    ItemAppearance.Fill.ShadowOffset = 0
    ItemAppearance.Fill.Glow = gmNone
    ItemAppearance.FillSelected.Color = 11196927
    ItemAppearance.FillSelected.ColorTo = 7257087
    ItemAppearance.FillSelected.ColorMirror = 4370174
    ItemAppearance.FillSelected.ColorMirrorTo = 8053246
    ItemAppearance.FillSelected.GradientType = gtVertical
    ItemAppearance.FillSelected.GradientMirrorType = gtVertical
    ItemAppearance.FillSelected.BorderColor = 16765357
    ItemAppearance.FillSelected.Rounding = 0
    ItemAppearance.FillSelected.ShadowOffset = 0
    ItemAppearance.FillSelected.Glow = gmNone
    ItemAppearance.FillSelectedAlternate.Color = 11196927
    ItemAppearance.FillSelectedAlternate.ColorTo = 7257087
    ItemAppearance.FillSelectedAlternate.ColorMirror = 4370174
    ItemAppearance.FillSelectedAlternate.ColorMirrorTo = 8053246
    ItemAppearance.FillSelectedAlternate.GradientType = gtVertical
    ItemAppearance.FillSelectedAlternate.GradientMirrorType = gtVertical
    ItemAppearance.FillSelectedAlternate.BorderColor = 16765357
    ItemAppearance.FillSelectedAlternate.Rounding = 0
    ItemAppearance.FillSelectedAlternate.ShadowOffset = 0
    ItemAppearance.FillSelectedAlternate.Glow = gmNone
    ItemAppearance.FillDisabled.Color = 15921906
    ItemAppearance.FillDisabled.ColorTo = 11974326
    ItemAppearance.FillDisabled.ColorMirror = 11974326
    ItemAppearance.FillDisabled.ColorMirrorTo = 15921906
    ItemAppearance.FillDisabled.GradientType = gtVertical
    ItemAppearance.FillDisabled.GradientMirrorType = gtVertical
    ItemAppearance.FillDisabled.BorderColor = 16765357
    ItemAppearance.FillDisabled.Rounding = 0
    ItemAppearance.FillDisabled.ShadowOffset = 0
    ItemAppearance.FillDisabled.Glow = gmNone
    ItemAppearance.ProgressAppearance.BackGroundFill.Color = 16765615
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorTo = 16765615
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirror = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
    ItemAppearance.ProgressAppearance.BackGroundFill.GradientType = gtVertical
    ItemAppearance.ProgressAppearance.BackGroundFill.GradientMirrorType = gtSolid
    ItemAppearance.ProgressAppearance.BackGroundFill.BorderColor = clSilver
    ItemAppearance.ProgressAppearance.BackGroundFill.Rounding = 0
    ItemAppearance.ProgressAppearance.BackGroundFill.ShadowOffset = 0
    ItemAppearance.ProgressAppearance.BackGroundFill.Glow = gmNone
    ItemAppearance.ProgressAppearance.ProgressFill.Color = 16773091
    ItemAppearance.ProgressAppearance.ProgressFill.ColorTo = 16768452
    ItemAppearance.ProgressAppearance.ProgressFill.ColorMirror = 16765357
    ItemAppearance.ProgressAppearance.ProgressFill.ColorMirrorTo = 16767936
    ItemAppearance.ProgressAppearance.ProgressFill.GradientType = gtVertical
    ItemAppearance.ProgressAppearance.ProgressFill.GradientMirrorType = gtVertical
    ItemAppearance.ProgressAppearance.ProgressFill.BorderColor = 16765357
    ItemAppearance.ProgressAppearance.ProgressFill.Rounding = 0
    ItemAppearance.ProgressAppearance.ProgressFill.ShadowOffset = 0
    ItemAppearance.ProgressAppearance.ProgressFill.Glow = gmNone
    ItemAppearance.ProgressAppearance.Font.Charset = DEFAULT_CHARSET
    ItemAppearance.ProgressAppearance.Font.Color = clWindowText
    ItemAppearance.ProgressAppearance.Font.Height = -11
    ItemAppearance.ProgressAppearance.Font.Name = 'Tahoma'
    ItemAppearance.ProgressAppearance.Font.Style = []
    ItemAppearance.ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
    ItemAppearance.ProgressAppearance.ProgressFont.Color = clWindowText
    ItemAppearance.ProgressAppearance.ProgressFont.Height = -11
    ItemAppearance.ProgressAppearance.ProgressFont.Name = 'Tahoma'
    ItemAppearance.ProgressAppearance.ProgressFont.Style = []
    ItemAppearance.ProgressAppearance.ValueFormat = '%.0f%%'
    ItemAppearance.ButtonAppearance.Font.Charset = DEFAULT_CHARSET
    ItemAppearance.ButtonAppearance.Font.Color = clWindowText
    ItemAppearance.ButtonAppearance.Font.Height = -11
    ItemAppearance.ButtonAppearance.Font.Name = 'Tahoma'
    ItemAppearance.ButtonAppearance.Font.Style = []
    ItemAppearance.ButtonAppearance.WordWrapping = False
    ItemAppearance.InfoFill.ColorMirror = clNone
    ItemAppearance.InfoFill.ColorMirrorTo = clNone
    ItemAppearance.InfoFill.GradientType = gtVertical
    ItemAppearance.InfoFill.GradientMirrorType = gtSolid
    ItemAppearance.InfoFill.BorderColor = clNone
    ItemAppearance.InfoFill.Rounding = 0
    ItemAppearance.InfoFill.ShadowOffset = 0
    ItemAppearance.InfoFill.Glow = gmNone
    ItemAppearance.InfoFillSelected.ColorMirror = clNone
    ItemAppearance.InfoFillSelected.ColorMirrorTo = clNone
    ItemAppearance.InfoFillSelected.GradientType = gtVertical
    ItemAppearance.InfoFillSelected.GradientMirrorType = gtSolid
    ItemAppearance.InfoFillSelected.BorderColor = clNone
    ItemAppearance.InfoFillSelected.Rounding = 0
    ItemAppearance.InfoFillSelected.ShadowOffset = 0
    ItemAppearance.InfoFillSelected.Glow = gmNone
    ItemAppearance.InfoFillDisabled.ColorMirror = clNone
    ItemAppearance.InfoFillDisabled.ColorMirrorTo = clNone
    ItemAppearance.InfoFillDisabled.GradientType = gtVertical
    ItemAppearance.InfoFillDisabled.GradientMirrorType = gtSolid
    ItemAppearance.InfoFillDisabled.BorderColor = clNone
    ItemAppearance.InfoFillDisabled.Rounding = 0
    ItemAppearance.InfoFillDisabled.ShadowOffset = 0
    ItemAppearance.InfoFillDisabled.Glow = gmNone
    ItemAppearance.DeleteButtonCaption = 'Delete'
    ItemAppearance.DeleteButtonFont.Charset = DEFAULT_CHARSET
    ItemAppearance.DeleteButtonFont.Color = clWhite
    ItemAppearance.DeleteButtonFont.Height = -11
    ItemAppearance.DeleteButtonFont.Name = 'Tahoma'
    ItemAppearance.DeleteButtonFont.Style = [fsBold]
    LookupBar.DisabledFont.Charset = DEFAULT_CHARSET
    LookupBar.DisabledFont.Color = clSilver
    LookupBar.DisabledFont.Height = -11
    LookupBar.DisabledFont.Name = 'Tahoma'
    LookupBar.DisabledFont.Style = []
    LookupBar.Font.Charset = DEFAULT_CHARSET
    LookupBar.Font.Color = clWindowText
    LookupBar.Font.Height = -11
    LookupBar.Font.Name = 'Tahoma'
    LookupBar.Font.Style = []
    LookupBar.Visible = False
    Sections.Font.Charset = DEFAULT_CHARSET
    Sections.Font.Color = clWindowText
    Sections.Font.Height = -11
    Sections.Font.Name = 'Tahoma'
    Sections.Font.Style = []
    Sections.BorderColor = clBlack
    SelectedItemIndex = -1
    Header.Fill.Color = clGray
    Header.Fill.ColorMirror = clGray
    Header.Fill.ColorMirrorTo = clGray
    Header.Fill.GradientType = gtVertical
    Header.Fill.GradientMirrorType = gtSolid
    Header.Fill.BorderColor = clSilver
    Header.Fill.Rounding = 0
    Header.Fill.ShadowOffset = 0
    Header.Fill.Glow = gmNone
    Header.Caption = 'DIVISI'
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWhite
    Header.Font.Height = -13
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Filter.Fill.Color = 16773091
    Filter.Fill.ColorMirror = clNone
    Filter.Fill.ColorMirrorTo = clNone
    Filter.Fill.GradientType = gtSolid
    Filter.Fill.GradientMirrorType = gtSolid
    Filter.Fill.BorderColor = 16765615
    Filter.Fill.Rounding = 0
    Filter.Fill.ShadowOffset = 0
    Filter.Fill.Glow = gmNone
    Footer.Fill.Color = 16773091
    Footer.Fill.ColorTo = 16765615
    Footer.Fill.ColorMirror = clNone
    Footer.Fill.ColorMirrorTo = clNone
    Footer.Fill.GradientType = gtVertical
    Footer.Fill.GradientMirrorType = gtSolid
    Footer.Fill.BorderColor = 16765615
    Footer.Fill.Rounding = 0
    Footer.Fill.ShadowOffset = 0
    Footer.Fill.Glow = gmNone
    Footer.Caption = 'Footer'
    Footer.Font.Charset = DEFAULT_CHARSET
    Footer.Font.Color = 7485192
    Footer.Font.Height = -13
    Footer.Font.Name = 'Tahoma'
    Footer.Font.Style = []
    Footer.Visible = False
    OnItemClick = Lb1ItemClick
    DefaultItem.Caption = 'Item 0'
    DefaultItem.ProgressMaximum = 100.000000000000000000
    Categories = <>
    TextRendering = tAntiAlias
    Align = alLeft
    TabOrder = 4
    TMSStyle = 4
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 479
    Top = 80
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 535
    Top = 80
  end
  object Q3: TMyQuery
    Connection = MariaCon.con
    Left = 591
    Top = 80
  end
end
