// Gender Selection Widget
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenderSelectionWidget extends StatefulWidget {
  String? selectedGender;
  final ValueChanged<String?> onChanged;

  GenderSelectionWidget({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
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
                groupValue: widget.selectedGender,
                onChanged: (value) {
                  setState(() {
                    widget.selectedGender = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: widget.selectedGender,
                onChanged: (value) {
                  setState(() {
                    widget.selectedGender = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
