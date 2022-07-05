{ Modelo de cobrança pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Belém

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas mãos para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.Model.GerarCodigoPix;

interface

uses
  Pix.Model.Interfaces, Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Vcl.Dialogs;

Type
  TModelGerarCodigoPix = class(TInterfacedObject, iGerarPix)
  private
    FStringPadraoCadastrada: String;
    FValor: String;
    FNovaString: String;
    FQtdCaracteres: String;
    FPosicaoNaStringPadrao: String;
    FNovoCRC16: String;

    FDisplay: TEvDisplay;
    Memo: TMemo;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iGerarPix;
    function CRC16CCITT: iGerarPix;
    function StringPadraoCadastrada(aValue: String): iGerarPix;
    function Valor(aValue: String): iGerarPix;
    function ContarStringsValor(aValue: String): iGerarPix;
    function PosicaoNaStringPadrao(aValue: String): iGerarPix;
    function AlterarStrigValor(aValue: String): iGerarPix;
    function AlterarStrigCRC: iGerarPix;
    function NovaString: iGerarPix;
    function Display(Value: TEvDisplay): iGerarPix;
    function DesenhaTextoPix(Formulario: TForm; aValue: String): iGerarPix;
    function DesenharQRCode(Formulario: TForm; aValue: String): iGerarPix;
      virtual; abstract;
  end;

implementation

{ TModelGerarCodigoPix }

constructor TModelGerarCodigoPix.Create;
begin

end;

destructor TModelGerarCodigoPix.Destroy;
begin

  inherited;

end;

function TModelGerarCodigoPix.PosicaoNaStringPadrao(aValue: String): iGerarPix;
begin
  Result := Self;
  FPosicaoNaStringPadrao := POS((aValue), (FStringPadraoCadastrada)).ToString;
end;

function TModelGerarCodigoPix.StringPadraoCadastrada(aValue: String): iGerarPix;
begin
  Result := Self;
  FStringPadraoCadastrada := aValue;
end;

function TModelGerarCodigoPix.ContarStringsValor(aValue: String): iGerarPix;
var
  N: Integer;
begin
  Result := Self;

  FValor := StringReplace(aValue, '.', ',', []);
  FValor := CurrToStrF(FValor.ToDouble,ffNumber,2);
  FValor := StringReplace(FValor, ',', '.', []);

  N := Length(FValor);
  FQtdCaracteres := Format('%.2d', [N]);
end;

function TModelGerarCodigoPix.CRC16CCITT: iGerarPix;
const
  polynomial = $1021;
var
  CRC: Word;
  i, j: Integer;
  b: Byte;
  bit, c15: Boolean;
begin
  Result := Self;

  CRC := $FFFF;
  for i := 1 to Length(FNovaString) do
  begin
    b := Byte(FNovaString[i]);
    for j := 0 to 7 do
    begin
      bit := (((b shr (7 - j)) and 1) = 1);
      c15 := (((CRC shr 15) and 1) = 1);
      CRC := CRC shl 1;
      if (c15 xor bit) then
        CRC := CRC xor polynomial;
    end;
  end;

  FNovoCRC16 := inttohex(CRC and $FFFF, 4)

end;

function TModelGerarCodigoPix.DesenhaTextoPix(Formulario: TForm; aValue: String)
  : iGerarPix;
begin

  Result := Self;
  Memo := TMemo.Create(nil);


  With Memo do
  begin
    Memo.Parent := Formulario;
    Name := 'MemoPix';
    Clear;
    Text := aValue;
    Parent := Formulario;
    Left := 34;
    Top := 151;
    Width := 905;
    Height := 37;
    Visible := True;
  end;

end;

function TModelGerarCodigoPix.Display(Value: TEvDisplay): iGerarPix;
begin
  Result := Self;
  FDisplay := Value;
end;

class function TModelGerarCodigoPix.New: iGerarPix;
begin
  Result := Self.Create;
end;

function TModelGerarCodigoPix.NovaString: iGerarPix;
begin
  Result := Self;
  FDisplay(FNovaString + FNovoCRC16);
end;

function TModelGerarCodigoPix.AlterarStrigCRC: iGerarPix;
var
  TamanhoDaString_Menos4: Integer;
begin
  Result := Self;
  TamanhoDaString_Menos4 := Length(FNovaString);
  FNovaString := copy(FNovaString, 0, TamanhoDaString_Menos4 - 4);
end;

function TModelGerarCodigoPix.AlterarStrigValor(aValue: String): iGerarPix;
var
  PosicaoDaStringQueSeraAlterada,
  QuantidadeDeLetras              : Integer;
  StringPrincipal,
  StringQueVaiSerAlterada,
  StringNova,
  ParteDaStringAntesDoValor,
  ParteDaStringDepoisDoValor      : String;
begin

  Result := Self;

  StringPrincipal                 := '';
  StringQueVaiSerAlterada         := '';
  StringNova                      := '';
  PosicaoDaStringQueSeraAlterada  := 0;
  QuantidadeDeLetras              := 0;
  ParteDaStringAntesDoValor       := '';
  ParteDaStringDepoisDoValor      := '';

  PosicaoDaStringQueSeraAlterada  := POS((aValue), (FStringPadraoCadastrada));
  QuantidadeDeLetras              := Length(FStringPadraoCadastrada);
  ParteDaStringAntesDoValor       := copy((FStringPadraoCadastrada), 0,
    PosicaoDaStringQueSeraAlterada - 1);
  ParteDaStringDepoisDoValor := copy(FStringPadraoCadastrada,
    PosicaoDaStringQueSeraAlterada + 8, QuantidadeDeLetras);

  StringPrincipal := FStringPadraoCadastrada;
  StringQueVaiSerAlterada := aValue;
  StringNova := '54' + FQtdCaracteres + FValor;
  FNovaString := StringPrincipal.Replace(StringQueVaiSerAlterada, StringNova,
    [rfReplaceAll]);

end;

function TModelGerarCodigoPix.Valor(aValue: String): iGerarPix;
begin
  Result := Self;
  FValor := StringReplace(aValue, '.', ',', []);
  FValor := CurrToStrF(FValor.ToDouble,ffNumber,2);
  FValor := StringReplace(FValor, ',', '.', []);
end;

end.
