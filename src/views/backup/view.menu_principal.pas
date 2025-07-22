unit view.menu_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  view.menu_cliente, view.menu_produto, Cliente.Repositorio, Produto.Repositorio;

type

  { TViewPrincipal }

  TViewPrincipal = class(TForm)
    btnMenuCliente: TButton;
    btnMenuPedido: TButton;
    btnMenuProduto: TButton;
    mmoLog: TMemo;
    mmoLogP: TMemo;
    pnlMenu: TPanel;
    procedure btnMenuClienteClick(Sender: TObject);
    procedure btnMenuProdutoClick(Sender: TObject);
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
    begin
      //ShowMessage('3 - ModalResult foi OK! Atualizando o memo.');
      TClienteRepositorio.ShowClientesLogs(mmoLog);
    end;


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
    begin
      //ShowMessage('3 - ModalResult foi OK! Atualizando o memo.');
      TProdutoRepositorio.ShowProdutosLogs(mmoLog);
    end;


  finally
    LProduto.Free;
  end;

end;

procedure TViewPrincipal.FormShow(Sender: TObject);
begin
  TClienteRepositorio.StartRepo();
  TProdutoRepositorio.StartRepo();
end;

end.
