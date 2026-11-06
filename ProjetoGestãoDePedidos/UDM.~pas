unit UDM;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery, DBTables;

type
  TDM = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQueryClientes: TIBQuery;
    dsClientes: TDataSource;
    dsConsulta: TDataSource;
    IBQueryConsulta: TIBQuery;
    IBQueryProdutos: TIBQuery;
    dsProdutos: TDataSource;
  private
    { Private declarations }
  public

    procedure CarregarClientes;
    procedure SalvarCliente(
      const ANome,
            ACPF,
            AEndereco,
            ATelefone: String);
    procedure BuscarCliente(AChave: Integer);
    procedure AlterarCliente (
      AChave: Integer;
      const ANome,
            ACPF,
            AEndereco,
            ATelefone: String);
    procedure ExcluirCliente(AChave: Integer);
    procedure ExecutarConsulta(const ASQL: String);

    procedure BuscarProduto(const ACodigo: String);
    procedure SalvarProduto(
        const ACodigo, ANome, ADescricao: String;
        const APreco: Currency;
        const AQuantidade: Integer
    );
    procedure AlterarProduto(
      const ACodigo, ANome, ADescricao: String;
      const APreco: Currency;
      const AQuantidade: Integer
    );
    procedure ExcluirProduto(const ACodigo: String);

  end;

var
  DM: TDM;

implementation

{$R *.dfm}

// Carregar Clientes
procedure TDM.CarregarClientes;
begin
    if IBQueryClientes.Active then
      IBQueryClientes.Close;

    IBQueryClientes.Open;
end;

//Salvar Clientes
procedure TDM.SalvarCliente(
  const ANome,
        ACPF,
        AEndereco,
        ATelefone: String);

  begin
      if not IBTransaction1.InTransaction then
        IBTransaction1.StartTransaction;

      IBQueryClientes.Close;
      IBQueryClientes.SQL.Clear;

      IBQueryClientes.SQL.Add(
      'INSERT INTO CLIENTES ' +
      '(NOME, CPF, ENDERECO, TELEFONE) ' +
      'VALUES (:NOME, :CPF, :ENDERECO, :TELEFONE)');

      IBQueryClientes.ParamByName('NOME').AsString := ANome;
      IBQueryClientes.ParamByName('CPF').AsString := ACPF;
      IBQueryClientes.ParamByName('ENDERECO').AsString := AEndereco;
      IBQueryClientes.ParamByName('TELEFONE').AsString := ATelefone;

      IBQueryClientes.ExecSQL;

      IBTransaction1.CommitRetaining;
  end;

procedure TDM.BuscarCliente(AChave: Integer);
begin
  if IBQueryClientes.Active then
    IBQueryClientes.Close;

    IBQueryClientes.SQL.Clear;
    IBQueryClientes.SQL.Add(
      'SELECT CHAVE, NOME, CPF, ENDERECO, TELEFONE ' +
      'FROM CLIENTES ' +
      'WHERE CHAVE = :CHAVE');

    IBQueryClientes.ParamByName('CHAVE').AsInteger := AChave;

    IBQueryClientes.Open;
end;

procedure TDM.AlterarCliente(AChave: Integer;
                              const ANome,
                                    ACPF,
                                    AEndereco,
                                    ATelefone: String);
begin
  if not IBTransaction1.InTransaction then
    IBTransaction1.StartTransaction;

  IBQueryClientes.Close;
  IBQueryClientes.SQL.Clear;

  IBQueryClientes.SQL.Add(
    'UPDATE CLIENTES SET ' +
    'NOME = :NOME, ' +
    'CPF = :CPF, ' +
    'ENDERECO = :ENDERECO, ' +
    'TELEFONE = :TELEFONE ' +
    'WHERE CHAVE = :CHAVE');

  IBQueryClientes.ParamByName('NOME').AsString := ANome;
  IBQueryClientes.ParamByName('CPF').AsString := ACPF;
  IBQueryClientes.ParamByName('ENDERECO').AsString := AEndereco;
  IBQueryClientes.ParamByName('TELEFONE').AsString := ATelefone;
  IBQueryClientes.ParamByName('CHAVE').AsInteger := AChave;

  IBQueryClientes.ExecSQL;

  IBTransaction1.Commit;

end;

procedure TDM.ExcluirCliente(AChave: Integer);
begin
  if not IBTransaction1.InTransaction then
    IBTransaction1.StartTransaction;

  try
    IBQueryClientes.Close;
    IBQueryClientes.SQL.Clear;

    IBQueryClientes.SQL.Add(
      'DELETE FROM CLIENTES ' +
      'WHERE CHAVE = :CHAVE');

    IBQueryClientes.ParamByName('CHAVE').AsInteger := AChave;

    IBQueryClientes.ExecSQL;

    IBTransaction1.Commit;
  except
    IBTransaction1.Rollback;

    raise;
  end;
end;

procedure TDM.ExecutarConsulta(const ASQL: String);
begin
    if IBQueryConsulta.Active then
      IBQueryConsulta.Close;

    IBQueryConsulta.SQL.Clear;
    IBQueryConsulta.SQL.Add(ASQL);

    IBQueryConsulta.Open;
end;

procedure TDM.BuscarProduto(const ACodigo: String);
begin
  if IBQueryProdutos.Active then
    IBQueryProdutos.Close;

  IBQueryProdutos.SQL.Clear;
  IBQueryProdutos.SQL.Add(
    'SELECT CODIGO, NOME, DESCRICAO, PRECO, ESTOQUE ' +
    'FROM PRODUTOS ' +
    'WHERE CODIGO = :CODIGO'
  );

  IBQueryProdutos.ParamByName('CODIGO').AsString := ACodigo;
  IBQueryProdutos.Open;
end;

procedure TDM.SalvarProduto(
  const ACodigo, ANome, ADescricao: String;
  const APreco: Currency;
  const AQuantidade: Integer
);
begin
  if not IBTransaction1.InTransaction then
    IBTransaction1.StartTransaction;

  IBQueryProdutos.Close;
  IBQueryProdutos.SQL.Clear;
  IBQueryProdutos.SQL.Add(
    'INSERT INTO PRODUTOS ' +
    '(CODIGO, NOME, DESCRICAO, PRECO, ESTOQUE) ' +
    'VALUES ' +
    '(:CODIGO, :NOME, :DESCRICAO, :PRECO, :ESTOQUE)'
  );

  IBQueryProdutos.ParamByName('CODIGO').AsString := ACodigo;
  IBQueryProdutos.ParamByName('NOME').AsString := ANome;
  IBQueryProdutos.ParamByName('DESCRICAO').AsString := ADescricao;
  IBQueryProdutos.ParamByName('PRECO').AsCurrency := APreco;
  IBQueryProdutos.ParamByName('ESTOQUE').AsInteger := AQuantidade;

  IBQueryProdutos.ExecSQL;
  IBTransaction1.CommitRetaining;
end;

procedure TDM.AlterarProduto(
  const ACodigo, ANome, ADescricao: String;
  const APreco: Currency;
  const AQuantidade: Integer
);
begin
  if not IBTransaction1.InTransaction then
    IBTransaction1.StartTransaction;
    
  IBQueryProdutos.Close;
  IBQueryProdutos.SQL.Clear;
  IBQueryProdutos.SQL.Add(
    'UPDATE PRODUTOS SET ' +
    'NOME = :NOME, ' +
    'DESCRICAO = :DESCRICAO, ' +
    'PRECO = :PRECO, ' +
    'ESTOQUE = :ESTOQUE ' +
    'WHERE CODIGO = :CODIGO'
  );

  IBQueryProdutos.ParamByName('CODIGO').AsString := ACodigo;
  IBQueryProdutos.ParamByName('NOME').AsString := ANome;
  IBQueryProdutos.ParamByName('DESCRICAO').AsString := ADescricao;
  IBQueryProdutos.ParamByName('PRECO').AsCurrency := APreco;
  IBQueryProdutos.ParamByName('ESTOQUE').AsInteger := AQuantidade;

  IBQueryProdutos.ExecSQL;
  IBTransaction1.CommitRetaining;
end;

procedure TDM.ExcluirProduto(const ACodigo: String);
begin
  if not IBTransaction1.InTransaction then
    IBTransaction1.StartTransaction;

  IBQueryProdutos.Close;
  IBQueryProdutos.SQL.Clear;
  IBQueryProdutos.SQL.Add(
    'DELETE FROM PRODUTOS WHERE CODIGO = :CODIGO'
  );

  IBQueryProdutos.ParamByName('CODIGO').AsString := ACodigo;

  IBQueryProdutos.ExecSQL;
  IBTransaction1.CommitRetaining;
end;

end.
