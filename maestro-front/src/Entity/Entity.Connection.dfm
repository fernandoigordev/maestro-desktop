object EntityConnection: TEntityConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 140
  Width = 206
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=maestro-desktop'
      'Password=dev@1207'
      'DriverID=PG'
      'Server=localhost'
      'MetaDefSchema=front'
      'MetaCurSchema=front')
    Left = 56
    Top = 8
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    Left = 56
    Top = 64
  end
end
