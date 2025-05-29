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
class TebCustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final bool showAppDrawer;
  final bool showAppBar;
  final List<Widget>? appBarActions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final PreferredSizeWidget? appBar;
  final bool responsive;
  final int minWebViewWidth;
  final double? fixedWidth;
  final double? widthPercentage;
  final bool useCenter;

  const TebCustomScaffold({
    super.key,
    this.title,
    this.drawer,
    this.endDrawer,
    this.showAppBar = true,
    required this.body,
    this.floatingActionButton,
    this.showAppDrawer = true,
    this.appBarActions,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.appBar,
    this.responsive = false,
    this.minWebViewWidth = 600,
    this.fixedWidth,
    this.widthPercentage,
    this.useCenter = true,
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

    var bodyWidget = useCenter ? Center(child: SizedBox(width: width, child: body)) : SizedBox(width: width, child: body);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar ?? (showAppBar ? AppBar(title: title, actions: appBarActions) : null),
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: endDrawer,
      drawer: showAppDrawer ? drawer : null,
      body: bodyWidget,
      floatingActionButton: floatingActionButton,
    );
  }
}
