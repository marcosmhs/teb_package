import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:teb_package/teb_package.dart';
import 'package:teb_package/visual_elements/material_color_picker/material_color_consts.dart';
import 'package:teb_package/visual_elements/material_color_picker/teb_material_color_picker_dialog.dart';

class TebMaterialColorPicker {
  static Future<Color> showColorPicker({
    required BuildContext context,
    required Color pickedColor,
  }) async {
    List<Color> currentColor = [Colors.red, Colors.redAccent];
    Color currentShading = Colors.transparent;
    Color originalColor = pickedColor;
    Color customColor = Colors.transparent;

    await showDialog<Color>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final TextEditingController colorHexController = TextEditingController(
              text: TebUtil.colorToHex(
                customColor != Colors.transparent ? customColor : currentShading,
              ),
            );
            var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

            Widget colorList = Container(
              width: isPortrait ? 70 : null,
              height: isPortrait ? null : 70,
              decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.inverseSurface)),
              padding: const EdgeInsets.all(5),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(dragDevices: PointerDeviceKind.values.toSet()),
                child: ListView(
                  scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
                  children: [
                    ...TebMaterialColorConsts.colors.map((List<Color> colors) {
                      var colorType = colors[0];
                      return GestureDetector(
                        onTap: () => setState(() => currentColor = colors),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          child: Align(
                            child: Container(
                              width: 40,
                              height: 55,
                              decoration: BoxDecoration(color: colorType),
                            ),
                          ),
                        ),
                      );
                    }),
                    isPortrait
                        ? const Padding(padding: EdgeInsets.only(top: 5))
                        : const Padding(padding: EdgeInsets.only(left: 5)),
                  ],
                ),
              ),
            );

            var colorsShading = TebMaterialColorConsts.colorShadings(currentColor);

            Widget shadingList = SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Center(
                  child: GridView.builder(
                    itemCount: colorsShading.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: isPortrait ? 2 : 5),
                    itemBuilder: (_, index) {
                      var selectedShading = colorsShading[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: InkWell(
                            onTap: () => setState(() {
                              currentShading = selectedShading;
                              customColor = Colors.transparent;
                            }),
                            child: Container(
                              decoration: BoxDecoration(color: selectedShading),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TebText(
                                    TebUtil.colorToHex(selectedShading),
                                    textSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );

            for (List<Color> colors in TebMaterialColorConsts.colors) {
              TebMaterialColorConsts.colorShadings(colors).forEach((colorShade) {
                if (pickedColor.toARGB32() == colorShade.toARGB32()) {
                  return setState(() {
                    currentColor = colors;
                    currentShading = colorShade;
                  });
                }
              });
            }

            if (currentShading == Colors.transparent) {
              currentShading = pickedColor;
            }

            Widget header = const TebText(
              'Selecione uma cor',
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              textWeight: FontWeight.bold,
              textSize: 20,
            );

            Widget bottonOptions = SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // original color
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const TebText(
                          'Atual',
                          textSize: 10,
                          padding: EdgeInsets.only(bottom: 3),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(color: originalColor),
                        ),
                      ],
                    ),
                  ),

                  // selected color
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const TebText(
                          'Nova',
                          textSize: 10,
                          padding: EdgeInsets.only(bottom: 3),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(color: currentShading),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Material(
                      color: Theme.of(context).colorScheme.surface,
                      child: TebTextEdit(
                        labelText: 'Customizado',
                        controller: colorHexController,
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            var color = TebUtil.hexStringToColor(value);
                            if (color != Colors.transparent) {
                              setState(() => customColor = color);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  // selected color
                  if (customColor != Colors.transparent)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const TebText(
                            'Cust',
                            textSize: 10,
                            padding: EdgeInsets.only(bottom: 3),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(color: customColor),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  TebButton(
                    label: 'Cancelar',
                    buttonType: TebButtonType.outlinedButton,
                    onPressed: () => Navigator.pop(context, currentShading),
                    padding: const EdgeInsets.only(right: 10),
                  ),
                  TebButton(
                    label: 'Selecionar',
                    onPressed: () => Navigator.pop(context, currentShading),
                  ),
                ],
              ),
            );

            return TebMaterialColorPickerDialog(
              child: isPortrait
                  ? SizedBox(
                      width: 350,
                      height: 550,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header,
                          Expanded(
                            child: Row(
                              children: [colorList, Expanded(child: shadingList)],
                            ),
                          ),
                          bottonOptions,
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 500,
                      height: 450,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [header, colorList, Expanded(child: shadingList), bottonOptions],
                      ),
                    ),
            );
          },
        );
      },
    );
    return customColor != Colors.transparent ? customColor : currentShading;
  }
}
