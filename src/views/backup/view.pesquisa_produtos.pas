unit view.pesquisa_produtos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, MemDS, Forms, Controls, Graphics, DBGrids,
  uModels, Produto.Repositorio, ExtCtrls, Dialogs;

type
  { TViewPesquisaProdutos }
  TViewPesquisaProdutos = class(TForm)
    cdsControl: TMemDataSet;
    dsControl: TDataSource;
    grdPesquisar: TDBGrid;
    pnlPesquisa: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
  private
    FProdutos: TArrProdutosModel;
    FProdutoSelecionado: TProduto;
  public
    property ProdutoSelecionado: TProduto read FProdutoSelecionado;
  end;

var
  ViewPesquisaProdutos: TViewPesquisaProdutos;

implementation

{$R *.lfm}

{ TViewPesquisaProdutos }

procedure TViewPesquisaProdutos.FormCreate(Sender: TObject);
var
  LProduto: TProduto;
begin
  if cdsControl.Active then
    cdsControl.Close;

  cdsControl.FieldDefs.Clear;
  cdsControl.FieldDefs.Add('CodigoBarras', ftString, 20);
  cdsControl.FieldDefs.Add('Descricao', ftString, 100);
  cdsControl.FieldDefs.Add('Preco', ftCurrency);

  cdsControl.Open;

  FProdutos := TProdutoRepositorio.GetRepo;

  for LProduto in FProdutos do
  begin
    cdsControl.InsertRecord([LProduto.CodigoBarras, LProduto.Descricao, LProduto.Preco]);
  end;
end;

procedure TViewPesquisaProdutos.grdPesquisaDblClick(Sender: TObject);
var
  codBarrasSelecionado: string;
  produto: TProduto;
begin
  if cdsControl.RecordCount = 0 then
    Exit;

  codBarrasSelecionado := cdsControl.FieldByName('CodigoBarras').AsString;

  FProdutoSelecionado := Default(TProduto);
  for produto in FProdutos do
  begin
    if produto.CodigoBarras = codBarrasSelecionado then
    begin
      FProdutoSelecionado := produto;
      break;
    end;
  end;

  Self.ModalResult := mrOk;
end;

end.
