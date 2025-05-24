// Farmers Statistics Widget
import 'package:coffee_app/homepage/widgets/stats_item.dart';
import 'package:coffee_app/models/data_models.dart';
import 'package:flutter/material.dart';

class FarmersStats extends StatelessWidget {
  final int totalFarmers;
final List<Farmer> farmers;
  const FarmersStats({super.key, required this.totalFarmers, required this.farmers});

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
                value: _getTotalFarms(farmers).toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

int _getTotalFarms(List<Farmer> farmers) {
  return farmers.fold(0, (total, farmer) => total + farmer.farmIds.length);
}

}
