object FDataGanttChart: TFDataGanttChart
  Left = 0
  Top = 0
  Caption = 'Gantt Chart'
  ClientHeight = 528
  ClientWidth = 1243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sg1: TAdvStringGrid
    AlignWithMargins = True
    Left = 226
    Top = 50
    Width = 1014
    Height = 416
    Cursor = crDefault
    Align = alClient
    DoubleBuffered = True
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentDoubleBuffered = False
    ParentFont = False
    PopupMenu = PopupMenu1
    ScrollBars = ssBoth
    TabOrder = 0
    OnEnter = sg1Enter
    OnKeyPress = sg1KeyPress
    OnKeyUp = sg1KeyUp
    HoverRowCells = [hcNormal, hcSelected]
    OnGetAlignment = sg1GetAlignment
    OnCanEditCell = sg1CanEditCell
    OnGetEditorType = sg1GetEditorType
    OnDateTimeChange = sg1DateTimeChange
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
    SelectionColor = clYellow
    SortSettings.DefaultFormat = ssAutomatic
    Version = '8.4.2.2'
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
    Width = 1237
    Height = 53
    Align = alBottom
    ParentCtl3D = True
    TabOrder = 1
    object AdvSmoothButton1: TAdvSmoothButton
      Left = 370
      Top = 11
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
      Caption = 'Excell'
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
      Left = 629
      Top = 11
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
    object AdvSmoothButton3: TAdvSmoothButton
      Left = 117
      Top = 11
      Width = 106
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
      Caption = 'Hapus Item'
      Color = clGreen
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA793000000CC4944415438116360A0
        1030E2D2FFFDF7CF5A86FFFFEDC0F28C8C073959D95BC06C34026EC0B79F3F43
        1919FFAF4293C7CAFDFF9F318C8B9D7D3548126EC097FF5FC459FEB0E8323032
        70FCFBFF4F0B24898E991899AE31FC67F8F187E5CF651E469E972079B80120CE
        B7DFDF2C19FE31CB80D83831D3DF275CAC5CC761F22C3006886662602AFCCFF8
        3F14C4C685191998404E871BC0844B21B1E2A30630300CB2300026D1CF84A2EF
        FF7F864FC86A501212E3BFFF6DFF9918998179820B59118C0DB4E01B480D8C4F
        151A00564B384A8542894C0000000049454E44AE426082}
      Shadow = True
      TabOrder = 2
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton3Click
      TMSStyle = 0
    end
    object AdvSmoothButton4: TAdvSmoothButton
      Left = 8
      Top = 11
      Width = 107
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
      Caption = 'Simpan'
      Color = clGreen
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA793000001894944415438119592BF
        4A034110C6772E1221E1925E10EC4C69AB956F904602222206B1D0426CAD7C03
        05118922621922D656165A08626FE53304F62E1788B9ACBF5D2E924B4E438EF9
        76FE7E733B73A7D494270AC3CD4E10348C31B929A593E984DCA781D15A2F4F56
        28E565056D2C0CC31513C71ABB0F7ABEEF7FA12724B301E42D31E64344D69531
        1BB00CB739618C7CB7DD5E420B3127BF86F338206F43BEC3CC0145F11945CF4A
        E4017F1E58B92AFAFE8135523760D643C8F7241C190D4F8E39AA46A48ADF05B1
        28F5827682EDB4EA685DA7F006CF035972C9759EA859E0EDD7C302D700F21E89
        06C1BFC8A4542C83C15AA15C7EB7CE101ECB39826C3BFE47FEE64DB571B26DE2
        B1A40A0679CE6C8999BF5EF0FD479B664FAD48EB556B3BD040924F9327790ACC
        0862BECA8E2B4C0E9B8B82A096B86945B3390A7AC0368943AD77D3154AD9DC68
        03192DE077ADE4443E890DD8F87EB154BAC5B6A416DAFE50A8B4A41A700361A9
        17045F99B9392C75338B2C5ADF28D504E76CFCCDFA33637C041ACDDC2345F801
        15D4D22F8F09A29C0000000049454E44AE426082}
      Shadow = True
      TabOrder = 3
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton4Click
      TMSStyle = 0
    end
    object AdvSmoothButton2: TAdvSmoothButton
      Left = 501
      Top = 11
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
      Caption = 'Hide GC List'
      Color = clGreen
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA79300000162494441543811C592CF
        2E044110C6AB07BB73D878004B0457246EE2CE411CC9BE8178027114CFC3DD9F
        2BBB9C49B8AC88E00530DD3DB3BBED5733764D24241CE8F457FD557D5D35D53D
        2DF2DFC37CD580736E260C8531D54DD73CC571DC56FE2D4208C6A56ECBA6EE06
        844FB846DBD43DE522830E10465DE6F7119781CE171173A54424CCB2D600548E
        E24A75C318F39CFB6A48AEDAD4B73EBEE89B4992D45553C0C7D1CF4BFA193915
        D522353EF57B945E540E6CE8741B51255A20E116B4E1F3D2ED35D01C6086258E
        B32B3A8AEACEB3B17FE6538DE3DF837EEC4E1874D12CC53CB9F588B30CA39567
        2F778C44F95A98771E0AAD888541AECDFC4EA932859309D7716B36738FE001BE
        6AAD9D648F054191647EBBA883E542228227201769B545C214523E7913D336B5
        171FBA3BD61C158D1A05819A4BFD811859511F648897AC1244E6584700772D87
        FCC675DA7FCDFDB2A1C8EF1F52B99072DAFEF953D6C43FC71B63EE4986D4BA2C
        F60000000049454E44AE426082}
      Shadow = True
      TabOrder = 4
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton2Click
      TMSStyle = 0
    end
    object BitBtn1: TBitBtn
      Left = 768
      Top = 16
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 5
      Visible = False
      OnClick = BitBtn1Click
    end
    object AdvSmoothButton5: TAdvSmoothButton
      Left = 225
      Top = 11
      Width = 144
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
      Caption = 'Hapus Gantt Chart'
      Color = 2368767
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA793000000CC4944415438116360A0
        1030E2D2FFFDF7CF5A86FFFFEDC0F28C8C073959D95BC06C34026EC0B79F3F43
        1919FFAF4293C7CAFDFF9F318C8B9D7D3548126EC097FF5FC459FEB0E8323032
        70FCFBFF4F0B24898E991899AE31FC67F8F187E5CF651E469E972079B80120CE
        B7DFDF2C19FE31CB80D83831D3DF275CAC5CC761F22C3006886662602AFCCFF8
        3F14C4C685191998404E871BC0844B21B1E2A30630300CB2300026D1CF84A2EF
        FF7F864FC86A501212E3BFFF6DFF9918998179820B59118C0DB4E01B480D8C4F
        151A00564B384A8542894C0000000049454E44AE426082}
      Shadow = True
      TabOrder = 6
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton5Click
      TMSStyle = 0
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1237
    Height = 41
    Align = alTop
    TabOrder = 2
    Visible = False
    object Memo1: TMemo
      Left = 208
      Top = 8
      Width = 185
      Height = 89
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object dt: TDateTimePicker
      Left = 12
      Top = 10
      Width = 186
      Height = 21
      Date = 44827.000000000000000000
      Time = 0.606709814812347800
      TabOrder = 1
    end
  end
  object GList: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 217
    Height = 416
    Align = alLeft
    TabOrder = 3
    object sgGantChart: TAdvStringGrid
      AlignWithMargins = True
      Left = 5
      Top = 62
      Width = 207
      Height = 349
      Cursor = crDefault
      Align = alClient
      DrawingStyle = gdsClassic
      ScrollBars = ssBoth
      TabOrder = 0
      OnDblClick = sgGantChartDblClick
      HoverRowCells = [hcNormal, hcSelected]
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
    object CheckBox1: TCheckBox
      AlignWithMargins = True
      Left = 6
      Top = 15
      Width = 205
      Height = 17
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 4
      Align = alTop
      Caption = 'Tampilkan Semua Gantt Chart'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object Ecari: TAdvEdit
      AlignWithMargins = True
      Left = 6
      Top = 35
      Width = 205
      Height = 21
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 4
      DefaultHandling = True
      EmptyText = 'Cari No SO / No Container'
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
      Align = alTop
      Color = clWindow
      TabOrder = 2
      Text = ''
      Visible = True
      OnKeyUp = EcariKeyUp
      Version = '3.4.7.0'
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
    Top = 91
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
    Left = 592
    Top = 164
  end
  object Q5: TMyQuery
    Connection = MariaCon.con
    Left = 640
    Top = 164
  end
  object AdvGridExcelIO1: TAdvGridExcelIO
    AdvStringGrid = sg1
    Options.ExportOverwrite = omAlways
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportFormulas = False
    Options.ExportCellFormats = False
    Options.ExportHTMLTags = False
    Options.ExportRawRTF = False
    Options.ExportShowInExcel = True
    Options.ExportHardBorders = True
    Options.ExportCellMargins = True
    UseUnicode = False
    GridStartRow = 0
    GridStartCol = 0
    Version = '3.14'
    Left = 375
    Top = 211
  end
  object PopupMenu1: TPopupMenu
    Left = 259
    Top = 271
    object A1: TMenuItem
      Caption = 'Add Cancel Date'
      OnClick = A1Click
    end
    object P1: TMenuItem
      Caption = 'Perbarui Gantt Chart'
      OnClick = P1Click
    end
  end
end
