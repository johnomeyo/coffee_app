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
      return const EmptyState(); // Keep your empty state handling
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16.0), // Apply padding around the entire grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0, // Horizontal space between cards
        mainAxisSpacing: 10.0, // Vertical space between cards
        childAspectRatio: 0.85, // Adjust as needed for your FarmerCard's content (width / height)
                                // For example, if FarmerCard is taller, you might need a smaller aspect ratio (e.g., 0.75)
                                // If it's wider, a larger one (e.g., 1.0 or 1.2)
      ),
      itemCount: farmers.length,
      itemBuilder: (context, index) {
        final farmer = farmers[index];
        return FarmerCard(
          farmer: farmer,
          onTap: () => onFarmerTap(farmer),
        );
      },
    );
  }
}