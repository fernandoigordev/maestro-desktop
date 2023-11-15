unit TestController.Login;

interface
uses
  DUnitX.TestFramework, Repository.Usuario.Interfaces, Mock.Repository.Usuario, Controller.Login;

type

  [TestFixture]
  TTestControllerLogin = class(TObject)
  private
    FMockRepositoryUsuario: IRepositoryUsuario;
    FControllerLogin: TControllerLogin;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure Logar;
  end;

implementation

procedure TTestControllerLogin.Setup;
begin
  FMockRepositoryUsuario := TMockRepositoryUsuario.Create;
  FControllerLogin := TControllerLogin.Create(FMockRepositoryUsuario);
end;

procedure TTestControllerLogin.TearDown;
begin
  FControllerLogin.Free;
end;

procedure TTestControllerLogin.Logar;
var
  Logado: Boolean;
begin
  Logado := FControllerLogin.Logar('UsuarioTeste', '123456');

  Assert.IsTrue(Logado, 'Login invalido!');
end;


initialization
  TDUnitX.RegisterTestFixture(TTestControllerLogin);
end.
