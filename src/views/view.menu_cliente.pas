unit view.menu_cliente;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  uModels, Cliente.Repositorio, view.pesquisa_clientes, Types;

type
  TClienteOp = (cpIncluir, cpAlterar);

  { TViewCliente }

  TViewCliente = class(TForm)
    edtNome: TEdit;
    edtCPF: TEdit;
    lblNome: TLabel;
    lblCPF: TLabel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    btnPesquisarClientes: TButton;

    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClientesClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);

  private
    FClienteModel: TCliente;

    FOperacao: TClienteOp;

    procedure ValidaDadosPreenchidos;
    procedure PreencheModel;
  public
    procedure SetModel(AValue: TCliente);
    function GetModel: TCliente;
  end;

var
  ViewCliente: TViewCliente;

implementation

{$R *.lfm}

{ TViewCliente }

procedure TViewCliente.ValidaDadosPreenchidos;
begin
  if Trim(edtNome.Text) = '' then
    raise Exception.Create('O campo Nome é obrigatório!');

  if Trim(edtCPF.Text) = '' then
    raise Exception.Create('O campo CPF é obrigatório!');
end;

procedure TViewCliente.PreencheModel;
begin
  FClienteModel.Nome := edtNome.Text;
  FClienteModel.CPF := edtCPF.Text;
end;

procedure TViewCliente.SetModel(AValue: TCliente);
begin
  FClienteModel := AValue;
  edtNome.Text := FClienteModel.Nome;
  edtCPF.Text := FClienteModel.CPF;
end;

function TViewCliente.GetModel: TCliente;
begin
  Result := FClienteModel;
end;

procedure TViewCliente.FormCreate(Sender: TObject);
begin
  FOperacao := cpIncluir;
end;

procedure TViewCliente.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  FClienteModel.Nome := edtNome.Text;
  FClienteModel.CPF := edtCPF.Text;
end;

procedure TViewCliente.btnCancelarClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  Self.Close;
end;

procedure TViewCliente.btnPesquisarClientesClick(Sender: TObject);
var
  LPesq: TViewPesquisaClientes;
begin
  LPesq := TViewPesquisaClientes.Create(Self);
  try
    if LPesq.ShowModal = mrOk then
    begin
      SetModel(LPesq.ClienteSelecionado);
      FOperacao := cpAlterar;
    end;
  finally
    LPesq.Free;
  end;
end;

procedure TViewCliente.btnSalvarClick(Sender: TObject);
begin
  //ShowMessage('1 - Entrei no btnSalvarClick');
  try
    ValidaDadosPreenchidos;

    if FOperacao = cpIncluir then
    begin
      if (TClienteRepositorio.ExisteClienteCadastrado(edtCPF.Text) >= 0) then
        raise Exception.Create('Já existe um cliente com este CPF!');
    end;

    PreencheModel;

    TClienteRepositorio.CadastrarCliente(FClienteModel);

    //ShowMessage('2 - Dados cadastrados. Vou fechar com OK.');
    Self.ModalResult := mrOk;
    //Self.Close;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

end.
