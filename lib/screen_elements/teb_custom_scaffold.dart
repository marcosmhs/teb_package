import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (fixedWidth != null) {
      width = fixedWidth!;
    } else {
      if (responsive && kIsWeb) {
        width = MediaQuery.of(context).size.width > minWebViewWidth
            ? MediaQuery.of(context).size.width * 0.7
            : MediaQuery.of(context).size.width * 0.9;
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar ?? (showAppBar ? AppBar(title: title, actions: appBarActions) : null),
      bottomNavigationBar: bottomNavigationBar,
      endDrawer: endDrawer,
      drawer: showAppDrawer ? drawer : null,
      body: Center(child: SizedBox(width: width, child: body)),
      floatingActionButton: floatingActionButton,
    );
  }
}
