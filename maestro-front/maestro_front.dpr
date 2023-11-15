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
  Repository.Usuario.Interfaces in 'src\Repository\Usuario\Repository.Usuario.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewLogin, ViewLogin);
  Application.Run;
end.
