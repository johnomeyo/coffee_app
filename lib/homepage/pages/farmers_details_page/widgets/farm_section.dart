import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farm_info_card.dart';
import 'package:coffee_app/models/data_models.dart';
import 'package:flutter/material.dart';

class FarmsSection extends StatelessWidget {
  final List<Farm> farms;
  final Function(String imageUrl) onImageTap;

  const FarmsSection(
      {super.key, required this.farms, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    if (farms.isEmpty) {
      return const Center(child: Text('No farms registered yet.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farms Owned',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: farms.length,
          itemBuilder: (context, index) {
            return FarmInfoCard(
                farm: farms[index], onImageTap: onImageTap);
          },
        ),
      ],
    );
  }
}