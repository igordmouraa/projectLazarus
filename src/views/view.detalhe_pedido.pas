unit view.detalhe_pedido;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DB, MemDS, DBGrids,
  StdCtrls, ExtCtrls, uModels;

type

  {TViewDetalhePedido}

  TViewDetalhePedido = class(TForm)
    dsItens: TDataSource;
    grdItens: TDBGrid;
    Label1: TLabel;
    lblInfo: TLabel;
    cdsItens: TMemDataset;
    pnlPedido: TPanel;
  private

  public
    procedure ExibirItens(APedido: TPedido);

  end;

var
  ViewDetalhePedido: TViewDetalhePedido;

implementation

{$R *.lfm}

procedure TViewDetalhePedido.ExibirItens(APedido: TPedido);
var Item: TPedidoItem;
begin
  Self.Caption := 'Itens do Pedido - ' + APedido.Cliente.Nome;

  if cdsItens.Active then
     cdsItens.Close;

  cdsItens.FieldDefs.Clear;
  cdsItens.FieldDefs.Add('Produto', ftString, 50);
  cdsItens.FieldDefs.Add('Quantidade', ftInteger);
  cdsItens.FieldDefs.Add('PrecoUnit', ftCurrency);
  cdsItens.FieldDefs.Add('Subtotal', ftCurrency);
  cdsItens.Open;

  for Item in APedido.Itens do
  begin
    cdsItens.InsertRecord([
      Item.Produto.Descricao,
      Item.Quantidade,
      Item.Produto.Preco,
      Item.ValorSubtotal
    ]);
  end;
end;

end.

