import 'package:flutter/material.dart';
import 'package:teb_package/util/teb_util.dart';
/// A class that represents a custom text widget.
///
/// The `TebText` class is typically used to display styled text in a Flutter application.
/// It provides customization options such as font size, color, and alignment.
///
/// Example usage:
/// ```dart
/// TebText(
///   text: 'Hello, World!',
///   fontSize: 16.0,
///   color: Colors.black,
///   textAlign: TextAlign.center,
/// );
/// ```
///
/// Properties:
/// - `text`: The string content to be displayed.
/// - `fontSize`: The size of the text. Defaults to a standard size if not specified.
/// - `color`: The color of the text. Defaults to black if not specified.
/// - `textAlign`: The alignment of the text. Defaults to left-aligned if not specified.
///
/// This class is designed to be lightweight and reusable for various text display needs.
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
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
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
