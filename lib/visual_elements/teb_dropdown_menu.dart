import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TebDropDownMenu extends StatefulWidget {
  final List<Object> itens;
  final String text;
  final Object? selectedValue;
  final void Function(Object?) onSelected;
  const TebDropDownMenu({
    super.key,
    required this.itens,
    required this.text,
    required this.onSelected,
    required this.selectedValue,
  });

  @override
  State<TebDropDownMenu> createState() => _TebDropDownMenuState();
}

class _TebDropDownMenuState extends State<TebDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Object>(
      initialSelection: widget.selectedValue,
      label: Text(widget.text),
      trailingIcon: const FaIcon(FontAwesomeIcons.arrowDown),
      onSelected: (Object? value) => setState(() => widget.onSelected(value)),
      dropdownMenuEntries: widget.itens.map<DropdownMenuEntry<Object>>((Object value) {
        return DropdownMenuEntry<Object>(
          value: value,
          label: value.toString(),
        );
      }).toList(),
    );
  }
}
