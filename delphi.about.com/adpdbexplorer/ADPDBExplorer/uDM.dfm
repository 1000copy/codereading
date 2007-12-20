object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 254
  Top = 193
  Height = 164
  Width = 223
  object ADOConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=biosShopImport;Data Source=ZARKO'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    BeforeDisconnect = ADOConnBeforeDisconnect
    OnDisconnect = ADOConnDisconnect
    OnConnectComplete = ADOConnConnectComplete
    Left = 16
    Top = 20
  end
  object RFQuery: TADOQuery
    Connection = ADOConn
    CursorLocation = clUseServer
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    ParamCheck = False
    Parameters = <>
    Left = 72
    Top = 20
  end
  object ExecCmd: TADOCommand
    Connection = ADOConn
    ExecuteOptions = [eoExecuteNoRecords]
    Parameters = <>
    Left = 140
    Top = 20
  end
  object RFQuery2: TADOQuery
    Connection = ADOConn
    CursorLocation = clUseServer
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    ParamCheck = False
    Parameters = <>
    Left = 72
    Top = 80
  end
end
