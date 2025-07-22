unit Pedido.Repositorio;

{$mode ObjFPC}{$H+}

interface

uses
  uModels, StdCtrls, SysUtils;

type
  TPedidoRepositorio = class
  private
    class var PedidosRepo: TArrPedidosModel;
  public
    class procedure StartRepo;
    class procedure CadastrarPedido(APedido: TPedido);
    class function GetRepo: TArrPedidosModel;
    class procedure ShowPedidosLogs(AppLog: TMemo);
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

class procedure TPedidoRepositorio.ShowPedidosLogs(AppLog: TMemo);
var
  LPedido: TPedido;
begin
  AppLog.Lines.Clear;
  AppLog.Lines.Add('--- LOG DE PEDIDOS ---');
  for LPedido in PedidosRepo do
  begin
    AppLog.Lines.Add(
      Format('Cliente: %s | Data: %s | Valor Total: %s',
      [ LPedido.Cliente.Nome,
        FormatDateTime('dd/mm/yyyy', LPedido.DataPedido),
        FormatCurr('R$ #,##0.00', LPedido.ValorTotal)
      ])
    );
  end;
end;

end.
