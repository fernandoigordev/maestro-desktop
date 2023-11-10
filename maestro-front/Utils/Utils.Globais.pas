unit Utils.Globais;

interface

type
  TUsuarioLogado = Record
    Id: Integer;
    Nome: String;
    Cargo: String;
    Foto: String;
  End;

var
  UsuarioLogado: TUsuarioLogado;

implementation


end.
