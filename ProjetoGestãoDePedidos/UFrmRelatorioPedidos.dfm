object FrmRelatorioPedidos: TFrmRelatorioPedidos
  Left = 649
  Top = 177
  Width = 787
  Height = 449
  Caption = 'Relat'#243'rio de Pedidos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 94
    Height = 24
    Caption = 'Data inicial:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 544
    Top = 32
    Width = 80
    Height = 24
    Caption = 'Data final:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object dtpDataFinal: TDateTimePicker
    Left = 640
    Top = 32
    Width = 97
    Height = 21
    Date = 46331.704868518520000000
    Time = 46331.704868518520000000
    TabOrder = 1
  end
  object dtpDataInicial: TDateTimePicker
    Left = 144
    Top = 24
    Width = 97
    Height = 21
    Date = 46331.704880439810000000
    Time = 46331.704880439810000000
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 32
    Top = 80
    Width = 705
    Height = 257
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btnImprimir: TButton
    Left = 568
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 3
    OnClick = btnImprimirClick
  end
  object btnGerarPDF: TButton
    Left = 664
    Top = 360
    Width = 75
    Height = 25
    Caption = 'PDF'
    TabOrder = 4
    OnClick = btnGerarPDFClick
  end
  object btnConsultar: TButton
    Left = 32
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 2
    OnClick = btnConsultarClick
  end
end
