
// Farmer Info Widget
import 'package:coffee_app/homepage/widgets/info_chip.dart' show InfoChip;
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmerInfo extends StatelessWidget {
  final Farmer farmer;

  const FarmerInfo({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoChip(icon: Icons.location_on, label: farmer.village),
        const SizedBox(width: 8),
        InfoChip(icon: Icons.person, label: farmer.gender),
        const SizedBox(width: 8),
        InfoChip(
          icon: Icons.agriculture,
          label: '${farmer.farms.length} farms',
        ),
      ],
    );
  }
}
