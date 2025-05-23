import 'package:flutter/material.dart';

class GenderSelectionWidget extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderSelectionWidget({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: selectedGender,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: selectedGender,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
