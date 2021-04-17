
library SomeDLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Zip,
  System.IOUtils,
  System.Classes;

{$R *.res}

procedure Foo; stdcall;
begin
  var ZipFile := TZipFile.Create;
  try
    ZipFile.Open('Test.zip', zmReadWrite);
    WriteLn(ZipFile.FileNames[0]); // Will call Encoding and will use the already free'ed FCP437Encoding field
  finally
    FreeAndNil(ZipFile);
  end;
end;

exports Foo name 'Foo';


begin
end.
