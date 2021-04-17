program Application;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Winapi.Windows,
  System.SysUtils;

type TFooProc = procedure;

procedure Call;
begin
  var lib := LoadLibrary('SomeDLL.dll');
  Assert(lib<> 0);

  var proc := TFooProc(GetProcAddress(lib, 'Foo'));
  Assert(Assigned(proc));
  proc();

  FreeLibrary(lib);
end;

begin
  // Link both the exe and dll with runtime packages!

  // First time, ok
  Call;

  // Second time, AV
  // Now the class dtor of TZipFile and TZipFile.FCP437Encoding.Free was called.
  // Because FCP437Encoding is not nil it wont be init again - AV
  Call;
end.
