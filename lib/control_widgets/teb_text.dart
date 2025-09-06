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
  final double? fontSize;
  final double? textSize;
  final Color? fontColor;
  final Color? textColor;
  final double? letterSpacing;
  final double? wordSpacing;
  final FontWeight? fontWeight;
  final FontWeight? textWeight;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final TextStyle? style;
  final int? maxLines;
  final FontWidth? fontWidth;
  final TextType textType;
  final bool strikethrough;
  final void Function()? onTap;

  const TebText(
    this.text, {
    super.key,
    this.fontColor,
    @Deprecated('Use .fontColor instead') this.textColor,

    this.fontSize,
    @Deprecated('Use .fontSize instead') this.textSize,

    this.fontWeight,
    @Deprecated('Use .fontWeight instead') this.textWeight,

    this.fontWidth,
    this.letterSpacing,
    this.wordSpacing,
    this.padding,
    this.textAlign,
    this.overflow,
    this.fontStyle,
    this.style,
    this.maxLines,

    this.textType = TextType.plainText,
    this.onTap,
    this.strikethrough = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle finalTextStyle =
        (style ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(
          color: fontColor ?? textColor,
          fontSize: fontSize ?? textSize,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          fontWeight: fontWeight ?? textWeight,
          fontStyle: fontStyle,
          overflow: overflow,
          decoration: strikethrough ? TextDecoration.lineThrough : null,
        );

    Widget coreTextWidget;

    if (textType == TextType.plainText) {
      coreTextWidget = Text(text, textAlign: textAlign, maxLines: maxLines, style: finalTextStyle);
    } else {
      var htmlText = text;
      if ((fontWeight ?? textWeight) != null) {
        if ((fontWeight ?? textWeight)!.value >= 700) {
          htmlText = '<b>$htmlText</b>';
        }
      }

      if ((fontColor ?? textColor) != null) {
        htmlText =
            "<span style='color: ${TebUtil.colorToHex(fontColor ?? textColor!)}'>$htmlText</span>";
      }

      htmlText = "<span style='font-size: ${fontSize ?? textSize ?? 12}px'>$htmlText</span>";

      if (textAlign == TextAlign.center) {
        htmlText = "<div style='text-align: center'>$htmlText</div>";
      }
      coreTextWidget = Html(data: htmlText);
    }

    Widget finalWidget = coreTextWidget;

    if (fontWidth != null) {
      finalWidget = SizedBox(width: TebUtil.fontWidthCalculation(fontWidth!), child: finalWidget);
    }

    if (padding != null) {
      finalWidget = Padding(padding: padding!, child: finalWidget);
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: finalWidget);
    }

    return finalWidget;
  }
}
