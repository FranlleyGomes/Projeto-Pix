{ Modelo de cobrança pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Belém

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas mãos para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.Model.GerarCodigoPix.Factory;

interface

uses
  Pix.Model.Interfaces;

Type
  TModelGerarCodigoPixFactory = class(TInterfacedObject, iGerarCodigoPixFactory)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iGerarCodigoPixFactory;
    function GerarCodigoPix : iGerarPix;
    function GerarQRCodePix : iGerarPix;
  end;

implementation

uses
  Pix.Model.GerarCodigoPix, Pix.Model.GerarQRCodePix;

{ TModelGerarCodigoPixFactory }

constructor TModelGerarCodigoPixFactory.Create;
begin

end;

destructor TModelGerarCodigoPixFactory.Destroy;
begin

  inherited;
end;

function TModelGerarCodigoPixFactory.GerarCodigoPix: iGerarPix;
begin
  Result := TModelGerarCodigoPix.New;
end;

function TModelGerarCodigoPixFactory.GerarQRCodePix: iGerarPix;
begin
  Result := TModelGerarQRCodePix.New;
end;

class function TModelGerarCodigoPixFactory.New: iGerarCodigoPixFactory;
begin
  Result := Self.Create;
end;



end.
