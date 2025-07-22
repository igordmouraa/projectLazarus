unit view.menu_pedido;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DBGrids, Grids, DB, MemDS, ExtCtrls, ComCtrls, DateTimePicker,
  uModels, view.pesquisa_clientes, view.pesquisa_produtos, view.pesquisa_pedidos, Cliente.Repositorio, Produto.Repositorio, Pedido.Repositorio;

type
  { TViewPedido }
  TViewPedido = class(TForm)
    btnAdicionarItem: TButton;
    btnCancelar: TButton;
    btnPesquisarCliente: TButton;
    btnSalvar: TButton;
    btnPesquisarPedidos: TButton;
    Button1: TButton;
    cdsItens: TMemDataSet;
    dsItens: TDataSource;
    dtpDataPedido: TDateTimePicker;
    edtCliente: TEdit;
    grdItens: TDBGrid;
    lblCliente: TLabel;
    lblData: TLabel;
    lblTotalPedido: TLabel;
    lblValorTotal: TLabel;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarPedidosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    FPedidoAtual: TPedido;
    procedure AtualizarTotais;
  public
    { Public declarations }
  end;

var
  ViewPedido: TViewPedido;

implementation

{$R *.lfm}

{ TViewPedido }

procedure TViewPedido.FormCreate(Sender: TObject);
begin
  if cdsItens.Active then cdsItens.Close;
  cdsItens.FieldDefs.Clear;
  cdsItens.FieldDefs.Add('CodBarras', ftString, 20);
  cdsItens.FieldDefs.Add('Descricao', ftString, 100);
  cdsItens.FieldDefs.Add('Quantidade', ftInteger);
  cdsItens.FieldDefs.Add('PrecoUnit', ftCurrency);
  cdsItens.FieldDefs.Add('Subtotal', ftCurrency);
  cdsItens.Open;

  FPedidoAtual := Default(TPedido);
  dtpDataPedido.Date := Now;
  AtualizarTotais;
end;

procedure TViewPedido.btnCancelarClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TViewPedido.btnPesquisarPedidosClick(Sender: TObject);
var LPesq: TViewPesquisaPedidos;
begin
  LPesq := TViewPesquisaPedidos.Create(Self);
  try
    LPesq.ShowModal;
  finally
    LPesq.Free;
  end;
end;

procedure TViewPedido.btnPesquisarClienteClick(Sender: TObject);
var
  FormPesq: TViewPesquisaClientes;
begin
  FormPesq := TViewPesquisaClientes.Create(Self);
  try
    if FormPesq.ShowModal = mrOk then
    begin
      FPedidoAtual.Cliente := FormPesq.ClienteSelecionado;
      edtCliente.Text := FPedidoAtual.Cliente.Nome;
    end;
  finally
    FormPesq.Free;
  end;
end;

procedure TViewPedido.btnAdicionarItemClick(Sender: TObject);
var
  FormPesq: TViewPesquisaProdutos;
  ProdutoSelecionado: TProduto;
  sQtd: String;
  iQtd: Integer;
  dSubtotal: Double;
begin
  FormPesq := TViewPesquisaProdutos.Create(Self);
  try
    if FormPesq.ShowModal = mrOk then
    begin
      ProdutoSelecionado := FormPesq.ProdutoSelecionado;


      sQtd := '1';
      if InputQuery('Adicionar Item', 'Quantidade:', sQtd) and (sQtd <> '') then
      begin
        try
          iQtd := StrToInt(sQtd);
          if iQtd > 0 then
          begin
            dSubtotal := iQtd * ProdutoSelecionado.Preco;
            cdsItens.Append;
            cdsItens.FieldByName('CodBarras').AsString := ProdutoSelecionado.CodigoBarras;
            cdsItens.FieldByName('Descricao').AsString := ProdutoSelecionado.Descricao;
            cdsItens.FieldByName('Quantidade').AsInteger := iQtd;
            cdsItens.FieldByName('PrecoUnit').AsCurrency := ProdutoSelecionado.Preco;
            cdsItens.FieldByName('Subtotal').AsCurrency := dSubtotal;
            cdsItens.Post;

            AtualizarTotais;
          end;
        except
          on E: EConvertError do
            ShowMessage('Quantidade inválida!');
        end;
      end;
    end;
  finally
    FormPesq.Free;
  end;
end;

procedure TViewPedido.AtualizarTotais;
var
  Total: Double;
begin
  Total := 0;
  cdsItens.First;
  while not cdsItens.Eof do
  begin
    Total := Total + cdsItens.FieldByName('Subtotal').AsCurrency;
    cdsItens.Next;
  end;
  lblValorTotal.Caption := FormatCurr('R$ #,##0.00', Total);
  FPedidoAtual.ValorTotal := Total;
end;

procedure TViewPedido.btnSalvarClick(Sender: TObject);
var
  Item: TPedidoItem;
begin
  if Trim(edtCliente.Text) = '' then
  begin
    ShowMessage('Por favor, selecione um cliente.');
    Exit;
  end;
  if cdsItens.RecordCount = 0 then
  begin
    ShowMessage('O pedido deve ter pelo menos um item.');
    Exit;
  end;

  FPedidoAtual.DataPedido := dtpDataPedido.Date;

  SetLength(FPedidoAtual.Itens, 0);
  cdsItens.First;
  while not cdsItens.Eof do
  begin
    Item.Produto := TProdutoRepositorio.GetProduto(cdsItens.FieldByName('CodBarras').AsString);
    Item.Quantidade := cdsItens.FieldByName('Quantidade').AsInteger;
    Item.ValorSubtotal := cdsItens.FieldByName('Subtotal').AsCurrency;
    SetLength(FPedidoAtual.Itens, Length(FPedidoAtual.Itens) + 1);
    FPedidoAtual.Itens[High(FPedidoAtual.Itens)] := Item;
    cdsItens.Next;
  end;

  TPedidoRepositorio.CadastrarPedido(FPedidoAtual);
  ModalResult := mrOk;
end;

end.
