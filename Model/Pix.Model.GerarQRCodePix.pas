{ Modelo de cobrança pelo Pix desenvolvido pelo programador em Delphi
  Franlley Gomes Belém

 "Bendito seja o SENHOR, minha Rocha,
que adestra minhas mãos para a guerra, meus dedos para as batalhas!"
SALMO 144:1}

unit Pix.Model.GerarQRCodePix;

interface

uses
  Pix.Model.Interfaces, Vcl.Graphics, ACBrDelphiZXingQRCode, Vcl.Forms,
  Vcl.ExtCtrls, System.SysUtils;

Type
  TModelGerarQRCodePix = class(TInterfacedObject, iGerarPix)
  private
    FStringPadraoCadastrada: String;
    FValor: String;
    FNovaString: String;
    FQtdCaracteres: String;
    FPosicaoNaStringPadrao: String;
    FNovoCRC16: String;

    FDisplay: TEvDisplay;
    Imagem: TImage;
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

    procedure QrCodeToCanvas(AWidth, AHeight: Integer; ATexto: String;
      ACanvas: TCanvas);
    function DesenhaTextoPix(Formulario: TForm; aValue: String): iGerarPix;
      virtual; abstract;
    function DesenharQRCode(Formulario: TForm; aValue: String): iGerarPix;
    function  CurrToStrF(Value: Currency; Format: TFloatFormat = ffNumber; Digits: Integer = 2): String;

  end;

implementation

uses
  Vcl.Dialogs, System.Classes;

{ TModelGerarQRCodePix }

constructor TModelGerarQRCodePix.Create;
begin

end;

function TModelGerarQRCodePix.CurrToStrF(Value: Currency; Format: TFloatFormat;
  Digits: Integer): String;
var
  Buffer: array[0..63] of Char;
begin
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvCurrency,  Format, 0, Digits));

end;

destructor TModelGerarQRCodePix.Destroy;
begin
  inherited;

end;

function TModelGerarQRCodePix.PosicaoNaStringPadrao(aValue: String): iGerarPix;
begin
  Result := Self;
  FPosicaoNaStringPadrao := POS((aValue), (FStringPadraoCadastrada)).ToString;
end;

procedure TModelGerarQRCodePix.QrCodeToCanvas(AWidth, AHeight: Integer;
  ATexto: String; ACanvas: TCanvas);
var
  bitmap: TBitmap;
  qr: TDelphiZXingQRCode;
  r: Integer;
  c: Integer;
  scala: Double;
begin
  bitmap := TBitmap.Create;
  try
    qr := TDelphiZXingQRCode.Create;
    try
      qr.Data := ATexto;

      // ajuta o tamanho do bitmap para o tamanho do qrcode
      bitmap.SetSize(qr.Rows, qr.Columns);

      // copia o qrcode para o bitmap
      for r := 0 to qr.Rows - 1 do
        for c := 0 to qr.Columns - 1 do
          if qr.IsBlack[r, c] then
            bitmap.Canvas.Pixels[c, r] := clBlack
          else
            bitmap.Canvas.Pixels[c, r] := clWhite;

      // prepara para redimensionar o qrcode para o tamanho do canvas
      if (AWidth < bitmap.Height) then
      begin
        scala := AWidth / bitmap.Width;
      end
      else
      begin
        scala := AHeight / bitmap.Height;
      end;

      // transfere o bitmap para a imagem
      ACanvas.StretchDraw(Rect(0, 0, Trunc(scala * bitmap.Width),
        Trunc(scala * bitmap.Height)), bitmap);

    finally
      qr.Free;
    end;
  finally
    bitmap.Free;
  end;

end;

function TModelGerarQRCodePix.StringPadraoCadastrada(aValue: String): iGerarPix;
begin
  Result := Self;
  FStringPadraoCadastrada := aValue;
end;

function TModelGerarQRCodePix.ContarStringsValor(aValue: String): iGerarPix;
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

function TModelGerarQRCodePix.CRC16CCITT: iGerarPix;
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

function TModelGerarQRCodePix.DesenharQRCode(Formulario: TForm; aValue: String)
  : iGerarPix;
begin
  Result := Self;

  Imagem := TImage.Create(nil);

  With Imagem do
  begin
    Parent := Formulario;
    Left := 34;
    Top := 250;
    Width := 225;
    Height := 226;
    Stretch := True;
    QrCodeToCanvas(Imagem.Width, Imagem.Height, aValue, Imagem.Canvas);
    Visible := True;
  end;
end;



function TModelGerarQRCodePix.Display(Value: TEvDisplay): iGerarPix;
begin
  Result := Self;
  FDisplay := Value;
end;

class function TModelGerarQRCodePix.New: iGerarPix;
begin
  Result := Self.Create;
end;

function TModelGerarQRCodePix.NovaString: iGerarPix;
begin
  Result := Self;
  FDisplay(FNovaString + FNovoCRC16);
end;

function TModelGerarQRCodePix.AlterarStrigCRC: iGerarPix;
var
  TamanhoDaString_Menos4: Integer;
begin
  Result := Self;
  TamanhoDaString_Menos4 := Length(FNovaString);
  FNovaString := copy(FNovaString, 0, TamanhoDaString_Menos4 - 4);
end;

function TModelGerarQRCodePix.AlterarStrigValor(aValue: String): iGerarPix;
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

  PosicaoDaStringQueSeraAlterada := POS((aValue), (FStringPadraoCadastrada));
  QuantidadeDeLetras := Length(FStringPadraoCadastrada);
  ParteDaStringAntesDoValor := copy((FStringPadraoCadastrada), 0,
    PosicaoDaStringQueSeraAlterada - 1);
  ParteDaStringDepoisDoValor := copy(FStringPadraoCadastrada,
    PosicaoDaStringQueSeraAlterada + 8, QuantidadeDeLetras);

  StringPrincipal := FStringPadraoCadastrada;
  StringQueVaiSerAlterada := aValue;
  StringNova := '54' + FQtdCaracteres + FValor;
  FNovaString := StringPrincipal.Replace(StringQueVaiSerAlterada, StringNova,
    [rfReplaceAll]);

end;

function TModelGerarQRCodePix.Valor(aValue: String): iGerarPix;
begin
  Result := Self;
  FValor := StringReplace(aValue, '.', ',', []);
  FValor := CurrToStrF(FValor.ToDouble,ffNumber,2);
  FValor := StringReplace(FValor, ',', '.', []);
end;

end.

