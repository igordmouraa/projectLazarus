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
  //Models
  uModels,
  //Views
  view.menu_principal,
  view.menu_cliente,
  view.pesquisa_clientes,
  view.menu_produto,
  //Repositorios
  Cliente.Repositorio,
  Produto.Repositorio, view.pesquisa_produtos, view.menu_pedido;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.MainFormOnTaskbar:=True;
  Application.Initialize;


  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TViewPesquisaProdutos, ViewPesquisaProdutos);
  Application.CreateForm(TViewPedido, ViewPedido);
  Application.Run;
end.
