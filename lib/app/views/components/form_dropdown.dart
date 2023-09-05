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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1, // Largura da borda
          color: Theme.of(context).primaryColor, // Cor da borda primária
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: DropdownButton(
          value: value,
          items: items,
          onChanged: onChanged,
          borderRadius: BorderRadius.circular(15.0),
          icon: const Icon(Icons.arrow_drop_down_rounded),
          iconSize: 30,
          iconEnabledColor: Theme.of(context).primaryColor,
          menuMaxHeight: 300,
          isExpanded: true,
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
