unit Entity.Usuario;

interface
uses
  Dto.Usuario, Repository.Usuario.Interfaces;

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
    FRepository: IRepositoryUsuario;

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

    constructor Create(ARepositoryUsuario: IRepositoryUsuario);
  end;

implementation
uses
  System.SysUtils, System.Hash;

{ TEntityUsuario }

constructor TEntityUsuario.Create(ARepositoryUsuario: IRepositoryUsuario);
begin
  FRepository := ARepositoryUsuario;
end;

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
  HashSenha: String;
begin
  Result := False;
  HashSenha := THashMD5.GetHashString(Self.FSenha);
  UsuarioDto := FRepository.Logar(Self.FNome, HashSenha);
  try
    if UsuarioDto.Id > 0 then
    begin
      SetUsuarioLogado(UsuarioDto);
      Result := True;
    end;
  finally
    UsuarioDto.Free;
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
