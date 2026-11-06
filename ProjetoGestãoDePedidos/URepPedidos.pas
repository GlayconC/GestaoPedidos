unit URepPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, UDMRelatorios2;

type
  TFrmRepPedidos = class(TForm)
    rlRelatorioPedidos: TRLReport;
    rlDataSourcePedidos: TDataSource;
    rlCabecalho: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    rlDetalhe: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    rlRodape: TRLBand;
    RLLabel1: TRLLabel;
    RLDBResult1: TRLDBResult;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRepPedidos: TFrmRepPedidos;

implementation

{$R *.dfm}

procedure TFrmRepPedidos.FormCreate(Sender: TObject);
begin
  rlDataSourcePedidos.DataSet :=
    DMRelatorios2.IBQueryRelatorioPedidos;
end;

end.
