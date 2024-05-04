unit Entity.Migration;

interface

uses
  FireDAC.Comp.Client, System.Generics.Collections, Repository.Migration.Interfaces,
  System.Classes, Utils.Observer.Migration;

type
  TEntityMigrationItem = class
    public
      function SqlExcute: String;virtual;abstract;
      function SqlRolback: String;Virtual;abstract;
      function GetId: Integer;
  end;

  TMigration_1 = class(TEntityMigrationItem)
    public
      function SqlExcute: String;override;
      function SqlRolback: String;override;
  end;

  TMigration_2 = class(TEntityMigrationItem)
    public
      function SqlExcute: String;override;
      function SqlRolback: String;override;
  end;

  TMigration_3 = class(TEntityMigrationItem)
    public
      function SqlExcute: String;override;
      function SqlRolback: String;override;
  end;

  TMigration_4 = class(TEntityMigrationItem)
    public
      function SqlExcute: String;override;
      function SqlRolback: String;override;
  end;


  TEntityMigration = class(TPublisherMigration)
    private
      FRepositoryMigration: IRepositoryMigration;
      FListaMigrationExecutadas: TStrings;
      FMigrationItens: TObjectList<TEntityMigrationItem>;
      procedure CriaTabelasMigration;
      procedure AddMigration;
    protected
      procedure ExecutarMigrations;override;
    public
      constructor Create(ARepository: IRepositoryMigration);
      destructor Destroy;override;

      function QuantidadeMigrationExecutar: Integer;
  end;

implementation
uses
  Utils.Factory.DataSet, System.SysUtils, FMX.Dialogs, Dto.Migration;


{ TEntityMigration }

procedure TEntityMigration.AddMigration;
begin
  FMigrationItens.Add(TMigration_1.Create);
  FMigrationItens.Add(TMigration_2.Create);
  FMigrationItens.Add(TMigration_3.Create);
  FMigrationItens.Add(TMigration_4.Create);
end;

constructor TEntityMigration.Create(ARepository: IRepositoryMigration);
begin
  inherited Create;
  FRepositoryMigration := ARepository;
  CriaTabelasMigration;
  FListaMigrationExecutadas := FRepositoryMigration.GetListaMigrationExecutadas;
  FMigrationItens := TObjectList<TEntityMigrationItem>.Create;
  AddMigration;
end;

procedure TEntityMigration.CriaTabelasMigration;
begin
  FRepositoryMigration.CriarTabelaMigration;
  FRepositoryMigration.CriarTabelaMigrationLog;
end;

destructor TEntityMigration.Destroy;
begin
  FListaMigrationExecutadas.Free;
  FMigrationItens.Free;
  inherited;
end;

procedure TEntityMigration.ExecutarMigrations;
var
  Item: TEntityMigrationItem;
  MigrationDto: TMigrationDto;
  IdMigration: Integer;
begin
  for Item in FMigrationItens do
  begin
    try
      IdMigration := Item.GetId;
      if (IdMigration > 0) and (FListaMigrationExecutadas.IndexOf(IdMigration.ToString) = -1) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
                      procedure
                      begin
                        Self.NotificarObservadores(IdMigration.ToString);
                        Sleep(200);
                      end
                     );
        MigrationDto := TMigrationDto.Create;
        try
          MigrationDto.Id := IdMigration;
          MigrationDto.Descricao := Item.ClassName;
          MigrationDto.Status := mseSucesso;
          MigrationDto.DataExecucao := Now;
          MigrationDto.SqlExcute := Item.SqlExcute;
          MigrationDto.SqlRolback := Item.SqlRolback;
          FRepositoryMigration.ExecutarMigration(MigrationDto);
        finally
          MigrationDto.Free;
        end;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(Concat('Erro ao executar Migration: ', Item.ClassName));
      end;
    end;
  end;
end;


function TEntityMigration.QuantidadeMigrationExecutar: Integer;
var
  Item: TEntityMigrationItem;
begin
  Result := 0;

  for Item in FMigrationItens do
    if (Item.GetId > 0) and (FListaMigrationExecutadas.IndexOf(Item.GetId.ToString) = -1) then
      Inc(Result)
end;

{ TEntityMigrationItem }

function TEntityMigrationItem.GetId: Integer;
var
  ANomeClasse: String;
  NumeroMigration: String;
begin
  ANomeClasse := Self.ClassName;
  NumeroMigration := Copy(ANomeClasse, (Pos('_', ANomeClasse)+1), Length(ANomeClasse));

  Result := StrToIntDef(NumeroMigration, 0);
end;

{ TMigration_1 }

function TMigration_1.SqlExcute: String;
begin
  Result := 'CREATE TABLE TIPOUSUARIO ( ' +
            ' ID INT4 NOT NULL GENERATED ALWAYS AS IDENTITY, ' +
            ' DESCRICAO VARCHAR(100) NOT NULL, ' +
            ' CONSTRAINT "TIPOUSUARIO_PKEY" PRIMARY KEY (ID) ' +
            ');';
end;


function TMigration_1.SqlRolback: String;
begin
  Result := 'DROP TABLE IF EXISTS TIPOUSUARIO;';
end;

{ TMigration_2 }

function TMigration_2.SqlExcute: String;
begin
  Result := 'CREATE TABLE USUARIO ( ' +
            ' ID INT4 NOT NULL, ' +
            ' NOME VARCHAR(100) NOT NULL, ' +
            ' FOTO VARCHAR(300) NULL, ' +
            ' SENHA VARCHAR(200) NOT NULL, ' +
            ' TIPOUSUARIO_ID INT4 NOT NULL, ' +
            ' CONSTRAINT USUARIO_PK PRIMARY KEY (ID), ' +
            ' CONSTRAINT USUARIO_TIPO_USUARIO_FK FOREIGN KEY (TIPOUSUARIO_ID) REFERENCES TIPOUSUARIO(ID) ' +
            ');';
end;

function TMigration_2.SqlRolback: String;
begin
  Result := 'DROP TABLE IF EXISTS USUARIO;';
end;

{ TMigration_3 }

function TMigration_3.SqlExcute: String;
begin
  Result := 'CREATE TABLE CARGO ( ' +
            ' ID INT4 NOT NULL, ' +
            ' DESCRICAO VARCHAR(100) NOT NULL, ' +
            ' CONSTRAINT CARGO_PK PRIMARY KEY (ID) ' +
            ');';
end;

function TMigration_3.SqlRolback: String;
begin
  Result := 'DROP TABLE IF EXISTS CARGO;';
end;

{ TMigration_4 }

function TMigration_4.SqlExcute: String;
begin
  Result := 'CREATE TABLE FUNCIONARIO ( ' +
            ' ID INT4 NOT NULL, ' +
            ' NOME VARCHAR(100) NOT NULL, ' +
            ' CARGO_ID INT4 NOT NULL, ' +
            ' USUARIO_ID INT4 NOT NULL, ' +
            ' CONSTRAINT FUNCIONARIO_PK PRIMARY KEY (ID), ' +
            ' CONSTRAINT FUNCIONARIO_CARGO_ID_FK FOREIGN KEY (CARGO_ID) REFERENCES CARGO(ID), ' +
            ' CONSTRAINT FUNCIONARIO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO(ID) ' +
            ');';
end;

function TMigration_4.SqlRolback: String;
begin
  Result := 'DROP TABLE IF EXISTS FUNCIONARIO;';
end;

end.
