unit ugridfields;

interface

uses
  Consts, Buttons, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CustomizeDlg, ExtCtrls, ComCtrls, Grids, DBGrids, DB,
  ADODB, DBCtrls, ImgList, StrUtils;

type
  THackDBNavigator = class(TDBNavigator);

  TADPDBGrid = class(TCustomGrid)
  end;
  TfrmGridFields = class(TForm)
    Grid: TDBGrid;
    DataSource: TDataSource;
    pnlTop: TPanel;
    Query: TADOQuery;
    FieldBox: TScrollBox;
    pnlNav: TPanel;
    DBNavigator: TDBNavigator;
    pnlSearch: TPanel;
    edTrazi: TEdit;
    cboTraziPo: TComboBox;
    Label1: TLabel;
    lblRecNo: TStaticText;
    pnlEditArea: TPanel;
    pnlEALeft: TPanel;
    pnlEARight: TPanel;
    SQLQuery: TMemo;
    pnlQuery: TPanel;
    pnlQueryBtn: TPanel;
    RefreshButton: TBitBtn;
    Command: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edTraziEnter(Sender: TObject);
    procedure cboTraziPoClick(Sender: TObject);
    procedure edTraziKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edTraziExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure QueryAfterScroll(DataSet: TDataSet);
    procedure RefreshButtonClick(Sender: TObject);
    procedure DBNavigatorBeforeAction(Sender: TObject;
      Button: TNavigateBtn);
  private
    fSort: string;
    fSortChild: string;

    fDescription: string;

    ChildQuery : TAdoQuery;
    ChildGrid : TDBGrid;
    ChildDBNavigator : TDBNavigator;

    ChildcboTraziPo : TComboBox;
    ChildedTrazi : TEdit;


    procedure SetDescription(const Value: string);
    procedure SortGrid(const AGrid:TDBGrid; FieldName : string; OnlyRefresh : boolean = False);
    procedure QueryRequery(const AQuery: TADOQuery);

    procedure FillSearchCombo(const aCombo : TComboBox; const AQuery : TAdoQuery);

    procedure SetupHackedNavigator(const Navigator : TDBNavigator);
    function IsChildSender(const ControlName : string) : boolean;

  public
    property Description : string read fDescription write SetDescription;
  end;

const
 sSEARCH_ENTER = 'Enter a term to search, hit [RETURN]';

var
  frmGridFields: TfrmGridFields;

implementation
{$R *.dfm}
uses Main, uutils, uDM;


procedure TfrmGridFields.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  MainForm.lblTOP.Caption := Application.Title;
  MainForm.CloseButton.Visible:=False;

  if ChildQuery <> nil then ChildQuery.Close;
  Query.Close;

  Action:=caFree;
end;

procedure TfrmGridFields.GridTitleClick(Column: TColumn);
begin
  SortGrid(TDBGrid(Column.Grid), Column.Field.FieldName);
end;

procedure TfrmGridFields.FormCreate(Sender: TObject);
begin
  self.lblRecNo.Caption :='No dataset opened!';
  try //Bad, but who cares
    TStaticText(FindComponent('lblRecNoChild')).Caption :='No dataset opened!';
  except
  end;


  ChildQuery := nil;
  ChildQuery := TAdoQuery(FindComponent('QueryChild'));

  ChildGrid := nil;
  ChildGrid := TDBGrid(FindComponent('GridChild'));

  ChildDBNavigator := nil;
  ChildDBNavigator := TDBNavigator(FindComponent('DBNavigatorChild'));

  ChildcboTraziPo := nil;
  ChildcboTraziPo := TComboBox(FindComponent('cboTraziPoChild'));

  ChildedTrazi := nil;
  ChildedTrazi := TEdit(FindComponent('edTraziChild'));


  SetupHackedNavigator(DBNavigator);
  SetupHackedNavigator(ChildDBNavigator);

  if Query.SQL.Text <> '' then Query.Open;
  if (ChildQuery <> nil) AND (ChildQuery.SQL.Text <> '') then ChildQuery.Open;


  Grid.TitleFont.Style:=Grid.TitleFont.Style + [fsBold];

  FillSearchCombo(cboTraziPo,Query);
  FillSearchCombo(TComboBox(FindComponent('cboTraziPoChild')),ChildQuery);


  QueryRequery(Query);
  QueryRequery(ChildQuery);
end; {TfrmGridFields.FormCreate}

procedure TfrmGridFields.GridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  pt: TGridcoord;
begin
  pt:= TDBGrid(Sender).MouseCoord( x, y );

  if pt.y=0 then TDBGrid(Sender).Cursor:=crHandPoint else TDBGrid(Sender).Cursor:=crDefault;
end;

procedure TfrmGridFields.edTraziEnter(Sender: TObject);
begin
  if TEdit(Sender).Text = sSEARCH_ENTER then
  begin
    TEdit(Sender).Text := '';
    TEdit(Sender).Font.Color := clWindowText;
  end
end;

procedure TfrmGridFields.cboTraziPoClick(Sender: TObject);
begin
  if IsChildSender(TComboBox(Sender).Name) then
    ChildedTrazi.SetFocus
  else
    edTrazi.SetFocus;
end;

procedure TfrmGridFields.edTraziKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ffield:TField;
  strazi: string;
  opts : TLocateOptions;
  cbo : TComboBox;
  q : TAdoQuery;
begin
  if Key <> VK_RETURN then Exit;

  if IsChildSender(TEdit(Sender).Name) then
  begin
    cbo := ChildcboTraziPo;
    q :=  ChildQuery;
  end
  else
  begin
    cbo := cboTraziPo;
    q :=  Query;
  end;


  ffield := TField(cbo.Items.Objects[cbo.ItemIndex]);
  strazi := TEdit(Sender).Text;
  opts := [loCaseInsensitive, loPartialKey];
  Screen.Cursor := crHourGlass;
  if q.Locate(ffield.DisplayName, strazi, opts) then
  begin
    TEdit(Sender).Text := ffield.AsString;
  end;
  Screen.Cursor := crDefault;

end;

procedure TfrmGridFields.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    Key := 0; {ignore}
end;

procedure TfrmGridFields.edTraziExit(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
  begin
    TEdit(Sender).Font.Color := clGray;
    TEdit(Sender).Text := sSEARCH_ENTER;
  end;
end;

procedure TfrmGridFields.SetupHackedNavigator(const Navigator: TDBNavigator);
const
  Captions : array[TNavigateBtn] of string =
      ('First', 'Proir', 'Next', 'Last', '&Add',
       'Delete', 'Edit', 'Save', 'Cancel', 'Refresh');
var
  btn : TNavigateBtn;
begin

  if NOT Assigned(Navigator) then Exit;

  for btn := Low(TNavigateBtn) to High(TNavigateBtn) do
  with THackDBNavigator(Navigator).Buttons[btn] do
  begin
    Caption := Captions[btn];
    NumGlyphs := 2;
    Layout := blGlyphTop;
  end;
end; //SetupHackedNavigator


procedure TfrmGridFields.SetDescription(const Value: string);
begin
  if Value <> fDescription then
  begin
    fDescription := Value;
    Caption:=fDescription;
  end;
end;

procedure TfrmGridFields.FormActivate(Sender: TObject);
begin
  MainForm.CloseButton.Visible:=True;
end;

procedure TfrmGridFields.QueryAfterScroll(DataSet: TDataSet);
var
  st : TStaticText;
begin
  if NOT Assigned(Dataset) then Exit;
  if not DataSet.Active then Exit;

  if IsChildSender(Dataset.Name) then
    st:=TStaticText(FindComponent('lblRecNoChild'))
  else
    st:=lblRecNo;

  st.Caption:='Record ' + IntToStr(TCustomADODataSet(DataSet).RecNo) + ' / ' + IntToStr(TCustomADODataSet(DataSet).RecordCount);


end;

procedure TfrmGridFields.SortGrid(const AGrid:TDBGrid; FieldName: string; OnlyRefresh: boolean);
var
  fs : string;
begin
  if NOT Assigned(AGrid) then Exit;
  if not AGrid.DataSource.DataSet.Active then Exit; 

  if IsChildSender(AGrid.Name) then
    fs:=fSortChild
  else
    fs:=fSort;


  try
    if OnlyRefresh then
    begin
      if fs <> '' then TCustomADODataSet(AGrid.DataSource.DataSet).Sort := fs;
      Exit;
    end;

    try
      Screen.Cursor := crSQLWait;

      if TCustomADODataSet(AGrid.DataSource.DataSet).Sort = FieldName then
        TCustomADODataSet(AGrid.DataSource.DataSet).Sort := FieldName + ' DESC'
      else
        TCustomADODataSet(AGrid.DataSource.DataSet).Sort := FieldName;
    finally
      Screen.Cursor := crDefault;
    end;
  except
  end;

  fs := TCustomADODataSet(AGrid.DataSource.DataSet).Sort;
end;

procedure TfrmGridFields.QueryRequery(const AQuery: TADOQuery);
var
  dbnav : TDBNavigator;
begin
  if not Assigned(AQuery) then Exit;
  if NOT AQuery.Active then Exit;

  if self.IsChildSender(AQuery.Name) then
  begin
    dbnav := ChildDBNavigator;
  end
  else
  begin
    dbnav := DBNavigator;
  end;

  AQuery.Requery();
  QueryAfterScroll(AQuery);

  THackDBNavigator(dbnav).Buttons[nbEdit].Enabled := AQuery.RecordCount > 0;

end;(*QueryRequery*)

function TfrmGridFields.IsChildSender(const ControlName: string): boolean;
begin
  if RightStr(ControlName,Length('Child'))  = 'Child' then
    Result := True
  else
    Result := False;
end; (*IsChildSender*)


procedure TfrmGridFields.FillSearchCombo(const aCombo: TComboBox; const AQuery: TAdoQuery);
var
  i: integer;
begin
  if NOT Assigned(AQuery) then Exit;

  aCombo.Clear;
  for i:=0 to AQuery.FieldCount - 1 do begin
    if AQuery.Fields.Fields[i].DataType in [ftWideString, ftDate, ftInteger] then
    begin
      aCombo.AddItem(AQuery.Fields[i].DisplayName, AQuery.Fields[i]);
    end;
  end; //for
  aCombo.ItemIndex := 0;
end; (*FillSearchCombo*)


function GetFirstWord(const input : string):string;
var
  tmp : string;
  i : integer;
begin
  tmp := Trim(input);
  i := Pos(' ',input);
  tmp := LeftStr(tmp,i-1);
  Result := LowerCase(tmp);
end;

procedure TfrmGridFields.RefreshButtonClick(Sender: TObject);
var
  raf : integer;
begin
  if Query.Active then Query.Close;

  if GetFirstWord(SQLQuery.Lines[0]) = 'select' then
  begin
    Query.SQL.Text := SQLQuery.Text;
    try
      Query.Open;
    except
      on e:exception do
      begin
        MessageDlg(e.Message,mtError, [mbOK],0);
      end;
    end;
  end
  else
  begin
    Command.CommandText :=  SQLQuery.Text;
    try
      Command.Execute(raf,EmptyParam);
      MessageDlg(intToStr(raf) + ' record affected',mtInformation, [mbOK],0);
    except
      on e:exception do
      begin
        MessageDlg(e.Message,mtError, [mbOK],0);
      end;
    end;
  end;
end;

procedure TfrmGridFields.DBNavigatorBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbRefresh then begin
    QueryRequery(TADOQuery(TDBNavigator(Sender).DataSource.DataSet));
    Abort;
  end;
end;

end.
