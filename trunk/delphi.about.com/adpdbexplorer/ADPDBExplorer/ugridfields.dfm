object frmGridFields: TfrmGridFields
  Left = 204
  Top = 237
  Width = 781
  Height = 455
  Caption = 'View....'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000007777770000000000000000
    0000000000000007000000000000000000000000000000070000000000000000
    0000000000777007000000000000000000077070007770070000700000000000
    0077000700787000000007000000000007708000077877000070007000000000
    07088807777777770777000700000000008F88877FFFFF077887700700000000
    00088888F88888FF08870070000000000000880888877778F070007000000007
    77088888880007778F770077777000700008F088007777077F07000000700700
    008F08880800077778F7700000700708888F0880F08F807078F7777700700708
    F88F0780F070F07078F7887700700708888F0780F077807088F7777700700700
    008F0788FF00080888F77000007000000008F0780FFFF0088F77007000000000
    0008F07788000888887700700000000000008F07788888880870007000000000
    00088FF0077788088887000700000000008F888FF00000F87887700700000000
    0708F8088FFFFF88078700700000000007708000088888000070070000000000
    0077007000888007000070000000000000077700008F80070007000000000000
    0000000000888007000000000000000000000000000000070000000000000000
    000000000777777700000000000000000000000000000000000000000000FFFF
    FFFFFFFC0FFFFFFC0FFFFFF80FFFFFF80FFFFE180E7FFC00043FF800001FF800
    000FF800000FFC00001FFE00001FE0000001C000000180000001800000018000
    00018000000180000001FC00001FFC00001FFE00001FFC00000FF800000FF800
    001FF800003FFC180C7FFE380EFFFFF80FFFFFF80FFFFFF80FFFFFFFFFFF}
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlEditArea: TPanel
    Left = 0
    Top = 0
    Width = 773
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlEALeft: TPanel
      Left = 0
      Top = 0
      Width = 773
      Height = 428
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object FieldBox: TScrollBox
        Left = 0
        Top = 276
        Width = 773
        Height = 152
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alBottom
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
      end
      object Grid: TDBGrid
        Left = 0
        Top = 125
        Width = 773
        Height = 136
        Align = alClient
        DataSource = DataSource
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = GridKeyDown
        OnMouseMove = GridMouseMove
        OnTitleClick = GridTitleClick
      end
      object lblRecNo: TStaticText
        Left = 0
        Top = 261
        Width = 773
        Height = 15
        Align = alBottom
        Caption = 'lblRecNo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 773
        Height = 57
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 3
        object pnlNav: TPanel
          Left = 436
          Top = 1
          Width = 336
          Height = 55
          Align = alRight
          BevelInner = bvLowered
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object DBNavigator: TDBNavigator
            Left = 6
            Top = 6
            Width = 324
            Height = 43
            DataSource = DataSource
            VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
            Align = alClient
            Constraints.MaxHeight = 50
            Ctl3D = True
            Hints.Strings = (
              'Prvi zapis'
              'Prethodni zapis'
              'Slijede'#263'i zapis'
              'Zadnji zapis'
              'Dodaj'
              'Obri'#353'i'
              'Promijeni'
              'Spremi'
              'Odustani'
              'Osvje'#382'i')
            ParentCtl3D = False
            TabOrder = 0
            BeforeAction = DBNavigatorBeforeAction
          end
        end
        object pnlSearch: TPanel
          Left = 1
          Top = 1
          Width = 208
          Height = 55
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 8
            Top = 8
            Width = 52
            Height = 13
            Caption = 'Search on:'
            FocusControl = edTrazi
          end
          object edTrazi: TEdit
            Left = 8
            Top = 28
            Width = 193
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'Enter your search term, hit [RETURN]'
            OnEnter = edTraziEnter
            OnExit = edTraziExit
            OnKeyDown = edTraziKeyDown
          end
          object cboTraziPo: TComboBox
            Left = 64
            Top = 4
            Width = 137
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 1
            OnClick = cboTraziPoClick
          end
        end
      end
      object pnlQuery: TPanel
        Left = 0
        Top = 57
        Width = 773
        Height = 68
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 4
        object pnlQueryBtn: TPanel
          Left = 676
          Top = 1
          Width = 96
          Height = 66
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            96
            66)
          object RefreshButton: TBitBtn
            Left = 8
            Top = 6
            Width = 81
            Height = 53
            Anchors = [akRight]
            Caption = 'Refresh'
            TabOrder = 0
            OnClick = RefreshButtonClick
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
              055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
              005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
              B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
              305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
              305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
              30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
              3055577777555557F7F555000555555999555577755555577755}
            Layout = blGlyphTop
            NumGlyphs = 2
          end
        end
        object SQLQuery: TMemo
          Left = 1
          Top = 1
          Width = 675
          Height = 66
          Align = alClient
          Lines.Strings = (
            '[Enter SQL query here]')
          ScrollBars = ssBoth
          TabOrder = 1
        end
      end
    end
    object pnlEARight: TPanel
      Left = 773
      Top = 0
      Width = 0
      Height = 428
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlEARight'
      TabOrder = 1
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 68
    Top = 140
  end
  object Query: TADOQuery
    Connection = DM.ADOConn
    CursorType = ctStatic
    AfterScroll = QueryAfterScroll
    Parameters = <>
    Left = 136
    Top = 136
  end
  object Command: TADOCommand
    Connection = DM.ADOConn
    Parameters = <>
    Left = 200
    Top = 136
  end
end
