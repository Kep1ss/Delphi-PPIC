object FDaftarSORencanaKerja: TFDaftarSORencanaKerja
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Daftar SO'
  ClientHeight = 540
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSmoothPanel2: TAdvSmoothPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 924
    Height = 534
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
      924
      534)
    TMSStyle = 0
    object Label1: TLabel
      Left = 10
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Nomer SO'
    end
    object AdvSmoothPanel1: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 919
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
        Width = 66
        Height = 25
        Caption = 'Daftar'
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
        Width = 29
        Height = 25
        Caption = 'SO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object AdvSmoothPanel3: TAdvSmoothPanel
      Left = 10
      Top = 96
      Width = 899
      Height = 393
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
        Width = 884
        Height = 373
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
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentCtl3D = False
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyDown = sgBarangKeyDown
        HoverRowCells = [hcNormal, hcSelected]
        OnCanEditCell = sgBarangCanEditCell
        OnCheckBoxChange = sgBarangCheckBoxChange
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
    object Ecari: TAdvEdit
      Left = 104
      Top = 61
      Width = 433
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
      OnKeyDown = EcariKeyDown
      Version = '3.4.7.0'
    end
    object btnFind: TAdvSmoothButton
      Left = 549
      Top = 59
      Width = 41
      Height = 31
      Appearance.PictureAlignment = taCenter
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
      Color = clGreen
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA7930000011A494441543811CD90B1
        4AC35014866F444C57374107A1D07410D1C157E924A21D4AA0635FC07790BE40
        D776751589E0D42538291D3B181CEC52DA90B4F1FB430269E8D04C35FCDF39E7
        FEE7DCD34B8DF9775F922437A2FC3079A2EC6F9C1978805C77791363AB9FF70D
        0327F001BB6ACCE07171C1234655F58A0BFCAAB7997FD7028BA24E3181AA4AB8
        707E407021866FD0D6901C4159F296989A09C82B700D2FF8010F6C0C9D1DEA25
        4843C208A405A191CDD8D46F10E805479803CBB2F4CB86FCC9D903694D1024E3
        D1FB52410EC903B00F0953B884546CAD5134416A296438F4ECECB2AC2BC2544F
        6ED388E009BAF00ABF70CA402AEA3398C10B68A64F8EE1DEE8A3E8C004E6F00C
        17F28BE05D8307FA7F7CF26DB1BFBFFA0F1E7D78704848B3EA0000000049454E
        44AE426082}
      Shadow = True
      TabOrder = 3
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnFindClick
      TMSStyle = 0
    end
    object btnTutup: TAdvSmoothButton
      Left = 819
      Top = 493
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
      TabOrder = 4
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnTutupClick
      TMSStyle = 0
    end
    object btnPilih: TAdvSmoothButton
      Left = 726
      Top = 493
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
      Caption = 'Proses'
      Color = clGreen
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA7930000019749444154381195503D
        4B034110DDB90B467277215641106C02A282602976228A8560656121881F60A3
        95A0D8F83BACADB451EC222258088A8510ECAC24160A1A725F08B9DBF1ED2531
        E1BC0473CCDB99D999377BF384E8E1F36C7BD3B5EDBD1E28AD5690173DC70900
        060E5B957F44AEEB4EF88E6383A8C811F027078A4AEAE80690F324E5BD201A8E
        F731F3BE16BF6CCFD14082F934898CBE1A1155BA0E40539A984FE025D06E1526
        5A302CEB3871005E4E63DF6DDF75CB607D205F870F01652F21F394699AD72AF9
        D500842321C41830088C030380B21A9A562451BFC6BC16302F67B3D94F555040
        4D604DEEF33DEF0B81A12E13F09A31CD0276AEC56BD10A507ABA0B59BDB09344
        56C3A2013AD19C4A14A0D60C049A557103E58C655D36E23F2E1A0091E6A30AF3
        A3699AB73A7310E5F5E301AF636E3D899FA9EF6AB5100A3109316E20D216942F
        A1691468DA5B3348F25AA0EB4B28DC6961B8116ADA19E276F23BB479C25D474B
        6952E681D550D7CFD1350214A14111FECA308C127E9F117734F27D7F4804C12E
        967C0EA4BCC8E572958EDD09851FD7C9B4C6ECACB80F0000000049454E44AE42
        6082}
      Shadow = True
      TabOrder = 5
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnPilihClick
      TMSStyle = 0
    end
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 423
    Top = 72
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 471
    Top = 72
  end
  object vt: TVirtualTable
    Left = 706
    Top = 189
    Data = {04000000000000000000}
    object vtjob_order: TStringField
      FieldName = 'job_order'
      Size = 100
    end
    object vtdivisi: TStringField
      FieldName = 'divisi'
      Size = 100
    end
    object vtno_so: TStringField
      FieldName = 'no_so'
      Size = 100
    end
    object vtno_container: TStringField
      FieldName = 'no_container'
      Size = 100
    end
    object vtitem: TStringField
      FieldName = 'item'
      Size = 100
    end
    object vtqty: TIntegerField
      FieldName = 'qty'
    end
    object vtmh: TIntegerField
      FieldName = 'mh'
    end
    object vtunit_price: TIntegerField
      FieldName = 'unit_price'
    end
    object vtid: TIntegerField
      FieldName = 'id'
    end
    object vtqty_order: TIntegerField
      FieldName = 'qty_order'
    end
    object vtitemno: TStringField
      FieldName = 'itemno'
      Size = 100
    end
    object vtitem_id: TIntegerField
      FieldName = 'item_id'
    end
    object vtid_divisi: TStringField
      FieldName = 'id_divisi'
      Size = 50
    end
  end
end
