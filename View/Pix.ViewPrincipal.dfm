object frmViewPrincipal: TfrmViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Modelo para Pix - By Franlley Gomes'
  ClientHeight = 515
  ClientWidth = 1048
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblPIX_Primario: TLabel
    Left = 34
    Top = 48
    Width = 95
    Height = 13
    Caption = 'C'#243'd Pix Cadastrado'
    Visible = False
  end
  object lblValor: TLabel
    Left = 242
    Top = 88
    Width = 82
    Height = 13
    Caption = 'Valor cobrado R$'
  end
  object EdtCodPix: TEdit
    Left = 135
    Top = 45
    Width = 905
    Height = 21
    TabOrder = 0
    Text = 
      '00020126330014BR.GOV.BCB.PIX01110303553677552040000530398654041.' +
      '005802BR5920FRANLLEY GOMES BELEM6009SAO PAULO622605221GZZBocdZm9' +
      'h3iBfAn9aj2630405FB'
    Visible = False
  end
  object Button2: TButton
    Left = 421
    Top = 107
    Width = 271
    Height = 25
    Caption = 'PRINCIPAL'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBoxTipoPix: TGroupBox
    Left = 34
    Top = 85
    Width = 185
    Height = 60
    Caption = 'Escolha o Tipo de Pix'
    TabOrder = 2
    object ComboBoxTipoPix: TComboBox
      Left = 21
      Top = 24
      Width = 145
      Height = 21
      TabOrder = 0
      OnChange = ComboBoxTipoPixChange
      Items.Strings = (
        'Pix N'#250'mero'
        'Pix QrCode')
    end
  end
  object EdtValor: TEdit
    Left = 242
    Top = 107
    Width = 145
    Height = 19
    Alignment = taRightJustify
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    Text = '200.00'
  end
  object Memo1: TMemo
    Left = 664
    Top = 282
    Width = 328
    Height = 159
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Se forem implementar este programa para gerar '
      'renda, ajuda o parceiro.'
      ''
      'O Pix Cadstrado '#233' meu mesmo!!!'
      ''
      'Franlley Gomes Bel'#233'm'
      'Um abra'#231'o a todos!!!'
      ''
      'Leia o ReadMe.txt')
    ParentFont = False
    TabOrder = 4
  end
end
