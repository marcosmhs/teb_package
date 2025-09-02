import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teb_package/control_widgets/teb_text.dart';

class TebDropDownMenu extends StatefulWidget {
  final List<Object> itens;
  final String label;
  final Widget? labelWidget;
  final Object? selectedValue;

  final bool enable;
  final Widget? trailingIcon;
  final String errorText;
  final double? width;

  final void Function(Object?) onSelected;
  const TebDropDownMenu({
    super.key,
    required this.itens,
    this.label = '',
    this.labelWidget,
    required this.onSelected,
    required this.selectedValue,
    this.enable = true,
    this.trailingIcon,
    this.errorText = '',
    this.width,
  });

  @override
  State<TebDropDownMenu> createState() => _TebDropDownMenuState();
}

class _TebDropDownMenuState extends State<TebDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Object>(
      initialSelection: widget.selectedValue,
      enabled: widget.enable,
      label: widget.labelWidget ?? TebText(widget.label),
      trailingIcon: widget.trailingIcon ?? const FaIcon(FontAwesomeIcons.arrowDown),
      width: widget.width,
      
      errorText: widget.errorText.isEmpty ? null : widget.errorText,
      onSelected: (Object? value) => widget.onSelected(value),
      dropdownMenuEntries: widget.itens.map<DropdownMenuEntry<Object>>((Object value) {
        return DropdownMenuEntry<Object>(value: value, label: value.toString());
      }).toList(),
    );
  }
}
