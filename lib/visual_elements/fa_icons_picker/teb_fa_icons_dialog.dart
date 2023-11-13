import 'package:flutter/material.dart';

class TebFaIconDialog extends StatelessWidget {
  const TebFaIconDialog({Key? key, required this.backgroundColor, required this.child}) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 70.0),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
            child: child,
          ),
        ),
      ),
    );
  }
}
