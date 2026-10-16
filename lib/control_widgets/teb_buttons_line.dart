import 'package:flutter/material.dart';
import 'package:teb_package/control_widgets/teb_text.dart';

enum TebButtonType { elevatedButton, outlinedButton }

/// A custom button widget that provides additional styling and functionality.
///
/// The `TebButton` class is designed to create a reusable button component
/// with customizable properties such as text, color, size, and actions.
/// It simplifies the process of creating consistent buttons across the application.
///
/// Features:
/// - Customizable text displayed on the button.
/// - Configurable colors for background, text, and borders.
/// - Optional icon support for enhanced visual representation.
/// - Handles user interactions with onPressed and onLongPress callbacks.
///
/// Example usage:
/// ```dart
/// TebButton(
///   text: 'Click Me',
///   onPressed: () {
///     print('Button clicked!');
///   },
///   backgroundColor: Colors.blue,
///   textColor: Colors.white,
/// )
/// ```
///
/// This widget is ideal for creating buttons that adhere to a consistent design
/// system while allowing flexibility for specific use cases.

class TebButton extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;
  final bool enabled;
  final TebButtonType buttonType;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final Widget? icon;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? size;

  const TebButton({
    super.key,
    this.label = '',
    this.onPressed,
    this.enabled = true,
    this.buttonType = TebButtonType.elevatedButton,
    this.textStyle,
    this.buttonStyle,
    this.icon,
    this.child,
    this.padding,
    this.size,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonChild =
        child ?? TebText(label ?? '', fontColor: foregroundColor, style: textStyle);

    final ButtonStyle finalStyle;
    if (buttonStyle != null) {
      finalStyle = buttonStyle!;
    } else {
      finalStyle = ButtonStyle(
        fixedSize: size != null ? WidgetStateProperty.all(size) : null,
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.resolveWith<Color?>((states) => backgroundColor)
            : null,

        foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return foregroundColor ?? Theme.of(context).disabledColor;
          }
          return foregroundColor;
        }),
      );
    }

    if (buttonType == TebButtonType.outlinedButton) {
      return icon != null
          ? OutlinedButton.icon(
              onPressed: enabled ? onPressed : null,
              style: finalStyle,
              icon: icon!,
              label: buttonChild,
            )
          : OutlinedButton(
              onPressed: enabled ? onPressed : null,
              style: finalStyle,
              child: buttonChild,
            );
    }

    return Padding(
      padding: padding == null ? EdgeInsets.zero : padding!,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: enabled ? onPressed : null,
              style: finalStyle,
              icon: icon!,
              label: buttonChild,
            )
          : ElevatedButton(
              onPressed: enabled ? onPressed : null,
              style: finalStyle,
              child: buttonChild,
            ),
    );
  }
}

/// A class that represents a line of tab buttons.
///
/// The `TebButtonsLine` class is typically used to create a horizontal row
/// of tab buttons, allowing users to navigate between different sections
/// or views in an application. It provides functionality to manage the
/// appearance and behavior of the buttons in the line.
///
/// Features:
/// - Customizable button styles and layout.
/// - Handles user interaction with the tab buttons.
/// - Can be integrated with navigation or state management systems.
///
/// Example usage:
/// ```dart
/// TebButtonsLine(
///   tabs: ['Home', 'Profile', 'Settings'],
///   onTabSelected: (index) {
///     print('Selected tab: $index');
///   },
/// );
/// ```
///
/// This class is designed to be flexible and reusable, making it suitable
/// for a variety of tab-based navigation scenarios.

class TebButtonsLine extends StatefulWidget {
  final List<Widget> buttons;
  final MainAxisAlignment mainAxisAlignment;
  final double widthSpaceBetweenButtons;
  final EdgeInsetsGeometry? padding;

  const TebButtonsLine({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.widthSpaceBetweenButtons = 20,
    this.padding,
    required this.buttons,
  });

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
      child: Row(mainAxisAlignment: widget.mainAxisAlignment, children: (getList())),
    );
  }
}
