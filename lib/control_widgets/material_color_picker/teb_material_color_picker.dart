import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:teb_package/control_widgets/teb_buttons_line.dart';
import 'package:teb_package/control_widgets/teb_text.dart';

class TebMaterialColorPicker {
  static Future<Color?> showColorPicker({
    required BuildContext context,
    required Color selectedColor,
  }) async {
    return await showDialog<Color?>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Card(
              margin: EdgeInsets.all(6),
              elevation: 2,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      ColorPicker(
                        color: selectedColor,
                        pickersEnabled: const <ColorPickerType, bool>{
                          ColorPickerType.primary: true,
                          ColorPickerType.accent: false,
                          ColorPickerType.bw: true,
                          ColorPickerType.custom: true,
                          ColorPickerType.wheel: true,
                        },
                        pickerTypeLabels: const <ColorPickerType, String>{
                          ColorPickerType.primary: 'Cores primárias',
                          ColorPickerType.bw: 'Preto e Branco',
                          ColorPickerType.wheel: 'Customizado',
                        },
                        opacitySubheading: TebText('Transparência'),

                        showColorCode: true,
                        onColorChanged: (Color color) => setState(() => selectedColor = color),
                        width: 44,
                        height: 44,
                        borderRadius: 32,
                        wheelDiameter: 300,
                        heading: Text(
                          'Selecione uma cor',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        subheading: Text(
                          'Tonalidades',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(backgroundColor: selectedColor, radius: 25),
                          const SizedBox(width: 10),
                          TebButton(
                            label: 'Confirmar',
                            textStyle: TextStyle(fontSize: 20),
                            foregroundColor: Theme.of(context).canvasColor,
                            onPressed: () => Navigator.of(context).pop(selectedColor),
                          ),
                          const SizedBox(width: 10),
                          TebButton(
                            label: 'Cancelar',
                            textStyle: TextStyle(fontSize: 20),
                            foregroundColor: Theme.of(context).canvasColor,
                            onPressed: () => Navigator.of(context).pop(null),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      return value;
    });
  }
}
