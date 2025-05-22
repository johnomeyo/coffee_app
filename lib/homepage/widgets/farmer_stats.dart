// Farmers Statistics Widget
import 'package:coffee_app/homepage/widgets/stats_item.dart';
import 'package:flutter/material.dart';

class FarmersStats extends StatelessWidget {
  final int totalFarmers;

  const FarmersStats({super.key, required this.totalFarmers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatItem(
                icon: Icons.people,
                label: 'Total Farmers',
                value: totalFarmers.toString(),
              ),
              StatItem(
                icon: Icons.agriculture,
                label: 'Active Farms',
                value: _getTotalFarms().toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getTotalFarms() {
    // This would typically calculate from actual data
    return totalFarmers * 2; // Placeholder calculation
  }
}
