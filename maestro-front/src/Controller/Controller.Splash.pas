unit Controller.Splash;

interface
uses
  Utils.Observer.Migration;

type
  TControllerSplash = class
  private

  protected

  public
    procedure ExecutarMigration(AObservadorMigration: IObservadorMigration);
  end;

implementation
uses
  Repository.Migration.Interfaces, Repository.Migration, Entity.Migration;

{ TControllerSplash }

procedure TControllerSplash.ExecutarMigration(AObservadorMigration: IObservadorMigration);
var
  RepositoryMigration: IRepositoryMigration;
  EntityMigration: TEntityMigration;
begin
  RepositoryMigration := TRepositoryMigration.Create;
  EntityMigration := TEntityMigration.Create(RepositoryMigration);
  try
    EntityMigration.AddObservador(AObservadorMigration);
    EntityMigration.Execute;
  finally
    EntityMigration.Free;
  end;
end;

end.
