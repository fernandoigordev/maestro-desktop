unit Repository.Usuario;

interface
uses
  Repository.Usuario.Interfaces, Dto.Usuario;

type
  TRepositoryUsuario = Class(TInterfacedObject, IRepositoryUsuario)
  private
    function GetSqlLogar: String;
  public
    function Logar(AUsuario, Senha: String): TUsuarioDto;
  End;

implementation

uses
  Entity.Connection,

  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Comp.DataSet;

{ TRepositoryUsuario }

function TRepositoryUsuario.GetSqlLogar: String;
begin
  Result := 'SELECT U.ID, U.NOME, C.DESCRICAO , U.FOTO ' +
            '  FROM USUARIO U ' +
            '  JOIN FUNCIONARIO F ' +
            '    ON U.ID = F.USUARIO_ID ' +
            '  JOIN CARGO C ' +
  	        '    ON F.CARGO_ID = C.ID ' +
            ' WHERE U.NOME = :NOME AND U.SENHA = :SENHA ';
end;

function TRepositoryUsuario.Logar(AUsuario, Senha: String): TUsuarioDto;
var
  Query: TFDQuery;
begin
  Result := TUsuarioDto.Create;
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := TEntityConnection.GetInstance.FDConnection;
      Query.SQL.Text := GetSqlLogar;
      Query.ParamByName('NOME').AsString := AUsuario;
      Query.ParamByName('SENHA').AsString := Senha;
      Query.Open;

      if Query.RecordCount > 0 then
      begin
        Result.Id := Query.FieldByName('ID').AsInteger;
        Result.Nome := Query.FieldByName('Nome').AsString;
        Result.Cargo := Query.FieldByName('DESCRICAO').AsString;
        Result.Foto := Query.FieldByName('FOTO').AsString;
      end;
    finally
      Query.Free;
    end;
  Except
    Result.Free;
    raise;
  end;
end;

end.
