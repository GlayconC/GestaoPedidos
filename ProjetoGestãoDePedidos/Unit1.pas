unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UDM, Menus, UFrmClientes, UFrmProdutos, UFrmPedidos, UFrmRelatorioPedidos;

type
  TFrmPrincipal = class(TForm)
    Button1: TButton;
    MainMenu1: TMainMenu;
    Ca1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Pedidos1: TMenuItem;
    NovoPedido1: TMenuItem;
    ConsultarPedidos1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure NovoPedido1Click(Sender: TObject);
    procedure ConsultarPedidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation
{$R *.dfm}

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
  try
    DM.IBDatabase1.Connected := True;
    ShowMessage('Conexão realizada com sucesso!');
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmPrincipal.Clientes1Click(Sender: TObject);
begin
  FrmClientes.Show;
end;

procedure TFrmPrincipal.Produtos1Click(Sender: TObject);
begin
 FormProdutos.Show;
end;

procedure TFrmPrincipal.NovoPedido1Click(Sender: TObject);
begin
  FrmPedidos.Show;
end;

procedure TFrmPrincipal.ConsultarPedidos1Click(Sender: TObject);
begin
  FrmRelatorioPedidos.Show;
end;
end.
