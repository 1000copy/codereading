unit uExample;

interface
  end;

{ TTestCaseList }

//------------------------------------------------------------------------------
procedure TTestcaseTemplate.SetUp;
var
begin
end;


  Check(2=1+1,'OnePlusOneNotEqualsTwo');
end;
initialization
  RegisterTest('', TTestcaseTemplate.Suite);