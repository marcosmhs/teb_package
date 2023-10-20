import 'package:flutter/material.dart';

class TebText extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? color;
  final double? letterSpacing;
  final double? wordSpacing;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const TebText({
    super.key,
    required this.text,
    required this.color,
    this.textSize,
    this.letterSpacing,
    this.wordSpacing,
    this.fontWeight,
    this.padding,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: textSize,
          letterSpacing: letterSpacing ?? 0.10,
          wordSpacing: wordSpacing ?? 0.10,
          fontWeight: fontWeight ?? FontWeight.w400,
          overflow: overflow,
        ),
        maxLines: 4,
      ),
    );
  }
}
