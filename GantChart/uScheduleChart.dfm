object FGrafikJadwal: TFGrafikJadwal
  Left = 0
  Top = 0
  Caption = 'Gantt Chart'
  ClientHeight = 522
  ClientWidth = 1279
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
    Left = 3
    Top = 55
    Width = 1273
    Height = 395
    Cursor = crDefault
    Align = alClient
    DoubleBuffered = True
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    PopupMenu = PopupMenu1
    ScrollBars = ssBoth
    TabOrder = 0
    OnEnter = sg1Enter
    OnKeyUp = sg1KeyUp
    HoverRowCells = [hcNormal, hcSelected]
    OnGetAlignment = sg1GetAlignment
    OnGetEditorType = sg1GetEditorType
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
    Top = 456
    Width = 1273
    Height = 63
    Align = alBottom
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = True
    TabOrder = 1
    DesignSize = (
      1273
      63)
    object Label5: TLabel
      Left = 874
      Top = 12
      Width = 53
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Total SO :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 964
      Top = 12
      Width = 93
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Total Container :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 1180
      Top = 12
      Width = 66
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Total Item :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LtotalSo: TLabel
      Left = 933
      Top = 12
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
    object LtotalContainer: TLabel
      Left = 1063
      Top = 12
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
    object LtotalItem: TLabel
      Left = 1255
      Top = 12
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
    object Label4: TLabel
      Left = 1084
      Top = 12
      Width = 67
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Total Jenis :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LtotalJenis: TLabel
      Left = 1157
      Top = 12
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
    object AdvSmoothButton1: TAdvSmoothButton
      Left = 330
      Top = 28
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
      Left = 458
      Top = 28
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
    object AdvSmoothButton2: TAdvSmoothButton
      Left = 8
      Top = 28
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
      Caption = 'Add'
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
      TabOrder = 2
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton2Click
      TMSStyle = 0
    end
    object AdvSmoothButton3: TAdvSmoothButton
      Left = 225
      Top = 28
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
      TabOrder = 3
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton3Click
      TMSStyle = 0
    end
    object AdvSmoothButton4: TAdvSmoothButton
      Left = 117
      Top = 28
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
      Caption = 'Data GC'
      Color = clGreen
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000006624B474400FF00FF00FFA0BDA793000001C34944415438118D933B
        4F1B4110C76FD6109C34C68044014911A50289574F90684150E4A574348952D1
        2001E20BF045686828D2264A8AD0A5E4217A9454F8F66C19FB6C7237F9CD21CE
        41B289ADF9EFCEF33FBBB3E720E8F253D542AB5299B250338A96EBF5FAB8E9DD
        20FF3A2974CD309C702233A9C8C19372B9DCF4FE187D93C41792A6CB2272AE22
        67C552E93B7A9AD75B71C3FB9F74BC401FA8D56A637910A51145AF205343ECFD
        26AE4C06B295258EA23DBA3C4FD37403E63FB8AE402ECEB9D320493450BD5691
        913C604AA3529984B94597D7667703A72A70BA0F2DEFD7C9BDA1E6699EC7BD77
        099EE78EFF28109CD06CC7D29C2D1C79810E5F4CEF071A04DF18E8BCE5660438
        46B87F688E7E90E58A8C5A6E4680F21B4C827EE51989BF40704B20F20363856B
        14000DB07A08F12142ABBCC657F65B8262921C620C36ABD52D86F9592F2F1F63
        77159E7B9BC04D318E8FD83BD2A856DF33DD0468DDFBB94EA4A3F15AFBC4DB7C
        486B77DEEC0A1CCB89AA39339B7B4C9B8F02BB6BC093BDF1DE0F53F41238865E
        62BF2F143CBA8EA2053A6C80A5B6F7B3105C5816F61958525507D95BF4761C86
        9F2CD613240FF6FA1742F2EE8EE4C189F76427C0303FD264F12FF26A0EBA5737
        A4C30000000049454E44AE426082}
      Shadow = True
      TabOrder = 4
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = AdvSmoothButton4Click
      TMSStyle = 0
    end
  end
  object AdvGroupBox1: TAdvGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1273
    Height = 46
    Align = alTop
    ParentCtl3D = True
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 60
      Height = 13
      Caption = 'Start Date : '
    end
    object Label2: TLabel
      Left = 159
      Top = 16
      Width = 46
      Height = 13
      Caption = 'Filter By :'
    end
    object Label3: TLabel
      Left = 562
      Top = 16
      Width = 71
      Height = 13
      Caption = 'Fixed Column :'
    end
    object SpeedButton1: TSpeedButton
      Left = 979
      Top = 12
      Width = 23
      Height = 22
      Visible = False
    end
    object Label10: TLabel
      Left = 939
      Top = 16
      Width = 15
      Height = 13
      Caption = 's/d'
    end
    object Label8: TLabel
      Left = 1052
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Show :'
    end
    object Label9: TLabel
      Left = 1169
      Top = 16
      Width = 27
      Height = 13
      Caption = 'Items'
    end
    object dt: TDateTimePicker
      Left = 74
      Top = 13
      Width = 79
      Height = 21
      Date = 44721.000000000000000000
      Time = 0.625576724538405000
      TabOrder = 0
      OnCloseUp = dtCloseUp
    end
    object cbDIvisi: TAdvSmoothComboBox
      Left = 320
      Top = 12
      Width = 236
      Height = 21
      Cursor = crDefault
      Fill.Color = clCream
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtSolid
      Fill.GradientMirrorType = gtSolid
      Fill.BorderColor = clNone
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Glow = gmNone
      Items = <
        item
          Caption = 'Item 0'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 1'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 2'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 3'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 4'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 5'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 6'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 7'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 8'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 9'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 10'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 11'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 12'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 13'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 14'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 15'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 16'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 17'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 18'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 19'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 20'
          Checked = True
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end>
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
      ItemAppearance.Fill.Color = clBtnFace
      ItemAppearance.Fill.ColorTo = clBtnFace
      ItemAppearance.Fill.ColorMirror = clBtnFace
      ItemAppearance.Fill.ColorMirrorTo = clBtnFace
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
      LookupBar.AutoSize = False
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
      Header.Fill.Color = 16773091
      Header.Fill.ColorTo = 16765615
      Header.Fill.ColorMirror = clNone
      Header.Fill.ColorMirrorTo = clNone
      Header.Fill.GradientType = gtVertical
      Header.Fill.GradientMirrorType = gtSolid
      Header.Fill.BorderColor = 16765615
      Header.Fill.Rounding = 0
      Header.Fill.ShadowOffset = 0
      Header.Fill.Glow = gmNone
      Header.Caption = 'Header'
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = 7485192
      Header.Font.Height = -13
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Visible = False
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
      OnItemCheckClick = cbDIvisiItemCheckClick
      DefaultItem.Caption = 'Item 0'
      DefaultItem.Checked = True
      DefaultItem.ProgressMaximum = 100.000000000000000000
      MultiSelect = True
      Categories = <>
      TabOrder = 1
      Text = ''
      ItemBackGroundFill.Color = clBtnFace
      ItemBackGroundFill.ColorTo = clBtnFace
      ItemBackGroundFill.ColorMirror = clBtnFace
      ItemBackGroundFill.ColorMirrorTo = clBtnFace
      ItemBackGroundFill.GradientType = gtVertical
      ItemBackGroundFill.GradientMirrorType = gtVertical
      ItemBackGroundFill.BorderColor = clGray
      ItemBackGroundFill.Rounding = 0
      ItemBackGroundFill.ShadowOffset = 0
      ItemBackGroundFill.Glow = gmNone
      ButtonAppearance.Fill.Color = clBtnFace
      ButtonAppearance.Fill.ColorTo = clBtnFace
      ButtonAppearance.Fill.ColorMirror = clBtnFace
      ButtonAppearance.Fill.ColorMirrorTo = clBtnFace
      ButtonAppearance.Fill.GradientType = gtVertical
      ButtonAppearance.Fill.GradientMirrorType = gtVertical
      ButtonAppearance.Fill.BorderColor = clGray
      ButtonAppearance.Fill.Rounding = 0
      ButtonAppearance.Fill.ShadowOffset = 0
      ButtonAppearance.Fill.Glow = gmNone
      ButtonAppearance.FillDown.Color = 11196927
      ButtonAppearance.FillDown.ColorTo = 7257087
      ButtonAppearance.FillDown.ColorMirror = 4370174
      ButtonAppearance.FillDown.ColorMirrorTo = 8053246
      ButtonAppearance.FillDown.GradientType = gtVertical
      ButtonAppearance.FillDown.GradientMirrorType = gtVertical
      ButtonAppearance.FillDown.BorderColor = 16765615
      ButtonAppearance.FillDown.Rounding = 0
      ButtonAppearance.FillDown.ShadowOffset = 0
      ButtonAppearance.FillDown.Glow = gmNone
      ButtonAppearance.FillHover.Color = 15465983
      ButtonAppearance.FillHover.ColorTo = 11332863
      ButtonAppearance.FillHover.ColorMirror = 5888767
      ButtonAppearance.FillHover.ColorMirrorTo = 10807807
      ButtonAppearance.FillHover.GradientType = gtVertical
      ButtonAppearance.FillHover.GradientMirrorType = gtVertical
      ButtonAppearance.FillHover.BorderColor = 16765615
      ButtonAppearance.FillHover.Rounding = 0
      ButtonAppearance.FillHover.ShadowOffset = 0
      ButtonAppearance.FillHover.Glow = gmNone
      AutoHeight = False
      DropDownWidth = 310
      TMSStyle = 4
    end
    object cbFixed: TComboBox
      Left = 638
      Top = 13
      Width = 126
      Height = 21
      TabOrder = 2
      OnChange = cbFixedChange
    end
    object dtCancelMulai: TDateTimePicker
      Left = 857
      Top = 12
      Width = 80
      Height = 21
      Date = 44872.000000000000000000
      Time = 0.649055914349446500
      TabOrder = 3
      OnCloseUp = dtCancelMulaiCloseUp
    end
    object dtCancelAkhir: TDateTimePicker
      Left = 960
      Top = 12
      Width = 80
      Height = 21
      Date = 44872.000000000000000000
      Time = 0.649055914349446500
      TabOrder = 4
      OnCloseUp = dtCancelMulaiCloseUp
    end
    object cCancelDate: TCheckBox
      Left = 770
      Top = 15
      Width = 81
      Height = 17
      Caption = 'Cancel Date :'
      TabOrder = 5
      OnClick = cCancelDateClick
    end
    object cbFilterBy: TComboBox
      Left = 209
      Top = 13
      Width = 105
      Height = 21
      TabOrder = 6
      Text = '--- No Filter ---'
      OnCloseUp = cbFilterByCloseUp
      Items.Strings = (
        '--- No Filter ---'
        'Divisi'
        'Item'
        'SO'
        'Container')
    end
    object cbPage: TComboBox
      Left = 1092
      Top = 13
      Width = 72
      Height = 21
      ItemIndex = 1
      TabOrder = 7
      Text = '10'
      OnChange = cbPageChange
      Items.Strings = (
        '-- ALL --'
        '10'
        '20'
        '30'
        '40'
        '50'
        '100')
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
    Left = 488
    Top = 68
    Data = {04000000000000000000}
    object vtemp_datetglawal: TDateField
      FieldName = 'tglawal'
    end
    object vtemp_datetglakhir: TDateField
      FieldName = 'tglakhir'
    end
  end
  object DataSource1: TDataSource
    Left = 539
    Top = 91
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
  end
end
