unit Entity.Usuario;

interface

type
  TEntityUsuario = class
  private
    FId: Integer;
    FNome: String;
    FSenha: String;
  public
    function Id(AId: Integer): TEntityUsuario;
    function Nome(ANome: String): TEntityUsuario;
    function Senha(ASenha: String): TEntityUsuario;

    function Logar: Boolean;
  end;

implementation

{ TEntityUsuario }

function TEntityUsuario.Id(AId: Integer): TEntityUsuario;
begin
  Result := Self;
  Self.FId := AId;
end;

function TEntityUsuario.Logar: Boolean;
begin
  //Fazer processo de Login
  //Chamar m�todo para Guardar informa��es do usu�rio em uma vari�vel global.
end;

function TEntityUsuario.Nome(ANome: String): TEntityUsuario;
begin
  Result := Self;
  Self.FNome := ANome;
end;

function TEntityUsuario.Senha(ASenha: String): TEntityUsuario;
begin
  Result := Self;
  Self.FSenha := ASenha;
end;

end.
