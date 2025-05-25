import 'dart:io';
import 'package:coffee_app/homepage/pages/farmers_details_page/edit_farmer_dialog.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/details_row.dart';
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:coffee_app/services/hive_storage_service.dart';
import 'package:flutter/material.dart';

class FarmerInfoCard extends StatefulWidget {
  final Farmer farmer;
  final VoidCallback? onUpdated; 

  const FarmerInfoCard({super.key, required this.farmer, this.onUpdated});

  @override
  State<FarmerInfoCard> createState() => _FarmerInfoCardState();
}

class _FarmerInfoCardState extends State<FarmerInfoCard> {
  late Farmer farmer;
  final storage = HiveStorage();

  @override
  void initState() {
    super.initState();
    farmer = widget.farmer;
  }

  Future<void> _editFarmer() async {
    await showDialog(
      context: context,
      builder: (context) => EditFarmerDialog(
        farmer: farmer,
        onSave: (updatedFarmer) async {
          await storage.updateFarmer(updatedFarmer);
          setState(() {
            farmer = updatedFarmer;
          });
          widget.onUpdated?.call();
        },
      ),
    );
  }

  Future<void> _deleteFarmer() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Farmer'),
        content: const Text('Are you sure you want to delete this farmer? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await storage.deleteFarmer(farmer.id);
      widget.onUpdated?.call();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Farmer deleted')),
        );
        Navigator.of(context).pop(); // Close the dialog or page
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = farmer.imageUrl.isNotEmpty;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  backgroundImage: hasImage ? FileImage(File(farmer.imageUrl)) : null,
                  child: !hasImage
                      ? Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farmer.fullName,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Registration: ${farmer.registrationNumber}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _editFarmer,
                  tooltip: 'Edit Farmer Info',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _deleteFarmer,
                  tooltip: 'Delete Farmer',
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            DetailRow(label: 'Age', value: '${farmer.age} years'),
            DetailRow(label: 'Gender', value: farmer.gender),
            DetailRow(label: 'Village', value: farmer.village),
            DetailRow(
              label: 'Date of Birth',
              value:
                  '${farmer.dateOfBirth.day}/${farmer.dateOfBirth.month}/${farmer.dateOfBirth.year}',
            ),
            DetailRow(label: 'Total Farms', value: '${farmer.farmIds.length}'),
          ],
        ),
      ),
    );
  }
}
