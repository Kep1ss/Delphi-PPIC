object FJadwalDivisi: TFJadwalDivisi
  Left = 0
  Top = 0
  Caption = 'Jadwal Divisi'
  ClientHeight = 528
  ClientWidth = 924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvGroupBox2: TAdvGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 472
    Width = 918
    Height = 53
    Align = alBottom
    ParentCtl3D = True
    TabOrder = 0
    object AdvSmoothButton1: TAdvSmoothButton
      Left = 8
      Top = 19
      Width = 130
      Height = 31
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
      Caption = 'Print'
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
      TabOrder = 0
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton1Click
      TMSStyle = 0
    end
    object btnAdd: TAdvSmoothButton
      Left = 144
      Top = 19
      Width = 125
      Height = 31
      ClickDelay = False
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
      Caption = 'Close'
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
      TabOrder = 1
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnAddClick
      TMSStyle = 0
    end
  end
  object AdvSmoothPanel1: TAdvSmoothPanel
    Left = 0
    Top = 0
    Width = 924
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
    TabOrder = 1
    DesignSize = (
      924
      45)
    TMSStyle = 0
    object Label3: TLabel
      Left = 10
      Top = 8
      Width = 72
      Height = 25
      Caption = 'Jadwal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15987699
      Font.Height = -21
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 89
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
    object Ldivisi: TLabel
      Left = 212
      Top = 14
      Width = 709
      Height = 25
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15987699
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 212
      Top = 18
      Width = 63
      Height = 19
      Caption = 'Periode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 281
      Top = 19
      Width = 6
      Height = 19
      Caption = ':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 391
      Top = 20
      Width = 31
      Height = 19
      Caption = 'S/D'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dt1: TDateTimePicker
      Left = 288
      Top = 17
      Width = 97
      Height = 24
      Date = 44207.000000000000000000
      Time = 0.565219606483879000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = dt1Change
    end
    object dt2: TDateTimePicker
      Left = 428
      Top = 17
      Width = 97
      Height = 24
      Date = 44207.000000000000000000
      Time = 0.565219606483879000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object gp: TGridPanel
    AlignWithMargins = True
    Left = 212
    Top = 48
    Width = 709
    Height = 418
    Align = alClient
    Color = 15198183
    ColumnCollection = <
      item
        Value = 28.571428571428570000
      end
      item
        Value = 71.428571428571430000
      end
      item
      end
      item
      end
      item
      end>
    ControlCollection = <>
    Ctl3D = True
    DoubleBuffered = True
    ParentBackground = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ShowCaption = False
    TabOrder = 2
  end
  object sg1: TAdvStringGrid
    Left = 0
    Top = 45
    Width = 209
    Height = 424
    Cursor = crDefault
    Align = alLeft
    Ctl3D = False
    DrawingStyle = gdsClassic
    FixedCols = 0
    Options = [goRangeSelect, goRowSelect]
    ParentCtl3D = False
    ScrollBars = ssBoth
    TabOrder = 3
    OnClick = sg1Click
    GridLineColor = 15855083
    GridFixedLineColor = clSilver
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 10344697
    ActiveCellColorTo = 6210033
    ControlLook.FixedGradientFrom = clBtnHighlight
    ControlLook.FixedGradientTo = 14737632
    ControlLook.FixedGradientHoverFrom = clBtnHighlight
    ControlLook.FixedGradientHoverTo = clBtnHighlight
    ControlLook.FixedGradientHoverMirrorFrom = clBtnHighlight
    ControlLook.FixedGradientHoverMirrorTo = clBtnHighlight
    ControlLook.FixedGradientHoverBorder = clBtnHighlight
    ControlLook.FixedGradientDownFrom = clBtnHighlight
    ControlLook.FixedGradientDownTo = clBtnHighlight
    ControlLook.FixedGradientDownMirrorFrom = clBtnHighlight
    ControlLook.FixedGradientDownMirrorTo = clBtnHighlight
    ControlLook.FixedGradientDownBorder = clBtnHighlight
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
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    Flat = True
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glCustom
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
    SearchFooter.Color = 16513526
    SearchFooter.ColorTo = clNone
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
    SelectionColor = clGreen
    SortSettings.DefaultFormat = ssAutomatic
    Version = '8.4.2.2'
  end
  object AdvGridExcelIO1: TAdvGridExcelIO
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportHiddenColumns = True
    Options.ExportRawRTF = False
    Options.ExportShowInExcel = True
    Options.ExportHardBorders = True
    Options.ExportCellMargins = True
    UseUnicode = False
    Version = '3.14'
    Left = 368
    Top = 349
  end
  object frxReport1: TfrxReport
    Version = '6.6.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44207.587398645800000000
    ReportOptions.LastChange = 44660.417624918980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure DBCross1Cell0OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure DBCross1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      
        'procedure DBCross1OnPrintCell(Memo: TfrxMemoView; RowIndex, Colu' +
        'mnIndex, CellIndex: Integer; RowValues, ColumnValues, Value: Var' +
        'iant);'
      'begin'
      '  if Memo.Text <> '#39#39' then begin'
      '      if RowIndex = 0 then'
      '         Memo.Color := $00FFA74F;'
      '      if RowIndex = 1 then'
      '         Memo.Color := $00BBFFA4;'
      '      if RowIndex = 2 then'
      '         Memo.Color := $00E77C8C;'
      '      if RowIndex = 3 then'
      '         Memo.Color := $00A8A8FF;'
      '      if  RowIndex  = 4 then'
      '         Memo.Color := $0062E6EC;'
      '      if  RowIndex  = 5 then'
      '         Memo.Color := $00BBFFA4;'
      '      if  RowIndex  = 6 then'
      '         Memo.Color := $00C769DE;'
      '      if  RowIndex  = 7 then'
      '         Memo.Color := $00FF8080;'
      '      if  RowIndex  = 8 then'
      '         Memo.Color := $008AACC4;'
      '      if  RowIndex  = 9 then'
      '         Memo.Color := $00876AF9;'
      '      if  RowIndex  = 10 then'
      '         Memo.Color := $0055AAFF;'
      '      if  RowIndex  = 11 then'
      '         Memo.Color := $00BBE761;'
      '      if  RowIndex  = 12 then'
      '         Memo.Color := $00FF4A4A;'
      '      if  RowIndex  = 13 then'
      '         Memo.Color := $00DA7093;'
      '      if  RowIndex  = 14 then'
      '         Memo.Color := $00A74FFF;'
      '      if  RowIndex  = 15 then'
      '         Memo.Color := $00FF9191;'
      '      if  RowIndex  = 16 then'
      '         Memo.Color := $0000CACA;'
      '      if  RowIndex  = 17 then'
      '         Memo.Color := $00AE5E5E;'
      '      if  RowIndex  = 18 then'
      '         Memo.Color := $0059ACFF;'
      '      if  RowIndex  = 19 then'
      '         Memo.Color := $00FFBD35;'
      '      if  RowIndex  = 20 then'
      '         Memo.Color := $00ADFF5B;'
      '      if  RowIndex  = 21 then'
      '         Memo.Color := $004F4FFF;'
      '  end;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 644
    Top = 112
    Datasets = <
      item
        DataSet = frJadwal
        DataSetName = 'frJadwal'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      EndlessHeight = True
      EndlessWidth = True
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 349.606525000000000000
          Top = 11.338590000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Jadwal Produksi Divisi')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 55.322820000000000000
        Top = 124.724490000000000000
        Width = 1046.929810000000000000
        DataSet = frJadwal
        DataSetName = 'frJadwal'
        RowCount = 0
        object DBCross1: TfrxDBCrossView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 3.779530000000000000
          Width = 78.000000000000000000
          Height = 44.000000000000000000
          DownThenAcross = False
          ShowColumnTotal = False
          ShowRowTotal = False
          ShowTitle = False
          OnPrintCell = 'DBCross1OnPrintCell'
          CellFields.Strings = (
            'details')
          ColumnFields.Strings = (
            'tgl')
          DataSet = frJadwal
          DataSetName = 'frJadwal'
          RowFields.Strings = (
            'name')
          Memos = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574
            662D3822207374616E64616C6F6E653D226E6F223F3E3C63726F73733E3C6365
            6C6C6D656D6F733E3C546672784D656D6F5669657720416C6C6F77566563746F
            724578706F72743D225472756522204C6566743D2236312C3333383539222054
            6F703D223135302C3530343032222057696474683D2232382220486569676874
            3D22323222205265737472696374696F6E733D2232342220416C6C6F77457870
            72657373696F6E733D2246616C73652220466F6E742E436861727365743D2231
            2220466F6E742E436F6C6F723D22302220466F6E742E4865696768743D222D39
            2220466F6E742E4E616D653D22417269616C2220466F6E742E5374796C653D22
            3022204672616D652E5479703D2231352220476170583D22332220476170593D
            22332220506172656E74466F6E743D2246616C73652220546578743D2230222F
            3E3C546672784D656D6F5669657720416C6C6F77566563746F724578706F7274
            3D225472756522204C6566743D223133332220546F703D223434222057696474
            683D22323822204865696768743D22323222205265737472696374696F6E733D
            2232342220416C6C6F7745787072657373696F6E733D2246616C736522204672
            616D652E5479703D2231352220476170583D22332220476170593D2233222048
            416C69676E3D2268615269676874222056416C69676E3D22766143656E746572
            2220546578743D22222F3E3C546672784D656D6F5669657720416C6C6F775665
            63746F724578706F72743D225472756522204C6566743D223130392220546F70
            3D223232222057696474683D22383122204865696768743D2232322220526573
            7472696374696F6E733D2232342220416C6C6F7745787072657373696F6E733D
            2246616C736522204672616D652E5479703D2231352220476170583D22332220
            476170593D2233222048416C69676E3D2268615269676874222056416C69676E
            3D22766143656E7465722220546578743D22222F3E3C546672784D656D6F5669
            657720416C6C6F77566563746F724578706F72743D225472756522204C656674
            3D223130392220546F703D223434222057696474683D22383122204865696768
            743D22323222205265737472696374696F6E733D2232342220416C6C6F774578
            7072657373696F6E733D2246616C736522204672616D652E5479703D22313522
            20476170583D22332220476170593D2233222048416C69676E3D226861526967
            6874222056416C69676E3D22766143656E7465722220546578743D22222F3E3C
            2F63656C6C6D656D6F733E3C63656C6C6865616465726D656D6F733E3C546672
            784D656D6F5669657720416C6C6F77566563746F724578706F72743D22547275
            6522204C6566743D22302220546F703D2230222057696474683D223022204865
            696768743D223022205265737472696374696F6E733D22382220416C6C6F7745
            787072657373696F6E733D2246616C736522204672616D652E5479703D223135
            2220476170583D22332220476170593D2233222056416C69676E3D2276614365
            6E7465722220546578743D2264657461696C73222F3E3C546672784D656D6F56
            69657720416C6C6F77566563746F724578706F72743D225472756522204C6566
            743D22302220546F703D2230222057696474683D223022204865696768743D22
            3022205265737472696374696F6E733D22382220416C6C6F7745787072657373
            696F6E733D2246616C736522204672616D652E5479703D223135222047617058
            3D22332220476170593D2233222056416C69676E3D22766143656E7465722220
            546578743D2264657461696C73222F3E3C2F63656C6C6865616465726D656D6F
            733E3C636F6C756D6E6D656D6F733E3C546672784D656D6F5669657720416C6C
            6F77566563746F724578706F72743D225472756522204C6566743D2236312C33
            333835392220546F703D223132382C3530343032222057696474683D22323822
            204865696768743D22323222205265737472696374696F6E733D223234222041
            6C6C6F7745787072657373696F6E733D2246616C73652220466F6E742E436861
            727365743D22312220466F6E742E436F6C6F723D22302220466F6E742E486569
            6768743D222D31332220466F6E742E4E616D653D22417269616C2220466F6E74
            2E5374796C653D223022204672616D652E5479703D223135222046696C6C2E42
            61636B436F6C6F723D2231333432313737322220476170583D22332220476170
            593D2233222048416C69676E3D22686143656E7465722220506172656E74466F
            6E743D2246616C7365222056416C69676E3D22766143656E7465722220546578
            743D22222F3E3C2F636F6C756D6E6D656D6F733E3C636F6C756D6E746F74616C
            6D656D6F733E3C546672784D656D6F5669657720416C6C6F77566563746F7245
            78706F72743D225472756522204C6566743D223130392220546F703D22302220
            57696474683D22383122204865696768743D2232322220526573747269637469
            6F6E733D2238222056697369626C653D2246616C73652220416C6C6F77457870
            72657373696F6E733D2246616C73652220466F6E742E436861727365743D2231
            2220466F6E742E436F6C6F723D22302220466F6E742E4865696768743D222D31
            332220466F6E742E4E616D653D22417269616C2220466F6E742E5374796C653D
            223122204672616D652E5479703D2231352220476170583D2233222047617059
            3D2233222048416C69676E3D22686143656E7465722220506172656E74466F6E
            743D2246616C7365222056416C69676E3D22766143656E746572222054657874
            3D224772616E6420546F74616C222F3E3C2F636F6C756D6E746F74616C6D656D
            6F733E3C636F726E65726D656D6F733E3C546672784D656D6F5669657720416C
            6C6F77566563746F724578706F72743D225472756522204C6566743D2231312C
            33333835392220546F703D223132382C3530343032222057696474683D223530
            22204865696768743D223022205265737472696374696F6E733D223822205669
            7369626C653D2246616C73652220416C6C6F7745787072657373696F6E733D22
            46616C736522204672616D652E5479703D2231352220476170583D2233222047
            6170593D2233222048416C69676E3D22686143656E746572222056416C69676E
            3D22766143656E7465722220546578743D2264657461696C73222F3E3C546672
            784D656D6F5669657720416C6C6F77566563746F724578706F72743D22547275
            6522204C6566743D2236312C33333835392220546F703D223132382C35303430
            32222057696474683D22323822204865696768743D2230222052657374726963
            74696F6E733D2238222056697369626C653D2246616C73652220416C6C6F7745
            787072657373696F6E733D2246616C736522204672616D652E5479703D223135
            2220476170583D22332220476170593D2233222048416C69676E3D2268614365
            6E746572222056416C69676E3D22766143656E7465722220546578743D227467
            6C222F3E3C546672784D656D6F5669657720416C6C6F77566563746F72457870
            6F72743D225472756522204C6566743D22302220546F703D2230222057696474
            683D223022204865696768743D223022205265737472696374696F6E733D2238
            222056697369626C653D2246616C73652220416C6C6F7745787072657373696F
            6E733D2246616C736522204672616D652E5479703D2231352220476170583D22
            332220476170593D2233222048416C69676E3D22686143656E74657222205641
            6C69676E3D22766143656E7465722220546578743D22222F3E3C546672784D65
            6D6F5669657720416C6C6F77566563746F724578706F72743D22547275652220
            4C6566743D2231312C33333835392220546F703D223132382C35303430322220
            57696474683D22353022204865696768743D2232322220526573747269637469
            6F6E733D22382220416C6C6F7745787072657373696F6E733D2246616C736522
            20466F6E742E436861727365743D22312220466F6E742E436F6C6F723D223022
            20466F6E742E4865696768743D222D31332220466F6E742E4E616D653D224172
            69616C2220466F6E742E5374796C653D223022204672616D652E5479703D2231
            35222046696C6C2E4261636B436F6C6F723D2231333432313737322220476170
            583D22332220476170593D2233222048416C69676E3D22686143656E74657222
            20506172656E74466F6E743D2246616C7365222056416C69676E3D2276614365
            6E7465722220546578743D22444956495349222F3E3C2F636F726E65726D656D
            6F733E3C726F776D656D6F733E3C546672784D656D6F5669657720416C6C6F77
            566563746F724578706F72743D225472756522204C6566743D2231312C333338
            35392220546F703D223135302C3530343032222057696474683D223530222048
            65696768743D22323222205265737472696374696F6E733D2232342220416C6C
            6F7745787072657373696F6E733D2246616C73652220466F6E742E4368617273
            65743D22312220466F6E742E436F6C6F723D22302220466F6E742E4865696768
            743D222D31332220466F6E742E4E616D653D22417269616C2220466F6E742E53
            74796C653D223122204672616D652E5479703D223135222046696C6C2E426163
            6B436F6C6F723D2231323633323235362220476170583D22332220476170593D
            2233222048416C69676E3D22686143656E7465722220506172656E74466F6E74
            3D2246616C7365222056416C69676E3D22766143656E7465722220546578743D
            22222F3E3C2F726F776D656D6F733E3C726F77746F74616C6D656D6F733E3C54
            6672784D656D6F5669657720416C6C6F77566563746F724578706F72743D2254
            72756522204C6566743D22302220546F703D223434222057696474683D223831
            22204865696768743D22323222205265737472696374696F6E733D2238222056
            697369626C653D2246616C73652220416C6C6F7745787072657373696F6E733D
            2246616C73652220466F6E742E436861727365743D22312220466F6E742E436F
            6C6F723D22302220466F6E742E4865696768743D222D31332220466F6E742E4E
            616D653D22417269616C2220466F6E742E5374796C653D223122204672616D65
            2E5479703D2231352220476170583D22332220476170593D2233222048416C69
            676E3D22686143656E7465722220506172656E74466F6E743D2246616C736522
            2056416C69676E3D22766143656E7465722220546578743D224772616E642054
            6F74616C222F3E3C2F726F77746F74616C6D656D6F733E3C63656C6C66756E63
            74696F6E733E3C6974656D20302F3E3C2F63656C6C66756E6374696F6E733E3C
            636F6C756D6E736F72743E3C6974656D20302F3E3C2F636F6C756D6E736F7274
            3E3C726F77736F72743E3C6974656D20322F3E3C2F726F77736F72743E3C2F63
            726F73733E}
        end
      end
    end
  end
  object frJadwal: TfrxDBDataset
    UserName = 'frJadwal'
    CloseDataSource = False
    FieldAliases.Strings = (
      'id=id'
      'divno=divno'
      'name=name'
      'tgl=tgl'
      'sono=sono'
      'details=details')
    DataSet = QJadwal
    BCDToCurrency = False
    Left = 668
    Top = 184
  end
  object frxCrossObject1: TfrxCrossObject
    Left = 628
    Top = 304
  end
  object QJadwal: TMyQuery
    Connection = MariaCon.con
    SQL.Strings = (
      'select '
      '  j.id, '
      '  d.divno,'
      '  d.name,'
      '  j.tgl,'
      '  j.sono,'
      
        '  CONCAT(i.description,'#39'['#39',j.sono,'#39'] : '#39',j.`qty_order`,'#39'['#39',j.`to' +
        'tal_menit`,'#39']'#39') as details'
      'from'
      '  detailjadwal j '
      '  left join divisi d '
      '    on d.`id` = j.`id_divisi` '
      '  left join item i '
      '    on i.`id` = j.item_id '
      '  ORDER BY j.id asc')
    Options.FieldOrigins = foNone
    IndexFieldNames = 'divno'
    Left = 564
    Top = 248
  end
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 380
    Top = 96
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 436
    Top = 96
  end
end
