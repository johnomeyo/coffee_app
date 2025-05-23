
// Section Header Widget
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({Key? key, required this.title, required this.icon})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
