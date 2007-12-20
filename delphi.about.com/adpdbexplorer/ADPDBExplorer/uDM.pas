unit uDM;

interface

uses
  StdCtrls,Controls, Windows, SysUtils, Classes, DB, ADODB, Dialogs;

type
  TDBType = (dbtSQLServer, dbtAccess);

  TDM = class(TDataModule)
    ADOConn: TADOConnection;
    RFQuery: TADOQuery;
    ExecCmd: TADOCommand;
    RFQuery2: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ADOConnConnectComplete(Connection: TADOConnection;
      const Error: Error; var EventStatus: TEventStatus);
    procedure ADOConnBeforeDisconnect(Sender: TObject);
    procedure ADOConnDisconnect(Connection: TADOConnection;
      var EventStatus: TEventStatus);
  private
  public
    function ConnectDB(const FileName : TFileName; const DBType : TDBType; pwd : string = ''):boolean;


  end;

var
  DM: TDM;
  fs : TFormatSettings;

implementation
  uses Main, OpenSQLServer, uutils;
{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fs);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  try
    if AdoConn.Connected then AdoConn.Close;
  except
  end;
end;


function TDM.ConnectDB(const FileName: TFileName; const DBType : TDBType; pwd : string = ''): boolean;
var
  DBName : widestring;
  SQLConnection : TSQLConnection;
begin
  //SQL SERVER
  //integrated Windows
  //Initial Catalog=DBNAME;Data Source=SERVERNAME;Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False

  //with PWD
  //uid=USERNAME;pwd=PASSWORD;
  Result := False;
  if DBType = dbtSQLServer then
  begin
    SQLConnection := TSQLConnection.Create;
    try
      with TOpenSQLServerForm.Create(SQLConnection) do
      try
        ShowModal;
        case ModalResult of
          idOk:
          begin
            DBName := SQLConnection.DatabaseName + ' on ' + SQLConnection.ServerName;
            AdoConn.ConnectionString := 'Initial Catalog=' + SQLConnection.DatabaseName + ';Data Source=' + SQLConnection.ServerName + ';Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False';
            if SQLConnection.UserName <>'' then
              AdoConn.ConnectionString := AdoConn.ConnectionString + ';uid='+SQLConnection.UserName+';pwd='+SQLConnection.Password;
          end;
          else
          begin
            Result := False;
            Exit;
          end;
        end;//case
      finally
        Free;
      end;
    finally
      SQLConnection.Free;
    end;
  end
  else
  begin
    AdoConn.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + FileName + ';Persist Security Info=False';
    if pwd <> '' then AdoConn.ConnectionString:=AdoConn.ConnectionString + ';Jet OLEDB:Database Password=' + pwd;
    DBName := FileName;
  end;

  AdoConn.LoginPrompt := False;

  result:=True;
  MainForm.ConnectedTO := DBName;
  try
    if NOT AdoConn.Connected then AdoConn.Open;
    Result:=True;
  except
    ON E:Exception do
    begin

      MessageDlg(e.Message,mtError, [mbOK],0);
      MainForm.ConnectedTO := '';
      pwd := InputBox('MDB with password','If this is password protected, please enter password (leave empty to cancel):','');
      if pwd = '' then
      begin
        Result := false;
        Exit;
      end
      else
        if ConnectDB(FileName, DBType, pwd) then Result := True;
    end;
  end;
end; (*ConnectDB*)

procedure TDM.ADOConnConnectComplete(Connection: TADOConnection;
  const Error: Error; var EventStatus: TEventStatus);
begin
  if EventStatus = esOK then
  begin
    MainForm.Cursor := crHourGlass;
    MainForm.actFileOpen.Enabled := False;
    MainForm.mnuMRU.Enabled := False;
    MainForm.mnuDisconect.Enabled := True;
    MainForm.mnuOpenSQLServer.Enabled := False;
    MainForm.pnlBaza.Caption := 'Connected to: '  + MainForm.ConnectedTO;
    MainForm.FillDBTree;
    MainForm.Cursor := crDefault;
  end
  else
  begin
    //
  end;
end;

procedure TDM.ADOConnBeforeDisconnect(Sender: TObject);
begin
  MainForm.CloseChildren;
end;

procedure TDM.ADOConnDisconnect(Connection: TADOConnection;
  var EventStatus: TEventStatus);
begin
    MainForm.DBTree.Items.Clear;
    MainForm.actFileOpen.Enabled := True;
    MainForm.mnuMRU.Enabled := True;
    MainForm.mnuOpenSQLServer.Enabled := True;
    MainForm.mnuDisconect.Enabled := False;
    MainForm.pnlBaza.Caption := 'NOT Connected!';
end;

end.
