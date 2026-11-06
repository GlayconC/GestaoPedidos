object FrmConsulta: TFrmConsulta
  Left = 537
  Top = 259
  BorderStyle = bsSingle
  Caption = 'Consulta'
  ClientHeight = 385
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 52
    Height = 13
    Caption = 'Pesquisar: '
  end
  object edtPesquisar: TEdit
    Left = 24
    Top = 40
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 72
    Width = 473
    Height = 289
    DataSource = DM.dsConsulta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
  end
end
