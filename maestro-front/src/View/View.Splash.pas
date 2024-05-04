unit View.Splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Controller.Splash, Utils.Observer.Migration,
  FMX.Objects, FMX.Layouts;

type
  TViewSplash = class(TForm, IObservadorMigration)
    LabelLogMigration: TLabel;
    LayoutRodape: TLayout;
    LayoutPrincipal: TLayout;
    ImageLogo: TImage;
    ProgressBarMigration: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FControllerSplash: TControllerSplash;
    procedure ExecutarMigrations;
    procedure AtualizarObservador(ATexto: String);
  public
    Class procedure IniciarSistema;
  end;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure TViewSplash.ExecutarMigrations;
begin
  FControllerSplash.ExecutarMigration(Self);
end;

procedure TViewSplash.FormCreate(Sender: TObject);
begin
  FControllerSplash := TControllerSplash.Create;
end;

procedure TViewSplash.FormDestroy(Sender: TObject);
begin
  FControllerSplash.Free;
end;

class procedure TViewSplash.IniciarSistema;
var
  ViewSplash: TViewSplash;
  TotalQuantidadeMigrationExecutar: Integer;
begin
  ViewSplash := TViewSplash.Create(Application);
  try
    TotalQuantidadeMigrationExecutar := ViewSplash.FControllerSplash.QuantidadeMigrationExecutar;

    if TotalQuantidadeMigrationExecutar > 0 then
    begin
      ViewSplash.ProgressBarMigration.Value := 0;
      ViewSplash.ProgressBarMigration.Max := TotalQuantidadeMigrationExecutar;
      ViewSplash.Show;
      ViewSplash.ExecutarMigrations;
      ViewSplash.Close;
    end;
  finally
    ViewSplash.Free;
  end;
end;

procedure TViewSplash.AtualizarObservador(ATexto: String);
begin
  ProgressBarMigration.Value := ProgressBarMigration.Value + 1;
  LabelLogMigration.Text := Concat('Executando atualização ', ATexto);
  Application.ProcessMessages;
end;


end.
