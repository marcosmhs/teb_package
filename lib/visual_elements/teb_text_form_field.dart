// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TebTextEdit extends StatefulWidget {
  final double? width;
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool enabled;
  final bool isPassword;
  final BuildContext? context;
  final String? inicialValue;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final void Function(String? value)? onSave;
  final void Function(String? value)? onChanged;
  final void Function()? onEditingCompleted;
  final InputBorder? border;
  final void Function()? onTap;
  final int maxLines;
  final int? maxLength;
  final String mask;
  final bool upperCase;
  final EdgeInsetsGeometry? padding;

  const TebTextEdit({
    Key? key,
    this.width,
    this.context,
    this.controller,
    required this.labelText,
    this.hintText = '',
    this.enabled = true,
    this.isPassword = false,
    this.inicialValue,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.keyboardType,
    this.nextFocusNode,
    this.focusNode,
    this.prefixIcon,
    this.validator,
    this.onSave,
    this.onChanged,
    this.onEditingCompleted,
    this.border,
    this.onTap,
    this.mask = '',
    this.upperCase = false,
    this.padding,
  }) : super(key: key);

  @override
  State<TebTextEdit> createState() => _TebTextEditState();
}

class _TebTextEditState extends State<TebTextEdit> {
  late bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter();
    if (widget.mask.isNotEmpty) {
      maskFormatter = MaskTextInputFormatter(mask: widget.mask);
    }

    var widgetResult = Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextFormField(
              textCapitalization: widget.upperCase ? TextCapitalization.characters : TextCapitalization.none,
              inputFormatters: widget.mask.isEmpty ? null : [maskFormatter],
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
              initialValue: widget.inicialValue,
              textInputAction: widget.textInputAction,
              onFieldSubmitted:
                  widget.nextFocusNode == null ? null : (_) => FocusScope.of(context).requestFocus(widget.nextFocusNode),
              focusNode: widget.focusNode,
              validator: widget.validator,
              controller: widget.controller,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.fillColor,
                prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
                // set if password should be visible
                suffixIcon: !widget.isPassword
                    ? null
                    : GestureDetector(
                        onTap: () {
                          _hidePassword = !_hidePassword;
                          setState(() {});
                        },
                        child: Icon(_hidePassword
                            ? const FaIcon(FontAwesomeIcons.eyeSlash).icon
                            : const FaIcon(FontAwesomeIcons.eye).icon),
                      ),
                hintText: widget.hintText,
                labelText: widget.labelText,
                border: widget.border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ],
        ),
      ),
    );

    //if (widget.controller != null && widget.mask.isNotEmpty) {
    //widget.controller!.value = maskFormatter.updateMask(mask: widget.mask);
    //}

    if (widget.width != null) {
      return SizedBox(
        width: widget.width,
        child: widgetResult,
      );
    } else {
      return widgetResult;
    }
  }
}
