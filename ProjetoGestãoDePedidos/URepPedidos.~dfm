object FrmRepPedidos: TFrmRepPedidos
  Left = 245
  Top = 130
  Width = 1349
  Height = 1005
  Caption = 'Relat'#243'rio de Pedidos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object rlRelatorioPedidos: TRLReport
    Left = 280
    Top = 0
    Width = 794
    Height = 1123
    DataSource = rlDataSourcePedidos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object rlCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 57
      BandType = btHeader
      Transparent = False
      object RLLabel3: TRLLabel
        Left = 232
        Top = 8
        Width = 153
        Height = 13
        Caption = 'RELAT'#211'RIO DE PEDIDOS'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 32
        Top = 32
        Width = 49
        Height = 13
        Caption = 'N'#250'mero'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 136
        Top = 32
        Width = 41
        Height = 13
        Caption = 'Data'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 272
        Top = 32
        Width = 57
        Height = 13
        Caption = 'Cliente'
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 424
        Top = 32
        Width = 49
        Height = 13
        Caption = 'Status'
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 523
        Top = 32
        Width = 78
        Height = 13
        Caption = 'Valor Total'
        Transparent = False
      end
    end
    object rlDetalhe: TRLBand
      Left = 38
      Top = 95
      Width = 718
      Height = 73
      Transparent = False
      object RLDBText1: TRLDBText
        Left = 304
        Top = 56
        Width = 57
        Height = 16
        DataField = 'CLIENTE'
        DataSource = rlDataSourcePedidos
        Transparent = False
      end
      object RLDBText2: TRLDBText
        Left = 440
        Top = 56
        Width = 54
        Height = 16
        DataField = 'STATUS'
        DataSource = rlDataSourcePedidos
        Transparent = False
      end
      object RLDBText8: TRLDBText
        Left = 570
        Top = 56
        Width = 95
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALOR_TOTAL'
        DataSource = rlDataSourcePedidos
        DisplayMask = '#,##0.00'
        Transparent = False
      end
      object RLDBText9: TRLDBText
        Left = 184
        Top = 56
        Width = 38
        Height = 16
        DataField = 'DATA'
        DataSource = rlDataSourcePedidos
        Transparent = False
      end
      object RLDBText10: TRLDBText
        Left = 32
        Top = 56
        Width = 117
        Height = 16
        DataField = 'NUMERO_PEDIDO'
        DataSource = rlDataSourcePedidos
        Transparent = False
      end
    end
    object rlRodape: TRLBand
      Left = 38
      Top = 168
      Width = 718
      Height = 67
      BandType = btFooter
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 456
        Top = 32
        Width = 109
        Height = 25
        Caption = 'Total do per'#237'odo:'
        Transparent = False
      end
      object RLDBResult1: TRLDBResult
        Left = 584
        Top = 32
        Width = 134
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALOR_TOTAL'
        DataSource = rlDataSourcePedidos
        DisplayMask = '#,##0.00'
        Info = riSum
        Transparent = False
      end
    end
  end
  object rlDataSourcePedidos: TDataSource
    Left = 168
    Top = 96
  end
end
