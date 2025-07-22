unit view.menu_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  view.menu_cliente, view.menu_produto, view.menu_pedido,
  Cliente.Repositorio, Produto.Repositorio, Pedido.Repositorio;

type
  { TViewPrincipal }
  TViewPrincipal = class(TForm)
    btnMenuCliente: TButton;
    btnMenuPedido: TButton;
    btnMenuProduto: TButton;
    mmoLog: TMemo;
    mmoLogP: TMemo;
    mmoLogPD: TMemo;
    pnlMenu: TPanel;
    procedure btnMenuClienteClick(Sender: TObject);
    procedure btnMenuProdutoClick(Sender: TObject);
    procedure btnMenuPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.lfm}

{ TViewPrincipal }

procedure TViewPrincipal.btnMenuClienteClick(Sender: TObject);
var
  LCliente: TViewCliente;
begin
  LCliente := TViewCliente.Create(Self);
  try
    LCliente.ShowModal;
    if LCliente.ModalResult = mrOk then
      TClienteRepositorio.ShowClientesLogs(mmoLog);
  finally
    LCliente.Free;
  end;
end;

procedure TViewPrincipal.btnMenuProdutoClick(Sender: TObject);
var
  LProduto: TViewProduto;
begin
  LProduto := TViewProduto.Create(Self);
  try
    LProduto.ShowModal;
    if LProduto.ModalResult = mrOk then
      TProdutoRepositorio.ShowProdutosLogs(mmoLogP);
  finally
    LProduto.Free;
  end;
end;

procedure TViewPrincipal.btnMenuPedidoClick(Sender: TObject);
var
  LPedido: TViewPedido;
begin
  LPedido := TViewPedido.Create(Self);
  try
    LPedido.ShowModal;
    if LPedido.ModalResult = mrOk then
    begin
      TPedidoRepositorio.ShowPedidosLogs(mmoLogPD);
    end;
  finally
    LPedido.Free;
  end;
end;

procedure TViewPrincipal.FormShow(Sender: TObject);
begin
  TClienteRepositorio.StartRepo();
  TProdutoRepositorio.StartRepo();
  TPedidoRepositorio.StartRepo();
end;

end.
