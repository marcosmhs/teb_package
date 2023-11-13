import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontStyle: textStyle,
          letterSpacing: letterSpacing ?? 0.10,
          wordSpacing: wordSpacing ?? 0.10,
          fontWeight: textWeight ?? FontWeight.w400,
          overflow: overflow,
        ),
        maxLines: 4,
      ),
    );
  }
}
