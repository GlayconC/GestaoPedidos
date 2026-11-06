unit UFrmClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UDM, UFrmConsulta;

type
  TFrmClientes = class(TForm)
    Nome: TLabel;
    CPF: TLabel;
    Endereco: TLabel;
    Telefone: TLabel;
    edtNome: TEdit;
    edtCPF: TEdit;
    edtEndereco: TEdit;
    edtTelefone: TEdit;
    btnSalvar: TButton;
    btnExcluir: TButton;
    id: TLabel;
    edtChave: TEdit;
    btnConsulta: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure BuscarCliente;
    procedure edtChaveExit(Sender: TObject);
    procedure edtChaveKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtChaveEnter(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure limparCampos;
    procedure salvarCliente;
  end;

var
  FrmClientes: TFrmClientes;

implementation

{$R *.dfm}

procedure TFrmClientes.btnSalvarClick(Sender: TObject);
begin
  salvarCliente;
end;

procedure TFrmClientes.salvarCliente();
begin
  DM.BuscarCliente(StrToInt(edtChave.Text));

  if DM.IBQueryClientes.IsEmpty then
    begin
      DM.SalvarCliente(
        edtNome.Text,
        edtCPF.Text,
        edtEndereco.Text,
        edtTelefone.Text
      );

      ShowMessage('Cliente CADASTRADO com sucesso!');
    end
  else
    begin
      DM.AlterarCliente(
        StrToInt(edtChave.Text),
        edtNome.Text,
        edtCPF.Text,
        edtEndereco.Text,
        edtTelefone.Text
      );

      ShowMessage('Cliente ALTERADO com sucesso!');
    end;

  limparCampos();
end;

procedure TFrmClientes.limparCampos();
begin
  edtChave.Clear;
  edtNome.Clear;
  edtCPF.Clear;
  edtEndereco.Clear;
  edtTelefone.Clear;
  edtChave.setFocus();
end;

procedure TFrmClientes.BuscarCliente;
begin
    if Trim(edtChave.Text) = '' then
      Exit;

    DM.BuscarCliente(StrToInt(edtChave.Text));

    if DM.IBQueryClientes.IsEmpty then
    begin
      edtNome.Clear;
      edtCPF.Clear;
      edtEndereco.Clear;
      edtTelefone.Clear;
      Exit;
    end;

    edtNome.Text := DM.IBQueryClientes.FieldByName('NOME').AsString;
    edtCPF.Text := DM.IBQueryClientes.FieldByName('CPF').AsString;
    edtEndereco.Text := DM.IBQueryClientes.FieldByName('ENDERECO').AsString;
    edtTelefone.Text := DM.IBQueryClientes.FieldByName('TELEFONE').AsString;
end;

procedure TFrmClientes.edtChaveExit(Sender: TObject);
begin
  BuscarCliente;
end;

procedure TFrmClientes.edtChaveKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    BuscarCliente;
    Key := #0;
  end;
end;

procedure TFrmClientes.btnExcluirClick(Sender: TObject);
begin
  if Trim(edtChave.Text) = '' then
  begin
    ShowMessage('Informe a chave do cliente.');
    Exit;
  end;

  if MessageDlg(
    'Deseja excluir este cliente?',
    mtConfirmation,
    [mbYes, mbNo],
    0) = mrYes then
  begin
    try
      DM.ExcluirCliente(StrToInt(edtChave.Text));

      ShowMessage('Cliente excluído com sucesso!');

      limparCampos;
      edtChave.Clear;
      edtChave.SetFocus;

    except
      on E: Exception do
        ShowMessage(
          'Não foi possível excluir o cliente.' + sLineBreak +
          'Verifique se ele possui pedidos cadastrados.');
      end;
  end;
end;


procedure TFrmClientes.FormCreate(Sender: TObject);
begin
 btnConsulta.Enabled := False;
end;

procedure TFrmClientes.edtChaveEnter(Sender: TObject);
begin
  btnConsulta.Enabled := True;
end;

procedure TFrmClientes.btnConsultaClick(Sender: TObject);
begin
  if FrmConsulta.ShowModal = mrOk then
  begin
    edtChave.Text := IntToStr(FrmConsulta.ChaveSelecionada);
    BuscarCliente;
  end;
end;

end.
