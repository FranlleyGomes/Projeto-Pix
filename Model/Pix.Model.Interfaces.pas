{ Modelo de cobrança pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Belém

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas mãos para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.Model.Interfaces;

interface

uses
  Vcl.Graphics, Vcl.Forms;

Type

  TEvDisplay = procedure (Value : String) of Object;


  iGerarPix = interface
    ['{FE429532-473D-4890-85A2-8429CD03BBC4}']
    function CRC16CCITT: iGerarPix;
    function StringPadraoCadastrada(aValue: String) : iGerarPix;
    function Valor(aValue : String) : iGerarPix;
    function ContarStringsValor(aValue :String) : iGerarPix;
    function PosicaoNaStringPadrao(aValue: String) : iGerarPix;
    function AlterarStrigValor(aValue: String) : iGerarPix;
    function AlterarStrigCRC: iGerarPix;
    function NovaString : iGerarPix;
    function Display (Value : TEvDisplay) : iGerarPix;
    function DesenhaTextoPix(Formulario : TForm; aValue : String) : iGerarPix;
    function DesenharQRCode(Formulario : TForm ; aValue : String) :iGerarPix;
  end;



  iGerarCodigoPixFactory = interface
    ['{75D59E09-B114-4129-9443-F3854B94CC09}']
    function GerarCodigoPix : iGerarPix;
    function GerarQRCodePix : iGerarPix;
  end;


implementation

end.
