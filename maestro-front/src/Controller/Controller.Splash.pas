unit Controller.Splash;

interface
uses
  Utils.Observer.Migration, Repository.Migration.Interfaces,
  Repository.Migration, Entity.Migration;

type
  TControllerSplash = class
  private
    RepositoryMigration: IRepositoryMigration;
    FEntityMigration: TEntityMigration;
  protected

  public
    constructor Create;
    destructor Destroy;override;
    procedure ExecutarMigration(AObservadorMigration: IObservadorMigration);
    function QuantidadeMigrationExecutar: Integer;

  end;

implementation

{ TControllerSplash }

constructor TControllerSplash.Create;
begin
  RepositoryMigration := TRepositoryMigration.Create;
  FEntityMigration := TEntityMigration.Create(RepositoryMigration);
end;

destructor TControllerSplash.Destroy;
begin
  FEntityMigration.Free;
  inherited;
end;

procedure TControllerSplash.ExecutarMigration(AObservadorMigration: IObservadorMigration);
begin
  FEntityMigration.AddObservador(AObservadorMigration);
  FEntityMigration.Execute;
end;

function TControllerSplash.QuantidadeMigrationExecutar: Integer;
begin
  Result := FEntityMigration.QuantidadeMigrationExecutar;
end;

end.
