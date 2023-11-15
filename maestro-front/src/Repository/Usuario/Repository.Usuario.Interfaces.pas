unit Repository.Usuario.Interfaces;

interface
uses
  Dto.Usuario;

type
  IRepositoryUsuario = interface
    function Logar(AUsuario, Senha: String): TUsuarioDto;
  end;

implementation

end.
