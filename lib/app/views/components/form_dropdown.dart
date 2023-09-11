import 'package:flutter/material.dart';

class FormDropdown extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem<String>> items;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final String? errorText;

  const FormDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FormField<String>(
          // validator: (value) {
          //   if (value == null) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: errorText != null
          //             ? Text('$errorText')
          //             : const Text('Selecione uma opção'),
          //         backgroundColor: Colors.yellow[700],
          //         behavior: SnackBarBehavior.floating,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15.0),
          //         ),
          //       ),
          //     );
          //   }
          //   return null;
          // },
          builder: (FormFieldState<String> state) {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(Icons.arrow_drop_down_rounded),
                iconEnabledColor: Theme.of(context).primaryColor,
                iconSize: 30,
                isExpanded: true,
                borderRadius: BorderRadius.circular(15.0),
                value: value,
                items: [...items],
                onChanged: (newValue) {
                  state.didChange(newValue);
                  onChanged!(newValue);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
