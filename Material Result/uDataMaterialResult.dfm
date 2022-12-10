object FDataMaterialResult: TFDataMaterialResult
  Left = 0
  Top = 0
  Caption = 'Data Material Result'
  ClientHeight = 459
  ClientWidth = 923
  Color = 13619151
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    923
    459)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 22
    Width = 78
    Height = 24
    Caption = 'Material'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 108
    Top = 28
    Width = 39
    Height = 16
    Caption = 'Result'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object P1: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 25
    Top = 50
    Width = 878
    Height = 389
    Cursor = crDefault
    Margins.Left = 25
    Margins.Top = 50
    Margins.Right = 20
    Margins.Bottom = 20
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
    Fill.Color = 15921906
    Fill.ColorTo = 15921906
    Fill.ColorMirror = 15921906
    Fill.ColorMirrorTo = 15921906
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 15921906
    Fill.Rounding = 5
    Fill.ShadowOffset = 5
    Fill.Glow = gmNone
    Version = '1.6.0.1'
    Align = alClient
    TabOrder = 1
    DesignSize = (
      878
      389)
    TMSStyle = 4
    object Label5: TLabel
      Left = 16
      Top = 58
      Width = 32
      Height = 16
      Caption = 'Show'
      Color = 11053224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4868682
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 134
      Top = 58
      Width = 39
      Height = 16
      Caption = 'Entries'
      Color = 50688
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4868682
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 592
      Top = 58
      Width = 49
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Search :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4868682
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Lentries: TLabel
      Left = 16
      Top = 345
      Width = 176
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = 'Showing 1 to 10 of 100 entries'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4868682
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 330
    end
    object AdvSmoothPanel1: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 873
      Height = 41
      Cursor = crDefault
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 5
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
        Width = 13
        Height = 36
        Caption = 'i'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -27
        Font.Name = 'Ravie'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 37
        Top = 16
        Width = 469
        Height = 13
        Caption = 
          'Gunakan button di sebelah kanan setiap baris tabel untuk menuju ' +
          'instruksi edit dan hapus data ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object cbEntries: TAdvComboBox
      Left = 56
      Top = 55
      Width = 72
      Height = 24
      Color = clWindow
      Version = '1.9.4.0'
      Visible = True
      ButtonWidth = 17
      EmptyTextStyle = []
      Etched = True
      DropWidth = 0
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        '10'
        '25'
        '50'
        '100')
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '10'
      OnChange = cbEntriesChange
    end
    object Ecari: TAdvEdit
      Left = 647
      Top = 55
      Width = 212
      Height = 24
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
      Anchors = [akTop, akRight]
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      Visible = True
      OnKeyUp = EcariKeyUp
      Version = '3.5.0.1'
    end
    object AdvSmoothPanel2: TAdvSmoothPanel
      Left = 16
      Top = 96
      Width = 839
      Height = 233
      Cursor = crDefault
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
      Fill.Color = 15921906
      Fill.ColorTo = 15921906
      Fill.ColorMirror = 15921906
      Fill.ColorMirrorTo = 15921906
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.BorderColor = 14737632
      Fill.Rounding = 5
      Fill.ShadowOffset = 0
      Fill.Glow = gmNone
      Version = '1.6.0.1'
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 3
      TMSStyle = 4
      object sg: TAdvStringGrid
        AlignWithMargins = True
        Left = 5
        Top = 10
        Width = 824
        Height = 213
        Cursor = crDefault
        Margins.Left = 5
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alClient
        BorderStyle = bsNone
        Color = 15921906
        Ctl3D = False
        DefaultRowHeight = 30
        DrawingStyle = gdsGradient
        FixedColor = 15921906
        FixedCols = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5789784
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssBoth
        ShowHint = True
        TabOrder = 0
        GridFixedLineColor = clSilver
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = sgGetAlignment
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 15387318
        ControlLook.FixedGradientFrom = clWhite
        ControlLook.FixedGradientTo = clBtnFace
        ControlLook.FixedGradientHoverFrom = 13619409
        ControlLook.FixedGradientHoverTo = 12502728
        ControlLook.FixedGradientHoverMirrorFrom = 12502728
        ControlLook.FixedGradientHoverMirrorTo = 11254975
        ControlLook.FixedGradientDownFrom = 8816520
        ControlLook.FixedGradientDownTo = 7568510
        ControlLook.FixedGradientDownMirrorFrom = 7568510
        ControlLook.FixedGradientDownMirrorTo = 6452086
        ControlLook.ControlStyle = csWinXP
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
        FixedRowHeight = 30
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = 4868682
        FixedFont.Height = -11
        FixedFont.Name = 'Segoe UI'
        FixedFont.Style = [fsBold]
        Flat = True
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
        SearchFooter.ColorTo = 15790320
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
        SelectionColor = 12713860
        SortSettings.DefaultFormat = ssAutomatic
        Version = '8.4.7.0'
        WordWrap = False
        ColWidths = (
          64
          64
          64
          64
          571)
      end
    end
    object pPagination: TAdvSmoothPanel
      Left = 680
      Top = 335
      Width = 170
      Height = 28
      Cursor = crDefault
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
      Fill.Color = 15921906
      Fill.ColorTo = 15921906
      Fill.ColorMirror = 15921906
      Fill.ColorMirrorTo = 15921906
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.BorderColor = 15921906
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Glow = gmNone
      Version = '1.6.0.1'
      Anchors = [akRight, akBottom]
      TabOrder = 4
      TMSStyle = 4
      object btnNext: TAdvSmoothButton
        Left = 89
        Top = 0
        Width = 81
        Height = 28
        Align = alRight
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clGray
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = []
        Appearance.SimpleLayout = True
        Appearance.SimpleLayoutBorder = True
        Appearance.Rounding = 3
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
        Caption = 'Next'
        Color = clGreen
        ParentFont = False
        DisabledColor = clGreen
        DisabledFontColor = clWhite
        TabOrder = 0
        Enabled = False
        Version = '2.1.3.0'
        TMSStyle = 0
      end
      object btnPriv: TAdvSmoothButton
        Left = 8
        Top = 0
        Width = 81
        Height = 28
        Align = alRight
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = 7405793
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = []
        Appearance.SimpleLayout = True
        Appearance.SimpleLayoutBorder = True
        Appearance.Rounding = 3
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
        Caption = 'Previos'
        Color = 16744576
        ParentFont = False
        DisabledColor = clGreen
        DisabledFontColor = clWhite
        TabOrder = 1
        Enabled = False
        Version = '2.1.3.0'
        TMSStyle = 0
      end
    end
  end
  object btnAdd: TAdvSmoothButton
    Left = 742
    Top = 8
    Width = 159
    Height = 31
    Anchors = [akTop, akRight]
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
    Caption = 'Add Material Result'
    Color = clGreen
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
      00206348524D00007A26000080840000FA00000080E8000075300000EA600000
      3A98000017709CBA513C000000CD49444154384FAD53CB0AC23010AC7E88E8C9
      D7D7792A22FA236DAFA25150F1DB444F89339084350D89B5068696CDECEC6E32
      298A7F2F63CC406BBD04764065B1C577C1BD643D9026C0197881FCB118034E08
      8EA32236F91E2646846E2D110486800AC8CA550AF750ECC01CDF0902F348DB29
      018E3893021B519D9D2808AE1C81FFB60BDF25626B29503B81DCAD3A1E6F470A
      347D05FA8DC003414BCF0EB7F0007FEA47B0EE3B7610D8B75C89C008AAD72F8C
      742137E5C6DFAC2C5CC7C7446395406351F29CB28F29E781D8FE1BB27914D3F7
      DC25F60000000049454E44AE426082}
    Shadow = True
    TabOrder = 0
    ShowFocus = False
    Version = '2.1.3.0'
    OnClick = btnAddClick
    TMSStyle = 0
  end
  object AdvSmoothButton3: TAdvSmoothButton
    Left = 452
    Top = 8
    Width = 119
    Height = 31
    Anchors = [akTop, akRight]
    Appearance.GlowPercentage = 0
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
    BevelColor = clPurple
    Caption = 'Export'
    Color = clGreen
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
      00206348524D00007A26000080840000FA00000080E8000075300000EA600000
      3A98000017709CBA513C0000016D49444154384FA5D3BB4BC35018C6E124A220
      D241F0D6C1C149C441115C74E8AAB3FE0B6E2E220A824EE2263A3988E8E420A2
      0E0511C1A94B17EB5004AF9B451CA482375A2B89BF174EE349B02E2D3C7C395F
      4FDE9C938BEB989FEFFB090E3B5CD74D52DB8220E8A3F6631869CFF3E6AA7323
      951327B18C63E4F0883201E18FF12683566AA7A59D5EA3634FAC75AC0064E2FF
      D3DBA937E0300C20ED1ED7BA0AF50B7914CD582B98C51EA68D376A24608DC600
      9E718214279F5B0167F44A783728D1801B1A4398C2089650B10256182B441792
      CF78C0378D75B4A0074FD59BC6B19EC23EB5006D4D2AF10035149040371EEC00
      C61BC829C884693B917B7041A3178B18C50C4AD616B6185F42EF8B94E301BACB
      E3D056D248216B059C32FE40D1A044577047A3604ED0F2AEF06205CC333E302B
      D3EAF4347EB7F0DF1BC9C45A6F62DD01DB0EE913D0C774840C6EF11AFF98E835
      438F38C49C86F0CB64D0842E0C32690C0BD83581AB7F7ECA347F0074386A2A55
      A7B3440000000049454E44AE426082}
    Shadow = True
    TabOrder = 2
    ShowFocus = False
    Version = '2.1.3.0'
    OnClick = AdvSmoothButton3Click
    TMSStyle = 0
  end
  object AdvSmoothButton1: TAdvSmoothButton
    Left = 577
    Top = 8
    Width = 159
    Height = 31
    Anchors = [akTop, akRight]
    Appearance.GlowPercentage = 0
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
    BevelColor = clPurple
    Caption = 'Print Material Release'
    Color = clGreen
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000015000000150806000000A917A5
      9600000006624B474400FF00FF00FFA0BDA79300000168494441543811D5543B
      4EC340109D599012C5B64489A04229E8A852D0213A4A8E80C4055272044A0E10
      291C838ED021210E0012940851217BED90821DDE2EB2E4CF1AE32805AC66BC33
      EFCD3CAF67A310FD97C5BE836AAD8FC8984D1F57C2947A0DC3F0AA84215987D7
      4DE48C990FEA441911911B2035510570E5E63F29F3D8886CB4BD0D5FF3DE56B3
      329E73A5344D47B89C0BE423780FFE5B5BA0F08E941A0741708F989C2806DECF
      B47E02B005EF6442F408911D34BD0DC27088912CDC45CDE3780F606741267A08
      A36817BD53F876966556879CE8A75203809D4D8886A9D613341EC3313D13D8DD
      7FFB60708A5B12B1F342E631E61E44F751735A651B456D83613EAC36E4393EF1
      3A8FAB7BA3A82D8CA268460D2B4D920686C889AE193317A59E0B55F6D2FA85BC
      29FC00F1027766755CE07BE82499E124E2E372CCF2B62ECF8BBB3B691128C63A
      8E4F6889F5A3287EC8D32534BF675A6B643E17632EA96DE1FFB4ADE46FF35F8B
      F667D8155D6A3B0000000049454E44AE426082}
    Shadow = True
    TabOrder = 3
    ShowFocus = False
    Version = '2.1.3.0'
    OnClick = AdvSmoothButton1Click
    TMSStyle = 0
  end
  object AdvGridExcelIO1: TAdvGridExcelIO
    AdvStringGrid = sg
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportRawRTF = False
    Options.ExportShowInExcel = True
    Options.ExportHardBorders = True
    Options.ExportCellMargins = True
    UseUnicode = True
    GridStartRow = 0
    GridStartCol = 0
    Version = '3.14'
    Left = 456
    Top = 24
  end
  object QFB1: TZQuery
    Params = <>
    Left = 152
    Top = 8
  end
  object QMasterRelease: TZQuery
    Connection = MariaCon.ZMy
    SQL.Strings = (
      'SELECT '
      ' r.id,'
      '  r.no_release,'
      '  r.tgl,'
      '  w.no_wo,'
      '  d.name,'
      '  w.deskripsi,'
      '  r.keterangan '
      'FROM'
      '  material_release r '
      '  LEFT JOIN wo w '
      '    ON w.`id` = r.`id_wo` '
      '  LEFT JOIN divisi d '
      '    ON d.id = r.`id_divisi` ')
    Params = <>
    Left = 353
    Top = 170
  end
  object QDetailRelease: TZQuery
    Connection = MariaCon.ZMy
    SQL.Strings = (
      'SELECT '
      '  rd.id_material_release,'
      '  rd.item_id,'
      '  i.itemno,'
      '  i.description,'
      '  rd.qty,'
      '  rd.unit,'
      '  rd.notes '
      'FROM'
      '  material_release_detail rd '
      '  LEFT JOIN item i '
      '    ON i.id = rd.item_id ')
    Params = <>
    MasterFields = 'id'
    MasterSource = DMasterRelease
    LinkedFields = 'id_material_release'
    Left = 473
    Top = 170
  end
  object frxReport1: TfrxReport
    Version = '6.6.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44125.684827685200000000
    ReportOptions.LastChange = 44149.471375613420000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 350
    Top = 100
    Datasets = <
      item
        DataSet = frDetailMasterRelease
        DataSetName = 'frDetailMasterRelease'
      end
      item
        DataSet = frMasterRelease
        DataSetName = 'frMasterRelease'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 37.795300000000000000
        Top = 22.677180000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 230.551330000000000000
          Top = 7.559060000000000000
          Width = 257.008040000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Material Release')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 113.385900000000000000
        Top = 83.149660000000000000
        Width = 718.110700000000000000
        DataSet = frMasterRelease
        DataSetName = 'frMasterRelease'
        RowCount = 0
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Nomer')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Tgl Input')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 37.795300000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'NO WO')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 83.149660000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Keterangan')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 18.897650000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 37.795300000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 83.149660000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object frMasterBombom_no: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385900000000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataField = 'no_release'
          DataSet = frMasterRelease
          DataSetName = 'frMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frMasterRelease."no_release"]')
          ParentFont = False
        end
        object frMasterBomtgl_input: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 18.897650000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'tgl'
          DataSet = frMasterRelease
          DataSetName = 'frMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frMasterRelease."tgl"]')
          ParentFont = False
        end
        object frMasterBomdescription: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 37.795300000000000000
          Width = 593.386210000000000000
          Height = 18.897650000000000000
          DataSet = FDataBOM.frMasterBom
          DataSetName = 'frMasterBom'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frMasterRelease."no_wo"] -  [frMasterRelease."deskripsi"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object frMasterBomketerangan: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.165430000000000000
          Top = 83.929190000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'keterangan'
          DataSet = frMasterRelease
          DataSetName = 'frMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frMasterRelease."keterangan"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 60.472480000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Divisi')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 60.472480000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 60.472480000000000000
          Width = 593.386210000000000000
          Height = 18.897650000000000000
          DataField = 'name'
          DataSet = frMasterRelease
          DataSetName = 'frMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frMasterRelease."name"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        DataSet = frDetailMasterRelease
        DataSetName = 'frDetailMasterRelease'
        RowCount = 0
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'itemno'
          DataSet = frDetailMasterRelease
          DataSetName = 'frDetailMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailMasterRelease."itemno"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 105.826840000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          DataField = 'description'
          DataSet = frDetailMasterRelease
          DataSetName = 'frDetailMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailMasterRelease."description"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'qty'
          DataSet = frDetailMasterRelease
          DataSetName = 'frDetailMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailMasterRelease."qty"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = 411.968770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'unit'
          DataSet = frDetailMasterRelease
          DataSetName = 'frDetailMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailMasterRelease."unit"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          DataField = 'notes'
          DataSet = frDetailMasterRelease
          DataSetName = 'frDetailMasterRelease'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailMasterRelease."notes"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Item No')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 105.826840000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Description')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Qty')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 411.968770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Unit')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Keterangan')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 124.724490000000000000
        Top = 328.819110000000000000
        Width = 718.110700000000000000
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 37.795300000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Disiapkan Oleh')
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 94.488250000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 166.299320000000000000
          Top = 37.795300000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Diterima Oleh')
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 166.299320000000000000
          Top = 94.488250000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
      end
    end
  end
  object frMasterRelease: TfrxDBDataset
    UserName = 'frMasterRelease'
    CloseDataSource = False
    FieldAliases.Strings = (
      'id=id'
      'no_release=no_release'
      'tgl=tgl'
      'no_wo=no_wo'
      'name=name'
      'deskripsi=deskripsi'
      'keterangan=keterangan')
    DataSet = QMasterRelease
    BCDToCurrency = False
    Left = 425
    Top = 98
  end
  object DMasterRelease: TDataSource
    DataSet = QMasterRelease
    Left = 350
    Top = 228
  end
  object frDetailMasterRelease: TfrxDBDataset
    UserName = 'frDetailMasterRelease'
    CloseDataSource = False
    FieldAliases.Strings = (
      'id_material_release=id_material_release'
      'item_id=item_id'
      'itemno=itemno'
      'description=description'
      'qty=qty'
      'unit=unit'
      'notes=notes')
    DataSet = QDetailRelease
    BCDToCurrency = False
    Left = 545
    Top = 98
  end
end
