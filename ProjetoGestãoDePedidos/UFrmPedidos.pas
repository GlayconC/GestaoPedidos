unit UFrmPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, UDMPedidos, Grids, DBGrids, UImpressaoPedido;

type
  TFrmPedidos = class(TForm)
    Label1: TLabel;
    edtNumeroPedido: TEdit;
    Label2: TLabel;
    dtpDataPedido: TDateTimePicker;
    Label3: TLabel;
    edtStatus: TEdit;
    Label4: TLabel;
    edtChaveCliente: TEdit;
    Label5: TLabel;
    edtNomeCliente: TEdit;
    Label6: TLabel;
    edtCodigoProduto: TEdit;
    Label7: TLabel;
    edtNomeProduto: TEdit;
    Label8: TLabel;
    edtPrecoUnitario: TEdit;
    Label9: TLabel;
    edtQuantidadeProduto: TEdit;
    btnAdicionarItem: TButton;
    btnRemoverItem: TButton;
    dbgItensPedido: TDBGrid;
    Label10: TLabel;
    edtValorTotalPedido: TEdit;
    Label11: TLabel;
    edtEstoqueDisponivel: TEdit;
    btnGravar: TButton;
    btnFinalizar: TButton;
    btnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure edtChaveClienteExit(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure edtNumeroPedidoExit(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure CodigoNumericoKeyPress(Sender: TObject; var Key: Char);
  private
    FPedidoExistente: Boolean;
    FPedidoRecemGravado: Boolean;
    FChavePedido: Integer;
    FAlteracoesPendentes: Boolean;

    function PedidoValido: Boolean;
    function SalvarPedidoAtual: Boolean;
    //procedure GravarPedido;
    procedure PrepararNovoPedido;
    function BuscarCliente: Boolean;
    procedure LimparDadosCliente;
    function BuscarProduto: Boolean;
    procedure LimparDadosProduto;
    procedure PrepararModoInsercao;
    procedure CarregarPedidoExistente;
    procedure AtualizarAcoesPedido;
    function QuantidadeProdutoValida: Boolean;
    procedure AdicionarItemTemporario;
    procedure AtualizarTotalPedido;
    procedure LimparEntradaProduto;
    procedure RemoverItemSelecionado;
    procedure AlterarStatusPedido(
      const ANovoStatus: String;
      const AMensagemConfirmacao: String;
      const AMensagemSucesso: String
    );
    procedure ImprimirPedido;
    function SalvarAntesDeFinalizar: Boolean;

  public
    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

{$R *.dfm}

procedure TFrmPedidos.PrepararNovoPedido;
begin
  FChavePedido := 0;
  FPedidoExistente := False;
  FPedidoRecemGravado := False;

  DMPedidos.LimparItensTemporarios;

  edtNumeroPedido.Clear;
  dtpDataPedido.Date := Date;
  edtStatus.Text := 'ABERTO';

  edtChaveCliente.Clear;
  edtNomeCliente.Clear;
  edtValorTotalPedido.Clear;

  FAlteracoesPendentes := False;
  LimparEntradaProduto;
  AtualizarAcoesPedido;
end;

procedure TFrmPedidos.FormShow(Sender: TObject);
begin
  dbgItensPedido.DataSource := DMPedidos.dsItensPedido;
  
  PrepararNovoPedido;
  edtNumeroPedido.SetFocus;
end;

procedure TFrmPedidos.LimparDadosCliente;
begin
    edtNomeCliente.Clear;
end;

function TFrmPedidos.BuscarCliente: Boolean;
var
  ChaveCliente: Integer;
begin
  Result := False;
  LimparDadosCliente;

  if Trim(edtChaveCliente.Text) = '' then
  begin
    ShowMessage('Informe o código do cliente.');
    Exit;
  end;

  if not TryStrToInt(edtChaveCliente.Text, ChaveCliente) then
  begin
    ShowMessage('Informe um código de cliente válido.');
    Exit;
  end;

  DMPedidos.BuscarCliente(ChaveCliente);

  if DMPedidos.IBQueryClientePedido.IsEmpty then
  begin
    ShowMessage('Cliente não encontrado.');
    Exit;
  end;

  edtNomeCliente.Text :=
    DMPedidos.IBQueryClientePedido.FieldByName('NOME').AsString;

  Result := True;
end;

procedure TFrmPedidos.edtChaveClienteExit(Sender: TObject);
begin
  if not BuscarCliente then
  begin
    edtChaveCliente.SetFocus;
    Exit;
  end;

  FAlteracoesPendentes := True;
end;

procedure TFrmPedidos.LimparDadosProduto;
begin
  edtNomeProduto.Clear;
  edtPrecoUnitario.Clear;
  edtEstoqueDisponivel.Clear;
  edtQuantidadeProduto.Clear;
end;

function TFrmPedidos.BuscarProduto: Boolean;
var
  CodigoProduto: Integer;
begin
  Result := False;
  LimparDadosProduto;

  if Trim(edtCodigoProduto.Text) = '' then
  begin
    ShowMessage('Informe o código do produto.');
    Exit;
  end;

  if not TryStrToInt(edtCodigoProduto.Text, CodigoProduto) then
  begin
    ShowMessage('Informe um código de produto válido.');
    Exit;
  end;

  DMPedidos.BuscarProduto(CodigoProduto);

  if DMPedidos.IBQueryProdutoPedido.IsEmpty then
  begin
    ShowMessage('Produto não encontrado.');
    Exit;
  end;

  edtNomeProduto.Text :=
    DMPedidos.IBQueryProdutoPedido.FieldByName('NOME').AsString;

  edtPrecoUnitario.Text :=
    FormatFloat(
      '0.00',
      DMPedidos.IBQueryProdutoPedido.FieldByName('PRECO').AsCurrency
    );

  edtEstoqueDisponivel.Text :=
    IntToStr(
      DMPedidos.IBQueryProdutoPedido.FieldByName('ESTOQUE').AsInteger
    );

  Result := True;
end;

procedure TFrmPedidos.edtCodigoProdutoExit(Sender: TObject);
begin
  if not BuscarProduto then
    edtCodigoProduto.SetFocus;
end;

procedure TFrmPedidos.AtualizarAcoesPedido;
var
  PedidoAberto: Boolean;
begin
  PedidoAberto := SameText(edtStatus.Text, 'ABERTO');

  btnGravar.Enabled :=
    (not FPedidoExistente) or PedidoAberto;

  btnFinalizar.Enabled :=
    FPedidoExistente and PedidoAberto and
    not FPedidoRecemGravado;

  btnFinalizar.Enabled :=
    FPedidoExistente and (edtStatus.Text = 'ABERTO');

  btnCancelar.Enabled :=
    FPedidoExistente and (edtStatus.Text = 'ABERTO');

  btnCancelar.Enabled :=
    FPedidoExistente and PedidoAberto and
    not FPedidoRecemGravado;

  edtChaveCliente.ReadOnly :=
    FPedidoExistente and not PedidoAberto;

  dtpDataPedido.Enabled :=
    (not FPedidoExistente) or PedidoAberto;

  edtCodigoProduto.Enabled :=
    (not FPedidoExistente) or PedidoAberto;

  edtQuantidadeProduto.Enabled :=
    (not FPedidoExistente) or PedidoAberto;

  btnAdicionarItem.Enabled :=
    (not FPedidoExistente) or PedidoAberto;

  btnRemoverItem.Enabled :=
    (not FPedidoExistente) or PedidoAberto;
end;

procedure TFrmPedidos.PrepararModoInsercao;
begin
  FChavePedido := 0;
  FPedidoExistente := False;
  FPedidoRecemGravado := False;
  DMPedidos.LimparItensTemporarios;

  dtpDataPedido.Date := Date;
  edtStatus.Text := 'ABERTO';

  edtChaveCliente.Clear;
  edtNomeCliente.Clear;
  edtValorTotalPedido.Clear;

  FAlteracoesPendentes := False;
  LimparEntradaProduto;
  AtualizarAcoesPedido;
end;

procedure TFrmPedidos.CarregarPedidoExistente;
begin
  FPedidoExistente := True;
  FPedidoRecemGravado := False;

  FChavePedido :=
    DMPedidos.IBQueryPedidos.FieldByName('CHAVE').AsInteger;

  DMPedidos.LimparItensTemporarios;

  edtNumeroPedido.Text :=
    DMPedidos.IBQueryPedidos.FieldByName(
      'NUMERO_DOCUMENTO'
    ).AsString;

  edtChaveCliente.Text :=
    DMPedidos.IBQueryPedidos.FieldByName(
      'CLIENTES_CHAVE'
    ).AsString;

  dtpDataPedido.Date :=
    DMPedidos.IBQueryPedidos.FieldByName(
      'DATA'
    ).AsDateTime;

  edtStatus.Text :=
    DMPedidos.IBQueryPedidos.FieldByName(
      'STATUS'
    ).AsString;

  edtValorTotalPedido.Text :=
    FormatFloat(
      '0.00',
      DMPedidos.IBQueryPedidos.FieldByName(
        'VALOR_TOTAL'
      ).AsCurrency
    );

  if not BuscarCliente then
    Exit;

  DMPedidos.CarregarItensPedido(FChavePedido);
  LimparEntradaProduto;

  FAlteracoesPendentes := False;
  AtualizarTotalPedido;
  AtualizarAcoesPedido;
end;

procedure TFrmPedidos.edtNumeroPedidoExit(Sender: TObject);
var
  NumeroDocumento: Integer;
begin
  if Trim(edtNumeroPedido.Text) = '' then
  begin
    PrepararModoInsercao;
    Exit;
  end;

  if not TryStrToInt(Trim(edtNumeroPedido.Text), NumeroDocumento) or
     (NumeroDocumento <= 0) then
  begin
    ShowMessage('Informe um número de pedido válido.');
    edtNumeroPedido.SetFocus;
    Exit;
  end;

  DMPedidos.BuscarPedido(NumeroDocumento);

  if DMPedidos.IBQueryPedidos.IsEmpty then
  begin
    PrepararModoInsercao;

    edtNumeroPedido.Text := IntToStr(NumeroDocumento);
  end
  else
    CarregarPedidoExistente;
end;

function TFrmPedidos.QuantidadeProdutoValida: Boolean;
var
  Quantidade: Integer;
  EstoqueDisponivel: Integer;
begin
  Result := False;

  if not TryStrToInt(Trim(edtQuantidadeProduto.Text), Quantidade) or
     (Quantidade <= 0) then
  begin
    ShowMessage('Informe uma quantidade maior que zero.');
    edtQuantidadeProduto.SetFocus;
    Exit;
  end;

  if not TryStrToInt(Trim(edtEstoqueDisponivel.Text), EstoqueDisponivel) then
  begin
    ShowMessage('Não foi possível identificar o estoque do produto.');
    edtCodigoProduto.SetFocus;
    Exit;
  end;

  if Quantidade > EstoqueDisponivel then
  begin
    ShowMessage('A quantidade informada é maior que o estoque disponível.');
    edtQuantidadeProduto.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmPedidos.AtualizarTotalPedido;
var
  TotalPedido: Currency;
begin
  TotalPedido := 0;

  DMPedidos.cdsItensTemporarios.First;

  while not DMPedidos.cdsItensTemporarios.Eof do
  begin
    TotalPedido := TotalPedido +
      DMPedidos.cdsItensTemporarios.FieldByName('VALOR_TOTAL').AsCurrency;

    DMPedidos.cdsItensTemporarios.Next;
  end;

  edtValorTotalPedido.Text := FormatFloat('0.00', TotalPedido);
end;

procedure TFrmPedidos.LimparEntradaProduto;
begin
  edtCodigoProduto.Clear;
  edtNomeProduto.Clear;
  edtPrecoUnitario.Clear;
  edtEstoqueDisponivel.Clear;
  edtQuantidadeProduto.Clear;

  //edtCodigoProduto.SetFocus;
end;

procedure TFrmPedidos.AdicionarItemTemporario;
var
  CodigoProduto: Integer;
  Quantidade: Integer;
  PrecoUnitario: Currency;
begin
  if Trim(edtNomeProduto.Text) = '' then
  begin
    ShowMessage('Informe um código de produto válido.');
    edtCodigoProduto.SetFocus;
    Exit;
  end;

  if not QuantidadeProdutoValida then
    Exit;

  CodigoProduto := StrToInt(edtCodigoProduto.Text);
  Quantidade := StrToInt(edtQuantidadeProduto.Text);
  PrecoUnitario := StrToCurr(edtPrecoUnitario.Text);

  DMPedidos.cdsItensTemporarios.Append;
  DMPedidos.cdsItensTemporarios.FieldByName('CODIGO').AsInteger := CodigoProduto;
  DMPedidos.cdsItensTemporarios.FieldByName('NOME').AsString := edtNomeProduto.Text;
  DMPedidos.cdsItensTemporarios.FieldByName('QUANTIDADE').AsInteger := Quantidade;
  DMPedidos.cdsItensTemporarios.FieldByName('VALOR_UNITARIO').AsCurrency := PrecoUnitario;
  DMPedidos.cdsItensTemporarios.FieldByName('VALOR_TOTAL').AsCurrency :=
    Quantidade * PrecoUnitario;
  DMPedidos.cdsItensTemporarios.Post;

  FAlteracoesPendentes := True;
  AtualizarTotalPedido;
  LimparEntradaProduto;
end;

procedure TFrmPedidos.btnAdicionarItemClick(Sender: TObject);
begin
  AdicionarItemTemporario;
end;

procedure TFrmPedidos.RemoverItemSelecionado;
begin
  if DMPedidos.cdsItensTemporarios.IsEmpty then
  begin
    ShowMessage('Não há itens para remover.');
    Exit;
  end;

  if MessageDlg(
    'Deseja remover o item selecionado?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) <> mrYes then
    Exit;

  FAlteracoesPendentes := True;
  DMPedidos.cdsItensTemporarios.Delete;
  AtualizarTotalPedido;
end;
procedure TFrmPedidos.btnRemoverItemClick(Sender: TObject);
begin
  RemoverItemSelecionado;
end;

function TFrmPedidos.PedidoValido: Boolean;
begin
  Result := False;

  if not BuscarCliente then
  begin
    edtChaveCliente.SetFocus;
    Exit;
  end;

  if DMPedidos.cdsItensTemporarios.IsEmpty then
  begin
    ShowMessage('Adicione ao menos um item ao pedido.');
    edtCodigoProduto.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TFrmPedidos.SalvarPedidoAtual: Boolean;
var
  NumeroDocumento: Integer;
  ChaveCliente: Integer;
  ValorTotalEmDouble: Double;
  ValorTotal: Currency;
begin
  Result := False;

  if not TryStrToInt(
    Trim(edtNumeroPedido.Text),
    NumeroDocumento
  ) or (NumeroDocumento <= 0) then
  begin
    ShowMessage('Informe um número de pedido válido.');
    edtNumeroPedido.SetFocus;
    Exit;
  end;

  if not PedidoValido then
    Exit;

  AtualizarTotalPedido;

  { Delphi 7 não possui TryStrToCurr. }
  if not TryStrToFloat(
    edtValorTotalPedido.Text,
    ValorTotalEmDouble
  ) then
  begin
    ShowMessage('Não foi possível calcular o total do pedido.');
    Exit;
  end;

  ValorTotal := ValorTotalEmDouble;

  if not TryStrToInt(
    Trim(edtChaveCliente.Text),
    ChaveCliente
  ) then
  begin
    ShowMessage('Informe um código de cliente válido.');
    edtChaveCliente.SetFocus;
    Exit;
  end;

  FChavePedido := DMPedidos.SalvarPedido(
    FChavePedido,
    NumeroDocumento,
    ChaveCliente,
    dtpDataPedido.Date,
    edtStatus.Text,
    ValorTotal
  );

  FPedidoExistente := True;
  FPedidoRecemGravado := False;
  FAlteracoesPendentes := False;

  edtNumeroPedido.Text := IntToStr(NumeroDocumento);

  AtualizarAcoesPedido;

  Result := True;
end;

procedure TFrmPedidos.btnGravarClick(Sender: TObject);
begin
  if SalvarPedidoAtual then
    ShowMessage('Pedido gravado com sucesso.');
end;

procedure TFrmPedidos.FormKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState
);
begin
  if Key = VK_F12 then
  begin
    if btnGravar.Enabled then
      if SalvarPedidoAtual then
        ShowMessage('Pedido gravado com sucesso.');

    Key := 0;
  end;
end;

procedure TFrmPedidos.AlterarStatusPedido(
  const ANovoStatus: String;
  const AMensagemConfirmacao: String;
  const AMensagemSucesso: String
);
var
  ChavePedido: Integer;
begin
  if not FPedidoExistente or FPedidoRecemGravado then
  begin
    ShowMessage(
      'Para alterar o status, grave o pedido e pesquise-o novamente.'
    );
    Exit;
  end;

  if not SameText(edtStatus.Text, 'ABERTO') then
  begin
    ShowMessage('Somente pedidos abertos podem ter o status alterado.');
    Exit;
  end;

  if MessageDlg(
    AMensagemConfirmacao,
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) <> mrYes then
    Exit;

  ChavePedido := FChavePedido;

  DMPedidos.AtualizarStatusPedido(ChavePedido, ANovoStatus);

  edtStatus.Text := ANovoStatus;
  AtualizarAcoesPedido;

  ShowMessage(AMensagemSucesso);

  if SameText(ANovoStatus, 'FINALIZADO') then
  begin
    if MessageDlg(
      'Deseja imprimir o pedido agora?',
      mtConfirmation,
      [mbYes, mbNo],
      0
    ) = mrYes then
      ImprimirPedido;
  end;
end;

procedure TFrmPedidos.btnFinalizarClick(Sender: TObject);
begin
  if not SalvarAntesDeFinalizar then
    Exit;

  AlterarStatusPedido(
    'FINALIZADO',
    'Deseja finalizar este pedido?',
    'Pedido finalizado com sucesso.'
  );
end;

procedure TFrmPedidos.btnCancelarClick(Sender: TObject);
begin
   AlterarStatusPedido(
    'CANCELADO',
    'Deseja cancelar este pedido?',
    'Pedido cancelado com sucesso.'
  );
end;

procedure TFrmPedidos.ImprimirPedido;
begin
  TImpressaoPedido.Imprimir(
    StrToInt(edtNumeroPedido.Text),
    dtpDataPedido.Date,
    edtNomeCliente.Text,
    StrToCurr(edtValorTotalPedido.Text),
    DMPedidos.cdsItensTemporarios
  );
end;

procedure TFrmPedidos.CodigoNumericoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

function TFrmPedidos.SalvarAntesDeFinalizar: Boolean;
begin
  Result := True;

  if not FAlteracoesPendentes then
    Exit;

  if MessageDlg(
    'Existem alterações não gravadas. Deseja gravar antes de finalizar o pedido?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) <> mrYes then
  begin
    Result := False;
    Exit;
  end;

  Result := SalvarPedidoAtual;
end;

end.
