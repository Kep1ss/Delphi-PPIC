object FGanttChartParameters: TFGanttChartParameters
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Gantt Chart Parameters'
  ClientHeight = 605
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSmoothPanel2: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 901
    Height = 599
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
    Fill.BorderColor = clSilver
    Fill.Rounding = 5
    Fill.RoundingType = rtBottom
    Fill.ShadowOffset = 5
    Fill.Glow = gmNone
    Version = '1.5.2.4'
    Align = alClient
    TabOrder = 0
    DesignSize = (
      901
      599)
    TMSStyle = 0
    object Label1: TLabel
      Left = 16
      Top = 110
      Width = 47
      Height = 13
      Caption = 'Jam Kerja'
    end
    object Label2: TLabel
      Left = 93
      Top = 110
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label4: TLabel
      Left = 15
      Top = 136
      Width = 65
      Height = 13
      Caption = 'Tanggal Mulai'
    end
    object Label5: TLabel
      Left = 92
      Top = 136
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label6: TLabel
      Left = 16
      Top = 61
      Width = 32
      Height = 13
      Caption = 'NO SO'
    end
    object Label8: TLabel
      Left = 93
      Top = 61
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label9: TLabel
      Left = 16
      Top = 85
      Width = 46
      Height = 13
      Caption = 'Customer'
    end
    object Label10: TLabel
      Left = 93
      Top = 85
      Width = 4
      Height = 13
      Caption = ':'
    end
    object AdvSmoothPanel1: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 896
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
      Fill.Rounding = 5
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
        Width = 58
        Height = 25
        Caption = 'Gantt'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -21
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 82
        Top = 8
        Width = 122
        Height = 25
        Caption = 'Parameters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object AdvSmoothPanel3: TAdvSmoothPanel
      Left = 3
      Top = 161
      Width = 876
      Height = 383
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
      Version = '1.5.2.4'
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
      TMSStyle = 4
      object sgBarang: TAdvStringGrid
        AlignWithMargins = True
        Left = 5
        Top = 10
        Width = 861
        Height = 363
        Cursor = crDefault
        Margins.Left = 5
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alClient
        BorderStyle = bsNone
        Color = 15921906
        Ctl3D = False
        DefaultRowHeight = 21
        DrawingStyle = gdsGradient
        FixedColor = 15921906
        FixedCols = 4
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ParentCtl3D = False
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyPress = sgBarangKeyPress
        OnKeyUp = sgBarangKeyUp
        OnSelectCell = sgBarangSelectCell
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = sgBarangGetAlignment
        OnCanEditCell = sgBarangCanEditCell
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
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -12
        FixedFont.Name = 'Segoe UI'
        FixedFont.Style = []
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
        SelectionColor = 11468718
        SortSettings.DefaultFormat = ssAutomatic
        Version = '8.4.2.2'
        ColWidths = (
          64
          64
          64
          64
          571)
      end
    end
    object btnTutup: TAdvSmoothButton
      Left = 636
      Top = 551
      Width = 92
      Height = 31
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
      Caption = 'Tutup'
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
    object Enoso: TAdvEdit
      Left = 103
      Top = 58
      Width = 178
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
    object ECustomer: TAdvEdit
      Left = 103
      Top = 82
      Width = 178
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
    object EjamKerja: TAdvEdit
      Left = 103
      Top = 107
      Width = 178
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
      Version = '3.4.7.0'
    end
    object dtMulai: TDateTimePicker
      Left = 103
      Top = 134
      Width = 178
      Height = 21
      Date = 44505.000000000000000000
      Time = 0.232371597223391300
      TabOrder = 6
    end
    object AdvSmoothButton1: TAdvSmoothButton
      Left = 540
      Top = 551
      Width = 92
      Height = 31
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
      Caption = 'Proccess'
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
      TabOrder = 7
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton1Click
      TMSStyle = 0
    end
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 531
    Top = 91
  end
end
