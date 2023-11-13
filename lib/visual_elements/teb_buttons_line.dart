import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TebButtonType { outlinedButton, elevatedButton }

class TebButton extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final bool enabled;
  final TebButtonType buttonType;
  final TextStyle? textStyle;
  final Widget? icon;
  final FaIcon? faIcon;
  final EdgeInsetsGeometry? padding;

  const TebButton({
    super.key,
    required this.label,
    this.onPressed,
    this.enabled = true,
    this.buttonType = TebButtonType.elevatedButton,
    this.textStyle,
    this.icon,
    this.faIcon,
    this.padding,
  });

  @override
  State<TebButton> createState() => _TebButtonState();
}

class _TebButtonState extends State<TebButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.icon != null || widget.faIcon != null) {
      if (widget.buttonType == TebButtonType.outlinedButton) {
        return Padding(
          padding: widget.padding != null ? widget.padding! : const EdgeInsets.all(0),
          child: OutlinedButton.icon(
            onPressed: widget.enabled ? widget.onPressed : () => {},
            style:
                widget.enabled ? null : ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).disabledColor)),
            icon: widget.icon != null ? widget.icon! : widget.faIcon!,
            label: Text(widget.label, style: widget.textStyle),
          ),
        );
      } else {
        return Padding(
          padding: widget.padding != null ? widget.padding! : const EdgeInsets.all(0),
          child: ElevatedButton.icon(
            onPressed: widget.enabled ? widget.onPressed : () => {},
            style:
                widget.enabled ? null : ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).disabledColor)),
            icon: widget.icon != null ? widget.icon! : widget.faIcon!,
            label: Text(widget.label, style: widget.textStyle),
          ),
        );
      }
    }

    if (widget.buttonType == TebButtonType.outlinedButton) {
      return Padding(
        padding: widget.padding != null ? widget.padding! : const EdgeInsets.all(0),
        child: OutlinedButton(
          onPressed: widget.enabled ? widget.onPressed : () => {},
          style: widget.enabled ? null : ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).disabledColor)),
          child: Text(widget.label, style: widget.textStyle),
        ),
      );
    } else {
      return Padding(
        padding: widget.padding != null ? widget.padding! : const EdgeInsets.all(0),
        child: ElevatedButton(
          onPressed: widget.enabled ? widget.onPressed : () => {},
          style: widget.enabled ? null : ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).disabledColor)),
          child: Text(widget.label, style: widget.textStyle),
        ),
      );
    }
  }
}

class TebButtonsLine extends StatefulWidget {
  final List<Widget> buttons;
  final MainAxisAlignment mainAxisAlignment;
  final double widthSpaceBetweenButtons;
  final EdgeInsetsGeometry? padding;

  const TebButtonsLine({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.widthSpaceBetweenButtons = 20,
    this.padding,
    required this.buttons,
  }) : super(key: key);

  @override
  State<TebButtonsLine> createState() => _TebButtonsLineState();
}

class _TebButtonsLineState extends State<TebButtonsLine> {
  List<Widget> getList() {
    List<Widget> btns = [];
    for (Widget btn in widget.buttons) {
      btns.add(btn);
      if (btn != widget.buttons.last) {
        btns.add(SizedBox(width: widget.widthSpaceBetweenButtons));
      }
    }
    return btns;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: (getList()),
      ),
    );
  }
}
