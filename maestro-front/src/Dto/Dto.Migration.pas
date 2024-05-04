unit Dto.Migration;

interface

type
 TMigrationStatusEnum = (mseErro, mseSucesso);

  TMigrationDto = class
  private
    FId: Integer;
    FDescricao: String;
    FStatus: TMigrationStatusEnum;
    FDataExecucao: TDateTime;
    FSqlExcute: String;
    FSqlRolback: String;
  public
    property Id: Integer read FId write FId;
    property Descricao: String read FDescricao write FDescricao;
    property Status: TMigrationStatusEnum read FStatus write FStatus;
    property DataExecucao: TDateTime read FDataExecucao write FDataExecucao;
    property SqlExcute: String read FSqlExcute write FSqlExcute;
    property SqlRolback: String read FSqlRolback write FSqlRolback;
  end;

implementation

end.
