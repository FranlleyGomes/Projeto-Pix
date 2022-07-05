{ Modelo de cobrança pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Belém

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas mãos para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.Controller.GerarCodigoPix;

interface

uses
  Pix.Interfaces.Controller, Pix.Model.Interfaces;

Type
  TControllerGerarCodigoPix = class(TInterfacedObject, iControllerPix)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iControllerPix;
    function GerarPix(Value: TTypePix): iGerarPix;
  end;

implementation

uses
  Pix.Model.GerarCodigoPix.Factory;

{ TControllerGerarCodigoPix }

constructor TControllerGerarCodigoPix.Create;
begin

end;

destructor TControllerGerarCodigoPix.Destroy;
begin

  inherited;
end;

function TControllerGerarCodigoPix.GerarPix(Value: TTypePix): iGerarPix;
begin
   case Value of
     TpNumero: Result:= TModelGerarCodigoPixFactory.New.GerarCodigoPix;
     TpDesenho:Result:= TModelGerarCodigoPixFactory.New.GerarQRCodePix;
   end;
end;

class function TControllerGerarCodigoPix.New: iControllerPix;
begin
  Result := Self.Create;
end;

end.
