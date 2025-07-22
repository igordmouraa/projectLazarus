unit view.menu_produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  uModels, view.pesquisa_produtos,Produto.Repositorio;

type
  TProdutoOp = (opIncluir, opAlterar);

  { TViewProduto }
  TViewProduto = class(TForm)
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnPesquisarProdutos: TButton;
    edtCodBar: TEdit;
    edtPrc: TEdit;
    edtDesc: TEdit;
    lblCodBar: TLabel;
    lblPrc: TLabel;
    lblDesc: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarProdutosClick(Sender: TObject);
  private
    FProdutoModel: TProduto;
    FOperacao: TProdutoOp;
    procedure ValidaDadosPreenchidos;
    procedure PreencheModel;
  public
    procedure SetModel(AValue: TProduto);
    function GetModel: TProduto;
  end;

var
  ViewProduto: TViewProduto;

implementation

{$R *.lfm}

{ TViewProduto }

procedure TViewProduto.ValidaDadosPreenchidos;
begin
  if Trim(edtDesc.Text) = '' then
    raise Exception.Create('O campo Descrição é obrigatório!');

  if Trim(edtCodBar.Text) = '' then
    raise Exception.Create('O campo Código de Barras é obrigatório!');

  if Trim(edtPrc.Text) = '' then
    raise Exception.Create('O campo Preço é obrigatório!');

  try
    StrToFloat(edtPrc.Text);
  except
    on E: EConvertError do
      raise Exception.Create('O valor do Preço não é um número válido!');
  end;
end;

procedure TViewProduto.PreencheModel;
begin
  FProdutoModel.Descricao := edtDesc.Text;
  FProdutoModel.CodigoBarras := edtCodBar.Text;
  FProdutoModel.Preco := StrToFloat(edtPrc.Text);
end;

procedure TViewProduto.SetModel(AValue: TProduto);
begin
  FProdutoModel := AValue;
  edtDesc.Text := FProdutoModel.Descricao;
  edtCodBar.Text := FProdutoModel.CodigoBarras;
  edtPrc.Text := FloatToStr(FProdutoModel.Preco);
end;

function TViewProduto.GetModel: TProduto;
begin
  Result := FProdutoModel;
end;

procedure TViewProduto.FormCreate(Sender: TObject);
begin
  FOperacao := opIncluir;
end;

procedure TViewProduto.btnCancelarClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  Self.Close;
end;

procedure TViewProduto.btnPesquisarProdutosClick(Sender: TObject);
var
  LPesq: TViewPesquisaProdutos;
begin
  LPesq := TViewPesquisaProdutos.Create(Self);
  try
    if LPesq.ShowModal = mrOk then
    begin

      SetModel(LPesq.ProdutoSelecionado);

      FOperacao := opAlterar;
    end;
  finally
    LPesq.Free;
  end;
end;

procedure TViewProduto.btnSalvarClick(Sender: TObject);
begin
  try
    ValidaDadosPreenchidos;

    if FOperacao = opIncluir then
    begin
      if (TProdutoRepositorio.ExisteProdutoCadastrado(edtCodBar.Text) >= 0) then
        raise Exception.Create('Já existe um produto com este Código de Barras!');
    end;

    PreencheModel;

    TProdutoRepositorio.CadastrarProduto(FProdutoModel);

    Self.ModalResult := mrOk;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

end.
