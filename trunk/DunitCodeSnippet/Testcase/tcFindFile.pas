unit tcFindFile;

interface

uses
  Classes, SysUtils,
  TestFrameWork,FindFile;
type
  TtcFindFile = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ClearAllDelphiGabage;
  end;

implementation

procedure TtcFindFile.SetUp;
begin
end;
procedure TtcFindFile.TearDown;
begin
end;
//

//(clearfiles rescure=true
//            directory="E:\codestock\codereading"
//            (mklist "*.dcu" "*.ddp" "*.exe" "*.~*"))
// return delete file's count
procedure TtcFindFile.ClearAllDelphiGabage;
var
  ff : TFindFile ;
  s : tStringList;
begin
  ff := TFindFile.Create(nil) ;
  try
    ff.InSubFolders := true;
    ff.Path := 'E:\codestock\codereading';
    ff.FileAttr := ff.FileAttr+[ffaAnyFile] ;
    ff.FileMask := '*.dcu';
    s := ff.SearchForFiles;
    ff.DeleteAll;
    ff.FileMask := '*.ddp';
    s := ff.SearchForFiles;
    ff.DeleteAll;
    ff.FileMask := '*.exe';
    s := ff.SearchForFiles;
    ff.DeleteAll;
    ff.FileMask := '*.~*';
    s := ff.SearchForFiles;
    ff.DeleteAll;

    Check(False,s.Text);
  finally
    ff.free ;
  end;

end;

initialization
  RegisterTest('', TtcFindFile.Suite);
end.
