unit Pedido.Repositorio;

{$mode ObjFPC}{$H+}

interface

uses
  uModels;

type
  TPedidoRepositorio = class
  private
    class var PedidosRepo: TArrPedidosModel;
  public
    class procedure StartRepo;
    class procedure CadastrarPedido(APedido: TPedido);
    class function GetRepo: TArrPedidosModel;
  end;

implementation

class procedure TPedidoRepositorio.StartRepo;
begin
  SetLength(PedidosRepo, 0);
end;

class procedure TPedidoRepositorio.CadastrarPedido(APedido: TPedido);
begin
  SetLength(PedidosRepo, Length(PedidosRepo) + 1);
  PedidosRepo[High(PedidosRepo)] := APedido;
end;

class function TPedidoRepositorio.GetRepo: TArrPedidosModel;
begin
  Result := PedidosRepo;
end;

end.
