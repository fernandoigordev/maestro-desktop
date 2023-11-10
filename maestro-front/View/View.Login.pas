unit View.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Effects,
  Controller.Login;

type
  TViewLogin = class(TForm)
    LayoutEsquerdo: TLayout;
    LayoutLogin: TLayout;
    RectangleLogin: TRectangle;
    TextSignIn: TText;
    LayoutConteudo: TLayout;
    RectangleEntrar: TRectangle;
    SpeedButtonEntrar: TSpeedButton;
    RectangleUsuario: TRectangle;
    LabelUsuario: TLabel;
    RectangleSenha: TRectangle;
    LabelSenha: TLabel;
    LayoutContainer: TLayout;
    LabelEsquecerSenha: TLabel;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    ImageLogo: TImage;
    RectangleContainer: TRectangle;
    ShadowEffect1: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButtonEntrarClick(Sender: TObject);
  private
    FControllerLogin: TControllerLogin;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewLogin: TViewLogin;

implementation

{$R *.fmx}

procedure TViewLogin.FormCreate(Sender: TObject);
begin
  FControllerLogin := TControllerLogin.Create;
end;

procedure TViewLogin.FormDestroy(Sender: TObject);
begin
  FControllerLogin.Free;
end;

procedure TViewLogin.SpeedButtonEntrarClick(Sender: TObject);
var
  LoginValidado: Boolean;
begin
  LoginValidado := FControllerLogin.Logar(EditUsuario.Text, EditSenha.Text);

  if LoginValidado then
    //Chamar tela de Menu
end;

end.
