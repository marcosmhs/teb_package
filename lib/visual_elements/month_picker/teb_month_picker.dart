import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:teb_package/visual_elements/month_picker/teb_month_container.dart';
import 'package:teb_package/visual_elements/month_picker/teb_month_dialog.dart';

class MonthStructure {
  int index;
  String name;
  MonthStructure({
    required this.index,
    required this.name,
  });
}

class TebMonthPicker {
  /// list of Months
  static final List<MonthStructure> _monthStructureList = [
    MonthStructure(index: 1, name: 'Jan'),
    MonthStructure(index: 2, name: 'Fev'),
    MonthStructure(index: 3, name: 'Mar'),
    MonthStructure(index: 4, name: 'Abr'),
    MonthStructure(index: 5, name: 'Mai'),
    MonthStructure(index: 6, name: 'Jun'),
    MonthStructure(index: 7, name: 'Jul'),
    MonthStructure(index: 8, name: 'Ago'),
    MonthStructure(index: 9, name: 'Set'),
    MonthStructure(index: 10, name: 'Out'),
    MonthStructure(index: 11, name: 'Nov'),
    MonthStructure(index: 12, name: 'Dez'),
  ];

  static Future<DateTime> showMonthYearPickerDialog({
    required BuildContext context,
  }) async {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
//    var textTheme = theme.textTheme;

    /// to get current year
    int selectedYear = DateTime.now().year;

    var selectedMonth = DateTime.now().month;

    await showDialog<DateTime>(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return TebMonthDialog(
            child: SizedBox(
              height: kIsWeb ? MediaQuery.of(context).size.height * 0.50 : MediaQuery.of(context).size.height * 0.53,
              width: kIsWeb ? MediaQuery.of(context).size.width * 0.45 : MediaQuery.of(context).size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // titulo
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        Text('Selecione o mês ', style: Theme.of(context).textTheme.headlineSmall),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => setState(() => selectedYear = selectedYear - 1),
                              icon: Icon(Icons.arrow_circle_left_sharp, size: 30, color: primaryColor),
                            ),
                            Text(
                              selectedYear.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            IconButton(
                              onPressed: () => setState(() => selectedYear = selectedYear + 1),
                              icon: Icon(Icons.arrow_circle_right_sharp, size: 30, color: primaryColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // lista de meses
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: SizedBox(
                        height: 250,
                        width: 300,
                        child: GridView.builder(
                          itemCount: _monthStructureList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemBuilder: (_, index) {
                            var monthModel = _monthStructureList[index];
                            return InkWell(
                              onTap: () => setState(() {
                                selectedMonth = index + 1;
                                String selectedMonthString = selectedMonth < 10 ? "0$selectedMonth" : "$selectedMonth";
                                var selectedDate = DateTime.parse('$selectedYear-$selectedMonthString-01');
                                Navigator.pop(context, selectedDate);
                              }),
                              child: TebMonthContainer(
                                month: monthModel.name,
                                selected: index + 1 == selectedMonth,
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
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          String selectedMonthString = selectedMonth < 10 ? "0$selectedMonth" : "$selectedMonth";
                          var selectedDate = DateTime.parse('$selectedYear-$selectedMonthString-01');
                          Navigator.pop(context, selectedDate);
                        },
                        child: const Text('Selecionar data'),
                      ),
                      const SizedBox(width: 15),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
    String selectedMonthString = selectedMonth < 10 ? "0$selectedMonth" : "$selectedMonth";
    return DateTime.parse('$selectedYear-$selectedMonthString-01');
  }
}