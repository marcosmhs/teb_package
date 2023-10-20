import 'package:flutter/material.dart';

enum TebSwitchDisplayMode { dialog, modal }

class TebSwitch extends StatefulWidget {
  final BuildContext context;
  final String title;
  final bool? value;
  final bool enabled;
  final void Function(bool?)? onChanged;

  const TebSwitch({
    Key? key,
    required this.context,
    required this.value,
    required this.title,
    required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<TebSwitch> createState() => _TebSwitchState();
}

class _TebSwitchState extends State<TebSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.title),
        const Spacer(),
        Switch(
          value: widget.value ?? false,
          onChanged: widget.enabled ? widget.onChanged : null,
        ),
      ],
    );
  }
}
