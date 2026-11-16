object FrmConsultaProdutos: TFrmConsultaProdutos
  Left = 861
  Top = 214
  Width = 401
  Height = 336
  Caption = 'Consulta Produtos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgProdutos: TDBGrid
    Left = 32
    Top = 96
    Width = 320
    Height = 169
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgProdutosDblClick
    OnKeyDown = dbgProdutosKeyDown
  end
  object edtFiltro: TEdit
    Left = 32
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = edtFiltroChange
    OnKeyDown = edtFiltroKeyDown
  end
  object dsConsultaProdutos: TDataSource
    Left = 240
    Top = 24
  end
  object IBQueryConsultaProdutos: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    Left = 176
    Top = 40
  end
end
