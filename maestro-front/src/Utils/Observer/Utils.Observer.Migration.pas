unit Utils.Observer.Migration;

interface

uses
  System.Classes, System.Generics.Collections;

type
  IObservadorMigration = interface
    procedure AtualizarObservador(ATexto: String);
  end;

  TPublisherMigration = Class(TThread)
  private
    FListaObservadorMigration: TList<IObservadorMigration>;
  protected
    procedure NotificarObservadores(ATexto: String);
    procedure ExecutarMigrations;virtual;abstract;
  public
    procedure AddObservador(ASubscriber: IObservadorMigration);
    procedure RemoveObservador(ASubscriber: IObservadorMigration);
    procedure Execute;override;

    constructor Create;
    destructor Destroy;override;
  end;

implementation

{ TPublisherMigration }

procedure TPublisherMigration.AddObservador(ASubscriber: IObservadorMigration);
begin
  FListaObservadorMigration.Add(ASubscriber);
end;

constructor TPublisherMigration.Create;
begin
  inherited Create(True);
  FListaObservadorMigration := TList<IObservadorMigration>.Create;
end;

destructor TPublisherMigration.Destroy;
begin
  FListaObservadorMigration.Free;
  inherited;
end;

procedure TPublisherMigration.Execute;
begin
  inherited;
  ExecutarMigrations;
end;

procedure TPublisherMigration.NotificarObservadores(ATexto: String);
var
  Item: IObservadorMigration;
begin
  for Item in FListaObservadorMigration do
    Item.AtualizarObservador(ATexto);
end;

procedure TPublisherMigration.RemoveObservador(
  ASubscriber: IObservadorMigration);
begin
  FListaObservadorMigration.Remove(ASubscriber);
end;

end.
