unit UFrmConsultaProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, Grids, DBGrids;

type
  TFrmConsultaProdutos = class(TForm)
    dbgProdutos: TDBGrid;
    edtFiltro: TEdit;
    dsConsultaProdutos: TDataSource;
    IBQueryConsultaProdutos: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFiltroChange(Sender: TObject);
    procedure edtFiltroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgProdutosDblClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FCodigoSelecionado: String;

    procedure PesquisarProdutos;
    procedure SelecionarProduto;
  public
    property CodigoSelecionado: String
      read FCodigoSelecionado;
  end;

var
  FrmConsultaProdutos: TFrmConsultaProdutos;

implementation

uses UDM;

{$R *.dfm}

procedure TFrmConsultaProdutos.FormCreate(Sender: TObject);
begin
  IBQueryConsultaProdutos.Database := DM.IBDatabase1;
  IBQueryConsultaProdutos.Transaction := DM.IBTransaction1;

  dsConsultaProdutos.DataSet := IBQueryConsultaProdutos;
  dbgProdutos.DataSource := dsConsultaProdutos;
end;

procedure TFrmConsultaProdutos.FormShow(Sender: TObject);
begin
  FCodigoSelecionado := '';
  edtFiltro.Clear;
  PesquisarProdutos;
  edtFiltro.SetFocus;
end;

procedure TFrmConsultaProdutos.PesquisarProdutos;
var
  Filtro: String;
begin
  Filtro := Trim(edtFiltro.Text);

  IBQueryConsultaProdutos.Close;
  IBQueryConsultaProdutos.SQL.Clear;

  IBQueryConsultaProdutos.SQL.Add(
    'SELECT CODIGO, NOME, DESCRICAO, PRECO, ESTOQUE ' +
    'FROM PRODUTOS'
  );

  if Filtro <> '' then
  begin
    IBQueryConsultaProdutos.SQL.Add(
      'WHERE CODIGO CONTAINING :FILTRO ' +
      '   OR NOME CONTAINING :FILTRO'
    );

    IBQueryConsultaProdutos.ParamByName('FILTRO').AsString :=
      Filtro;
  end;

  IBQueryConsultaProdutos.SQL.Add('ORDER BY NOME');

  IBQueryConsultaProdutos.Open;
end;

procedure TFrmConsultaProdutos.SelecionarProduto;
begin
  if IBQueryConsultaProdutos.IsEmpty then
    Exit;

  FCodigoSelecionado :=
    IBQueryConsultaProdutos.FieldByName('CODIGO').AsString;

  ModalResult := mrOk;
end;

procedure TFrmConsultaProdutos.edtFiltroChange(Sender: TObject);
begin
  PesquisarProdutos;
end;

procedure TFrmConsultaProdutos.edtFiltroKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState
);
begin
  if Key = VK_RETURN then
  begin
    SelecionarProduto;
    Key := 0;
  end;
end;

procedure TFrmConsultaProdutos.dbgProdutosDblClick(Sender: TObject);
begin
  SelecionarProduto;
end;

procedure TFrmConsultaProdutos.dbgProdutosKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState
);
begin
  if Key = VK_RETURN then
  begin
    SelecionarProduto;
    Key := 0;
  end;
end;

procedure TFrmConsultaProdutos.FormKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState
);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

end.
