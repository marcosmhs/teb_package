import 'package:flutter/material.dart';
import 'package:teb_package/control_widgets/teb_text.dart';

/// A custom [StatefulWidget] that represents a Silver AppBar for the application.
///
/// The [TebSilverBarApp] widget provides a flexible and customizable app bar
/// that can be used within a [CustomScrollView] to achieve a sliver effect.
/// This widget is typically used to create a collapsible app bar with advanced
/// scrolling behaviors and visual effects.
///
/// Example usage:
///
/// ```dart
/// TebCustomScaffold(
///   showAppBar: false,
///   body: _silverBarApp(
///     context: context,
///     title: TebText('Your Title', textColor: Theme.of(context).canvasColor),
///     fixedTitleBar: false,
///     titleBarHeight: 200,
///     titleBarColor: Colors.amber,
///     subtitle: TebText('Teb Silver Bar App', textColor: Theme.of(context).canvasColor),
///     subtitleBarColor: Colors.blue,
///     subtitleBarHeight: 100,
///     leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
///     actions: [
///       IconButton(icon: const Icon(Icons.search), onPressed: () {}),
///       IconButton(icon: const Icon(Icons.search), onPressed: () {}),
///     ],
///     sliverChildBuilderDelegate: SliverChildBuilderDelegate(
///       (context, index) => ListTile(title: Text('Item $index')),
///       childCount: 30,
///     ),
///   ),
/// )
/// ```
///
/// Customize this widget by providing the necessary parameters to fit your
/// application's requirements.
class TebSilverBarApp extends StatefulWidget {
  final BuildContext context;
  final Widget? drawer;
  final Widget title;
  final bool fixedTitleBar /* = true*/;
  final Color? titleBarColor;
  final double titleBarHeight /* = 100*/;
  final Widget? subtitle;
  final Color? subtitleBarColor;
  final double subtitleBarHeight /* = 100*/;
  final Widget? leading;
  final List<Widget>? actions;
  final SliverChildBuilderDelegate sliverChildBuilderDelegate;

  const TebSilverBarApp({
    super.key,
    required this.context,
    this.drawer,
    required this.title,
    this.fixedTitleBar = true,
    this.titleBarColor,
    this.titleBarHeight = 70,
    this.subtitle,
    this.subtitleBarColor,
    this.subtitleBarHeight = 60,
    this.leading,
    this.actions,
    required this.sliverChildBuilderDelegate,
  });

  static SliverChildBuilderDelegate emptyList({required String emptyListMessage}) {
    return SliverChildBuilderDelegate(
      childCount: 1,
      (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 5),
        child: Column(
          children: [
            TebText(
              emptyListMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<TebSilverBarApp> createState() => _TebSilverBarAppState();
}

class _TebSilverBarAppState extends State<TebSilverBarApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: widget.fixedTitleBar,
            expandedHeight: widget.titleBarHeight,
            backgroundColor: widget.titleBarColor ?? Theme.of(context).primaryColor,
            title: widget.title,
            leading: widget.leading,
            actions: widget.actions,
          ),
          if (widget.subtitle != null)
            SliverToBoxAdapter(
              child: Container(
                  height: widget.subtitleBarHeight,
                  color: widget.subtitleBarColor ?? Theme.of(context).primaryColor,
                  child: widget.subtitle),
            ),
          SliverList(delegate: widget.sliverChildBuilderDelegate),
        ],
      ),
    );
  }
}
