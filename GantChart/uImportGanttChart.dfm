object FImportGC: TFImportGC
  Left = 0
  Top = 0
  Caption = 'Import Gantt Chart'
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
  PixelsPerInch = 96
  TextHeight = 13
  object AdvGroupBox1: TAdvGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 918
    Height = 117
    BorderColor = clMedGray
    Align = alTop
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = True
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 37
      Width = 56
      Height = 13
      Caption = 'Sales Order'
    end
    object Label4: TLabel
      Left = 87
      Top = 37
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label2: TLabel
      Left = 11
      Top = 64
      Width = 63
      Height = 13
      Caption = 'No Container'
    end
    object Label3: TLabel
      Left = 87
      Top = 64
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label5: TLabel
      Left = 11
      Top = 10
      Width = 25
      Height = 13
      Caption = 'Code'
    end
    object Label6: TLabel
      Left = 87
      Top = 10
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label7: TLabel
      Left = 11
      Top = 90
      Width = 22
      Height = 13
      Caption = 'Cust'
    end
    object Label8: TLabel
      Left = 87
      Top = 90
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label9: TLabel
      Left = 295
      Top = 63
      Width = 58
      Height = 13
      Caption = 'Cancel Date'
    end
    object Label10: TLabel
      Left = 371
      Top = 63
      Width = 4
      Height = 13
      Caption = ':'
    end
    object Label11: TLabel
      Left = 499
      Top = 90
      Width = 16
      Height = 13
      Caption = 'File'
    end
    object Label12: TLabel
      Left = 527
      Top = 90
      Width = 4
      Height = 13
      Caption = ':'
    end
    object ENoSo: TAdvEdit
      Left = 97
      Top = 34
      Width = 192
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
    object AdvSmoothButton3: TAdvSmoothButton
      Left = 295
      Top = 29
      Width = 50
      Height = 25
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
      Caption = '...'
      Color = clGreen
      ParentFont = False
      TabOrder = 1
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton3Click
      TMSStyle = 0
    end
    object EnoContainer: TAdvEdit
      Left = 97
      Top = 60
      Width = 192
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
    object Ecode: TAdvEdit
      Left = 97
      Top = 7
      Width = 192
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
    object Ecustomer: TAdvEdit
      Left = 97
      Top = 87
      Width = 384
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
    object cancelDate: TDateTimePicker
      Left = 381
      Top = 60
      Width = 100
      Height = 21
      Date = 44758.000000000000000000
      Time = 0.948657048611494200
      TabOrder = 5
    end
    object AdvSmoothButton2: TAdvSmoothButton
      Left = 807
      Top = 84
      Width = 66
      Height = 25
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
      Caption = 'Cari File'
      Color = clGreen
      ParentFont = False
      TabOrder = 6
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton2Click
      TMSStyle = 0
    end
    object EFile: TAdvEdit
      Left = 537
      Top = 87
      Width = 264
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
      TabOrder = 7
      Text = ''
      Visible = True
      Version = '3.4.7.0'
    end
  end
  object sg1: TAdvStringGrid
    Left = 0
    Top = 123
    Width = 924
    Height = 346
    Cursor = crDefault
    Align = alClient
    DoubleBuffered = True
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentDoubleBuffered = False
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    OnKeyPress = sg1KeyPress
    OnKeyUp = sg1KeyUp
    HoverRowCells = [hcNormal, hcSelected]
    OnGetAlignment = sg1GetAlignment
    OnCanEditCell = sg1CanEditCell
    OnGetEditorType = sg1GetEditorType
    OnDatePickerCloseUp = sg1DatePickerCloseUp
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientTo = clSilver
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clFuchsia
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
    FixedRowHeight = 80
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
    Look = glCustom
    Multilinecells = True
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
    ExplicitTop = 124
    ExplicitHeight = 345
    RowHeights = (
      80
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
  object AdvGroupBox2: TAdvGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 472
    Width = 918
    Height = 53
    Align = alBottom
    ParentCtl3D = True
    TabOrder = 2
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
      Caption = 'Save'
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
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 424
    Top = 164
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 480
    Top = 164
  end
  object Q3: TMyQuery
    Connection = MariaCon.con
    Left = 536
    Top = 164
  end
  object vtemp_date: TVirtualTable
    Left = 480
    Top = 36
    Data = {04000000000000000000}
    object vtemp_datetglawal: TDateField
      FieldName = 'tglawal'
    end
    object vtemp_datetglakhir: TDateField
      FieldName = 'tglakhir'
    end
  end
  object DataSource1: TDataSource
    DataSet = SQ1
    Left = 539
    Top = 11
  end
  object SQ1: TFDQuery
    Connection = MariaCon.QCon
    SQL.Strings = (
      'SELECT * FROM detail_jadwal')
    Left = 672
    Top = 244
  end
  object SQ2: TFDQuery
    Connection = MariaCon.QCon
    SQL.Strings = (
      'SELECT * FROM detail_jadwal')
    Left = 720
    Top = 244
  end
  object SQ3: TFDQuery
    Connection = MariaCon.QCon
    SQL.Strings = (
      'SELECT * FROM detail_jadwal')
    Left = 760
    Top = 244
  end
  object SQ4: TFDQuery
    Connection = MariaCon.QCon
    SQL.Strings = (
      'SELECT * FROM detail_jadwal')
    Left = 808
    Top = 244
  end
  object SQDelete: TFDQuery
    Connection = MariaCon.QCon
    SQL.Strings = (
      'SELECT * FROM detail_jadwal')
    Left = 608
    Top = 308
  end
  object Q4: TMyQuery
    Connection = MariaCon.con
    Left = 584
    Top = 164
  end
  object OpenDialog1: TOpenDialog
    Left = 683
    Top = 51
  end
  object IO: TAdvGridExcelIO
    AdvStringGrid = sg1
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportRawRTF = False
    UseUnicode = False
    GridStartRow = 0
    GridStartCol = 0
    Version = '3.14'
    Left = 688
    Top = 155
  end
end
