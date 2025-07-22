program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, memdslaz,
  view.menu_principal,
  view.menu_cliente,
  Cliente.Repositorio,
  view.pesquisa_clientes;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.MainFormOnTaskbar:=True;
  Application.Initialize;


  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
