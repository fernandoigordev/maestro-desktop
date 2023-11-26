unit View.Splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, Controller.Splash, Utils.Observer.Migration;

type
  TViewSplash = class(TForm, IObservadorMigration)
    LabelLogMigration: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FControllerSplash: TControllerSplash;

    procedure AtualizarObservador(ATexto: String);
  public

  end;

var
  ViewSplash: TViewSplash;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure TViewSplash.FormCreate(Sender: TObject);
begin
  FControllerSplash := TControllerSplash.Create;
end;

procedure TViewSplash.FormDestroy(Sender: TObject);
begin
  FControllerSplash.Free;
end;

procedure TViewSplash.FormShow(Sender: TObject);
begin
  FControllerSplash.ExecutarMigration(Self);
end;

procedure TViewSplash.AtualizarObservador(ATexto: String);
begin
  LabelLogMigration.Text := ATexto;
end;


end.
