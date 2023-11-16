import 'package:flutter/material.dart';

class TebMaterialColorConsts {
  static final List<List<Color>> colors = [
    [Colors.red, Colors.redAccent],
    [Colors.pink, Colors.pinkAccent],
    [Colors.purple, Colors.purpleAccent],
    [Colors.deepPurple, Colors.deepPurpleAccent],
    [Colors.indigo, Colors.indigoAccent],
    [Colors.blue, Colors.blueAccent],
    [Colors.lightBlue, Colors.lightBlueAccent],
    [Colors.cyan, Colors.cyanAccent],
    [Colors.teal, Colors.tealAccent],
    [Colors.green, Colors.greenAccent],
    [Colors.lightGreen, Colors.lightGreenAccent],
    [Colors.lime, Colors.limeAccent],
    [Colors.yellow, Colors.yellowAccent],
    [Colors.amber, Colors.amberAccent],
    [Colors.orange, Colors.orangeAccent],
    [Colors.deepOrange, Colors.deepOrangeAccent],
    [Colors.brown],
    [Colors.grey],
    [Colors.blueGrey],
    [Colors.black],
  ];

  static List<Color> colorShadings(List<Color> colors) {
    List<Color> result = [];

    for (Color colorType in colors) {
      if (colorType == Colors.grey) {
        result.addAll([50, 100, 200, 300, 350, 400, 500, 600, 700, 800, 850, 900]
            .map((int shade) => Colors.grey[shade]!)
            .toList());
      } else if (colorType == Colors.black || colorType == Colors.white) {
        result.addAll([
          Colors.black,
          Colors.white
        ]);
      } else if (colorType is MaterialAccentColor) {
        result.addAll([100, 200, 400, 700].map((int shade) => colorType[shade]!).toList());
      } else if (colorType is MaterialColor) {
        result.addAll(
            [50, 100, 200, 300, 400, 500, 600, 700, 800, 900].map((int shade) => colorType[shade]!).toList());
      } else {
        result.add(const Color(0x00000000));
      }
    }

    return result;
  }
}
