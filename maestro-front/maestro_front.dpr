program maestro_front;

uses
  Vcl.Forms,
  View.Menu in 'View\View.Menu.pas' {FmViewMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmViewMenu, FmViewMenu);
  Application.Run;
end.
