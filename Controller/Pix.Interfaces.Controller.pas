{ Modelo de cobran�a pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Bel�m

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas m�os para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.Interfaces.Controller;

interface

uses
  Pix.Model.Interfaces;

type

   TTypePix = (TpNumero, TpDesenho);

  iControllerPix = interface
    ['{D2A92BB3-E216-405E-8196-AD9B51539BE8}']
    function GerarPix(Value :TTypePix) : iGerarPix;
  end;

implementation

end.
