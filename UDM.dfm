object DM: TDM
  OldCreateOrder = False
  Height = 255
  Width = 278
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Users\aluno\Desktop\Projects\BD\bancoDados.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    BeforeConnect = FDConnectionBeforeConnect
    Left = 48
    Top = 32
  end
  object FDQPessoa: TFDQuery
    Active = True
    Connection = FDConnection
    SQL.Strings = (
      'select * from pessoa'
      'where email=:pNome')
    Left = 112
    Top = 118
    ParamData = <
      item
        Name = 'PNOME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object FDQPessoaid: TFDAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object FDQPessoaemail: TStringField
      FieldName = 'email'
      Size = 300
    end
    object FDQPessoasenha: TStringField
      FieldName = 'senha'
      Size = 300
    end
  end
  object FDQueryCarros: TFDQuery
    Connection = FDConnection
    Left = 161
    Top = 48
  end
end
