import 'package:flutter/material.dart';

class TebMaterialColorPickerDialog extends StatelessWidget {
  const TebMaterialColorPickerDialog({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
        constraints: const BoxConstraints(minWidth: 70.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
