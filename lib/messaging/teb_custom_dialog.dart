import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TebCustomDialog {
  final BuildContext context;

  TebCustomDialog({required this.context});

  Future<bool?> errorMessage({required String message}) {
    return customdialog(
      message: message,
      yesButtonText: "OK",
      yesButtonValue: false,
      noButtonText: '',
      icon: Icon(
        const FaIcon(FontAwesomeIcons.circleExclamation).icon,
        size: 50,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<bool?> confirmationDialog({
    required String message,
    Color? yesButtonHighlightColor,
    Color? backgroundColor,
    String yesButtonText = 'Sim',
    String noButtonText = 'Não',
  }) async {
    return await customdialog(
      message: message,
      backgroundColor: backgroundColor,
      yesButtonText: yesButtonText,
      noButtonText: noButtonText,
      yesButtonColor: yesButtonHighlightColor,
      icon: const Icon(Icons.question_mark, size: 50),
    );
  }

  Future<bool?> informationDialog({required String message}) {
    // A cor do botão deve ser passada em branco para assumir a cor do tema
    // noButtonText deve ser deixado em branco para que não seja exibido
    return customdialog(
      message: message,
      yesButtonText: "OK",
      noButtonText: '',
      icon: const Icon(Icons.info_outline, size: 50),
    );
  }

  Future<bool?> customdialog({
    required String message,
    required String yesButtonText,
    required String noButtonText,
    bool? yesButtonValue = true,
    Color? backgroundColor,
    Color? yesButtonColor,
    Icon? icon,
  }) {
    Color yesBtnColor = yesButtonColor ?? Theme.of(context).colorScheme.primary;

    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: backgroundColor,
        content: Row(
          children: [
            icon ?? Container(),
            icon != null ? const SizedBox(width: 10) : Container(),
            Flexible(child: Text(message)),
          ],
        ),
        actions: [
          if (noButtonText != '')
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(noButtonText),
            ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(yesButtonValue),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(yesBtnColor)),
            child: Text(yesButtonText),
          )
        ],
      ),
    );
  }
}
