unit TListTestCase;

interface

uses
  Classes, SysUtils,
  TestFrameWork;
type
  TTestCaseList = class(TTestCase)
  private
    FEmpty: TList;
    FFull: TList;

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestQuote;
  end;

implementation

procedure TTestCaseList.SetUp;
begin
end;
procedure TTestCaseList.TearDown;
begin
end;

procedure TTestCaseList.TestQuote;
begin
  Check(1=1,'Not 2');
end;

initialization
  RegisterTest('', TTestCaseList.Suite);
end.
