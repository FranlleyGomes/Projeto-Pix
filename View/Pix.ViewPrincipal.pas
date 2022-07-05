{ Modelo de cobrança pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Belém

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas mãos para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.ViewPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, acbruTIL, Vcl.StdCtrls,
  Vcl.ExtCtrls, Pix.Model.Interfaces;

type
  TfrmViewPrincipal = class(TForm)
    EdtCodPix: TEdit;
    Button2: TButton;
    lblPIX_Primario: TLabel;
    GroupBoxTipoPix: TGroupBox;
    ComboBoxTipoPix: TComboBox;
    lblValor: TLabel;
    EdtValor: TEdit;
    Memo1: TMemo;
    procedure ComboBoxTipoPixChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    MemoPix: TMemo;
    GerarPix: iGerarPix;
    procedure ExibeResultado(Value: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewPrincipal: TfrmViewPrincipal;

implementation

uses
  Pix.Controller.GerarCodigoPix, Pix.Interfaces.Controller;



{$R *.dfm}

procedure TfrmViewPrincipal.Button2Click(Sender: TObject);
begin

  if Trim(ComboBoxTipoPix.Text) = '' then
  begin
    MessageDlg('Escolha o Tipo de Pix!', mtInformation, [mbOk], 0, mbOk);
    ComboBoxTipoPix.SetFocus;
    Abort;
  end;

  GerarPix.StringPadraoCadastrada(EdtCodPix.Text)
    .ContarStringsValor(EdtValor.Text)
    .Valor(EdtValor.Text)
    .AlterarStrigValor('54041.00')
    .PosicaoNaStringPadrao('6304')
    .AlterarStrigCRC
    .CRC16CCITT
    .Display(ExibeResultado)
    .NovaString;
end;

procedure TfrmViewPrincipal.ComboBoxTipoPixChange(Sender: TObject);
begin
  case ComboBoxTipoPix.ItemIndex of
    0:
      GerarPix := TControllerGerarCodigoPix.New.GerarPix(TpNumero);
    1:
      GerarPix := TControllerGerarCodigoPix.New.GerarPix(TpDesenho);
  end;
end;

procedure TfrmViewPrincipal.ExibeResultado(Value: String);
begin
  case ComboBoxTipoPix.ItemIndex of
    0:
      GerarPix.DesenhaTextoPix(frmViewPrincipal, Value);
    1:
      GerarPix.DesenharQRCode(frmViewPrincipal, Value);
  end;
end;

end.
