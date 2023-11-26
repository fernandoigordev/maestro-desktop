unit Repository.Migration;

interface
uses
  Repository.Migration.Interfaces, Dto.Migration, System.Classes;

type
  TRepositoryMigration = class(TInterfacedObject, IRepositoryMigration)
  private
    function GetSqlMigrationExecutadas: String;
    function GetSqlLog: String;
    function GetSqlGravarMigration: String;
    function GetSqlCriarTabelaMigration: String;
    function GetSqlCriarTabelaMigrationLog: String;

    procedure GravarLog(AMigrationItem: TMigrationDto);
    procedure GravarMigration(AMigrationItem: TMigrationDto);
    procedure CriarTabelaMigration;
    procedure CriarTabelaMigrationLog;
  public
    function GetListaMigrationExecutadas: TStrings;
    procedure ExecutarMigration(AMigrationItem: TMigrationDto);
  end;


implementation

uses
  FireDAC.Comp.Client, Utils.Factory.DataSet, FireDAC.Stan.Param,
  System.SysUtils;

{ TRepositoryMigration }

procedure TRepositoryMigration.CriarTabelaMigration;
var
  QueryMigration: TFDQuery;
begin
  QueryMigration := GetQuery(GetSqlCriarTabelaMigration);
  try
    QueryMigration.ExecSQL
  finally
    QueryMigration.Free;
  end;
end;

procedure TRepositoryMigration.CriarTabelaMigrationLog;
var
  QueryMigration: TFDQuery;
begin
  QueryMigration := GetQuery(GetSqlCriarTabelaMigrationLog);
  try
    QueryMigration.ExecSQL
  finally
    QueryMigration.Free;
  end;
end;

procedure TRepositoryMigration.ExecutarMigration(AMigrationItem: TMigrationDto);
var
  QueryMigration: TFDQuery;
begin
  QueryMigration := GetQuery(AMigrationItem.SqlExcute);
  try
    try
      QueryMigration.ExecSQL;
      GravarMigration(AMigrationItem);
      GravarLog(AMigrationItem);
    Except
      QueryMigration.SQL.Text := AMigrationItem.SqlRolback;
      QueryMigration.ExecSQL;
      AMigrationItem.Status := mseErro;
      GravarLog(AMigrationItem);
      raise;
    end;
  finally
    QueryMigration.Free;
  end;
end;

function TRepositoryMigration.GetListaMigrationExecutadas: TStrings;
var
  QueryMigration: TFDQuery;
begin
  Result := TStringList.Create;
  try
    QueryMigration := GetQuery(GetSqlMigrationExecutadas);
    try
      QueryMigration.Open;
      QueryMigration.First;
      while not QueryMigration.Eof do
      begin
        Result.Add(QueryMigration.FieldByName('ID').AsString);
        QueryMigration.Next;
      end;
    finally
      QueryMigration.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TRepositoryMigration.GetSqlCriarTabelaMigration: String;
begin
  Result := 'CREATE TABLE IF NOT EXISTS PUBLIC.MIGRATION ( ' +
            ' ID INT4 NOT NULL, ' +
            ' DESCRICAO VARCHAR(100) NOT NULL, ' +
            ' DATA_EXECUCAO TIMESTAMP NOT NULL, ' +
            ' CONSTRAINT MIGRATION_PK PRIMARY KEY (ID) ' +
            ');';
end;

function TRepositoryMigration.GetSqlCriarTabelaMigrationLog: String;
begin
  Result := 'CREATE TABLE IF NOT EXISTS PUBLIC.MIGRATION_LOG ( ' +
            ' ID INT4 NOT NULL, ' +
            ' DESCRICAO VARCHAR(100) NOT NULL, ' +
            ' DATA_EXECUCAO TIMESTAMP NOT NULL, ' +
            ' STATUS INT4 NOT NULL, ' +
            ' CONSTRAINT MIGRATION_LOG_PK PRIMARY KEY (ID) ' +
            ');';
end;

function TRepositoryMigration.GetSqlGravarMigration: String;
begin
  Result := 'INSERT INTO MIGRATION(ID, DESCRICAO, DATA_EXECUCAO) VALUES(:ID, :DESCRICAO, :DATA_EXECUCAO)';
end;

function TRepositoryMigration.GetSqlLog: String;
begin
  Result := 'INSERT INTO MIGRATION_LOG(ID, DESCRICAO, DATA_EXECUCAO, STATUS) VALUES(:ID, :DESCRICAO, :DATA_EXECUCAO, :STATUS)';
end;

function TRepositoryMigration.GetSqlMigrationExecutadas: String;
begin
  Result := 'SELECT ID FROM MIGRATION';
end;

procedure TRepositoryMigration.GravarLog(AMigrationItem: TMigrationDto);
var
  QueryMigration: TFDQuery;
begin
  QueryMigration := GetQuery(GetSqlLog);
  try
    QueryMigration.ParamByName('ID').AsInteger := AMigrationItem.Id;
    QueryMigration.ParamByName('DESCRICAO').AsString := AMigrationItem.Descricao;
    QueryMigration.ParamByName('DATA_EXECUCAO').AsDateTime := AMigrationItem.DataExecucao;
    QueryMigration.ParamByName('STATUS').AsInteger := Integer(AMigrationItem.Status);
    QueryMigration.ExecSQL;
  finally
    QueryMigration.Free;
  end;
end;

procedure TRepositoryMigration.GravarMigration(AMigrationItem: TMigrationDto);
var
  QueryMigration: TFDQuery;
begin
  QueryMigration := GetQuery(GetSqlGravarMigration);
  try
    QueryMigration.ParamByName('ID').AsInteger := AMigrationItem.Id;
    QueryMigration.ParamByName('DESCRICAO').AsString := AMigrationItem.Descricao;
    QueryMigration.ParamByName('DATA_EXECUCAO').AsDateTime := AMigrationItem.DataExecucao;
    QueryMigration.ExecSQL;
  finally
    QueryMigration.Free;
  end;
end;

end.
