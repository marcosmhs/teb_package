import 'package:flutter/material.dart';

class TebCustomModalDialog extends StatelessWidget {
  const TebCustomModalDialog({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        constraints: const BoxConstraints(minWidth: 70.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
