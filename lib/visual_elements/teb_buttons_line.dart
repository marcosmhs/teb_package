import 'package:flutter/material.dart';

enum TebButtonType { outlinedButton, elevatedButton }

class TebButton extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final bool enabled;
  final TebButtonType buttonType;
  final TextStyle? textStyle;

  const TebButton({
    super.key,
    required this.label,
    this.onPressed,
    this.enabled = true,
    this.buttonType = TebButtonType.elevatedButton,
    this.textStyle,
  });

  @override
  State<TebButton> createState() => _TebButtonState();
}

class _TebButtonState extends State<TebButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.buttonType == TebButtonType.outlinedButton) {
      return OutlinedButton(
        onPressed: widget.enabled ? widget.onPressed : () => {},
        style: widget.enabled ? null : ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).disabledColor)),
        child: Text(widget.label, style: widget.textStyle),
      );
    } else {
      return ElevatedButton(
        onPressed: widget.enabled ? widget.onPressed : () => {},
        style: widget.enabled ? null : ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).disabledColor)),
        child: Text(widget.label, style: widget.textStyle),
      );
    }
  }
}

class TebButtonsLine extends StatefulWidget {
  final List<TebButton> buttons;
  final MainAxisAlignment mainAxisAlignment;
  final double widthSpaceBetweenButtons;

  const TebButtonsLine({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.widthSpaceBetweenButtons = 20,
    required this.buttons,
  }) : super(key: key);

  @override
  State<TebButtonsLine> createState() => _TebButtonsLineState();
}

class _TebButtonsLineState extends State<TebButtonsLine> {
  List<Widget> getList() {
    List<Widget> btns = [];
    for (TebButton btn in widget.buttons) {
      btns.add(btn);
      if (btn != widget.buttons.last) btns.add(SizedBox(width: widget.widthSpaceBetweenButtons));
    }
    return btns;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: (getList()),
    );
  }
}
