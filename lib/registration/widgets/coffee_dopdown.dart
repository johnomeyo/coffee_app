import 'package:flutter/material.dart';

class CoffeeTypeDropdown extends StatelessWidget {
  final String? selectedType;
  final ValueChanged<String?> onChanged;

  const CoffeeTypeDropdown({
    Key? key,
    required this.selectedType,
    required this.onChanged,
  }) : super(key: key);

  final List<String> coffeeTypes = const [
    'Wild Coffee',
    'Semi-Forest',
    'Plantation',
    'Home Garden',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Coffee Type',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      value: selectedType,
      items: coffeeTypes
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Coffee type is required' : null,
    );
  }
}
