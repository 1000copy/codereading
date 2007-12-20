unit OpenSQLServer;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, uutils, Dialogs;

type
  TOpenSQLServerForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    cboServers: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cboDatabases: TComboBox;
    GroupBox1: TGroupBox;
    rbTrustedConnection: TRadioButton;
    rbLoginInfo: TRadioButton;
    ledUserName: TLabeledEdit;
    ledPwd: TLabeledEdit;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    TestConButton: TBitBtn;
    procedure rbLoginInfoClick(Sender: TObject);
    procedure rbTrustedConnectionClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure cboServersClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure TestConButtonClick(Sender: TObject);
  private
    procedure DatabasesOnServer(Databases : TStrings; const ServerName:string);
    function ConstructConnStr(const ServerName : string) : widestring;
  public
    SC : TSQLConnection;
    constructor Create(var SQLCon : TSQLConnection); reintroduce;
  end;

var
  OpenSQLServerForm: TOpenSQLServerForm;

implementation
{$R *.dfm}

uses Variants, ActiveX, comobj, adodb, adoint, oledb, db;

function PtCreateADOObject(const ClassID: TGUID): IUnknown;
var
  Status: HResult;
  FPUControlWord: Word;
begin
  asm
    FNSTCW  FPUControlWord
  end;
  Status := CoCreateInstance(CLASS_Recordset, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, IUnknown, Result);
  asm
    FNCLEX
    FLDCW FPUControlWord
  end;
  OleCheck(Status);
end;

procedure ListAvailableSQLServers(Names : TStrings);
var
  RSCon: ADORecordsetConstruction;
  Rowset: IRowset;
  SourcesRowset: ISourcesRowset;
  SourcesRecordset: _Recordset;
  SourcesName, SourcesType: TField;
begin
  SourcesRecordset := PtCreateADOObject(CLASS_Recordset) as _Recordset;
  RSCon := SourcesRecordset as ADORecordsetConstruction;
  SourcesRowset := CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator'))
as ISourcesRowset;
  OleCheck(SourcesRowset.GetSourcesRowset(nil, IRowset, 0, nil,
IUnknown(Rowset)));
  RSCon.Rowset := RowSet;
  with TADODataSet.Create(nil) do try
    Recordset := SourcesRecordset;
    SourcesName := FieldByName('SOURCES_NAME'); { do not localize }
    SourcesType := FieldByName('SOURCES_TYPE'); { do not localize }
    Names.BeginUpdate;
    try
      while not EOF do begin
        if (SourcesType.AsInteger = DBSOURCETYPE_DATASOURCE)
            and
          (SourcesName.AsString <> '')
        then
          Names.Add(SourcesName.AsString);
        Next;
      end;
    finally
      Names.EndUpdate;
    end;
  finally
    Free;
  end;
end;

procedure TOpenSQLServerForm.DatabasesOnServer(Databases : TStrings; const ServerName:string);
var
  rs : _RecordSet;
begin
    //you can use any of next 2 assignments
  with TAdoConnection.Create(nil) do
  try
    ConnectionString := ConstructConnStr(ServerName);
    LoginPrompt := False;
    try
      Open;
      rs := ConnectionObject.OpenSchema(adSchemaCatalogs, EmptyParam, EmptyParam);//more general approach in terms of ADO
      with rs do
      begin
        while not Eof do
        begin
          Databases.Add(VarToStr(Fields['CATALOG_NAME'].Value));
          MoveNext;
        end;
      end;
      Close;
    except
      on e:exception do
        MessageDlg(e.Message,mtError, [mbOK],0);
    end;
  finally
    Free;
  end;
end;


constructor TOpenSQLServerForm.Create(var SQLCon: TSQLConnection);
begin
  inherited Create(nil);
  SC := SQLCon;

  Screen.Cursor := crSQLWait;
  try
    ListAvailableSQLServers(self.cboServers.Items);
  finally
    Screen.Cursor := crDefault;
  end;



end;

procedure TOpenSQLServerForm.rbLoginInfoClick(Sender: TObject);
begin
  ledUserName.Enabled := True;
  ledPwd.Enabled := True;
end;

procedure TOpenSQLServerForm.rbTrustedConnectionClick(Sender: TObject);
begin
  ledUserName.Enabled := False;
  ledPwd.Enabled := False;
end;

procedure TOpenSQLServerForm.OKBtnClick(Sender: TObject);
begin
  sc.ServerName := 'zarko';
end;

procedure TOpenSQLServerForm.cboServersClick(Sender: TObject);
var
  db : string;
begin
  //if cboServers.ItemIndex = -1 then Exit;

  db := cboServers.Items[cboServers.ItemIndex];
  if db  = '' then db := cboServers.Text;

  if db  = '' then Exit;

  cboDatabases.Clear;

  DatabasesOnServer(cboDatabases.Items, db);
end;

function TOpenSQLServerForm.ConstructConnStr (const ServerName :string): widestring;
begin
  Result:= 'Data Source=' + ServerName + ';Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False';
  if self.rbLoginInfo.Checked then
  begin
    Result := Result + ';uid='+ledUserName.Text+';pwd='+ledPwd.text;
  end
end;

procedure TOpenSQLServerForm.btnOKClick(Sender: TObject);
begin
  TestConButtonClick(Sender);
  if (sc.ServerName  = '') OR (sc.DatabaseName = '') then
  begin
    ModalResult:= mrNone;
    Exit;
  end;
end;

procedure TOpenSQLServerForm.TestConButtonClick(Sender: TObject);
var
  dbc : TAdoConnection;
begin
  sc.ServerName:= cboServers.Text; //cboServers.Items[cboServers.ItemIndex];
  sc.DatabaseName :=cboDatabases.Items[cboDatabases.ItemIndex];
  sc.UserName := ledUserName.Text;
  sc.Password := ledPwd.Text;

  if (sc.ServerName  = '') OR (sc.DatabaseName = '') then
  begin
    MessageDlg('Select at least a server and a database!',mtWarning, [mbOK],0);
    Exit;
  end;

  dbC := TAdoConnection.Create(nil);
  try
    dbc.LoginPrompt := False;
    dbc.ConnectionString := 'Initial Catalog=' + sc.DatabaseName + ';Data Source=' + sc.ServerName + ';Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False';
    if sc.UserName <>'' then
      dbc.ConnectionString := dbc.ConnectionString + ';uid='+sc.UserName+';pwd='+sc.Password;
    try
      dbc.Open;
      dbc.Close;
      MessageDlg('Connection successful',mtInformation, [mbOK],0);
    except
      on e:exception do
        MessageDlg(e.Message,mtError, [mbOK],0);
    end;
  finally
    if dbc.Connected then dbc.Close;
    dbc.Free;
  end;
end;

end.

