object FrmClientes: TFrmClientes
  Left = 1265
  Top = 178
  Width = 442
  Height = 481
  Caption = 'Clientes'
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
  object Nome: TLabel
    Left = 24
    Top = 96
    Width = 47
    Height = 20
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CPF: TLabel
    Left = 24
    Top = 168
    Width = 35
    Height = 20
    Caption = 'CPF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Endereco: TLabel
    Left = 24
    Top = 240
    Width = 78
    Height = 20
    Caption = 'Endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Telefone: TLabel
    Left = 24
    Top = 312
    Width = 71
    Height = 20
    Caption = 'Telefone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object id: TLabel
    Left = 24
    Top = 24
    Width = 17
    Height = 20
    Caption = 'Id'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNome: TEdit
    Left = 24
    Top = 120
    Width = 377
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object edtCPF: TEdit
    Left = 24
    Top = 192
    Width = 377
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtEndereco: TEdit
    Left = 24
    Top = 264
    Width = 377
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edtTelefone: TEdit
    Left = 24
    Top = 336
    Width = 377
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object btnSalvar: TButton
    Left = 24
    Top = 392
    Width = 97
    Height = 30
    Caption = 'Salvar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 304
    Top = 392
    Width = 97
    Height = 30
    Caption = 'Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnExcluirClick
  end
  object edtChave: TEdit
    Left = 24
    Top = 48
    Width = 49
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnEnter = edtChaveEnter
    OnExit = edtChaveExit
    OnKeyPress = edtChaveKeyPress
  end
  object btnConsulta: TButton
    Left = 88
    Top = 56
    Width = 25
    Height = 17
    Caption = '...'
    TabOrder = 7
    OnClick = btnConsultaClick
  end
end
