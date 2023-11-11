unit Controller.Login;

interface

type
  TControllerLogin = class
  private

  protected

  public
    function Logar(AUsuario, ASenha: String): Boolean;
  end;

implementation

uses
  Entity.Usuario, Repository.Usuario.Interfaces, Repository.Usuario;

{ TControllerLogin }

function TControllerLogin.Logar(AUsuario, ASenha: String): Boolean;
var
  EntityUsuario: TEntityUsuario;
  RepositoryUsuario: IRepositoryUsuario;
begin
  RepositoryUsuario := TRepositoryUsuario.Create;
  EntityUsuario := TEntityUsuario.Create(RepositoryUsuario);
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
