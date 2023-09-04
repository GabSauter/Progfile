import 'package:flutter/material.dart';

class FormDropdown extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem> items;
  final void Function(dynamic)? onChanged;

  const FormDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: items,
      onChanged: onChanged,
      alignment: Alignment.centerLeft,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      iconSize: 30,
      borderRadius: BorderRadius.circular(15.0),
      iconEnabledColor: const Color(0xFF482FF7),
      menuMaxHeight: 300,
    );
  }
}
