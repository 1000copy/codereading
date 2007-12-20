
{$IFDEF LINUX}
{$DEFINE DUNIT_CLX}
{$ENDIF}
program ListTest;

uses
  TestFramework,
  GUITestRunner,
  TListTestCase in 'TListTestCase.pas',
  FindFile in '..\..\delphi.about.com\TFindFile\FindFile.pas',
  tcFindFile in 'tcFindFile.pas';

{$R *.res}

begin
  TGUITestRunner.runRegisteredTests;
end.
