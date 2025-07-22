unit Produto.Repositorio;

{$mode ObjFPC}{$H+}

interface

uses
  uModels, StdCtrls, SysUtils, Dialogs;

type
  TProdutoRepositorio = class
  private
    class procedure AlterarProduto(AIndex: Integer; AProduto: TProduto);
    class procedure IncluirProduto(AProduto: TProduto);
    class var ProdutosRepo: TArrProdutosModel;
  public
    class procedure StartRepo;
    class function GetRepo: TArrProdutosModel;
    class function ExisteProdutoCadastrado(ACodigoBarras: String): Integer;
    class procedure CadastrarProduto(AProduto: TProduto);
    class procedure ShowProdutosLogs(AppLog: TMemo);
    class function GetProduto(ACodigoBarras: String): TProduto;
  end;

implementation

{ TProdutoRepositorio }

class procedure TProdutoRepositorio.AlterarProduto(AIndex: Integer; AProduto: TProduto);
begin
  if (AIndex >= Low(ProdutosRepo)) and (AIndex <= High(ProdutosRepo)) then
    ProdutosRepo[AIndex] := AProduto;
end;

class procedure TProdutoRepositorio.CadastrarProduto(AProduto: TProduto);
var
  index: Integer;
begin
  index := ExisteProdutoCadastrado(AProduto.CodigoBarras);
  if index >= 0 then
    AlterarProduto(index, AProduto)
  else
    IncluirProduto(AProduto);
end;

class function TProdutoRepositorio.ExisteProdutoCadastrado(ACodigoBarras: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := Low(ProdutosRepo) to High(ProdutosRepo) do
  begin
    if ProdutosRepo[i].CodigoBarras = ACodigoBarras then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

class function TProdutoRepositorio.GetProduto(ACodigoBarras: String): TProduto;
var
  LProduto: TProduto;
begin
  Result := Default(TProduto);
  for LProduto in ProdutosRepo do
  begin
    if LProduto.CodigoBarras = ACodigoBarras then
    begin
      Result := LProduto;
      Exit;
    end;
  end;
end;

class function TProdutoRepositorio.GetRepo: TArrProdutosModel;
begin
  Result := ProdutosRepo;
end;

class procedure TProdutoRepositorio.IncluirProduto(AProduto: TProduto);
var
  index: Integer;
begin
  index := Length(ProdutosRepo);
  SetLength(ProdutosRepo, index + 1);
  ProdutosRepo[index] := AProduto;
end;

class procedure TProdutoRepositorio.ShowProdutosLogs(AppLog: TMemo);
var
  LProduto: TProduto;
begin
  AppLog.Lines.Clear;
  AppLog.Lines.Add('--- LOG DE PRODUTOS ---');
  for LProduto in ProdutosRepo do
  begin

    AppLog.Lines.Add(Format('Cód: %s, Desc: %s, Preço: R$ %.2f',
      [LProduto.CodigoBarras, LProduto.Descricao, LProduto.Preco]));
  end;
end;

class procedure TProdutoRepositorio.StartRepo;
begin
  SetLength(ProdutosRepo, 0);
end;

end.
