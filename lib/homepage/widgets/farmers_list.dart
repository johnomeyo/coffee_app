// Farmers List Widget
import 'package:coffee_app/homepage/widgets/empty_state.dart' show EmptyState;
import 'package:coffee_app/homepage/widgets/farmer_card.dart' show FarmerCard;
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmersList extends StatelessWidget {
  final List<Farmer> farmers;
  final Function(Farmer) onFarmerTap;

  const FarmersList({
    super.key,
    required this.farmers,
    required this.onFarmerTap,
  });

  @override
  Widget build(BuildContext context) {
    if (farmers.isEmpty) {
      return const EmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: farmers.length,
      itemBuilder: (context, index) {
        return FarmerCard(
          farmer: farmers[index],
          onTap: () => onFarmerTap(farmers[index]),
        );
      },
    );
  }
}
