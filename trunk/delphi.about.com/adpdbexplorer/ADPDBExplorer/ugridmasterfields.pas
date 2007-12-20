unit ugridmasterfields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ugridfields, DB, ADODB, StdCtrls, DBCtrls, Grids, DBGrids,
  ExtCtrls, udm, Buttons, ValEdit;

type

  THackDBNavigator = class(TDBNavigator);

  TfrmGridMasterFields = class(TfrmGridFields)
    GridChild: TDBGrid;
    lblRecNoChild: TStaticText;
    QueryChild: TADOQuery;
    DataSourceChild: TDataSource;
    pnlTopChild: TPanel;
    pnlNavChild: TPanel;
    DBNavigatorChild: TDBNavigator;
    pnlSearchChild: TPanel;
    Label3: TLabel;
    edTraziChild: TEdit;
    cboTraziPoChild: TComboBox;
    pnlTCB: TPanel;
    pnlTCN: TPanel;
    cboMasterTable: TComboBox;
    Label2: TLabel;
    cboChildTable: TComboBox;
    Label4: TLabel;
    Panel1: TPanel;
    MCRefreshButton: TBitBtn;
    GroupBox1: TGroupBox;
    lbMasterFields: TListBox;
    GroupBox2: TGroupBox;
    lbChildFields: TListBox;
    Rel: TValueListEditor;
    AddRelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cboMasterTableClick(Sender: TObject);
    procedure AddRelButtonClick(Sender: TObject);
    procedure MCRefreshButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGridMasterFields: TfrmGridMasterFields;

implementation

{$R *.dfm}

procedure TfrmGridMasterFields.FormCreate(Sender: TObject);
begin
  inherited;

  DM.ADOConn.GetTableNames(cboMasterTable.Items,False);
  DM.ADOConn.GetTableNames(cboChildTable.Items,False);

  //Rel.DeleteRow(0);
end;

procedure TfrmGridMasterFields.cboMasterTableClick(Sender: TObject);
var
  Table : string;
  aCombo : TComboBox;
  lb : TListBox;
  i : integer;
begin
  inherited;

  if NOT (sender is TComboBox) then Exit;

  aCombo := (Sender as TComboBox);

  if aCombo.Name = 'cboMasterTable' then
    lb:= self.lbMasterFields
  else
    lb:= self.lbChildFields;


  if aCombo.ItemIndex  = -1 then Exit;

  Table := aCombo.Items[aCombo.ItemIndex];

  lb.Clear;
  with TAdoQuery.Create(nil) do
  try
    Connection := DM.ADOConn;
    SQl.Text := 'SELECT TOP 1 * FROM ' + Table;
    try
      Open;
      for i:=0 to FieldCount - 1 do
        lb.Items.Add(Fields[i].DisplayName);
      Close;
    except
      on e:exception do MessageDlg(e.Message,mtError, [mbOK],0);
    end;
  finally
    Free;
  end;
end;

procedure TfrmGridMasterFields.AddRelButtonClick(Sender: TObject);
var
  mf, cf: string;
begin
  inherited;

  if lbMasterFields.ItemIndex = -1 then Exit;
  if lbChildFields.ItemIndex = -1 then Exit;

  mf:= lbMasterFields.Items[lbMasterFields.ItemIndex];
  cf:= lbChildFields.Items[lbChildFields.ItemIndex];

  Rel.InsertRow(mf,cf,True);
end;

procedure TfrmGridMasterFields.MCRefreshButtonClick(Sender: TObject);
var
  i: integer;
  mt, ct :string;
begin
  inherited;

  if QueryChild.Active then QueryChild.Close;
  if Query.Active then Query.Close;

  if Rel.Cells[1,1] = '' then
  begin
    MessageDlg('You must setup master-detail relations!',mtError, [mbOK],0);
    Exit;
  end;

  mt:=  cboMasterTable.Items[cboMasterTable.ItemIndex];
  ct:= cboChildTable.Items[cboChildTable.ItemIndex];

  QueryChild.SQL.Clear;
  QueryChild.SQL.Add('SELECT * FROM [' + ct +']');
  QueryChild.SQL.Add('WHERE ');
  for i:= 1 to -1 + Rel.RowCount do
  begin
    QueryChild.SQL.Add(ct + '.' + Rel.Values[Rel.Keys[i]] + ' = :'+Rel.Keys[i] );
    if i < (Rel.RowCount - 1) then QueryChild.SQL.Add(' AND ');
  end;

  //showmessage(QueryChild.SQL.text);

  Query.SQL.Text := 'SELECT * FROM [' + mt +']';
  try
    Query.Open;
    QueryChild.Open;
  except
    on e:exception do
    begin
      MessageDlg(e.Message,mtError, [mbOK],0);
    end;
  end;

end;

end.
