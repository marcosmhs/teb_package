// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teb_package/teb_package.dart';

/// A custom text editing widget that extends the functionality of a standard
/// text editing field. The `TebTextEdit` class provides additional features
/// and customization options for handling text input.
///
/// This widget is designed to be flexible and can be used in various scenarios
/// where advanced text editing capabilities are required.
///
/// Features:
/// - Customizable appearance and behavior.
/// - Support for advanced text input handling.
/// - Integration with other widgets and state management solutions.
///
/// Example usage:
/// ```dart
/// TebTextEdit(
///   controller: myController,
///   focusNode: myFocusNode,
///   onChanged: (text) {
///     print('Text changed: $text');
///   },
/// )
/// ```
///
/// Note:
/// Ensure that you provide the necessary `TextEditingController` and `FocusNode`
/// to manage the state and focus of the text field effectively.
///
/// This class is suitable for use in forms, dialogs, or any other part of the
/// application where text input is required.
class TebTextEdit extends StatefulWidget {
  final double? width;
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextStyle? contentTextStyle;
  final bool enabled;
  final bool isPassword;
  final BuildContext? context;
  final String? initialValue;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final Color? fillColor;
  final String? Function(String? value)? validator;
  final String stringValueValidatorMessage;
  final void Function(String? value)? onSave;
  final void Function(String? value)? onChanged;
  final void Function()? onEditingCompleted;
  final void Function(String? value)? onFieldSubmitted;
  final void Function()? onTap;
  final int maxLines;
  final int? maxLength;
  final String mask;
  final bool upperCase;
  final EdgeInsetsGeometry? padding;
  final FontWidth? fontWidth;
  // border and padding behavior
  final bool showBorder;
  final InputBorder? border;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;

  const TebTextEdit({
    super.key,
    this.context,
    this.width,
    this.controller,
    this.contentTextStyle,
    this.labelText,
    this.hintText = '',
    this.enabled = true,
    this.isPassword = false,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.keyboardType,
    this.nextFocusNode,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.validator,
    this.stringValueValidatorMessage = '',
    this.onSave,
    this.onChanged,
    this.onEditingCompleted,
    this.onFieldSubmitted,
    this.showBorder = true,
    this.border,
    this.onTap,
    this.mask = '',
    this.upperCase = false,
    this.padding,
    this.fontWidth,
    this.isDense = true,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
  });

  @override
  State<TebTextEdit> createState() => _TebTextEditState();
}

class _TebTextEditState extends State<TebTextEdit> {
  late bool _hidePassword = true;

  String? _stringValueValidator(String? value, String errorMessage) {
    if (!widget.enabled) return null;
    var finalValue = value ?? '';
    if (finalValue.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter();
    if (widget.mask.isNotEmpty) {
      maskFormatter = MaskTextInputFormatter(mask: widget.mask);
    }

    Widget textFormField = GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          const SizedBox(height: 8),
          TextFormField(
            textCapitalization: widget.upperCase
                ? TextCapitalization.characters
                : TextCapitalization.none,
            inputFormatters: widget.mask.isEmpty ? null : [maskFormatter],
            style: widget.contentTextStyle,
            enabled: widget.enabled,
            obscureText: !widget.isPassword ? false : _hidePassword,
            // use text editor only if keyboardType wasn´t set.
            keyboardType: widget.isPassword && widget.keyboardType == null
                ? TextInputType.text
                : widget.keyboardType ?? TextInputType.text,
            onSaved: (value) {
              if (widget.onSave != null) {
                var finalValue = value;
                if (widget.mask.isNotEmpty) {
                  finalValue = maskFormatter.unmaskText(finalValue ?? '');
                }
                widget.onSave!(finalValue);
              }
            },
            onChanged: (value) {
              if (widget.onChanged != null) {
                var finalValue = value;
                if (widget.mask.isNotEmpty) {
                  finalValue = maskFormatter.getUnmaskedText();
                }
                widget.onChanged!(finalValue);
              }
            },
            onEditingComplete: widget.onEditingCompleted,
            initialValue: widget.initialValue,
            textInputAction: widget.textInputAction,
            onFieldSubmitted:
                widget.onFieldSubmitted ??
                (widget.nextFocusNode == null
                    ? null
                    : (_) => FocusScope.of(context).requestFocus(widget.nextFocusNode)),
            focusNode: widget.focusNode,
            validator: widget.stringValueValidatorMessage.isEmpty
                ? widget.validator
                : (value) => _stringValueValidator(value, widget.stringValueValidatorMessage),
            controller: widget.controller,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.contentTextStyle,
              labelText: widget.labelText,
              labelStyle: widget.contentTextStyle,
              filled: true,
              fillColor: widget.fillColor,
              isDense: widget.isDense,
              contentPadding: widget.contentPadding,

              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon, color: widget.prefixIconColor),
              // set if password should be visible
              suffixIcon: !widget.isPassword
                  ? widget.suffixIcon
                  : GestureDetector(
                      onTap: () {
                        _hidePassword = !_hidePassword;
                        setState(() {});
                      },
                      child: Icon(
                        _hidePassword
                            ? const Icon(FontAwesomeIcons.eyeSlash).icon
                            : const Icon(FontAwesomeIcons.eye).icon,
                      ),
                    ),

              focusedBorder: widget.focusedBorder,
              enabledBorder: widget.enabledBorder,
              border: !widget.showBorder
                  ? InputBorder.none
                  : widget.border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
            ),
          ),
        ],
      ),
    );

    if (widget.padding != null) {
      textFormField = Padding(padding: widget.padding!, child: textFormField);
    }

    //if (widget.controller != null && widget.mask.isNotEmpty) {
    //widget.controller!.value = maskFormatter.updateMask(mask: widget.mask);
    //}

    if (widget.fontWidth == null) {
      if (widget.width != null) {
        return SizedBox(width: widget.width, child: textFormField);
      }
    } else {
      return SizedBox(width: TebUtil.fontWidthCalculation(widget.fontWidth!), child: textFormField);
    }

    if (widget.width != null) {
      return SizedBox(width: widget.width, child: textFormField);
    }
    return textFormField;
  }
}
