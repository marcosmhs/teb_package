import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

typedef OnSelectedValue<DateTime> = void Function(DateTime? date);

class TebDateTimeSelector extends StatefulWidget {
  final BuildContext context;
  final DateTime? initialDate;
  final void Function()? onOpenDateSelector;
  final String? displayName;
  final String? buttonText;
  final String? errorMessage;
  final OnSelectedValue<DateTime?> onSelected;
  final bool enabled;
  const TebDateTimeSelector(
      {Key? key,
      required this.context,
      required this.onSelected,
      this.errorMessage = '',
      this.initialDate,
      this.displayName,
      this.buttonText,
      this.onOpenDateSelector,
      this.enabled = true})
      : super(key: key);

  @override
  State<TebDateTimeSelector> createState() => _TebDateTimeSelectorState();
}

class _TebDateTimeSelectorState extends State<TebDateTimeSelector> {
  DateTime? selectedDate;

  void _selectDate() async {
    selectedDate = await showDatePicker(
      cancelText: 'Cancelar',
      confirmText: 'OK',
      context: widget.context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        widget.onOpenDateSelector;
        widget.onSelected(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialDate != null && selectedDate == null) {
      setState(() {
        selectedDate = widget.initialDate;
        widget.onSelected(selectedDate);
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration:
            widget.errorMessage != '' ? BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.error)) : null,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    selectedDate == null
                        ? 'Selecionar ${widget.displayName ?? 'a data'}'
                        : '${widget.displayName ?? 'Data: '}: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}',
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  if (widget.enabled)
                    ElevatedButton(
                      onPressed: _selectDate,
                      child: Text(widget.buttonText ?? 'Selecionar'),
                    ),
                ],
              ),
              if (widget.errorMessage != '')
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall!.merge(
                            TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
