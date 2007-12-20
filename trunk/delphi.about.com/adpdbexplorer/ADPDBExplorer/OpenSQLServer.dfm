object OpenSQLServerForm: TOpenSQLServerForm
  Left = 372
  Top = 188
  BorderStyle = bsDialog
  Caption = 'SQL Server connection...'
  ClientHeight = 339
  ClientWidth = 326
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 326
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 316
      Height = 286
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Connection properties'
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 228
          Height = 13
          Caption = 'Server name (pick from the list or enter manually)'
        end
        object Label2: TLabel
          Left = 8
          Top = 176
          Width = 75
          Height = 13
          Caption = 'Database name'
        end
        object cboServers: TComboBox
          Left = 8
          Top = 24
          Width = 289
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnClick = cboServersClick
          OnExit = cboServersClick
        end
        object cboDatabases: TComboBox
          Left = 8
          Top = 192
          Width = 289
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 52
          Width = 289
          Height = 117
          Caption = 'Login info'
          TabOrder = 2
          object rbTrustedConnection: TRadioButton
            Left = 8
            Top = 20
            Width = 181
            Height = 17
            Caption = 'Use Windows integrated security'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = rbTrustedConnectionClick
          end
          object rbLoginInfo: TRadioButton
            Left = 8
            Top = 44
            Width = 237
            Height = 17
            Caption = 'Use a specific user name and password'
            TabOrder = 1
            OnClick = rbLoginInfoClick
          end
          object ledUserName: TLabeledEdit
            Left = 24
            Top = 84
            Width = 121
            Height = 21
            EditLabel.Width = 51
            EditLabel.Height = 13
            EditLabel.Caption = 'User name'
            TabOrder = 2
          end
          object ledPwd: TLabeledEdit
            Left = 156
            Top = 84
            Width = 121
            Height = 21
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Caption = 'Password'
            TabOrder = 3
          end
        end
        object TestConButton: TBitBtn
          Left = 172
          Top = 224
          Width = 123
          Height = 25
          Caption = 'Test connection'
          TabOrder = 3
          OnClick = TestConButtonClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
            33333333333F8888883F33330000324334222222443333388F3833333388F333
            000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
            F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
            223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
            3338888300003AAAAAAA33333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333344444433FFFF333333888888
            00003A444333333A22222438888F333338F3333800003A2243333333A2222438
            F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
            22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
            33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 296
    Width = 326
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 212
      Top = 4
      Width = 99
      Height = 33
      Caption = 'Close'
      TabOrder = 0
      Kind = bkCancel
    end
    object btnOK: TBitBtn
      Left = 15
      Top = 4
      Width = 126
      Height = 33
      Caption = 'OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
      OnClick = btnOKClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
