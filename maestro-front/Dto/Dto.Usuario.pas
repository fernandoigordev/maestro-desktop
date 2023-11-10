unit Dto.Usuario;

interface

type
  TUsuarioDto = Class
  private
    FId: Integer;
    FNome: String;
    FCargo: String;
    FFoto: String;
  public
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property Cargo: String read FCargo write FCargo;
    property Foto: String read FFoto write FFoto;
  End;

implementation

end.
