import 'package:flutter/material.dart';
import 'package:teb_package/control_widgets/fa_icons_picker/teb_icons_list.dart';
import 'package:teb_package/teb_package.dart';

class TebIconPicker {
  static Future<IconData?> showIconPickerDialog({
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

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 768),
                height: size.height * 0.8,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const TebText(
                      'Selecione um ícone',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TebTextEdit(
                      labelText: 'Busca',
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      onChanged: (value) {
                        if (value != null) {
                          setState(
                            () => iconsList = faIconDataList
                                .where((e) => e.title.contains(value))
                                .toList(),
                          );
                        } else {
                          setState(() => iconsList = faIconDataList);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemCount: iconsList.length,
                          itemBuilder: (context, index) {
                            final icon = iconsList[index];
                            return GestureDetector(
                              onTap: () {
                                selectedIcon = icon.iconData;
                                Navigator.pop(context, icon.iconData);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(icon.iconData, color: iconColor, size: 32),
                                  if (showIconName) const SizedBox(height: 4),
                                  if (showIconName)
                                    TebText(
                                      icon.title,
                                      style: const TextStyle(fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TebButton(
                        label: 'Cancelar',
                        onPressed: () => Navigator.pop(context),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    return selectedIcon;
  }
}
