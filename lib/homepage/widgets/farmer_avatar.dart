// Farmer Avatar Widget
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmerAvatar extends StatelessWidget {
  final Farmer farmer;

  const FarmerAvatar({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        farmer.firstName[0] + farmer.lastName[0],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
