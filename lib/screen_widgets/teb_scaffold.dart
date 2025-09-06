import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Um widget personalizado que fornece uma estrutura de Scaffold para a aplicação.
///
/// Este widget pode ser utilizado para padronizar a aparência e o comportamento
/// das telas da aplicação, permitindo a reutilização de configurações comuns.
///
/// Exemplo de uso:
/// ```dart
/// TebCustomScaffold(
///   appBar: AppBar(
///     title: Text('Minha Tela'),
///   ),
///   body: Center(
///     child: Text('Conteúdo da tela'),
///   ),
/// )
/// ```
class TebScaffold extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final bool showAppDrawer;
  final bool showAppBar;
  final List<Widget>? appBarActions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final PreferredSizeWidget? appBar;
  final bool responsive;
  final int minWebViewWidth;
  final double? fixedWidth;
  final double widthPercentage;
  final bool useCenter;
  final double? maxWidth;

  const TebScaffold({
    super.key,
    this.title,
    this.drawer,
    this.endDrawer,
    this.showAppBar = true,
    required this.body,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.showAppDrawer = true,
    this.appBarActions,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.appBar,
    this.responsive = false,
    this.minWebViewWidth = 600,
    this.fixedWidth,
    this.widthPercentage = 0.98,
    this.useCenter = true,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    if (widthPercentage != null) {
      width = MediaQuery.of(context).size.width * widthPercentage!;
    } else {
      if (fixedWidth != null) {
        width = fixedWidth!;
      } else {
        if (responsive && kIsWeb) {
          width = MediaQuery.of(context).size.width > minWebViewWidth
              ? MediaQuery.of(context).size.width * 0.7
              : MediaQuery.of(context).size.width * 0.9;
        }
      }
    }

    Widget bodyWidget = SizedBox(width: width, child: body);

    if (maxWidth != null) {
      bodyWidget = Container(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: bodyWidget,
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar ?? (showAppBar ? AppBar(title: title, actions: appBarActions) : null),
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: endDrawer,
      drawer: showAppDrawer ? drawer : null,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      body: Align(alignment: Alignment.topCenter, child: bodyWidget),
    );
  }
}
