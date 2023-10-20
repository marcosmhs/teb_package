import 'package:flutter/material.dart';

class TebMonthContainer extends StatelessWidget {
  const TebMonthContainer({
    Key? key,
    required this.month,
    required this.selected,
  }) : super(key: key);

  final bool selected;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          month,
          style: TextStyle(
            fontSize: 20,
            color: selected ? Theme.of(context).cardColor : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
