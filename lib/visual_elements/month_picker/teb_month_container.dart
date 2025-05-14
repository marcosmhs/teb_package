import 'package:flutter/material.dart';
import 'package:teb_package/visual_elements/teb_text.dart';

class TebMonthContainer extends StatelessWidget {
  const TebMonthContainer({
    super.key,
    required this.month,
    required this.selected,
  });

  final bool selected;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TebText(
          month,
          textSize: 20,
          textColor: selected ? Theme.of(context).cardColor : Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
