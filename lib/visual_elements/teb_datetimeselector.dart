import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

typedef OnSelectedValue<DateTime> = void Function(DateTime? date);

class TebDateTimeSelector extends StatefulWidget {
  final BuildContext ctx;
  final DateTime? initialValue;
  final DateTime? startDate;
  final void Function()? onOpenDateSelector;
  final String? displayName;
  final String? buttonText;
  final String? errorMessage;
  final OnSelectedValue<DateTime?> onSelected;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final bool setSelectedDateOnStart;
  const TebDateTimeSelector({
    super.key,
    required this.ctx,
    required this.onSelected,
    this.errorMessage = '',
    this.padding,
    this.initialValue,
    this.startDate,
    this.displayName,
    this.buttonText,
    this.onOpenDateSelector,
    this.enabled = true,
    this.setSelectedDateOnStart = true,
  });

  @override
  State<TebDateTimeSelector> createState() => _TebDateTimeSelectorState();
}

class _TebDateTimeSelectorState extends State<TebDateTimeSelector> {
  DateTime? selectedDate;

  void _selectDate() async {
    selectedDate = await showDatePicker(
      cancelText: 'Cancelar',
      confirmText: 'OK',
      context: widget.ctx,
      initialDate: widget.initialValue ?? DateTime.now(),
      firstDate: widget.startDate ?? DateTime(2015, 8),
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
    if (widget.initialValue != null && selectedDate == null && widget.setSelectedDateOnStart) {
      setState(() {
        selectedDate = widget.initialValue;
        widget.onSelected(selectedDate);
      });
    }
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration:
            widget.errorMessage != '' ? BoxDecoration(border: Border.all(color: Theme.of(widget.ctx).colorScheme.error)) : null,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(widget.ctx).size.width),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    selectedDate == null
                        ? widget.displayName ?? 'Data:'
                        : '${widget.displayName ?? 'Data: '}: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}',
                  ),
                  const Expanded(child: SizedBox()),
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
                      style: Theme.of(widget.ctx).textTheme.bodySmall!.merge(
                            TextStyle(color: Theme.of(widget.ctx).colorScheme.error),
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
