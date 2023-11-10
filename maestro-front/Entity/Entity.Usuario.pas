unit Entity.Usuario;

interface
uses
  Dto.Usuario;

type
  TEntityUsuario = class
  private
    FId: Integer;
    FNome: String;
    FSenha: String;

    //setusuariocorrente(dto)
    procedure SetUsuarioLogado(AUsuarioDto: TUsuarioDto);
  public
    function Id(AId: Integer): TEntityUsuario;
    function Nome(ANome: String): TEntityUsuario;
    function Senha(ASenha: String): TEntityUsuario;

    function Logar: Boolean;
  end;

implementation
uses
  Utils.Globais;

{ TEntityUsuario }

function TEntityUsuario.Id(AId: Integer): TEntityUsuario;
begin
  Result := Self;
  Self.FId := AId;
end;

function TEntityUsuario.Logar: Boolean;
var
  UsuarioDto: TUsuarioDto;
begin
  Result := False;
  //Fazer processo de Login(Chamar um repository pra verificar se vai logar no banco)
  UsuarioDto := TUsuarioDto.Create;
          try
    UsuarioDto.Id := 1;
    UsuarioDto.Nome := 'Igor';
    UsuarioDto.Cargo := 'Desenvolvedor';
    UsuarioDto.Foto := 'xxxxxxxxxx';

    SetUsuarioLogado(UsuarioDto);
    Result := True;
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
  Utils.Globais.UsuarioLogado.Id := AUsuarioDto.Id;
  Utils.Globais.UsuarioLogado.Nome := AUsuarioDto.Nome;
  Utils.Globais.UsuarioLogado.Cargo := AUsuarioDto.Cargo;
  Utils.Globais.UsuarioLogado.Foto := AUsuarioDto.Foto;
end;

end.
