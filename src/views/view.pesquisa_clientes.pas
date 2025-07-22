unit view.pesquisa_clientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Grids, DBGrids, StdCtrls,
  ExtCtrls, DB, MemDS, Cliente.Repositorio, uModels, Dialogs;

type
  { TViewPesquisaClientes }
  TViewPesquisaClientes = class(TForm)
    grdPesquisar: TDBGrid;
    dsControl: TDataSource;
    cdsControl: TMemDataset;
    pnlPesquisa: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
  private
    FClientes: TArrClientesModel;
    FClienteSelecionado: TCliente;
  public
    property ClienteSelecionado: TCliente read FClienteSelecionado;
  end;

var
  ViewPesquisaClientes: TViewPesquisaClientes;

implementation

{$R *.lfm}

{ TViewPesquisaClientes }

procedure TViewPesquisaClientes.FormCreate(Sender: TObject);
var
  LCliente: TCliente;
begin

  if cdsControl.Active then
    cdsControl.Close;

  cdsControl.FieldDefs.Clear;
  cdsControl.FieldDefs.Add('Nome', ftString, 50);
  cdsControl.FieldDefs.Add('CPF', ftString, 14);


  cdsControl.Open;


  FClientes := TClienteRepositorio.GetRepo;


  for LCliente in FClientes do
  begin
    cdsControl.InsertRecord([LCliente.Nome, LCliente.CPF]);
  end;
end;

procedure TViewPesquisaClientes.grdPesquisaDblClick(Sender: TObject);
var
  cpfSelecionado: string;
  cliente: TCliente;
begin
  if cdsControl.RecordCount = 0 then
    Exit;

  cpfSelecionado := cdsControl.FieldByName('CPF').AsString;
  FClienteSelecionado := Default(TCliente);
  for cliente in FClientes do
  begin
    if cliente.CPF = cpfSelecionado then
    begin
      FClienteSelecionado := cliente;
      break;
    end;
  end;
  Self.ModalResult := mrOk;
end;

end.
