unit Repository.Usuario;

interface
uses
  Dto.Usuario;

type
  TRepositoryUsuario = Class
  private

  public
    function Logar(AUsuario, Senha: String): TUsuarioDto;
  End;

implementation

{ TRepositoryUsuario }

function TRepositoryUsuario.Logar(AUsuario, Senha: String): TUsuarioDto;
begin
  Result := TUsuarioDto.Create;
  try
    //Fazer select no banco e preencher result com os dados da consulta
    Result.Id := 1;
    Result.Nome := 'Fernando Igor';
    Result.Cargo := 'Desenvolvedor';
    Result.Foto := 'xxxxxxxxxx';
  Except
    Result.Free;
    raise;
  end;
end;

end.
