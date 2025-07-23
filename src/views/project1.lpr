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
  Forms,
  memdslaz,
  datetimectrls,
  //Model
  uModels in 'model/uModels.pas',
  //Repositorio
  Cliente.Repositorio in 'repo/Cliente.Repositorio.pas',
  Produto.Repositorio in 'repo/Produto.Repositorio.pas',
  Pedido.Repositorio in 'repo/Pedido.Repositorio.pas',
  //Views
  view.menu_principal in 'views/view.menu_principal.pas',
  view.menu_cliente in 'views/view.menu_cliente.pas',
  view.pesquisa_clientes in 'views/view.pesquisa_clientes.pas',
  view.menu_produto in 'views/view.menu_produto.pas',
  view.pesquisa_produtos in 'views/view.pesquisa_produtos.pas',
  view.menu_pedido in 'views/view.menu_pedido.pas',
  view.pesquisa_pedidos in 'views/view.pesquisa_pedidos.pas',
  view.detalhe_pedido in 'views/view.detalhe_pedido.pas';

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title:='projetoTeste';
  Application.Scaled:=True;
  Application.MainFormOnTaskbar := True;
  Application.Initialize;

  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.

