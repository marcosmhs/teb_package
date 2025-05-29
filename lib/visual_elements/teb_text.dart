import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:teb_package/util/teb_util.dart';

/// Um widget de texto personalizável do TEB Package.
///
/// Este widget permite exibir texto com diferentes estilos e tipos, incluindo texto simples (`plainText`)
/// e HTML (`html`). O parâmetro [textType] define como o texto será interpretado e exibido.
///
/// Parâmetros:
/// - [text]: O conteúdo textual a ser exibido.
/// - [textType]: Define o tipo de texto a ser renderizado. Pode ser [TextType.plainText] para texto simples
///   ou [TextType.html] para renderizar HTML.
/// - [style]: Estilo opcional para o texto.
/// - Outros parâmetros opcionais para personalização.
///
/// Exemplos de uso:
///
/// ```dart
/// // Exemplo usando plainText
/// TebText(
///   text: 'Olá, mundo!',
///   textType: TextType.plainText,
/// )
///
/// // Exemplo usando HTML
/// TebText(
///   text: '<b>Olá, mundo!</b>',
///   textType: TextType.html,
/// )
/// ```

enum TextType { plainText, html }

class TebText extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? textColor;
  final double? letterSpacing;
  final double? wordSpacing;
  final FontWeight? textWeight;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  final FontStyle? textStyle;
  final TextOverflow? overflow;
  final TextStyle? style;
  final int? maxLines;
  final TextWidth? textWidth;
  final TextType textType;

  const TebText(
    this.text, {
    super.key,
    this.textColor,
    this.textSize,
    this.letterSpacing,
    this.wordSpacing,
    this.textWeight,
    this.padding,
    this.textAlign,
    this.overflow,
    this.textStyle,
    this.style,
    this.maxLines,
    this.textWidth,
    this.textType = TextType.plainText,
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget;

    if (textType == TextType.plainText) {
      textWidget = Text(
        text,
        textAlign: textAlign,
        style: style ??
            TextStyle(
              color: textColor,
              fontSize: textSize,
              fontStyle: textStyle,
              letterSpacing: letterSpacing ?? 0.10,
              wordSpacing: wordSpacing ?? 0.10,
              fontWeight: textWeight ?? FontWeight.w400,
              overflow: overflow,
            ),
        maxLines: maxLines,
      );
    } else {
      var htmlText = text;
      if (textWeight != null) {
        if (textWeight!.value >= 700) {
          htmlText = '<b> $htmlText </b';
        }
      }

      if (textColor != null) {
        htmlText = "<span style='color: ${TebUtil.colorToHex(textColor!)}'> $htmlText </span>";
      }

      htmlText = "<span style='font-size: ${textSize ?? 12}px'> $htmlText </span>";

      if (textAlign == TextAlign.center) {
        htmlText = "<div style='text-align: center'>$htmlText</div>";
      }

      textWidget = Html(data: htmlText);
    }

    if (textWidth != null) {
      textWidget = SizedBox(
        width: TebUtil.textWidthCalculation(textWidth!),
        child: textWidget,
      );
    }

    if (padding == null) {
      return textWidget;
    } else {
      return Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: textWidget,
      );
    }
  }
}
