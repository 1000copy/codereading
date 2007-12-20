unit uutils;

interface
uses Windows, StdCtrls, SysUtils, Dialogs, Forms, Registry;


type
  TSQLConnection = class
    ServerName : string;
    DatabaseName : string;
    UserName : string;
    Password : string;
  end;



function SQLDate(const ADateTime : TDateTime) : string;

function RRead(Name,DefaultValue: string): string;
function RintRead(Name: string; DefaultValue: integer): integer;
function RWrite(Name,Value: string): boolean;
function RIntWrite(Name: string;Value: integer): boolean;

implementation


function SQLDate(const ADateTime : TDateTime) : string;
begin
  Result := FormatDateTime('mm"/"dd"/"yyyy', ADateTime);
end; (*SQLDate*)


//******************************************************************************
//******************************************************************************
function RRead(Name, DefaultValue: string):string;
var  Reg: TRegistry;
begin
 Reg := TRegistry.Create;
 result:='';
 with Reg do begin
  try
   RootKey := HKEY_CURRENT_USER;
   if OpenKey('\Software\ADP\' + Application.Title, TRUE) then
    begin
      Result := ReadString(Name);
      if Result = '' then
      begin
        RWrite(Name, DefaultValue);
        Result:=DefaultValue
      end;
    end;
  Finally
   free;
  end; //try
end;//with
end;
//******************************************************************************
function RintRead(Name : string; DefaultValue: integer):integer;
var  Reg: TRegistry;
begin
 Reg := TRegistry.Create;
 result:=0;
 with Reg do begin
  try
   RootKey := HKEY_CURRENT_USER;
   if OpenKey('\Software\ADP\' + Application.Title, TRUE) then
    begin
      try
       Result := ReadInteger(Name);
      except
        RintWrite(Name, DefaultValue);
        Result:=DefaultValue;
      end;
    end;
  Finally
   free;
  end; //try
end;//with
end;

//******************************************************************************
function RWrite(Name, Value : string):boolean;
var  Reg: TRegistry;
begin
 Reg := TRegistry.Create;
 Result:=True;
 with Reg do begin
  try
   RootKey := HKEY_CURRENT_USER;
   if OpenKey('\Software\ADP\' + Application.Title, TRUE) then
    WriteString(Name, Value)
   else Result:=False;
  Finally
   free;
  end; //try
 end;//with
end;
//*******************************************************************************
function RIntWrite(Name: string;Value: integer): boolean;
var  Reg: TRegistry;
begin
 Reg := TRegistry.Create;
 Result:=True;
 with Reg do begin
  try
   RootKey := HKEY_CURRENT_USER;
   if OpenKey('\Software\ADP\' + Application.Title, TRUE) then
    WriteInteger(Name, Value)
   else Result:=False;
  Finally
   free;
  end; //try
 end;//with
end;
//*******************************************************************************
end.
