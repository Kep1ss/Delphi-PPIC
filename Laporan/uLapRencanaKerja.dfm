object FLapRencanaKerja: TFLapRencanaKerja
  Left = 0
  Top = 0
  Caption = 'Laporan Rencana Kerja'
  ClientHeight = 459
  ClientWidth = 923
  Color = 11579568
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 25
    Top = 22
    Width = 237
    Height = 24
    Caption = 'Laporan Rencana Kerja'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -21
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
    Version = '1.5.2.4'
    Align = alClient
    TabOrder = 0
    TMSStyle = 4
    object AdvSmoothPanel1: TAdvSmoothPanel
      AlignWithMargins = True
      Left = 656
      Top = 0
      Width = 217
      Height = 384
      Cursor = crDefault
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 5
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
      Fill.Color = 6723891
      Fill.ColorTo = 6723891
      Fill.ColorMirror = 6723891
      Fill.ColorMirrorTo = 6723891
      Fill.GradientType = gtVertical
      Fill.GradientMirrorType = gtVertical
      Fill.BorderColor = clSilver
      Fill.Rounding = 5
      Fill.ShadowColor = clNone
      Fill.ShadowOffset = 10
      Fill.Glow = gmNone
      Version = '1.5.2.4'
      Align = alRight
      TabOrder = 0
      DesignSize = (
        217
        384)
      TMSStyle = 4
      object Label2: TLabel
        Left = 7
        Top = 12
        Width = 43
        Height = 13
        Caption = 'Periode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 105
        Top = 34
        Width = 21
        Height = 13
        Caption = 'S/D'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 7
        Top = 61
        Width = 30
        Height = 13
        Caption = 'Divisi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dt1: TDateTimePicker
        Left = 10
        Top = 31
        Width = 89
        Height = 21
        Date = 44446.000000000000000000
        Time = 0.847871238423977000
        TabOrder = 0
      end
      object dt2: TDateTimePicker
        Left = 129
        Top = 31
        Width = 82
        Height = 21
        Date = 44446.000000000000000000
        Time = 0.847871238423977000
        TabOrder = 1
      end
      object cbDivisi: TAdvComboBox
        Left = 10
        Top = 81
        Width = 200
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
        TabOrder = 2
      end
      object AdvSmoothButton4: TAdvSmoothButton
        Left = 8
        Top = 302
        Width = 209
        Height = 31
        Anchors = [akRight, akBottom]
        Appearance.GlowPercentage = 0
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clBlack
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = [fsBold]
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
        Caption = 'Preview'
        Color = clWhite
        ParentFont = False
        Shadow = True
        TabOrder = 3
        ShowFocus = False
        Version = '2.1.1.9'
        OnClick = AdvSmoothButton4Click
        TMSStyle = 0
      end
      object AdvSmoothButton1: TAdvSmoothButton
        Left = 8
        Top = 339
        Width = 209
        Height = 31
        Anchors = [akRight, akBottom]
        Appearance.GlowPercentage = 0
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clBlack
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = [fsBold]
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
        Caption = 'Print'
        Color = clWhite
        ParentFont = False
        Shadow = True
        TabOrder = 4
        ShowFocus = False
        Version = '2.1.1.9'
        OnClick = AdvSmoothButton1Click
        TMSStyle = 0
      end
    end
    object frxPreview1: TfrxPreview
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 653
      Height = 383
      Margins.Right = 0
      Align = alClient
      OutlineVisible = True
      OutlineWidth = 121
      ThumbnailVisible = False
      FindFmVisible = False
      UseReportHints = True
      HideScrolls = False
    end
  end
  object DRencanaKerja: TDataSource
    DataSet = QRencanaKerja
    Left = 278
    Top = 276
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
    ReportOptions.LastChange = 44903.323331261580000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure DetailData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  if (<frDetailRencanaKerja."jenis"> = '#39'SET'#39') and (UPPERCASE(<fr' +
        'DetailRencanaKerja."is_parent">) ='#39'TRUE'#39') then'
      '    Memo44.Color := clGray else'
      '    Memo44.Color := clWhite;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 598
    Top = 196
    Datasets = <
      item
        DataSet = frRencanaKerja
        DataSetName = 'frRencanaKerja'
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
        Height = 56.692950000000000000
        Top = 18.897650000000000000
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
            'Laporan Rencana Kerja')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Top = 37.795300000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Periode ')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        DataSet = frRencanaKerja
        DataSetName = 'frRencanaKerja'
        RowCount = 0
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = -120.944960000000000000
          Width = 718.110700000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 30.236240000000000000
          Width = 109.606370000000000000
          Height = 34.015770000000000000
          DataField = 'no_so'
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frRencanaKerja."no_so"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 139.842610000000000000
          Width = 86.929190000000000000
          Height = 34.015770000000000000
          DataField = 'itemno'
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frRencanaKerja."itemno"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Width = 219.212740000000000000
          Height = 34.015770000000000000
          DataField = 'description'
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frRencanaKerja."description"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Width = 37.795300000000000000
          Height = 34.015770000000000000
          DataField = 'qty'
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frRencanaKerja."qty"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          AllowVectorExport = True
          Width = 30.236240000000000000
          Height = 34.015770000000000000
          DataSet = FDataRencanaKerja.frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[Line#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          AllowVectorExport = True
          Left = 483.779840000000000000
          Width = 56.692950000000000000
          Height = 34.015770000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[<frRencanaKerja."mh">/<frRencanaKerja."qty">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 540.472790000000000000
          Width = 56.692950000000000000
          Height = 34.015770000000000000
          DataField = 'mh'
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frRencanaKerja."mh"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 71.811070000000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        Condition = 'frRencanaKerja."divisi_pengerjaan"'
        KeepTogether = True
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 139.842610000000000000
          Top = 41.574830000000000000
          Width = 86.929190000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
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
          Left = 226.771800000000000000
          Top = 41.574830000000000000
          Width = 219.212740000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
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
          Left = 445.984540000000000000
          Top = 41.574830000000000000
          Width = 37.795300000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Qty')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          AllowVectorExport = True
          Left = 30.236240000000000000
          Top = 41.574830000000000000
          Width = 109.606370000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Nomer SO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Top = 41.574830000000000000
          Width = 30.236240000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'No')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 483.779840000000000000
          Top = 41.574830000000000000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          DataSet = FDataRencanaKerja.frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'MH'
            'Per Set')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 540.472790000000000000
          Top = 41.574830000000000000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          DataSet = FDataRencanaKerja.frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL MH')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Divisi : ')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = 52.913420000000000000
          Top = 3.779530000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frRencanaKerja."name"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 137.842610000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Top = 18.897650000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Gaji')
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Top = 37.795300000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Lembur')
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Total Gaji')
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Top = 75.590600000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Hasil Kerja')
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Top = 94.488250000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Plus/Minus')
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 90.708720000000000000
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
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 90.708720000000000000
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
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 90.708720000000000000
          Top = 56.692950000000000000
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
          AllowVectorExport = True
          Left = 90.708720000000000000
          Top = 75.590600000000000000
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
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 90.708720000000000000
          Top = 94.488250000000000000
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
        object frRencanaKerjagaji: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 109.606370000000000000
          Top = 18.897650000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frRencanaKerja."gaji">/200) *<frRencanaKerja."jml_tenaga_kerj' +
              'a">]')
          ParentFont = False
        end
        object frRencanaKerjalembur: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 109.606370000000000000
          Top = 37.795300000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."lembur">/200]')
          ParentFont = False
        end
        object frRencanaKerjatotal_gaji: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 109.606370000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(((<frRencanaKerja."gaji">+<frRencanaKerja."lembur">)/200) * <f' +
              'rRencanaKerja."jml_tenaga_kerja">) ]')
          ParentFont = False
        end
        object frRencanaKerjahasil_kerja: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 110.606370000000000000
          Top = 76.370130000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."hasil_kerja"> / 200]')
          ParentFont = False
        end
        object frRencanaKerjaplus_minus: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 109.606370000000000000
          Top = 96.267780000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."plus_minus"> / 200]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Top = 117.165430000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Persentase')
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 90.708720000000000000
          Top = 117.165430000000000000
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
        object Memo49: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 109.606370000000000000
          Top = 118.944960000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frRencanaKerja
          DataSetName = 'frRencanaKerja'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frRencanaKerja."plus_minus">/200) / ((((<frRencanaKerja."gaji' +
              '">+<frRencanaKerja."lembur">)/200) * <frRencanaKerja."jml_tenaga' +
              '_kerja">)) * 100] %')
          ParentFont = False
        end
      end
    end
  end
  object frRencanaKerja: TfrxDBDataset
    UserName = 'frRencanaKerja'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tgl=tgl'
      'nomer=nomer'
      'id_divisi=id_divisi'
      'divisi_process=divisi_process'
      'jml_tenaga_kerja=jml_tenaga_kerja'
      'gaji=gaji'
      'lembur=lembur'
      'total_gaji=total_gaji'
      'hasil_kerja=hasil_kerja'
      'plus_minus=plus_minus'
      'prosentase=prosentase'
      'divisi_pengerjaan=divisi_pengerjaan'
      'name=name'
      'no_job_order=no_job_order'
      'no_so=no_so'
      'no_container=no_container'
      'item_id=item_id'
      'itemno=itemno'
      'description=description'
      'qty_order=qty_order'
      'qty=qty'
      'mh=mh'
      'harga_satuan=harga_satuan'
      'subtotal=subtotal'
      'id_divisi_process=id_divisi_process')
    DataSet = QRencanaKerja
    BCDToCurrency = False
    Left = 406
    Top = 244
  end
  object QRencanaKerja: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM (SELECT '
      '  `r`.`tgl` AS `tgl`,'
      '  `r`.`nomer` AS `nomer`,'
      '  `r`.`id_divisi` AS `id_divisi`,'
      '  `d`.`name` AS `divisi_process`,'
      '  SUM(`r`.`jml_tenaga_kerja`) AS `jml_tenaga_kerja`,'
      '  SUM(`r`.`gaji`) AS `gaji`,'
      '  SUM(`r`.`lembur`) AS `lembur`,'
      '  SUM(`r`.`total_gaji`) AS `total_gaji`,'
      '  SUM(`r`.`hasil_kerja`) AS `hasil_kerja`,'
      '  SUM(r.hasil_kerja - r.total_gaji) AS `plus_minus`,'
      '  SUM('
      '    (`r`.hasil_kerja - r.total_gaji) / `r`.`total_gaji`'
      '  ) AS `prosentase`,'
      '  `r`.`divisi_planned` AS `divisi_pengerjaan`,'
      '  `dp`.`name` AS `name`,'
      '  `rk`.`no_job_order` AS `no_job_order`,'
      '  `rk`.`no_so` AS `no_so`,'
      '  `rk`.`no_container` AS `no_container`,'
      '  `rk`.`item_id` AS `item_id`,'
      '  `i`.`itemno` AS `itemno`,'
      '  `i`.`description` AS `description`,'
      '  `rk`.`qty_order` AS `qty_order`,'
      '  SUM(`rk`.`qty`) AS `qty`,'
      '  SUM(`rk`.`mh`) AS `mh`,'
      '  SUM(`rk`.`harga_satuan`) AS `harga_satuan`,'
      '  SUM(`rk`.`subtotal`) AS `subtotal`,'
      '  `rk`.`id_divisi` AS `id_divisi_process` '
      'FROM'
      '  `rencana_kerja` `r` '
      '  JOIN `rencana_kerja_detail` `rk` '
      '    ON `r`.`nomer` = `rk`.`nomer` '
      '  JOIN `item` `i` '
      '    ON `i`.`id` = `rk`.`item_id` '
      '  JOIN `divisi` `d` '
      '    ON `d`.`id` = `r`.`id_divisi` '
      '  JOIN `divisi_pengerjaan` `dp` '
      '    ON `dp`.`id` = `r`.`divisi_planned` '
      'GROUP BY   r.divisi_planned,rk.no_so,'
      '   rk.no_container,'
      '   rk.item_id '
      'UNION ALL'
      'SELECT '
      '  `r`.`tgl` AS `tgl`,'
      '  `r`.`nomer` AS `nomer`,'
      '  `r`.`id_divisi` AS `id_divisi`,'
      '  `d`.`name` AS `divisi_process`,'
      '  `r`.`jml_tenaga_kerja` AS `jml_tenaga_kerja`,'
      '  `r`.`gaji` AS `gaji`,'
      '  `r`.`lembur` AS `lembur`,'
      '  `r`.`total_gaji` AS `total_gaji`,'
      '  `r`.`hasil_kerja` AS `hasil_kerja`,'
      '  r.hasil_kerja - r.total_gaji AS `plus_minus`,  '
      '    (`r`.hasil_kerja - r.total_gaji) / `r`.`total_gaji`'
      '   AS `prosentase`,'
      '  `r`.`divisi_planned` AS `divisi_pengerjaan`,'
      '  `dp`.`name` AS `name`,'
      '  '#39'-'#39' AS `no_job_order`,'
      '  '#39'-'#39' AS `no_so`,'
      '  '#39'-'#39' AS `no_container`,'
      '  '#39'-'#39' AS `item_id`,'
      '  '#39'Z-BA'#39' AS `itemno`,'
      '  `rk`.`description` AS `description`,'
      '  '#39'-'#39' AS `qty_order`,'
      '  SUM(`rk`.`qty`) AS `qty`,'
      '  SUM(`rk`.`mh`) AS `mh`,'
      '  SUM(`rk`.`cost`) AS `harga_satuan`,'
      '  SUM(`rk`.`total_cost`) AS `subtotal`,'
      '  `rk`.`id_divisi` AS `id_divisi_process` '
      'FROM'
      '  rencana_kerja r '
      '  JOIN rencana_berita_acara rk '
      '    ON rk.nomer_rencana_kerja = r.nomer JOIN `divisi` `d` '
      '    ON `d`.`id` = `r`.`id_divisi` '
      '  JOIN `divisi_pengerjaan` `dp` '
      '    ON `dp`.`id` = `r`.divisi_planned GROUP BY '
      
        '  r.divisi_planned,rk.description) a ORDER BY divisi_pengerjaan,' +
        'itemno ASC')
    Options.FieldOrigins = foNone
    Left = 401
    Top = 154
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 113
    Top = 98
  end
  object frBeritaAcara: TfrxDBDataset
    UserName = 'frBeritaAcara'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tgl=tgl'
      'nomer=nomer'
      'id_divisi=id_divisi'
      'divisi_planned=divisi_planned'
      'nomer_rencana_kerja=nomer_rencana_kerja'
      'description=description'
      'qty=qty'
      'mh=mh'
      'cost=cost'
      'total_cost=total_cost')
    DataSet = QBeritaAcara
    BCDToCurrency = False
    Left = 534
    Top = 276
  end
  object QBeritaAcara: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM v_rekap_ba')
    Options.FieldOrigins = foNone
    MasterSource = DRencanaKerja
    MasterFields = 'id_divisi_rencana'
    DetailFields = 'id_divisi'
    Left = 273
    Top = 322
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id_divisi_rencana'
        ParamType = ptInput
        Value = 8
      end>
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 169
    Top = 98
  end
end
