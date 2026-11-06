object DM: TDM
  OldCreateOrder = False
  Left = 326
  Top = 424
  Height = 400
  Width = 440
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 'localhost:D:\Projetos\ProjetoGest'#227'oDePedidos\gestaopedidos.fdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 96
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabase1
    AutoStopAction = saNone
    Left = 24
    Top = 16
  end
  object IBQueryClientes: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT'
      '    CHAVE,'
      '    NOME,'
      '    CPF,'
      '    ENDERECO,'
      '    TELEFONE'
      'FROM CLIENTES'
      'ORDER BY NOME;')
    Left = 24
    Top = 128
  end
  object dsClientes: TDataSource
    DataSet = IBQueryClientes
    Left = 24
    Top = 80
  end
  object dsConsulta: TDataSource
    DataSet = IBQueryConsulta
    Left = 104
    Top = 128
  end
  object IBQueryConsulta: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 104
    Top = 80
  end
  object IBQueryProdutos: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT'
      '    CHAVE,'
      '    NOME,'
      '    CPF,'
      '    ENDERECO,'
      '    TELEFONE'
      'FROM CLIENTES'
      'ORDER BY NOME;')
    Left = 24
    Top = 192
  end
  object dsProdutos: TDataSource
    DataSet = IBQueryProdutos
    Left = 96
    Top = 192
  end
end
