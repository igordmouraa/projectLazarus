unit view.menu_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  view.menu_cliente, Cliente.Repositorio;

type

  { TViewPrincipal }

  TViewPrincipal = class(TForm)
    btn_menu_cliente: TButton;
    btn_menu_produto: TButton;
    btn_menu_pedido: TButton;
    mmoLog: TMemo;
    procedure btn_menu_clienteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.lfm}

{ TViewPrincipal }

procedure TViewPrincipal.btn_menu_clienteClick(Sender: TObject);
var
  LCliente: TViewCliente;
begin
  LCliente := TViewCliente.Create(Self);
  try

    LCliente.ShowModal;


    if LCliente.ModalResult = mrOk then
    begin
      ShowMessage('3 - ModalResult foi OK! Atualizando o memo.');
      TClienteRepositorio.ShowClientesLogs(mmoLog);
    end;


  finally
    LCliente.Free;
  end;

end;

procedure TViewPrincipal.FormShow(Sender: TObject);
begin
  TClienteRepositorio.StartRepo();
end;

end.
