unit Mock.Repository.Usuario;

interface
uses
  Repository.Usuario.Interfaces, Dto.Usuario;

const
  CS_MOCK_USUARIO_SENHA = 'e10adc3949ba59abbe56e057f20f883e';
  CS_MOCK_USUARIO = 'UsuarioTeste';

type
  TMockRepositoryUsuario = Class(TInterfacedObject, IRepositoryUsuario)
  private

  public
    function Logar(AUsuario, Senha: String): TUsuarioDto;
  End;

implementation

{ TRepositoryUsuario }

function TMockRepositoryUsuario.Logar(AUsuario, Senha: String): TUsuarioDto;
begin
  Result := TUsuarioDto.Create;
  try
    if (AUsuario = CS_MOCK_USUARIO) and (Senha = CS_MOCK_USUARIO_SENHA) then
    begin
      Result.Id := 17;
      Result.Nome := 'Fernando Igor';
      Result.Cargo := 'Desenvolvedor';
      Result.Foto := 'xxxxxxxxxx';
    end;
  Except
    Result.Free;
    raise;
  end;
end;
end.
