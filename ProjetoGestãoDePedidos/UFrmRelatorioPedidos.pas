unit UFrmRelatorioPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ComCtrls, UDMRelatorios2, URepPedidos, UImpressaoRelatorioPedidos;

type
  TFrmRelatorioPedidos = class(TForm)
    dtpDataFinal: TDateTimePicker;
    dtpDataInicial: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    btnImprimir: TButton;
    btnGerarPDF: TButton;
    btnConsultar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioPedidos: TFrmRelatorioPedidos;

implementation

{$R *.dfm}

procedure TFrmRelatorioPedidos.FormShow(Sender: TObject);
begin
  if DMRelatorios2.IBQueryRelatorioPedidos.Active then
    DMRelatorios2.IBQueryRelatorioPedidos.Close;
  dtpDataInicial.Date := Date;
  dtpDataFinal.Date := Date;

  DBGrid1.DataSource := DMRelatorios2.dsRelatorioPedidos;

  btnImprimir.Enabled := False;
  btnGerarPDF.Enabled := False;
end;

procedure TFrmRelatorioPedidos.btnConsultarClick(Sender: TObject);
begin
  if Trunc(dtpDataInicial.Date) > Trunc(dtpDataFinal.Date) then
  begin
    ShowMessage('A data inicial não pode ser maior que a data final.');
    dtpDataInicial.SetFocus;
    Exit;
  end;

  DMRelatorios2.ConsultarPedidosPorPeriodo(
    Trunc(dtpDataInicial.Date),
    Trunc(dtpDataFinal.Date)
  );

  btnImprimir.Enabled :=
    not DMRelatorios2.IBQueryRelatorioPedidos.IsEmpty;

  btnGerarPDF.Enabled := btnImprimir.Enabled;

  if not btnImprimir.Enabled then
    ShowMessage('Nenhum pedido foi encontrado no período informado.');
end;

procedure TFrmRelatorioPedidos.btnImprimirClick(Sender: TObject);
begin
  if DMRelatorios2.IBQueryRelatorioPedidos.IsEmpty then
  begin
    ShowMessage('Não há pedidos para imprimir.');
    Exit;
  end;

  FrmRepPedidos.rlRelatorioPedidos.Preview;
end;

procedure TFrmRelatorioPedidos.btnGerarPDFClick(
  Sender: TObject
);
begin
  TImpressaoRelatorioPedidos.GerarPDF(
    dtpDataInicial.Date,
    dtpDataFinal.Date,
    DMRelatorios2.IBQueryRelatorioPedidos
  );
end;
end.
