unit view.pesquisa_pedidos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, memds, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Grids, uModels, view.detalhe_pedido, Pedido.Repositorio;

type

  { TViewPesquisaPedidos }

  TViewPesquisaPedidos = class(TForm)
    dsControl: TDataSource;
    grdPesquisar: TDBGrid;
    cdsControl: TMemDataset;
    pnlPesquisa: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure grdPesquisarDblClick(Sender: TObject);
  private

  public

  end;

var
  ViewPesquisaPedidos: TViewPesquisaPedidos;

implementation

{$R *.lfm}

{ TViewPesquisaPedidos }

procedure TViewPesquisaPedidos.FormCreate(Sender: TObject);
var LPedido: TPedido;
    LPedidos: TArrPedidosModel;
    i: Integer; //indice de referencia do pedido
begin
  if cdsControl.Active then
     cdsControl.Close;

  cdsControl.FieldDefs.Clear;
  cdsControl.FieldDefs.Add('Cliente', ftString, 30);
  cdsControl.FieldDefs.Add('Data', ftDate);
  cdsControl.FieldDefs.Add('ValorTotal', ftCurrency);
  cdsControl.FieldDefs.Add('PedidoIndex', ftInteger);
  cdsControl.Open;

  cdsControl.FieldByName('PedidoIndex').Visible := False;  //torna o campo do indice invisivel

  LPedidos := TPedidoRepositorio.GetRepo;
  for i := 0 to High(LPedidos) do
  begin
    LPedido := LPedidos[i];
    cdsControl.InsertRecord([
      LPedido.Cliente.Nome,
      LPedido.DataPedido,
      LPedido.ValorTotal,
      i //indice que fica guardado
    ]);
  end;

end;

procedure TViewPesquisaPedidos.grdPesquisarDblClick(Sender: TObject);
var FormDetalhe: TViewDetalhePedido;
    PedidoSelecionado: TPedido;
    Index: Integer;
begin
  if cdsControl.RecordCount = 0 then
     Exit;

  Index := cdsControl.FieldByName('PedidoIndex').AsInteger;

  PedidoSelecionado := TPedidoRepositorio.GetRepo[Index];

  FormDetalhe := TViewDetalhePedido.Create(Self);
  try
    FormDetalhe.ExibirItens(PedidoSelecionado);
    FormDetalhe.ShowModal;
  finally
    FormDetalhe.Free;
  end;

end;

end.

