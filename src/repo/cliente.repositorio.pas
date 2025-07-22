unit Cliente.Repositorio;

interface

uses
  uModels, StdCtrls, SysUtils;

type
  TClienteRepositorio = class
    private
      class procedure AlterarCliente(Id: Integer; ABody: TCliente);
      class procedure IncluirCliente(ABody: TCliente);

      class var ClientesRepo: TArrClientesModel;

    public

      class procedure StartRepo;
      class function GetRepo: TArrClientesModel;

      class function ExisteClienteCadastrado(ACpf: String): Integer;
      class procedure CadastrarCliente(ABody: TCliente);
      class procedure ShowClientesLogs(AppLog: TMemo);
      class function GetCLiente(ACpf: String): TCliente;
  end;

implementation

  {TClienteRepositorio}

  class procedure TClienteRepositorio.AlterarCliente(Id: Integer; ABody: TCliente);
  begin
     ClientesRepo[Id] := ABody;
  end;

  class procedure TClienteRepositorio.CadastrarCliente(ABody: TCliente);
  var Id: Integer;
  begin
     Id := ExisteClienteCadastrado(ABody.CPF);

     if (Id >= 0) then
        AlterarCliente(Id, ABody)
     else
       IncluirCliente(ABody);
  end;

  class function TClienteRepositorio.ExisteClienteCadastrado(ACpf: String): Integer;
  var i: Integer;
  begin
    Result := -1;

    for i := Low(ClientesRepo) to High(ClientesRepo) do
        begin
          if ClientesRepo[i].CPF = ACpf then
             Exit(i);
        end;
  end;

  class function TClienteRepositorio.GetCliente(ACpf: String): TCliente;
  var LCliente: TCliente;
  begin
      for LCLiente in ClientesRepo do
     begin
       if LCliente.CPF = ACpf then
          Exit(LCliente);
     end;
  end;

  class function TClienteRepositorio.GetRepo: TArrClientesModel;
  begin
    Result := ClientesRepo;
  end;

  class procedure TClienteRepositorio.IncluirCliente(ABody: TCliente);
  var index: Integer;
  begin
    index := Length(ClientesRepo);
    SetLength(ClientesRepo, index + 1);

    ClientesRepo[index] := ABody
  end;

  class procedure TClienteRepositorio.ShowClientesLogs(AppLog: TMemo);
  var LCliente: TCliente;
  begin
    AppLog.Lines.Clear;
    AppLog.Lines.Add('--- LOG DE CLIENTES ---');

    for LCliente in ClientesRepo do
    begin
      AppLog.Lines.Add(Format('Nome: %s, CPF: %s', [LCliente.Nome, LCliente.CPF]));
    end;
  end;

  class procedure TClienteRepositorio.StartRepo;
  begin
    SetLength(ClientesRepo, 0);
  end;
end.

