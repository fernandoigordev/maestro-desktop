unit Controller.Login;

interface
uses
  Repository.Usuario.Interfaces;

type
  TControllerLogin = class
  private
    FRepositoryUsuario: IRepositoryUsuario;
  protected

  public
    function Logar(AUsuario, ASenha: String): Boolean;

    constructor Create(ARepositoryUsuario: IRepositoryUsuario);
  end;

implementation

uses
  Entity.Usuario;

{ TControllerLogin }

constructor TControllerLogin.Create(ARepositoryUsuario: IRepositoryUsuario);
begin
  FRepositoryUsuario := ARepositoryUsuario;
end;

function TControllerLogin.Logar(AUsuario, ASenha: String): Boolean;
var
  EntityUsuario: TEntityUsuario;
begin
  EntityUsuario := TEntityUsuario.Create(FRepositoryUsuario);
  try
    Result := EntityUsuario
                .Nome(AUsuario)
                .Senha(ASenha)
                .Logar;
  finally
    EntityUsuario.Free;
  end;
end;

end.
