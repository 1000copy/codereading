unit MAIN;

interface

uses
  consts, 
  Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, ActnMan, ActnColorMaps;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Window1: TMenuItem;
    Help1: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    actFileOpen: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ImageList1: TImageList;
    XPColorMap1: TXPColorMap;
    mnuFile: TMenuItem;
    mnuMRU: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    imgTop: TImage;
    lblTOP: TLabel;
    Panel2: TPanel;
    CloseButton: TSpeedButton;
    mnuOpen: TMenuItem;
    mnuExit: TMenuItem;
    mnuDisconect: TMenuItem;
    N3: TMenuItem;
    TreePanel: TPanel;
    DBTree: TTreeView;
    Splitter1: TSplitter;
    pnlBaza: TPanel;
    mnuOpenSQLServer: TMenuItem;
    N1: TMenuItem;
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure mnuDisconectClick(Sender: TObject);
    procedure DBTreeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuOpenSQLServerClick(Sender: TObject);
    procedure MRUClick(Sender: TObject; const FileName: String);
  private
    FConnectedTO : widestring;
  public
    procedure FillDBTree;
    procedure CloseChildren;
    property ConnectedTO : widestring read FConnectedTO write FConnectedTO;
  end;

const
  sFilterBy = 'Filter by:';

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uabout, uDM, ugridfields, ugridmasterfields;


procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  TAboutBox.ShowMe;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FConnectedTO:='';

  MainForm.lblTOP.Caption := Application.Title;
  MainForm.CloseButton.Visible:=False;

  //MainForm.MRU.RegistryPath := '\software\ADP\' + Application.Title + '\mru';
end;


procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
  self.ActiveMDIChild.Close;
end;


procedure TMainForm.actFileOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    if DM.ConnectDB(OpenDialog.FileName, dbtAccess) then
    begin
      //MRU.AddItem(OpenDialog.FileName);
    end
  end;
end;

procedure TMainForm.mnuDisconectClick(Sender: TObject);
begin
  if DM.AdoConn.Connected then
  try
    DM.AdoConn.Close;
  except on e: exception do
    MessageDlg(e.Message,mtError, [mbOK],0);
  end;
end;

procedure TMainForm.FillDBTree;
var
  Tables : TStringList;
  tn : TTreeNode;
  i:cardinal;
begin
  MainForm.DBTree.Items.Clear;

  (*
  Tables := TStringList.Create;
  try
    DM.ADOConn.GetProcedureNames(Tables);
    if Tables.Count > 0 then
    begin
      tn:=DBTree.Items.AddFirst(nil,'Queries');
      for i:=0 to Tables.Count-1 do
        DBTree.Items.AddChild(tn,Tables[i]);
    end;
  finally
    Tables.Free;
  end;
  *)

  Tables := TStringList.Create;
  try
    DM.ADOConn.GetTableNames(Tables,False);
    if Tables.Count > 0 then
    begin
      tn:=DBTree.Items.AddFirst(nil,'Tables');
      for i:=0 to Tables.Count-1 do
        DBTree.Items.AddChild(tn,Tables[i]);
    end;
  finally
    Tables.Free;
  end;

  //add an  option to add query
  tn:=DBTree.Items.AddFirst(nil,'Misc');
  DBTree.Items.AddChild(tn,'Query');
  DBTree.Items.AddChild(tn,'Master detail');

  DBTree.FullExpand;
end; (*FillDBTree*)

procedure TMainForm.DBTreeClick(Sender: TObject);
var
  TableForm : TfrmGridFields;
  TableName : string;
begin
  if DBTree.Selected = nil then Exit;
  if DBTree.Selected.Parent = nil then Exit;

  Screen.Cursor := crSQLWait;

  TableForm := TfrmGridMasterFields.Create(self);
  TableForm.pnlEARight.Visible := False;

  if DBTree.Selected.Parent.Text = 'Tables' then
  begin
    TableName := DBTree.Selected.Text;

    TableForm.pnlQuery.Visible := False;
    TableForm.Description := 'TABLE: '  + TableName ;
    TableForm.Query.SQL.Text:= 'SELECT * FROM [' + TableName +']';
    TableForm.Query.Open;
  end
  else
  begin
    if DBTree.Selected.Text ='Query' then
    begin
      TableForm.Description := '"Freehand" query';
      TableForm.pnlQuery.Visible := True;
    end
    else if DBTree.Selected.Text ='Master detail' then
    begin
      TableForm.Description := 'Master-detail';
      TableForm.pnlQuery.Visible := False;
      TableForm.pnlEARight.Visible := true;
      TableForm.FieldBox.Visible := True;
    end;
  end;


  TableForm.OnCreate(self);
  TableForm.OnActivate(self);

  TableForm.SQLQuery.SelectAll;

  Screen.Cursor := crDefault;

end;

procedure TMainForm.CloseChildren;
var
  i : cardinal;
begin
  if MainForm.MDIChildCount = 0 then Exit;
  for i:= 0 to MainForm.MDIChildCount-1 do
  begin
    MainForm.MDIChildren[i].Close;
  end;
end; (*CloseChildren*)

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseChildren;
end;

procedure TMainForm.mnuOpenSQLServerClick(Sender: TObject);
begin
  if DM.ConnectDB(OpenDialog.FileName, dbtSQLServer) then
  begin
    //MRU.AddItem(OpenDialog.FileName);
  end
end;

procedure TMainForm.MRUClick(Sender: TObject; const FileName: String);
begin
  DM.ConnectDB(FileName, dbtAccess)
end;

end.

