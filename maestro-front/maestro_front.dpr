program Maestro_Front;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Menu in 'src\View\View.Menu.pas' {Form1},
  View.Login in 'src\View\View.Login.pas' {ViewLogin},
  Controller.Login in 'src\Controller\Controller.Login.pas',
  Entity.Usuario in 'src\Entity\Entity.Usuario.pas',
  Dto.Usuario in 'src\Dto\Dto.Usuario.pas',
  Repository.Usuario in 'src\Repository\Usuario\Repository.Usuario.pas',
  Repository.Usuario.Interfaces in 'src\Repository\Usuario\Repository.Usuario.Interfaces.pas',
  Entity.Connection in 'src\Entity\Entity.Connection.pas' {EntityConnection: TDataModule},
  Entity.Migration in 'src\Entity\Entity.Migration.pas',
  Utils.Factory.DataSet in 'src\Utils\Factory\Utils.Factory.DataSet.pas',
  Repository.Migration.Interfaces in 'src\Repository\Migration\Repository.Migration.Interfaces.pas',
  Repository.Migration in 'src\Repository\Migration\Repository.Migration.pas',
  Dto.Migration in 'src\Dto\Dto.Migration.pas',
  View.Splash in 'src\View\View.Splash.pas' {ViewSplash},
  Controller.Splash in 'src\Controller\Controller.Splash.pas',
  Utils.Observer.Migration in 'src\Utils\Observer\Utils.Observer.Migration.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  TViewSplash.IniciarSistema;
  Application.CreateForm(TViewLogin, ViewLogin);
  Application.Run;
end.
