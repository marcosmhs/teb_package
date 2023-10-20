import 'package:flutter/material.dart';

enum DisplayMode { dialog, modal }

class TebCheckBox extends StatefulWidget {
  final BuildContext context;
  final String title;
  final String subTitle;
  final bool? value;
  final bool enabled;
  final void Function(bool?)? onChanged;

  const TebCheckBox({
    Key? key,
    required this.context,
    required this.value,
    required this.title,
    this.subTitle = '',
    required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<TebCheckBox> createState() => _TebCheckBoxState();
}

class _TebCheckBoxState extends State<TebCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: widget.value,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      subtitle: widget.subTitle.isEmpty ? null : Text(widget.subTitle),
    );
  }
}
