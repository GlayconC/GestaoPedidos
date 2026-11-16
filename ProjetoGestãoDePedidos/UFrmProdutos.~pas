unit UFrmProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UDM;

type
  TFormProdutos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnSalvar: TButton;
    btnExcluir: TButton;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtPreco: TEdit;
    edtQuantidade: TEdit;
    memDescricao: TMemo;
    btnConsulta: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure LimparCampos;
    procedure btnConsultaClick(Sender: TObject);
  private
      function ValidarCampos: Boolean;
      procedure SalvarProduto;
      procedure BuscarProduto;
      procedure LimparDadosProduto;
      function CodigoProdutoInformado: Boolean;
      function ProdutoExiste: Boolean;
      function ConfirmarExclusao: Boolean;
      procedure ExcluirProdutoAtual;
      function CodigoProdutoValido: Boolean;
  public
    { Public declarations }
  end;

var
  FormProdutos: TFormProdutos;

implementation

uses UFrmConsultaProdutos;

{$R *.dfm}

procedure TFormProdutos.LimparCampos;
begin
    edtCodigo.Clear;
    edtNome.Clear;
    edtPreco.Clear;
    edtQuantidade.Clear;
    memDescricao.Clear;

    edtCodigo.SetFocus;
end;

procedure TFormProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    LimparCampos;
    Key := 0;
  end;
end;

procedure TFormProdutos.edtPrecoKeyPress(
  Sender: TObject;
  var Key: Char
);
var
  PosicaoVirgula: Integer;
begin
  if Key = #8 then
    Exit;

  if Key in ['0'..'9'] then
  begin
    PosicaoVirgula := Pos(',', edtPreco.Text);

    if (PosicaoVirgula > 0) and
       (Length(edtPreco.Text) - PosicaoVirgula >= 2) then
      Key := #0;

    Exit;
  end;

  if Key = ',' then
  begin
    if Pos(',', edtPreco.Text) > 0 then
      Key := #0;

    Exit;
  end;

  Key := #0;
end;

procedure TFormProdutos.edtQuantidadeKeyPress(
  Sender: TObject;
  var Key: Char
);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;


procedure TFormProdutos.btnSalvarClick(Sender: TObject);
begin
  if not ValidarCampos then
    Exit;

  SalvarProduto;
end;

function TFormProdutos.ValidarCampos: Boolean;
var
  Preco: Currency;
  Quantidade: Integer;
begin
  Result := False;

  if not CodigoProdutoValido then
    Exit;

  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome do produto.');
    edtNome.SetFocus;
    Exit;
  end;

  if not TryStrToCurr(edtPreco.Text, Preco) then
  begin
    ShowMessage('Informe um preço válido.');
    edtPreco.SetFocus;
    Exit;
  end;

  if Preco < 0 then
  begin
    ShowMessage('O preço não pode ser negativo.');
    edtPreco.SetFocus;
    Exit;
  end;

  if not TryStrToInt(edtQuantidade.Text, Quantidade) then
  begin
    ShowMessage('Informe a quantidade em estoque.');
    edtQuantidade.SetFocus;
    Exit;
  end;

  if Quantidade < 0 then
  begin
    ShowMessage('A quantidade não pode ser negativa.');
    edtQuantidade.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFormProdutos.SalvarProduto;
  var
  Preco: Currency;
  Quantidade: Integer;
begin
  Preco := StrToCurr(edtPreco.Text);
  Quantidade := StrToInt(edtQuantidade.Text);

  DM.BuscarProduto(edtCodigo.Text);

  if DM.IBQueryProdutos.IsEmpty then
  begin
    DM.SalvarProduto(
      edtCodigo.Text,
      edtNome.Text,
      memDescricao.Text,
      Preco,
      Quantidade
    );

    ShowMessage('Produto cadastrado com sucesso.');
  end
  else
  begin
    DM.AlterarProduto(
      edtCodigo.Text,
      edtNome.Text,
      memDescricao.Text,
      Preco,
      Quantidade
    );

    ShowMessage('Produto alterado com sucesso.');
  end;

  LimparCampos;
end;

procedure TFormProdutos.BuscarProduto;
begin
    if Trim(edtCodigo.Text) = '' then
      Exit;

    DM.BuscarProduto(Trim(edtCodigo.Text));

    if DM.IBQueryProdutos.IsEmpty then
    begin
      LimparDadosProduto;
      Exit;
    end;

    edtNome.Text :=
      DM.IBQueryProdutos.FieldByName('NOME').AsString;
    memDescricao.Text :=
      DM.IBQueryProdutos.FieldByName('DESCRICAO').AsString;

    edtPreco.Text :=
      FormatFloat(
        '0.00',
        DM.IBQueryProdutos.FieldByName('PRECO').AsCurrency
      );

    edtQuantidade.Text :=
      IntToStr(
        DM.IBQueryProdutos.FieldByName('ESTOQUE').AsInteger
      );
end;

procedure TFormProdutos.edtCodigoExit(Sender: TObject);
begin
    BuscarProduto;
end;

procedure TFormProdutos.LimparDadosProduto;
begin
  edtNome.Clear;
  memDescricao.Clear;
  edtPreco.Clear;
  edtQuantidade.Clear;
end;

procedure TFormProdutos.btnExcluirClick(Sender: TObject);
begin
  if not CodigoProdutoInformado then
    Exit;

  if not ProdutoExiste then
  begin
    ShowMessage('Produto não encontrado.');
    edtCodigo.SetFocus;
    Exit;
  end;

  if DM.ProdutoPossuiItensPedido(edtCodigo.Text) then
  begin
    ShowMessage(
      'Este produto não pode ser excluído porque possui itens vinculados a pedidos.'
    );
    Exit;
  end;

  if not ConfirmarExclusao then
    Exit;

  ExcluirProdutoAtual;
end;

function TFormProdutos.CodigoProdutoInformado: Boolean;
begin
    Result := Trim(edtCodigo.Text) <> '';

    if not Result then
    begin
        ShowMessage('Informe o código do produto.');
        edtCodigo.SetFocus;
    end;
end;

function TFormProdutos.ConfirmarExclusao: Boolean;
begin
  Result := MessageDlg(
    'Deseja excluir este produto?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) = mrYes;
end;

procedure TFormProdutos.ExcluirProdutoAtual;
begin
  try
    DM.ExcluirProduto(Trim(edtCodigo.Text));

    ShowMessage('Produto excluído com sucesso.');
    LimparCampos;
  except
    on E: Exception do
      ShowMessage(
        'Não foi possível excluir o produto.' + sLineBreak +
        E.Message
      );
  end;
end;

function TFormProdutos.ProdutoExiste: Boolean;
begin
  DM.BuscarProduto(Trim(edtCodigo.Text));

  Result := not DM.IBQueryProdutos.IsEmpty;
end;

procedure TFormProdutos.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;


function TFormProdutos.CodigoProdutoValido: Boolean;
var
  Indice: Integer;
  Codigo: String;
begin
  Result := False;
  Codigo := Trim(edtCodigo.Text);

  if Codigo = '' then
  begin
    ShowMessage('Informe o código do produto.');
    edtCodigo.SetFocus;
    Exit;
  end;

  if Length(Codigo) > 20 then
  begin
    ShowMessage('O código do produto deve ter no máximo 20 dígitos.');
    edtCodigo.SetFocus;
    Exit;
  end;

  for Indice := 1 to Length(Codigo) do
  begin
    if not (Codigo[Indice] in ['0'..'9']) then
    begin
      ShowMessage('O código do produto deve conter somente números.');
      edtCodigo.SetFocus;
      Exit;
    end;
  end;

  Result := True;
end;

procedure TFormProdutos.FormShow(Sender: TObject);
begin
  LimparCampos;
end;

procedure TFormProdutos.btnConsultaClick(Sender: TObject);
begin
  if FrmConsultaProdutos.ShowModal = mrOk then
  begin
    edtCodigo.Text := FrmConsultaProdutos.CodigoSelecionado;
    BuscarProduto;
  end;
end;

end.
