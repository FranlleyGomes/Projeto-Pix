program ProjectPix;

uses
  Vcl.Forms,
  Pix.ViewPrincipal in 'View\Pix.ViewPrincipal.pas' {frmViewPrincipal},
  Pix.Model.Interfaces in 'Model\Pix.Model.Interfaces.pas',
  Pix.Model.GerarCodigoPix in 'Model\Pix.Model.GerarCodigoPix.pas',
  Pix.Model.GerarCodigoPix.Factory in 'Model\Pix.Model.GerarCodigoPix.Factory.pas',
  Pix.Controller.GerarCodigoPix in 'Controller\Pix.Controller.GerarCodigoPix.pas',
  Pix.Interfaces.Controller in 'Controller\Pix.Interfaces.Controller.pas',
  Pix.Model.GerarQRCodePix in 'Model\Pix.Model.GerarQRCodePix.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewPrincipal, frmViewPrincipal);
  Application.Run;
end.
