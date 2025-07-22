unit view.menu_produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

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
  private

  public

  end;

var
  ViewProduto: TViewProduto;

implementation

{$R *.lfm}

end.

