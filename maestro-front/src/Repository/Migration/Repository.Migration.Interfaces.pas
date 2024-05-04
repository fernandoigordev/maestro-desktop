unit Repository.Migration.Interfaces;

interface
uses
  Dto.Migration, System.Classes;

type
  IRepositoryMigration = interface
    function GetListaMigrationExecutadas: TStrings;
    procedure ExecutarMigration(AMigrationItem: TMigrationDto);
    procedure CriarTabelaMigration;
    procedure CriarTabelaMigrationLog;
  end;

implementation

end.
