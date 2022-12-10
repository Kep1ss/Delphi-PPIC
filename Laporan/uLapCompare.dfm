object FLapRencanavsHasil: TFLapRencanavsHasil
  Left = 0
  Top = 0
  Caption = 'Laporan Rencana VS Hasil Kerja'
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
    Width = 335
    Height = 24
    Caption = 'Laporan Rencana dan Hasil Kerja'
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
        Left = 7
        Top = 304
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
  object DCompare: TDataSource
    Left = 318
    Top = 244
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
    ReportOptions.LastChange = 44903.422096979160000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo122OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  case StrToInt(<frDetailHasilKerja."Indikator">) of'
      '    1..4 : Memo122.Color := $00004BE8;'
      '    5..100 : Memo122.Color := clRed;'
      '    -1000..-10 : Memo122.Color := $0053FFFF;'
      '    -10..0 : Memo122.Color := clGreen;'
      '   end;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 598
    Top = 196
    Datasets = <
      item
        DataSet = frBARencanaKerja
        DataSetName = 'frBARencanaKerja'
      end
      item
        DataSet = frBeritaAcara
        DataSetName = 'frBeritaAcara'
      end
      item
        DataSet = frDetailHasilKerja
        DataSetName = 'frDetailHasilKerja'
      end
      item
        DataSet = frDetailRencanaKerja
        DataSetName = 'frDetailRencanaKerja'
      end
      item
        DataSet = frHasilKerja
        DataSetName = 'frHasilKerja'
      end
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
      PaperWidth = 215.900000000000000000
      PaperHeight = 355.600000000000000000
      PaperSize = 5
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 37.795300000000000000
        Top = 18.897650000000000000
        Width = 816.000527000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 279.496243500000000000
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
            'Lap. Rencana Kerja Vs Hasil Kerja')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 75.590600000000000000
        Top = 117.165430000000000000
        Width = 816.000527000000000000
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 162.519790000000000000
          Top = 45.354360000000000000
          Width = 136.063080000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 4210943
          HAlign = haCenter
          Memo.UTF8W = (
            'Description')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 298.582870000000000000
          Top = 45.354360000000000000
          Width = 26.456710000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 4210943
          HAlign = haCenter
          Memo.UTF8W = (
            'Qty')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Top = 45.354360000000000000
          Width = 79.370130000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 4210943
          HAlign = haCenter
          Memo.UTF8W = (
            'Nomer SO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Top = 45.354360000000000000
          Width = 26.456710000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 4210943
          HAlign = haCenter
          Memo.UTF8W = (
            'No')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 26.456710000000000000
          Top = 45.354360000000000000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 4210943
          HAlign = haCenter
          Memo.UTF8W = (
            'Tgl')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'DIVISI')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Left = 71.811070000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object frRencanaKerjadivisi_rencana: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 86.929190000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frRencanaKerja."name"]')
          ParentFont = False
        end
        object Subreport1: TfrxSubreport
          AllowVectorExport = True
          Left = 362.834880000000000000
          Top = 45.354360000000000000
          Width = 68.031540000000000000
          Height = 30.236240000000000000
          Page = frxReport1.Page2
          PrintOnParent = True
        end
        object Memo96: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 45.354360000000000000
          Width = 37.795300000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 4210943
          HAlign = haCenter
          Memo.UTF8W = (
            'MH')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo92: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 22.677180000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Periode')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          AllowVectorExport = True
          Left = 71.811070000000000000
          Top = 22.677180000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Lperiode: TfrxMemoView
          AllowVectorExport = True
          Left = 86.929190000000000000
          Top = 22.677180000000000000
          Width = 676.535870000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Periode')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 215.433210000000000000
        Width = 816.000527000000000000
        DataSet = frDetailRencanaKerja
        DataSetName = 'frDetailRencanaKerja'
        RowCount = 0
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Width = 79.370130000000000000
          Height = 34.015770000000000000
          DataField = 'no_so'
          DataSet = frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailRencanaKerja."no_so"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          AllowVectorExport = True
          Left = 162.519790000000000000
          Width = 136.063080000000000000
          Height = 34.015770000000000000
          DataSet = frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailRencanaKerja."description"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo51: TfrxMemoView
          AllowVectorExport = True
          Left = 298.582870000000000000
          Width = 26.456710000000000000
          Height = 34.015770000000000000
          DataField = 'qty'
          DataSet = frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailRencanaKerja."qty"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          AllowVectorExport = True
          Width = 26.456710000000000000
          Height = 34.015750470000000000
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
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 26.456710000000000000
          Width = 56.692950000000000000
          Height = 34.015770000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frRencanaKerja."tgl"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo97: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Width = 37.795300000000000000
          Height = 34.015770000000000000
          DataSet = frDetailRencanaKerja
          DataSetName = 'frDetailRencanaKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailRencanaKerja."mh"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 313.700990000000000000
        Width = 816.000527000000000000
        DataSet = frBARencanaKerja
        DataSetName = 'frBARencanaKerja'
        RowCount = 0
        object Memo110: TfrxMemoView
          AllowVectorExport = True
          Left = 30.236240000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DataField = 'description'
          DataSet = frBARencanaKerja
          DataSetName = 'frBARencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frBARencanaKerja."description"]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          AllowVectorExport = True
          Left = 298.582870000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          DataField = 'qty'
          DataSet = frBARencanaKerja
          DataSetName = 'frBARencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frBARencanaKerja."qty"]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          AllowVectorExport = True
          Width = 30.236240000000000000
          Height = 18.897650000000000000
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
        end
        object Memo113: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataField = 'mh'
          DataSet = frBARencanaKerja
          DataSetName = 'frBARencanaKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frBARencanaKerja."mh"]')
          ParentFont = False
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 272.126160000000000000
        Width = 816.000527000000000000
        object Memo114: TfrxMemoView
          AllowVectorExport = True
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          Memo.UTF8W = (
            'Berita Acara')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 355.275820000000000000
        Width = 816.000527000000000000
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 283.464750000000000000
        Top = 438.425480000000000000
        Width = 816.000527000000000000
        object Shape2: TfrxShapeView
          AllowVectorExport = True
          Top = 128.504020000000000000
          Width = 207.874150000000000000
          Height = 154.960730000000000000
          Frame.Typ = []
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 158.740260000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Gaji')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 177.637910000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Lembur')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 196.535560000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Total Gaji')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 215.433210000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Hasil Kerja')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 234.330860000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Plus/Minus')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 158.740260000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 177.637910000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 196.535560000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 215.433210000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 234.330860000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
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
          Left = 113.385821890000000000
          Top = 158.740260000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."gaji">/200]')
          ParentFont = False
        end
        object frRencanaKerjalembur: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385821890000000000
          Top = 177.637910000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."lembur">/200]')
          ParentFont = False
        end
        object frRencanaKerjatotal_gaji: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385821890000000000
          Top = 196.535560000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((((<frRencanaKerja."gaji">+ <frRencanaKerja."lembur">)/200) * ' +
              '<frRencanaKerja."jml_tenaga_kerja">) )]')
          ParentFont = False
        end
        object frRencanaKerjahasil_kerja: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385821890000000000
          Top = 216.212740000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."hasil_kerja">/200]')
          ParentFont = False
        end
        object frRencanaKerjaplus_minus: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385821890000000000
          Top = 236.110390000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."plus_minus">/200]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 136.063080000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Tenaga Kerja')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 136.063080000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385821890000000000
          Top = 136.063080000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frRencanaKerja."jml_tenaga_kerja"]')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 253.228510000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Prosentase')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 253.228510000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385821890000000000
          Top = 255.008040000000000000
          Width = 86.929119210000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frRencanaKerja."plus_minus">/200) / ((((<frRencanaKerja."gaji' +
              '">+ <frRencanaKerja."lembur">)/200) * <frRencanaKerja."jml_tenag' +
              'a_kerja">) ) * 100] %')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          AllowVectorExport = True
          Top = 102.047310000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Rencana Kerja')
          ParentFont = False
        end
        object Shape3: TfrxShapeView
          AllowVectorExport = True
          Left = 219.212740000000000000
          Top = 128.504020000000000000
          Width = 211.653680000000000000
          Height = 154.960730000000000000
          Frame.Typ = []
        end
        object Memo64: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 233.771800000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Plus/Minus')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 233.771800000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 235.551330000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frHasilKerja."plus_minus">/200]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 177.078850000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Lembur')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 195.976500000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Total Gaji')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 214.874150000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Hasil Kerja')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 177.078850000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 195.976500000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 214.874150000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 177.078850000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frHasilKerja."lembur">/200]')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 195.976500000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(((<frHasilKerja."gaji">+ <frHasilKerja."lembur">)/200) * <frHa' +
              'silKerja."jml_tenaga_kerja">) ]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 215.653680000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frHasilKerja."hasil_kerja"> / 200]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 158.181200000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Gaji')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 158.181200000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 158.181200000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frHasilKerja."gaji"> /200) * <frHasilKerja."jml_tenaga_kerja"' +
              '>]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 135.504020000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Tenaga Kerja')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 135.504020000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 135.504020000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frHasilKerja."jml_tenaga_kerja"]')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 252.669450000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Prosentase')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          AllowVectorExport = True
          Left = 317.480520000000000000
          Top = 252.669450000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 336.377672050000000000
          Top = 254.448980000000000000
          Width = 86.929085040000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frHasilKerja."plus_minus">/200) / ((((<frHasilKerja."gaji">+ ' +
              '<frHasilKerja."lembur">)/200) * <frHasilKerja."jml_tenaga_kerja"' +
              '>)  )* 100] %')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          AllowVectorExport = True
          Left = 219.212740000000000000
          Top = 102.047310000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Hasil Kerja')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 181.417440000000000000
          Width = 245.669450000000000000
          Height = 102.047310000000000000
          Frame.Typ = []
        end
        object Memo78: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Top = 211.653680000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Total Hasil Kerja')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Top = 232.551330000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Plus / Minus')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Top = 211.653680000000000000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Top = 230.551330000000000000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 211.653680000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frHasilKerja."hasil_kerja">/200]')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 230.551330000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frHasilKerja."hasil_kerja">/200) - (<frRencanaKerja."hasil_ke' +
              'rja">/200)]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Top = 188.976500000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Total Rcna Kerja')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Top = 188.976500000000000000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 188.976500000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frRencanaKerja."hasil_kerja"> / 200]')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Top = 255.228510000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Prosentase')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Top = 253.228510000000000000
          Width = 11.338590000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 253.228510000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(((<frHasilKerja."hasil_kerja">/200) - (<frRencanaKerja."hasil_' +
              'kerja">/200)) / (<frRencanaKerja."hasil_kerja">/200)) * 100]')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 355.600000000000000000
      PaperSize = 5
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      EndlessHeight = True
      MirrorMode = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015748030000000000
        Top = 154.960730000000000000
        Width = 816.000527000000000000
        DataSet = frDetailHasilKerja
        DataSetName = 'frDetailHasilKerja'
        RowCount = 0
        object Memo49: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Width = 75.590600000000000000
          Height = 34.015748030000000000
          DataField = 'no_so'
          DataSet = frDetailHasilKerja
          DataSetName = 'frDetailHasilKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailHasilKerja."no_so"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          AllowVectorExport = True
          Left = 158.740260000000000000
          Width = 136.063080000000000000
          Height = 34.015748030000000000
          DataField = 'description'
          DataSet = frDetailHasilKerja
          DataSetName = 'frDetailHasilKerja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailHasilKerja."description"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 26.456710000000000000
          Height = 34.015748030000000000
          DataField = 'qty'
          DataSet = frDetailHasilKerja
          DataSetName = 'frDetailHasilKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailHasilKerja."qty"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          AllowVectorExport = True
          Width = 26.456710000000000000
          Height = 34.015748030000000000
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
        end
        object Memo59: TfrxMemoView
          AllowVectorExport = True
          Left = 26.456710000000000000
          Width = 56.692950000000000000
          Height = 34.015748030000000000
          DataSet = frCompare
          DataSetName = 'frCompare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frHasilKerja."tgl"]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          AllowVectorExport = True
          Left = 321.260050000000000000
          Width = 41.574830000000000000
          Height = 34.015748030000000000
          DataField = 'mh'
          DataSet = frDetailHasilKerja
          DataSetName = 'frDetailHasilKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailHasilKerja."mh"]')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          AllowVectorExport = True
          Left = 362.834880000000000000
          Width = 41.574830000000000000
          Height = 34.015748030000000000
          OnBeforePrint = 'Memo122OnBeforePrint'
          DataSet = frDetailHasilKerja
          DataSetName = 'frDetailHasilKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailHasilKerja."Indikator"] Hari')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          AllowVectorExport = True
          Left = 404.409710000000000000
          Width = 45.354360000000000000
          Height = 34.015748030000000000
          DataField = 'qty_finis'
          DataSet = frDetailHasilKerja
          DataSetName = 'frDetailHasilKerja'
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frDetailHasilKerja."qty_finis"]')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 102.047310000000000000
        Width = 816.000527000000000000
        object Memo117: TfrxMemoView
          AllowVectorExport = True
          Left = 158.740260000000000000
          Width = 136.063080000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Description')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo118: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 26.456710000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Qty')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo119: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Width = 75.590600000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Nomer SO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo120: TfrxMemoView
          AllowVectorExport = True
          Width = 26.456710000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'No')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo121: TfrxMemoView
          AllowVectorExport = True
          Left = 26.456710000000000000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Tgl')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo123: TfrxMemoView
          AllowVectorExport = True
          Left = 321.260050000000000000
          Width = 41.574830000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Mh')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo124: TfrxMemoView
          AllowVectorExport = True
          Left = 362.834880000000000000
          Width = 41.574830000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Ket')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo126: TfrxMemoView
          AllowVectorExport = True
          Left = 404.409710000000000000
          Width = 45.354360000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Balance')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportTitle2: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 816.000527000000000000
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 253.228510000000000000
        Width = 816.000527000000000000
        DataSet = frBeritaAcara
        DataSetName = 'frBeritaAcara'
        RowCount = 0
        object Memo93: TfrxMemoView
          AllowVectorExport = True
          Left = 30.236240000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          DataField = 'description'
          DataSet = frBeritaAcara
          DataSetName = 'frBeritaAcara'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frBeritaAcara."description"]')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          DataField = 'qty'
          DataSet = frBeritaAcara
          DataSetName = 'frBeritaAcara'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frBeritaAcara."qty"]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          AllowVectorExport = True
          Width = 30.236240000000000000
          Height = 18.897650000000000000
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
        end
        object Memo99: TfrxMemoView
          AllowVectorExport = True
          Left = 321.260050000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'mh'
          DataSet = frBeritaAcara
          DataSetName = 'frBeritaAcara'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frBeritaAcara."mh"]')
          ParentFont = False
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 211.653680000000000000
        Width = 816.000527000000000000
        object Memo91: TfrxMemoView
          AllowVectorExport = True
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          Memo.UTF8W = (
            'Berita Acara')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 294.803340000000000000
        Width = 816.000527000000000000
      end
    end
  end
  object frCompare: TfrxDBDataset
    UserName = 'frCompare'
    CloseDataSource = False
    FieldAliases.Strings = (
      'nomer_rencana=nomer_rencana'
      'tgl_rencana=tgl_rencana'
      'id_divisi_rencana=id_divisi_rencana'
      'divisi_rencana=divisi_rencana'
      'jml_tenaga_kerja_rencana=jml_tenaga_kerja_rencana'
      'gaji_rencana=gaji_rencana'
      'lembur_rencana=lembur_rencana'
      'total_gaji_rencana=total_gaji_rencana'
      'hasil_kerja_rencana=hasil_kerja_rencana'
      'plus_minus_rencana=plus_minus_rencana'
      'prosentase_rencana=prosentase_rencana'
      'no_so_rencana=no_so_rencana'
      'item_id_rencana=item_id_rencana'
      'item_description_rencana=item_description_rencana'
      'itemno_rencana=itemno_rencana'
      'qty_rencana=qty_rencana'
      'harga_satuan_rencana=harga_satuan_rencana'
      'subtotal_rencana=subtotal_rencana'
      'nomer_hasil=nomer_hasil'
      'tgl_hasil=tgl_hasil'
      'id_divisi_hasil=id_divisi_hasil'
      'divisi_hasil=divisi_hasil'
      'jml_tenaga_kerja_hasil=jml_tenaga_kerja_hasil'
      'gaji_hasil=gaji_hasil'
      'lembur_hasil=lembur_hasil'
      'total_gaji_hasil=total_gaji_hasil'
      'hasil_kerja_hasil=hasil_kerja_hasil'
      'plus_minus_hasil=plus_minus_hasil'
      'prosentase_hasil=prosentase_hasil'
      'no_so_hasil=no_so_hasil'
      'item_id_hasil=item_id_hasil'
      'item_description_hasil=item_description_hasil'
      'qty_hasil=qty_hasil'
      'harga_satuan_hasil=harga_satuan_hasil'
      'subtotal_hasil=subtotal_hasil')
    DataSet = QCompare
    BCDToCurrency = False
    Left = 406
    Top = 244
  end
  object QCompare: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM v_compare')
    Options.FieldOrigins = foNone
    Left = 401
    Top = 186
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM v_compare')
    Options.FieldOrigins = foNone
    Left = 201
    Top = 178
  end
  object frDetailHasilKerja: TfrxDBDataset
    UserName = 'frDetailHasilKerja'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tgl=tgl'
      'nomer=nomer'
      'no_so=no_so'
      'no_po=no_po'
      'no_container=no_container'
      'item_id=item_id'
      'description=description'
      'qty_rencana=qty_rencana'
      'qty=qty'
      'mh=mh'
      'harga_satuan=harga_satuan'
      'jenis=jenis'
      'parent_name=parent_name'
      'parent_id=parent_id'
      'subtotal=subtotal'
      'itemno=itemno'
      'rencana_id=rencana_id'
      'id_divisi=id_divisi'
      'id_pekerjaan=id_pekerjaan'
      'Indikator=Indikator'
      'qty_finis=qty_finis'
      'id=id')
    DataSet = QDetailHasilKerja
    BCDToCurrency = False
    Left = 142
    Top = 116
  end
  object frHasilKerja: TfrxDBDataset
    UserName = 'frHasilKerja'
    CloseDataSource = False
    FieldAliases.Strings = (
      'nomer=nomer'
      'nomer_rencana=nomer_rencana'
      'tgl=tgl'
      'name=name'
      'jml_tenaga_kerja=jml_tenaga_kerja'
      'gaji=gaji'
      'lembur=lembur'
      'total_gaji=total_gaji'
      'hasil_kerja=hasil_kerja'
      'plus_minus=plus_minus'
      'prosentase=prosentase'
      'full_name=full_name'
      'id_divisi=id_divisi'
      'id=id')
    DataSet = QHasilKerja
    BCDToCurrency = False
    Left = 182
    Top = 44
  end
  object QHasilKerja: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT '
      '              r.nomer,'
      '              r.nomer_rencana,'
      '              r.tgl,'
      '              d.name,             '
      '              r.jml_tenaga_kerja,'
      '              r.gaji,'
      '              r.lembur,'
      '              r.total_gaji,'
      '              r.hasil_kerja,'
      '              r.plus_minus,'
      '              r.prosentase,'
      '              u.full_name,'
      '              r.id_divisi,'
      '              r.id'
      '            FROM'
      '              hasil_kerja r '
      '              LEFT JOIN divisi d '
      '                ON d.`id` = r.`id_divisi` '
      '              LEFT JOIN user_login u '
      '                ON u.`id` = r.`id_user` ')
    Options.FieldOrigins = foNone
    Left = 49
    Top = 42
  end
  object QDetailHasilKerja: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT '
      '              h.tgl,'
      '              rk.nomer,'
      '              rk.no_so,'
      '              rk.no_po,'
      '              rk.no_container,'
      '              rk.item_id,'
      '              i.description,'
      '              rk.qty_rencana,'
      '              SUM(rk.qty) as qty,'
      '              ROUND(SUM(rk.mh)) as mh,'
      '              SUM(rk.harga_satuan) as harga_satuan,'
      '              rk.jenis,'
      '              rk.parent_name,'
      '              rk.parent_id,'
      '              rk.subtotal,'
      '              i.itemno,'
      '              rk.rencana_id,'
      '              rk.id_divisi,'
      '              rk.id_pekerjaan,'
      
        '              fc_indikator_hasil(h.tgl,rk.no_container,rk.no_so,' +
        'rk.item_id,h.id_divisi) as Indikator,'
      
        '              fc_balance(rk.item_id,rk.no_so,rk.no_container,rk.' +
        'id_divisi) as qty_finis,'
      '              rk.id '
      '            FROM'
      '              detail_hasil_kerja rk '
      '              LEFT JOIN item i '
      '                ON rk.`item_id` = i.`id` '
      '              LEFT JOIN hasil_kerja h ON h.nomer=rk.nomer')
    Options.FieldOrigins = foNone
    DetailFields = 'nomer'
    Left = 49
    Top = 114
  end
  object DHasilKerja: TMyDataSource
    DataSet = QHasilKerja
    Left = 113
    Top = 42
  end
  object MyQuery1: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM v_compare')
    Options.FieldOrigins = foNone
    Left = 465
    Top = 122
  end
  object QberitaAcara: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM by_accident')
    Options.FieldOrigins = foNone
    Left = 233
    Top = 114
  end
  object frBeritaAcara: TfrxDBDataset
    UserName = 'frBeritaAcara'
    CloseDataSource = False
    FieldAliases.Strings = (
      'id=id'
      'tgl=tgl'
      'nomer_hasil_kerja=nomer_hasil_kerja'
      'description=description'
      'qty=qty'
      'mh=mh'
      'cost=cost'
      'total_cost=total_cost')
    DataSet = QberitaAcara
    BCDToCurrency = False
    Left = 238
    Top = 44
  end
  object QRencanaKerja: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT '
      '              r.nomer,'
      '              r.tgl,'
      '              d.name,             '
      '              r.jml_tenaga_kerja,'
      '              r.gaji,'
      '              r.lembur,'
      '              r.total_gaji,'
      '              r.hasil_kerja,'
      '              r.plus_minus,'
      '              r.prosentase,'
      '              u.full_name,'
      '             r.id_divisi,'
      '              r.id'
      '            FROM'
      '              rencana_kerja r '
      '              LEFT JOIN divisi d '
      '                ON d.`id` = r.`id_divisi` '
      '              LEFT JOIN user_login u '
      '                ON u.`id` = r.`id_user` ')
    Options.FieldOrigins = foNone
    Left = 369
    Top = 50
  end
  object QDetailRencanaKerja: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT '
      '              rk.nomer,'
      '              rk.no_so,'
      '              rk.no_job_order,'
      '              rk.no_container,'
      '              rk.item_id,'
      '              i.description,'
      '              rk.qty,'
      '              rk.mh,'
      '              rk.qty_order,'
      '              rk.harga_satuan,'
      '              rk.subtotal,'
      '              i.itemno,'
      '              rk.jenis,'
      '              rk.id '
      '            FROM'
      '              rencana_kerja_detail rk '
      '              LEFT JOIN item i '
      '                ON rk.`item_id` = i.`id` ')
    Options.FieldOrigins = foNone
    Left = 369
    Top = 122
  end
  object DRencanaKerja: TMyDataSource
    DataSet = QRencanaKerja
    Left = 433
    Top = 50
  end
  object frRencanaKerja: TfrxDBDataset
    UserName = 'frRencanaKerja'
    CloseDataSource = False
    FieldAliases.Strings = (
      'nomer=nomer'
      'tgl=tgl'
      'name=name'
      'jml_tenaga_kerja=jml_tenaga_kerja'
      'gaji=gaji'
      'lembur=lembur'
      'total_gaji=total_gaji'
      'hasil_kerja=hasil_kerja'
      'plus_minus=plus_minus'
      'prosentase=prosentase'
      'full_name=full_name'
      'id_divisi=id_divisi'
      'id=id')
    DataSet = QRencanaKerja
    BCDToCurrency = False
    Left = 510
    Top = 52
  end
  object frDetailRencanaKerja: TfrxDBDataset
    UserName = 'frDetailRencanaKerja'
    CloseDataSource = False
    FieldAliases.Strings = (
      'nomer=nomer'
      'no_so=no_so'
      'no_job_order=no_job_order'
      'no_container=no_container'
      'item_id=item_id'
      'description=description'
      'qty=qty'
      'mh=mh'
      'qty_order=qty_order'
      'harga_satuan=harga_satuan'
      'subtotal=subtotal'
      'itemno=itemno'
      'jenis=jenis'
      'id=id')
    DataSet = QDetailRencanaKerja
    BCDToCurrency = False
    Left = 542
    Top = 124
  end
  object frBARencanaKerja: TfrxDBDataset
    UserName = 'frBARencanaKerja'
    CloseDataSource = False
    FieldAliases.Strings = (
      'id=id'
      'tgl=tgl'
      'id_divisi=id_divisi'
      'nomer_rencana_kerja=nomer_rencana_kerja'
      'description=description'
      'qty=qty'
      'mh=mh'
      'cost=cost'
      'total_cost=total_cost')
    DataSet = QBARencanaKerja
    BCDToCurrency = False
    Left = 222
    Top = 332
  end
  object QBARencanaKerja: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'SELECT * FROM rencana_berita_acara')
    Options.FieldOrigins = foNone
    Left = 345
    Top = 330
  end
end
