object FrmPrincipal: TFrmPrincipal
  Left = 576
  Top = 200
  Width = 1305
  Height = 675
  Caption = 'FrmPrincipal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 600
    Width = 89
    Height = 25
    Caption = 'Testar Conex'#227'o'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    object Ca1: TMenuItem
      Caption = 'Cadastros'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
    object Pedidos1: TMenuItem
      Caption = 'Pedidos'
      object NovoPedido1: TMenuItem
        Caption = 'Novo Pedido'
        OnClick = NovoPedido1Click
      end
      object ConsultarPedidos1: TMenuItem
        Caption = 'Consultar Pedidos'
        OnClick = ConsultarPedidos1Click
      end
    end
  end
end
