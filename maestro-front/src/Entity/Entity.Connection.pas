unit Entity.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

const
  CS_NOME_ARQUIVO_CONFIGURACAO = 'Configuracao.ini';

type
  TEntityConnection = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    Class var FEntityConnection: TEntityConnection;
    procedure ConfigurarConexao;
  public
    Class function GetInstance: TEntityConnection;
  end;

implementation
uses
  IniFiles, FMX.Dialogs, FMX.Forms;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TEntityConnection }

procedure TEntityConnection.DataModuleCreate(Sender: TObject);
begin
  ConfigurarConexao;
end;

class function TEntityConnection.GetInstance: TEntityConnection;
begin
  if not Assigned(FEntityConnection) then
    FEntityConnection := TEntityConnection.Create(nil);

  Result := FEntityConnection;
end;

procedure TEntityConnection.ConfigurarConexao;
var
  ArquivoINI: TIniFile;
  CaminhoArquivoConfiguracao: String;
begin
  CaminhoArquivoConfiguracao := Concat(ExtractFilePath(ParamStr(0)), CS_NOME_ARQUIVO_CONFIGURACAO);

  if FileExists(CaminhoArquivoConfiguracao) then
  begin
    ArquivoINI := TIniFile.Create(CaminhoArquivoConfiguracao);
    try
      Self.FDConnection.Params.UserName := ArquivoINI.ReadString('Conexao', 'User_Name', 'Erro ao ler User_Name');
      Self.FDConnection.Params.Database := ArquivoINI.ReadString('Conexao', 'Database', 'Erro ao ler Database');
      Self.FDConnection.Params.Password := ArquivoINI.ReadString('Conexao', 'Password', 'Erro ao ler Password');
      Self.FDConnection.Params.DriverID := ArquivoINI.ReadString('Conexao', 'DriverID', 'Erro ao ler DriverID');
      Self.FDConnection.Params.Values['Server'] := ArquivoINI.ReadString('Conexao', 'Server', 'Erro ao ler Server');
      Self.FDConnection.Params.Values['MetaDefSchema'] := ArquivoINI.ReadString('Conexao', 'MetaDefSchema', 'Erro ao ler MetaDefSchema');
      Self.FDConnection.Params.Values['Port'] := ArquivoINI.ReadString('Conexao', 'Port', 'Erro ao ler Port');

      Self.FDPhysPgDriverLink.VendorHome := ArquivoINI.ReadString('DriveLink', 'VendorHome', 'Erro ao ler VendorHome');
      Self.FDPhysPgDriverLink.VendorHome := ArquivoINI.ReadString('DriveLink', 'VendorLib', 'Erro ao ler VendorLib');

      Self.FDConnection.Connected;
    finally
      ArquivoINI.Free;
    end;
  end
  else
  begin
    ShowMessage(Concat('Arquivo de conexão não encontrado em: ', CaminhoArquivoConfiguracao));
    Application.Terminate;
  end;
end;

end.
