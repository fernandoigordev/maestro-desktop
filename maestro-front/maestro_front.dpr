program Maestro_Front;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Menu in 'View\View.Menu.pas' {Form1},
  View.Login in 'View\View.Login.pas' {ViewLogin},
  Controller.Login in 'Controller\Controller.Login.pas',
  Entity.Usuario in 'Entity\Entity.Usuario.pas',
  Utils.Globais in 'Utils\Utils.Globais.pas',
  Dto.Usuario in 'Dto\Dto.Usuario.pas',
  Repository.Usuario in 'Repository\Repository.Usuario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewLogin, ViewLogin);
  Application.Run;
end.
