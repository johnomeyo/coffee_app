import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farmer_info_card.dart' show FarmerInfoCard;
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farm_section.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/image_dialog_content.dart';
import 'package:coffee_app/models/data_models.dart' show Farm, Farmer;
import 'package:coffee_app/services/hive_storage_service.dart'; 
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FarmerDetailsPage extends StatelessWidget {
  final Farmer farmer;

  const FarmerDetailsPage({super.key, required this.farmer});

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { 
        return ImageDialogContent(imageUrl: imageUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(farmer.fullName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FarmerInfoCard(farmer: farmer),
            const SizedBox(height: 24),
            FarmsSection(
              farms: farmer.farmIds.map((farmId) => Hive.box<Farm>(HiveStorage.farmsBoxName).get(farmId)).whereType<Farm>().toList(),
              onImageTap: (imageUrl) => _showImageDialog(context, imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}

