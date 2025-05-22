// Farmers Statistics Widget
import 'package:coffee_app/homepage/widgets/stats_item.dart';
import 'package:flutter/material.dart';

class FarmersStats extends StatelessWidget {
  final int totalFarmers;

  const FarmersStats({super.key, required this.totalFarmers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatsItem(
            icon: Icons.people,
            label: 'Total Farmers',
            value: totalFarmers.toString(),
          ),
          StatsItem(
            icon: Icons.agriculture,
            label: 'Active Farms',
            value: _getTotalFarms().toString(),
          ),
        ],
      ),
    );
  }

  int _getTotalFarms() {
    // This would typically calculate from actual data
    return totalFarmers * 2; // Placeholder calculation
  }
}
