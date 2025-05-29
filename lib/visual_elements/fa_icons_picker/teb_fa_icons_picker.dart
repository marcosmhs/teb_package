import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teb_package/teb_package.dart';
import 'package:teb_package/visual_elements/fa_icons_picker/teb_fa_icons_list.dart';

class TebFaIconPicker {
  static Future<IconData?> showFaIconPickerDialog({
    required BuildContext context,
    required Color backgroundColor,
    required Color specialColor,
    Color? iconColor,
    bool fullScreen = false,
    bool showIconName = false,
  }) async {
    IconData? selectedIcon;

    var iconsList = faIconDataList;

    var size = MediaQuery.of(context).size;

    await showDialog<IconData?>(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return TebFaIconDialog(
            backgroundColor: backgroundColor,
            child: SizedBox(
              height: fullScreen
                  ? size.height * 0.98
                  : kIsWeb
                      ? size.height * 0.70
                      : size.height * 0.72,
              width: fullScreen
                  ? size.width * 0.98
                  : kIsWeb
                      ? size.width * 0.45
                      : size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TebTextEdit(
                    labelText: 'Busca',
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => iconsList = faIconDataList.where((e) => e.title.contains(value)).toList());
                      } else {
                        setState(() => iconsList = faIconDataList);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: SizedBox(
                        height: fullScreen
                            ? size.height * 0.78
                            : kIsWeb
                                ? MediaQuery.of(context).size.height * 0.55
                                : MediaQuery.of(context).size.height * 0.58,
                        width: fullScreen
                            ? size.width * 0.97
                            : kIsWeb
                                ? MediaQuery.of(context).size.width * 0.45
                                : MediaQuery.of(context).size.width * 0.85,
                        child: GridView.builder(
                          itemCount: iconsList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                          itemBuilder: (_, index) {
                            var faIconData = iconsList[index];
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  selectedIcon = faIconData.iconData;
                                  setState(() => Navigator.pop(context, faIconData.iconData));
                                },
                                child: Container(
                                  decoration: BoxDecoration(border: Border.all(color: specialColor)),
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        FaIcon(faIconData.iconData, color: iconColor),
                                        if (showIconName) const Spacer(),
                                        if (showIconName)
                                          TebText(
                                            faIconData.title.length > 12
                                                ? '${faIconData.title.substring(0, 12)}...'
                                                : faIconData.title,
                                            textAlign: TextAlign.center,
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TebButton(
                        label: 'Cancelar',
                        onPressed: () => Navigator.pop(context),
                        padding: const EdgeInsets.all(10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
    return selectedIcon;
  }
}
