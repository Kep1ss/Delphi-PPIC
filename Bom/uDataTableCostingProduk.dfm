object FDataTableCostingProduct: TFDataTableCostingProduct
  Left = 0
  Top = 0
  Caption = 'Table Costing Produk'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 22
    Width = 275
    Height = 24
    Caption = 'Data Table Costing Product'
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
    DesignSize = (
      878
      389)
    TMSStyle = 4
    object Label2: TLabel
      Left = 16
      Top = 21
      Width = 40
      Height = 13
      Caption = 'Produk :'
    end
    object AdvSmoothPanel2: TAdvSmoothPanel
      Left = 16
      Top = 48
      Width = 839
      Height = 329
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
      TabOrder = 0
      TMSStyle = 4
      object pg: TAdvPageControl
        Left = 0
        Top = 0
        Width = 839
        Height = 329
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        ActiveFont.Charset = DEFAULT_CHARSET
        ActiveFont.Color = clWindowText
        ActiveFont.Height = -11
        ActiveFont.Name = 'Tahoma'
        ActiveFont.Style = []
        Align = alClient
        DockSite = True
        DoubleBuffered = True
        HotTrack = True
        ShowFocus = True
        DefaultTabColorTo = clBtnFace
        ActiveColor = clGreen
        ActiveColorTo = clGreen
        TabBackGroundColor = clWhite
        TabMargin.RightMargin = 0
        TabOverlap = 0
        LowerActive = 0
        Version = '2.0.1.5'
        PersistPagesState.Location = plRegistry
        PersistPagesState.Enabled = False
        TabHeight = 30
        TabOrder = 0
        TabStop = False
        OnChange = pgChange
      end
    end
    object EitemNo: TAdvEdit
      Left = 64
      Top = 18
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
      TabOrder = 1
      Text = ''
      Visible = True
      Version = '3.4.7.0'
    end
    object btnFind: TAdvSmoothButton
      Left = 471
      Top = 11
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
      TabOrder = 2
      ShowFocus = False
      Version = '2.1.1.9'
      OnClick = btnFindClick
      TMSStyle = 0
    end
    object ENamaProduk: TAdvEdit
      Left = 151
      Top = 18
      Width = 314
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
  end
  object AdvGridExcelIO1: TAdvGridExcelIO
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
  object Q1: TMyQuery
    Connection = MariaCon.con
    Left = 305
    Top = 186
  end
  object Q2: TMyQuery
    Connection = MariaCon.con
    Left = 377
    Top = 186
  end
  object Q3: TMyQuery
    Connection = MariaCon.con
    Left = 433
    Top = 186
  end
  object Q4: TMyQuery
    Connection = MariaCon.con
    Left = 505
    Top = 186
  end
end
