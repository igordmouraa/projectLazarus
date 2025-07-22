program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces,
  Forms, memdslaz,
  //Views
  view.menu_principal,
  view.menu_cliente,
  view.pesquisa_clientes,
  view.menu_produto,
  //Repositorios
  Cliente.Repositorio,
  Produto.Repositorio,


{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.MainFormOnTaskbar:=True;
  Application.Initialize;


  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TViewProduto, ViewProduto);
  Application.Run;
end.
