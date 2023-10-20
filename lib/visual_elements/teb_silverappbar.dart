import 'package:flutter/material.dart';

class TebSilverBarApp extends StatefulWidget {
  final String title;
  final BuildContext context;
  final List<Object>? listItens;
  final String emptyListMessage;
  final SliverChildBuilderDelegate? sliverChildBuilderDelegate;
  final Widget? listHeaderArea;
  final double listHeaderitemExtent;
  final List<Widget>? actions;

  const TebSilverBarApp(
      {super.key,
      required this.context,
      this.title = '',
      this.listItens,
      this.emptyListMessage = '',
      this.sliverChildBuilderDelegate,
      this.listHeaderArea,
      this.listHeaderitemExtent = 75,
      this.actions});

  @override
  State<TebSilverBarApp> createState() => _TebSilverBarAppState();
}

class _TebSilverBarAppState extends State<TebSilverBarApp> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //SliverAppBar(
        //  floating: true,
        //  title: Text(widget.title),
        //  actions: widget.actions,
        //),
        if (widget.listHeaderArea != null)
          SliverFixedExtentList(
            itemExtent: widget.listHeaderitemExtent,
            delegate: SliverChildListDelegate([widget.listHeaderArea!]),
          ),
        widget.listItens == null
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 5),
                    child: Column(
                      children: [
                        Text(
                          widget.emptyListMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SliverList(delegate: widget.sliverChildBuilderDelegate!),
      ],
    );
  }
}
