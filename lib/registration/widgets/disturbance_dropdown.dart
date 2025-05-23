
import 'package:flutter/material.dart';

class DisturbanceDropdown extends StatelessWidget {
  final int selectedDisturbance;
  final ValueChanged<int> onChanged;

  const DisturbanceDropdown({
    Key? key,
    required this.selectedDisturbance,
    required this.onChanged,
  }) : super(key: key);

  static const List<String> labels = [
    'No Disturbance',
    'Low Disturbance',
    'Medium Disturbance',
    'High Disturbance',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disturbance Level',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: selectedDisturbance,
          items: List.generate(
            labels.length,
            (index) => DropdownMenuItem(
              value: index,
              child: Text('$index - ${labels[index]}'),
            ),
          ),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }
}
