// Custom Text Field Widget
import 'package:flutter/material.dart';

class FarmTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;

  const FarmTextfield({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}
