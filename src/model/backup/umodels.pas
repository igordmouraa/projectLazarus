unit uModels;

{$mode ObjFPC}{$H+}

interface

type
  TCliente = record
    Nome: String;
    CPF: String;
  end;
  TArrClientesModel = array of TCliente;

  TProduto = record
    CodigoBarras: String;
    Descricao: String;
    Preco: Double;
  end;
  TArrProdutosModel = array of TProduto;

  TPedidoItem = record
    Produto: TProduto;
    Quantidade: Integer;
    ValorSubtotal: Double;
  end;
  TArrPedidoItens = array of TPedidoItem;

  TPedido = record
    Cliente: TCliente;
    DataPedido: TDateTime;
    Itens: TArrPedidoItens;
    ValorTotal: Double;
  end;
  TArrPedidosModel = array of TPedido;

implementation

end.
