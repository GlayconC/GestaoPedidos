unit UImpressaoPedido;

interface

uses
  Windows, SysUtils, DBClient, Printers, Dialogs, Graphics;

type
  TImpressaoPedido = class
  private
    class function MilimetrosParaPixelsX(
      AMilimetros: Integer
    ): Integer;

    class function MilimetrosParaPixelsY(
      AMilimetros: Integer
    ): Integer;

    class procedure ImprimirCabecalho(
      ANumeroPedido: Integer;
      AData: TDateTime;
      const ACliente: String;
      var APosicaoY: Integer
    );
  public
    class procedure Imprimir(
      ANumeroPedido: Integer;
      AData: TDateTime;
      const ACliente: String;
      AValorTotal: Currency;
      AItens: TClientDataSet
    );
  end;

implementation

class function TImpressaoPedido.MilimetrosParaPixelsX(
  AMilimetros: Integer
): Integer;
begin
  Result := MulDiv(
    AMilimetros * 10,
    GetDeviceCaps(Printer.Handle, LOGPIXELSX),
    254
  );
end;

class function TImpressaoPedido.MilimetrosParaPixelsY(
  AMilimetros: Integer
): Integer;
begin
  Result := MulDiv(
    AMilimetros * 10,
    GetDeviceCaps(Printer.Handle, LOGPIXELSY),
    254
  );
end;

class procedure TImpressaoPedido.ImprimirCabecalho(
  ANumeroPedido: Integer;
  AData: TDateTime;
  const ACliente: String;
  var APosicaoY: Integer
);
begin
  Printer.Canvas.Font.Size := 14;
  Printer.Canvas.Font.Style := [fsBold];

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(15),
    MilimetrosParaPixelsY(APosicaoY),
    'PEDIDO DE VENDA'
  );

  APosicaoY := APosicaoY + 12;

  Printer.Canvas.Font.Size := 10;
  Printer.Canvas.Font.Style := [];

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(15),
    MilimetrosParaPixelsY(APosicaoY),
    'Número: ' + IntToStr(ANumeroPedido)
  );

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(110),
    MilimetrosParaPixelsY(APosicaoY),
    'Data: ' + FormatDateTime('dd/mm/yyyy', AData)
  );

  APosicaoY := APosicaoY + 8;

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(15),
    MilimetrosParaPixelsY(APosicaoY),
    'Cliente: ' + ACliente
  );

  APosicaoY := APosicaoY + 12;

  Printer.Canvas.Font.Style := [fsBold];

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(15),
    MilimetrosParaPixelsY(APosicaoY),
    'Código'
  );

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(40),
    MilimetrosParaPixelsY(APosicaoY),
    'Produto'
  );

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(125),
    MilimetrosParaPixelsY(APosicaoY),
    'Qtd.'
  );

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(145),
    MilimetrosParaPixelsY(APosicaoY),
    'Unitário'
  );

  Printer.Canvas.TextOut(
    MilimetrosParaPixelsX(175),
    MilimetrosParaPixelsY(APosicaoY),
    'Total'
  );

  Printer.Canvas.Font.Style := [];
  APosicaoY := APosicaoY + 8;
end;

class procedure TImpressaoPedido.Imprimir(
  ANumeroPedido: Integer;
  AData: TDateTime;
  const ACliente: String;
  AValorTotal: Currency;
  AItens: TClientDataSet
);
var
  DialogoImpressao: TPrintDialog;
  PosicaoY: Integer;
begin
  DialogoImpressao := TPrintDialog.Create(nil);

  try
    if not DialogoImpressao.Execute then
      Exit;

    Printer.Title := 'Pedido ' + IntToStr(ANumeroPedido);
    Printer.BeginDoc;

    try
      PosicaoY := 20;

      ImprimirCabecalho(
        ANumeroPedido,
        AData,
        ACliente,
        PosicaoY
      );

      AItens.First;

      while not AItens.Eof do
      begin
        if PosicaoY > 270 then
        begin
          Printer.NewPage;
          PosicaoY := 20;

          ImprimirCabecalho(
            ANumeroPedido,
            AData,
            ACliente,
            PosicaoY
          );
        end;

        Printer.Canvas.TextOut(
          MilimetrosParaPixelsX(15),
          MilimetrosParaPixelsY(PosicaoY),
          AItens.FieldByName('CODIGO').AsString
        );

        Printer.Canvas.TextOut(
          MilimetrosParaPixelsX(40),
          MilimetrosParaPixelsY(PosicaoY),
          Copy(
            AItens.FieldByName('NOME').AsString,
            1,
            35
          )
        );

        Printer.Canvas.TextOut(
          MilimetrosParaPixelsX(125),
          MilimetrosParaPixelsY(PosicaoY),
          AItens.FieldByName('QUANTIDADE').AsString
        );

        Printer.Canvas.TextOut(
          MilimetrosParaPixelsX(145),
          MilimetrosParaPixelsY(PosicaoY),
          FormatFloat(
            '0.00',
            AItens.FieldByName('VALOR_UNITARIO').AsCurrency
          )
        );

        Printer.Canvas.TextOut(
          MilimetrosParaPixelsX(175),
          MilimetrosParaPixelsY(PosicaoY),
          FormatFloat(
            '0.00',
            AItens.FieldByName('VALOR_TOTAL').AsCurrency
          )
        );

        PosicaoY := PosicaoY + 7;
        AItens.Next;
      end;

      PosicaoY := PosicaoY + 10;

      Printer.Canvas.Font.Style := [fsBold];

      Printer.Canvas.TextOut(
        MilimetrosParaPixelsX(145),
        MilimetrosParaPixelsY(PosicaoY),
        'Total: ' + FormatFloat('0.00', AValorTotal)
      );

      Printer.EndDoc;
    except
      Printer.Abort;
      raise;
    end;
  finally
    DialogoImpressao.Free;
  end;
end;

end.
