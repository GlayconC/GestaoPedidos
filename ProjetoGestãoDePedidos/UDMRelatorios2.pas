unit UDMRelatorios2;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBQuery;

type
  TDMRelatorios2 = class(TDataModule)
    IBQueryRelatorioPedidos: TIBQuery;
    dsRelatorioPedidos: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ConsultarPedidosPorPeriodo(
      ADataInicial: TDateTime;
      ADataFinal: TDateTime
    );
  end;

var
  DMRelatorios2: TDMRelatorios2;

implementation

uses UDM;

{$R *.dfm}

procedure TDMRelatorios2.DataModuleCreate(Sender: TObject);
begin
  IBQueryRelatorioPedidos.Database := DM.IBDatabase1;
  IBQueryRelatorioPedidos.Transaction := DM.IBTransaction1;

  dsRelatorioPedidos.DataSet := IBQueryRelatorioPedidos;
end;

procedure TDMRelatorios2.ConsultarPedidosPorPeriodo(
  ADataInicial: TDateTime;
  ADataFinal: TDateTime
);
begin
  if IBQueryRelatorioPedidos.Active then
    IBQueryRelatorioPedidos.Close;

  IBQueryRelatorioPedidos.SQL.Clear;

  IBQueryRelatorioPedidos.SQL.Add(
    'SELECT ' +
    '  P.CHAVE AS NUMERO_PEDIDO, ' +
    '  P.DATA, ' +
    '  C.NOME AS CLIENTE, ' +
    '  P.STATUS, ' +
    '  P.VALOR_TOTAL ' +
    'FROM PEDIDOS P ' +
    'INNER JOIN CLIENTES C ON C.CHAVE = P.CLIENTES_CHAVE ' +
    'WHERE P.DATA >= :DATA_INICIAL ' +
    '  AND P.DATA <= :DATA_FINAL ' +
    'ORDER BY P.DATA, P.CHAVE'
  );

  IBQueryRelatorioPedidos.ParamByName(
    'DATA_INICIAL'
  ).AsDateTime := ADataInicial;

  IBQueryRelatorioPedidos.ParamByName(
    'DATA_FINAL'
  ).AsDateTime := ADataFinal;

  IBQueryRelatorioPedidos.Open;
end;
end.
