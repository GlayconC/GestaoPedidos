unit UDMPedidos;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBQuery, DBClient;

type
  TDMPedidos = class(TDataModule)
    IBQueryPedidos: TIBQuery;
    IBQueryItensPedido: TIBQuery;
    IBQueryClientePedido: TIBQuery;
    IBQueryProdutoPedido: TIBQuery;
    dsItensPedido: TDataSource;
    cdsItensTemporarios: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ConfigurarItensTemporarios;
    function InserirPedido(
      AChaveCliente: Integer;
      AData: TDateTime;
      const AStatus: String;
      AValorTotal: Currency
    ): Integer;
    procedure ValidarEstoquePedido(AChavePedido: Integer);
    procedure BaixarEstoquePedido(AChavePedido: Integer);

    procedure AtualizarPedido(
      AChavePedido: Integer;
      AChaveCliente: Integer;
      AData: TDateTime;
      const AStatus: String;
      AValorTotal: Currency
    );

  procedure ExcluirItensPedido(AChavePedido: Integer);
  procedure GravarItensPedido(AChavePedido: Integer);
  function ProximaChavePedido: Integer;

  public
    procedure BuscarCliente(AChave: Integer);
    procedure BuscarProduto(ACodigo: Integer);
    procedure BuscarPedido(AChave: Integer);
    function SalvarPedido(
      AChavePedido: Integer;
      AChaveCliente: Integer;
      AData: TDateTime;
      const AStatus: String;
      AValorTotal: Currency
    ): Integer;
    procedure LimparItensTemporarios;
    procedure CarregarItensPedido(AChavePedido: Integer);
    procedure AtualizarStatusPedido(
      AChavePedido: Integer;
      const ANovoStatus: String
    );
  end;

var
  DMPedidos: TDMPedidos;

implementation

uses UDM, MidasLib;

{$R *.dfm}

procedure TDMPedidos.DataModuleCreate(Sender: TObject);
begin
  IBQueryPedidos.Database := DM.IBDatabase1;
  IBQueryPedidos.Transaction := DM.IBTransaction1;

  IBQueryItensPedido.Database := DM.IBDatabase1;
  IBQueryItensPedido.Transaction := DM.IBTransaction1;

  IBQueryClientePedido.Database := DM.IBDatabase1;
  IBQueryClientePedido.Transaction := DM.IBTransaction1;

  IBQueryProdutoPedido.Database := DM.IBDatabase1;
  IBQueryProdutoPedido.Transaction := DM.IBTransaction1;

  ConfigurarItensTemporarios;
  dsItensPedido.DataSet := cdsItensTemporarios;
end;


procedure TDMPedidos.BuscarCliente(AChave: Integer);
begin
  if IBQueryClientePedido.Active then
    IBQueryClientePedido.Close;

  IBQueryClientePedido.SQL.Clear;
  IBQueryClientePedido.SQL.Add(
    'SELECT CHAVE, NOME, CPF, ENDERECO, TELEFONE ' +
    'FROM CLIENTES ' +
    'WHERE CHAVE = :CHAVE'
  );

  IBQueryClientePedido.ParamByName('CHAVE').AsInteger := AChave;
  IBQueryClientePedido.Open;
end;

procedure TDMPedidos.BuscarProduto(ACodigo: Integer);
begin
  if IBQueryProdutoPedido.Active then
    IBQueryProdutoPedido.Close;

  IBQueryProdutoPedido.SQL.Clear;
  IBQueryProdutoPedido.SQL.Add(
    'SELECT CODIGO, NOME, PRECO, ESTOQUE ' +
    'FROM PRODUTOS ' +
    'WHERE CODIGO = :CODIGO'
  );

  IBQueryProdutoPedido.ParamByName('CODIGO').AsInteger := ACodigo;
  IBQueryProdutoPedido.Open;
end;

procedure TDMPedidos.BuscarPedido(AChave: Integer);
begin
  if IBQueryPedidos.Active then
    IBQueryPedidos.Close;

  IBQueryPedidos.SQL.Clear;
  IBQueryPedidos.SQL.Add(
  'SELECT CHAVE, CLIENTES_CHAVE, DATA, STATUS, VALOR_TOTAL ' +
    'FROM PEDIDOS ' +
    'WHERE CHAVE = :CHAVE'
  );

  IBQueryPedidos.ParamByName('CHAVE').AsInteger := AChave;
  IBQueryPedidos.Open;
end;

procedure TDMPedidos.ConfigurarItensTemporarios;
begin
  if cdsItensTemporarios.Active then
    cdsItensTemporarios.Close;

  cdsItensTemporarios.FieldDefs.Clear;

  cdsItensTemporarios.FieldDefs.Add('CODIGO', ftInteger);
  cdsItensTemporarios.FieldDefs.Add('NOME', ftString, 100);
  cdsItensTemporarios.FieldDefs.Add('QUANTIDADE', ftInteger);
  cdsItensTemporarios.FieldDefs.Add('VALOR_UNITARIO', ftCurrency);
  cdsItensTemporarios.FieldDefs.Add('VALOR_TOTAL', ftCurrency);

  cdsItensTemporarios.CreateDataSet;

  TCurrencyField(cdsItensTemporarios.FieldByName('VALOR_UNITARIO')).DisplayFormat := '0.00';
  TCurrencyField(cdsItensTemporarios.FieldByName('VALOR_TOTAL')).DisplayFormat := '0.00';
end;

function TDMPedidos.ProximaChavePedido: Integer;
begin
  IBQueryPedidos.Close;
  IBQueryPedidos.SQL.Clear;

  IBQueryPedidos.SQL.Add(
    'SELECT GEN_ID(GEN_PEDIDOS_CHAVE, 1) ' +
    'FROM RDB$DATABASE'
  );

  IBQueryPedidos.Open;
  Result := IBQueryPedidos.Fields[0].AsInteger;
  IBQueryPedidos.Close;
end;

function TDMPedidos.InserirPedido(
    AChaveCliente: Integer;
    AData: TDateTime;
    const AStatus: String;
    AValorTotal: Currency
  ): Integer;
var
  ChavePedido: Integer;
begin
  ChavePedido := ProximaChavePedido;

  IBQueryPedidos.Close;
  IBQueryPedidos.SQL.Clear;

  IBQueryPedidos.SQL.Add(
    'INSERT INTO PEDIDOS ' +
    '(CHAVE, CLIENTES_CHAVE, DATA, STATUS, VALOR_TOTAL) ' +
    'VALUES (:CHAVE, :CLIENTES_CHAVE, :DATA, :STATUS, :VALOR_TOTAL)'
  );

  IBQueryPedidos.ParamByName('CHAVE').AsInteger := ChavePedido;
  IBQueryPedidos.ParamByName('CLIENTES_CHAVE').AsInteger := AChaveCliente;
  IBQueryPedidos.ParamByName('DATA').AsDateTime := AData;
  IBQueryPedidos.ParamByName('STATUS').AsString := AStatus;
  IBQueryPedidos.ParamByName('VALOR_TOTAL').AsCurrency := AValorTotal;

  IBQueryPedidos.ExecSQL;

  Result := ChavePedido;
end;

procedure TDMPedidos.AtualizarPedido(
  AChavePedido: Integer;
  AChaveCliente: Integer;
  AData: TDateTime;
  const AStatus: String;
  AValorTotal: Currency
);
begin
  IBQueryPedidos.Close;
  IBQueryPedidos.SQL.Clear;

  IBQueryPedidos.SQL.Add(
    'UPDATE PEDIDOS SET ' +
    'CLIENTES_CHAVE = :CLIENTES_CHAVE, ' +
    'DATA = :DATA, ' +
    'STATUS = :STATUS, ' +
    'VALOR_TOTAL = :VALOR_TOTAL ' +
    'WHERE CHAVE = :CHAVE'
  );

  IBQueryPedidos.ParamByName('CLIENTES_CHAVE').AsInteger := AChaveCliente;
  IBQueryPedidos.ParamByName('DATA').AsDateTime := AData;
  IBQueryPedidos.ParamByName('STATUS').AsString := AStatus;
  IBQueryPedidos.ParamByName('VALOR_TOTAL').AsCurrency := AValorTotal;
  IBQueryPedidos.ParamByName('CHAVE').AsInteger := AChavePedido;

  IBQueryPedidos.ExecSQL;
end;

procedure TDMPedidos.ExcluirItensPedido(AChavePedido: Integer);
begin
  IBQueryItensPedido.Close;
  IBQueryItensPedido.SQL.Clear;

  IBQueryItensPedido.SQL.Add(
    'DELETE FROM ITENS_PEDIDO ' +
    'WHERE PEDIDOS_CHAVE = :PEDIDOS_CHAVE'
  );

  IBQueryItensPedido.ParamByName('PEDIDOS_CHAVE').AsInteger := AChavePedido;
  IBQueryItensPedido.ExecSQL;
end;

procedure TDMPedidos.GravarItensPedido(AChavePedido: Integer);
begin
  IBQueryItensPedido.Close;
  IBQueryItensPedido.SQL.Clear;

  IBQueryItensPedido.SQL.Add(
    'INSERT INTO ITENS_PEDIDO ' +
    '(PEDIDOS_CHAVE, PRODUTOS_CODIGO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) ' +
    'VALUES ' +
    '(:PEDIDOS_CHAVE, :PRODUTOS_CODIGO, :QUANTIDADE, :VALOR_UNITARIO, :VALOR_TOTAL)'
  );

  cdsItensTemporarios.First;

  while not cdsItensTemporarios.Eof do
  begin
    IBQueryItensPedido.ParamByName('PEDIDOS_CHAVE').AsInteger := AChavePedido;
    IBQueryItensPedido.ParamByName('PRODUTOS_CODIGO').AsInteger :=
      cdsItensTemporarios.FieldByName('CODIGO').AsInteger;
    IBQueryItensPedido.ParamByName('QUANTIDADE').AsInteger :=
      cdsItensTemporarios.FieldByName('QUANTIDADE').AsInteger;
    IBQueryItensPedido.ParamByName('VALOR_UNITARIO').AsCurrency :=
      cdsItensTemporarios.FieldByName('VALOR_UNITARIO').AsCurrency;
    IBQueryItensPedido.ParamByName('VALOR_TOTAL').AsCurrency :=
      cdsItensTemporarios.FieldByName('VALOR_TOTAL').AsCurrency;

    IBQueryItensPedido.ExecSQL;
    cdsItensTemporarios.Next;
  end;
end;

function TDMPedidos.SalvarPedido(
  AChavePedido: Integer;
  AChaveCliente: Integer;
  AData: TDateTime;
  const AStatus: String;
  AValorTotal: Currency
): Integer;
begin
  if not DM.IBTransaction1.InTransaction then
    DM.IBTransaction1.StartTransaction;

  try
    if AChavePedido = 0 then
      Result := InserirPedido(
        AChaveCliente,
        AData,
        AStatus,
        AValorTotal
      )
    else
    begin
      AtualizarPedido(
        AChavePedido,
        AChaveCliente,
        AData,
        AStatus,
        AValorTotal
      );

      Result := AChavePedido;
    end;

    ExcluirItensPedido(Result);
    GravarItensPedido(Result);

    DM.IBTransaction1.Commit;
  except
    if DM.IBTransaction1.InTransaction then
      DM.IBTransaction1.Rollback;

    raise;
  end;
end;

procedure TDMPedidos.LimparItensTemporarios;
begin
    if cdsItensTemporarios.Active then
      cdsItensTemporarios.EmptyDataSet;
end;

procedure TDMPedidos.CarregarItensPedido(AChavePedido: Integer);
begin
  LimparItensTemporarios;

  IBQueryItensPedido.Close;
  IBQueryItensPedido.SQL.Clear;

  IBQueryItensPedido.SQL.Add(
    'SELECT ' +
    '  I.PRODUTOS_CODIGO AS CODIGO, ' +
    '  P.NOME, ' +
    '  I.QUANTIDADE, ' +
    '  I.VALOR_UNITARIO, ' +
    '  I.VALOR_TOTAL ' +
    'FROM ITENS_PEDIDO I ' +
    'INNER JOIN PRODUTOS P ON P.CODIGO = I.PRODUTOS_CODIGO ' +
    'WHERE I.PEDIDOS_CHAVE = :PEDIDOS_CHAVE ' +
    'ORDER BY I.CHAVE'
  );

  IBQueryItensPedido.ParamByName('PEDIDOS_CHAVE').AsInteger :=
    AChavePedido;

  IBQueryItensPedido.Open;

  while not IBQueryItensPedido.Eof do
  begin
    cdsItensTemporarios.Append;

    cdsItensTemporarios.FieldByName('CODIGO').AsInteger :=
      IBQueryItensPedido.FieldByName('CODIGO').AsInteger;

    cdsItensTemporarios.FieldByName('NOME').AsString :=
      IBQueryItensPedido.FieldByName('NOME').AsString;

    cdsItensTemporarios.FieldByName('QUANTIDADE').AsInteger :=
      IBQueryItensPedido.FieldByName('QUANTIDADE').AsInteger;

    cdsItensTemporarios.FieldByName('VALOR_UNITARIO').AsCurrency :=
      IBQueryItensPedido.FieldByName('VALOR_UNITARIO').AsCurrency;

    cdsItensTemporarios.FieldByName('VALOR_TOTAL').AsCurrency :=
      IBQueryItensPedido.FieldByName('VALOR_TOTAL').AsCurrency;

    cdsItensTemporarios.Post;

    IBQueryItensPedido.Next;
  end;

  IBQueryItensPedido.Close;
end;

procedure TDMPedidos.AtualizarStatusPedido(
  AChavePedido: Integer;
  const ANovoStatus: String
);
begin
  if not DM.IBTransaction1.InTransaction then
    DM.IBTransaction1.StartTransaction;

  try
    if SameText(ANovoStatus, 'FINALIZADO') then
    begin
      ValidarEstoquePedido(AChavePedido);
      BaixarEstoquePedido(AChavePedido);
    end;

    IBQueryPedidos.Close;
    IBQueryPedidos.SQL.Clear;

    IBQueryPedidos.SQL.Add(
      'UPDATE PEDIDOS SET ' +
      'STATUS = :STATUS ' +
      'WHERE CHAVE = :CHAVE'
    );

    IBQueryPedidos.ParamByName('STATUS').AsString := ANovoStatus;
    IBQueryPedidos.ParamByName('CHAVE').AsInteger := AChavePedido;

    IBQueryPedidos.ExecSQL;

    DM.IBTransaction1.Commit;
  except
    if DM.IBTransaction1.InTransaction then
      DM.IBTransaction1.Rollback;

    raise;
  end;
end;

procedure TDMPedidos.ValidarEstoquePedido(AChavePedido: Integer);
var
  EstoqueDisponivel: Integer;
  QuantidadePedida: Integer;
  NomeProduto: String;
begin
  IBQueryItensPedido.Close;
  IBQueryItensPedido.SQL.Clear;

  IBQueryItensPedido.SQL.Add(
    'SELECT ' +
    '  P.NOME, ' +
    '  P.ESTOQUE, ' +
    '  SUM(I.QUANTIDADE) AS QUANTIDADE_PEDIDA ' +
    'FROM ITENS_PEDIDO I ' +
    'INNER JOIN PRODUTOS P ON P.CODIGO = I.PRODUTOS_CODIGO ' +
    'WHERE I.PEDIDOS_CHAVE = :PEDIDOS_CHAVE ' +
    'GROUP BY P.NOME, P.ESTOQUE'
  );

  IBQueryItensPedido.ParamByName('PEDIDOS_CHAVE').AsInteger :=
    AChavePedido;

  IBQueryItensPedido.Open;

  try
    while not IBQueryItensPedido.Eof do
    begin
      NomeProduto :=
        IBQueryItensPedido.FieldByName('NOME').AsString;

      EstoqueDisponivel :=
        IBQueryItensPedido.FieldByName('ESTOQUE').AsInteger;

      QuantidadePedida :=
        IBQueryItensPedido.FieldByName(
          'QUANTIDADE_PEDIDA'
        ).AsInteger;

      if QuantidadePedida > EstoqueDisponivel then
        raise Exception.CreateFmt(
          'Estoque insuficiente para o produto "%s". ' +
          'Disponível: %d. Solicitado: %d.',
          [NomeProduto, EstoqueDisponivel, QuantidadePedida]
        );

      IBQueryItensPedido.Next;
    end;
  finally
    IBQueryItensPedido.Close;
  end;
end;

procedure TDMPedidos.BaixarEstoquePedido(AChavePedido: Integer);
begin
  IBQueryItensPedido.Close;
  IBQueryItensPedido.SQL.Clear;

  IBQueryItensPedido.SQL.Add(
    'SELECT ' +
    '  PRODUTOS_CODIGO, ' +
    '  SUM(QUANTIDADE) AS QUANTIDADE_PEDIDA ' +
    'FROM ITENS_PEDIDO ' +
    'WHERE PEDIDOS_CHAVE = :PEDIDOS_CHAVE ' +
    'GROUP BY PRODUTOS_CODIGO'
  );

  IBQueryItensPedido.ParamByName('PEDIDOS_CHAVE').AsInteger :=
    AChavePedido;

  IBQueryItensPedido.Open;

  IBQueryProdutoPedido.Close;
  IBQueryProdutoPedido.SQL.Clear;

  IBQueryProdutoPedido.SQL.Add(
    'UPDATE PRODUTOS SET ' +
    'ESTOQUE = ESTOQUE - :QUANTIDADE ' +
    'WHERE CODIGO = :CODIGO'
  );

  try
    while not IBQueryItensPedido.Eof do
    begin
      IBQueryProdutoPedido.ParamByName('QUANTIDADE').AsInteger :=
        IBQueryItensPedido.FieldByName(
          'QUANTIDADE_PEDIDA'
        ).AsInteger;

      IBQueryProdutoPedido.ParamByName('CODIGO').AsInteger :=
        IBQueryItensPedido.FieldByName(
          'PRODUTOS_CODIGO'
        ).AsInteger;

      IBQueryProdutoPedido.ExecSQL;

      IBQueryItensPedido.Next;
    end;
  finally
    IBQueryItensPedido.Close;
  end;
end;

end.
