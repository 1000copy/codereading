program ADPDBExplorer;

{%ToDo 'ADPDBExplorer.todo'}

uses
  Forms,
  MAIN in 'MAIN.PAS' {MainForm},
  ugridfields in 'ugridfields.pas' {frmGridFields},
  uutils in 'uutils.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  ugridmasterfields in 'ugridmasterfields.pas' {frmGridMasterFields},
  OpenSQLServer in 'OpenSQLServer.pas' {OpenSQLServerForm},
  UAbout in 'UAbout.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ADP DB Explorer';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
