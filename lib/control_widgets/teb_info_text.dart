import 'package:flutter/material.dart';
import 'package:teb_package/control_widgets/teb_text.dart';

class TebInfoText extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? sideBarColor;
  final TextType textType;
  final EdgeInsets? padding;
  const TebInfoText({
    super.key,
    required this.text,
    this.padding,
    this.backgroundColor,
    this.sideBarColor,
    this.textType = TextType.html,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.shadow.withAlpha(10),
          borderRadius: BorderRadius.circular(0),
          border: Border(left: BorderSide(color: sideBarColor ?? Theme.of(context).primaryColor, width: 5)),
        ),
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            SizedBox(width: 2),
            Expanded(child: TebText(text, textType: textType, textSize: 14)),
          ],
        ),
      ),
    );
  }
}
