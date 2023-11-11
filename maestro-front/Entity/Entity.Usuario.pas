unit Entity.Usuario;

interface
uses
  Dto.Usuario;

type
  TUsuarioLogado = Record
    Id: Integer;
    Nome: String;
    Cargo: String;
    Foto: String;
  End;

  TEntityUsuario = class
  private
    Class var FUsuarioLogado: TUsuarioLogado;
    FId: Integer;
    FNome: String;
    FSenha: String;
    procedure SetUsuarioLogado(AUsuarioDto: TUsuarioDto);
  public
    Class function GetUsuarioLogado: TUsuarioLogado;
    function Id(AId: Integer): TEntityUsuario;
    function Nome(ANome: String): TEntityUsuario;
    function Senha(ASenha: String): TEntityUsuario;

    function Logar: Boolean;
  end;

implementation
uses
  System.SysUtils, System.Hash, Utils.Globais, Repository.Usuario;

{ TEntityUsuario }

class function TEntityUsuario.GetUsuarioLogado: TUsuarioLogado;
begin
  Result := FUsuarioLogado;
end;

function TEntityUsuario.Id(AId: Integer): TEntityUsuario;
begin
  Result := Self;
  Self.FId := AId;
end;

function TEntityUsuario.Logar: Boolean;
var
  UsuarioDto: TUsuarioDto;
  RepositoryUsuario: TRepositoryUsuario;
  HashSenha: String;
begin
  RepositoryUsuario := TRepositoryUsuario.Create;
  try
    HashSenha := THashMD5.GetHashString(Self.FSenha);
    UsuarioDto := RepositoryUsuario.Logar(Self.FNome, HashSenha);
    try
      SetUsuarioLogado(UsuarioDto);
      Result := True;
    finally
      UsuarioDto.Free;
    end;
  finally
    RepositoryUsuario.Free;
  end;
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

procedure TEntityUsuario.SetUsuarioLogado(AUsuarioDto: TUsuarioDto);
begin
  FUsuarioLogado.Id := AUsuarioDto.Id;
  FUsuarioLogado.Nome := AUsuarioDto.Nome;
  FUsuarioLogado.Cargo := AUsuarioDto.Cargo;
  FUsuarioLogado.Foto := AUsuarioDto.Foto;
end;

end.
