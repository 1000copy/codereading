inherited frmGridMasterFields: TfrmGridMasterFields
  Left = 393
  Top = 218
  Width = 818
  Height = 575
  Caption = 'frmGridMasterFields'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlEditArea: TPanel
    Width = 810
    Height = 548
    inherited pnlEALeft: TPanel
      Width = 810
      Height = 340
      inherited FieldBox: TScrollBox
        Top = 0
        Width = 810
        Height = 92
        Align = alTop
        ParentColor = False
        object Label2: TLabel
          Left = 8
          Top = 4
          Width = 33
          Height = 13
          Caption = 'Master'
        end
        object Label4: TLabel
          Left = 8
          Top = 44
          Width = 23
          Height = 13
          Caption = 'Child'
        end
        object cboMasterTable: TComboBox
          Left = 8
          Top = 20
          Width = 149
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnClick = cboMasterTableClick
        end
        object cboChildTable: TComboBox
          Left = 8
          Top = 60
          Width = 149
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnClick = cboMasterTableClick
        end
        object Panel1: TPanel
          Left = 710
          Top = 0
          Width = 96
          Height = 88
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          DesignSize = (
            96
            88)
          object MCRefreshButton: TBitBtn
            Left = 8
            Top = 18
            Width = 81
            Height = 53
            Anchors = [akRight]
            Caption = 'Refresh'
            TabOrder = 0
            OnClick = MCRefreshButtonClick
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
              300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
              330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
              333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
              339977FF777777773377000BFB03333333337773FF733333333F333000333333
              3300333777333333337733333333333333003333333333333377333333333333
              333333333333333333FF33333333333330003333333333333777333333333333
              3000333333333333377733333333333333333333333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
          end
        end
        object GroupBox1: TGroupBox
          Left = 164
          Top = 4
          Width = 137
          Height = 77
          Caption = 'Master fields'
          TabOrder = 3
          object lbMasterFields: TListBox
            Left = 2
            Top = 15
            Width = 133
            Height = 60
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
          end
        end
        object GroupBox2: TGroupBox
          Left = 308
          Top = 4
          Width = 137
          Height = 77
          Caption = 'Child fields'
          TabOrder = 4
          object lbChildFields: TListBox
            Left = 2
            Top = 15
            Width = 133
            Height = 60
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
          end
        end
        object Rel: TValueListEditor
          Left = 480
          Top = 8
          Width = 213
          Height = 73
          KeyOptions = [keyDelete, keyUnique]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goRowSelect, goThumbTracking]
          TabOrder = 5
          TitleCaptions.Strings = (
            'Master'
            'Child')
          ColWidths = (
            104
            103)
        end
        object AddRelButton: TButton
          Left = 448
          Top = 24
          Width = 29
          Height = 49
          Caption = '>'
          TabOrder = 6
          OnClick = AddRelButtonClick
        end
      end
      inherited Grid: TDBGrid
        Top = 217
        Width = 810
        Height = 108
      end
      inherited lblRecNo: TStaticText
        Top = 325
        Width = 810
      end
      inherited pnlTop: TPanel
        Top = 92
        Width = 810
        inherited pnlNav: TPanel
          Left = 473
        end
      end
      inherited pnlQuery: TPanel
        Top = 149
        Width = 810
        Visible = False
        inherited pnlQueryBtn: TPanel
          Left = 713
        end
        inherited SQLQuery: TMemo
          Width = 712
        end
      end
    end
    inherited pnlEARight: TPanel
      Left = 0
      Top = 340
      Width = 810
      Height = 208
      Align = alBottom
      object GridChild: TDBGrid
        Left = 0
        Top = 57
        Width = 810
        Height = 136
        Align = alClient
        DataSource = DataSourceChild
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = GridKeyDown
        OnMouseMove = GridMouseMove
        OnTitleClick = GridTitleClick
      end
      object lblRecNoChild: TStaticText
        Left = 0
        Top = 193
        Width = 810
        Height = 15
        Align = alBottom
        Caption = 'lblRecNo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object pnlTopChild: TPanel
        Left = 0
        Top = 0
        Width = 810
        Height = 57
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 2
        object pnlTCB: TPanel
          Left = 1
          Top = 1
          Width = 808
          Height = 56
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object pnlSearchChild: TPanel
            Left = 0
            Top = 0
            Width = 209
            Height = 56
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object Label3: TLabel
              Left = 8
              Top = 8
              Width = 52
              Height = 13
              Caption = '&Search on:'
              FocusControl = edTraziChild
            end
            object edTraziChild: TEdit
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
            object cboTraziPoChild: TComboBox
              Left = 60
              Top = 4
              Width = 141
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 1
              OnClick = cboTraziPoClick
            end
          end
          object pnlTCN: TPanel
            Left = 467
            Top = 0
            Width = 341
            Height = 56
            Align = alRight
            BevelOuter = bvNone
            Caption = 'pnlTCN'
            TabOrder = 1
            object pnlNavChild: TPanel
              Left = 0
              Top = 0
              Width = 341
              Height = 56
              Align = alClient
              BevelInner = bvLowered
              BevelOuter = bvNone
              BorderWidth = 5
              TabOrder = 0
              object DBNavigatorChild: TDBNavigator
                Left = 6
                Top = 6
                Width = 329
                Height = 44
                DataSource = DataSourceChild
                VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
                Align = alClient
                Constraints.MaxHeight = 50
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
                TabOrder = 0
              end
            end
          end
        end
      end
    end
  end
  inherited DataSource: TDataSource
    Left = 92
    Top = 240
  end
  inherited Query: TADOQuery
    Left = 132
    Top = 240
  end
  inherited Command: TADOCommand
    Left = 172
    Top = 240
  end
  object QueryChild: TADOQuery
    Connection = DM.ADOConn
    AfterScroll = QueryAfterScroll
    DataSource = DataSource
    Parameters = <>
    Left = 636
    Top = 241
  end
  object DataSourceChild: TDataSource
    DataSet = QueryChild
    Left = 584
    Top = 241
  end
end
