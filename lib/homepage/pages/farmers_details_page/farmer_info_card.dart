import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/details_row.dart';
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmerInfoCard extends StatelessWidget {
  final Farmer farmer;

  const FarmerInfoCard({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farmer.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Registration: ${farmer.registrationNumber}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
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
                    '${farmer.dateOfBirth.day}/${farmer.dateOfBirth.month}/${farmer.dateOfBirth.year}'),
            DetailRow(label: 'Total Farms', value: '${farmer.farms.length}'),
          ],
        ),
      ),
    );
  }
}
