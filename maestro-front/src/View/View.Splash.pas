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
    TextNomeSistem: TText;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FControllerSplash: TControllerSplash;
    procedure ExecutarMigrations;
    procedure AtualizarObservador(ATexto: String);
  public
    Class function IniciarSistema: Boolean;
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

class function TViewSplash.IniciarSistema: Boolean;
var
  ViewSplash: TViewSplash;
begin
  Result := True;
  ViewSplash := TViewSplash.Create(Application);
  try
    try
      ViewSplash.Show;
      ViewSplash.ExecutarMigrations;
      ViewSplash.Close;
    except
      Result := False;
      raise
    end;
  finally
    ViewSplash.Free;
  end;
end;

procedure TViewSplash.AtualizarObservador(ATexto: String);
begin
  LabelLogMigration.Text := ATexto;
  Application.ProcessMessages;
end;


end.
