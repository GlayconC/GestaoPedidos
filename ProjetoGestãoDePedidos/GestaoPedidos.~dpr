program GestaoPedidos;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FrmPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  UFrmClientes in 'UFrmClientes.pas' {FrmClientes},
  UFrmConsulta in 'UFrmConsulta.pas' {FrmConsulta},
  UFrmProdutos in 'UFrmProdutos.pas' {FormProdutos},
  UDMPedidos in 'UDMPedidos.pas' {DMPedidos: TDataModule},
  UFrmPedidos in 'UFrmPedidos.pas' {FrmPedidos},
  UImpressaoPedido in 'UImpressaoPedido.pas',
  UFrmRelatorioPedidos in 'UFrmRelatorioPedidos.pas' {FrmRelatorioPedidos},
  UDMRelatorios2 in 'UDMRelatorios2.pas' {DMRelatorios2: TDataModule},
  UImpressaoRelatorioPedidos in 'UImpressaoRelatorioPedidos.pas',
  URepPedidos in 'URepPedidos.pas' {FrmRepPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMPedidos, DMPedidos);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmClientes, FrmClientes);
  Application.CreateForm(TFormProdutos, FormProdutos);
  Application.CreateForm(TFrmConsulta, FrmConsulta);
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  Application.CreateForm(TDMRelatorios2, DMRelatorios2);
  Application.CreateForm(TFrmRelatorioPedidos, FrmRelatorioPedidos);
  Application.CreateForm(TFrmRepPedidos, FrmRepPedidos);
  Application.Run;
end.
