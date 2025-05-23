import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farm_detail_row.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/image_thumbnail.dart';
import 'package:coffee_app/models/data_models.dart' show Farm;
import 'package:flutter/material.dart';

class FarmInfoCard extends StatelessWidget {
  final Farm farm;
  final Function(String imageUrl) onImageTap;

  const FarmInfoCard(
      {super.key, required this.farm, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    farm.enumeratorName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: farm.isApproved
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    farm.isApproved ? 'Approved' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: farm.isApproved
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FarmDetailRow(label: 'Size', value: '${farm.plotSize} ha'),
            FarmDetailRow(label: 'Crop Type', value: farm.coffeeType),
            FarmDetailRow(label: 'Location', value: farm.collectingCenterName),
            if (farm.additionalInfo != null &&
                farm.additionalInfo!.isNotEmpty) ...[
              const SizedBox(height: 8),
              FarmDetailRow(
                  label: 'Additional Info', value: farm.additionalInfo!),
            ],
            if (farm.images.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Farm Images',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: farm.images.length,
                  itemBuilder: (context, index) {
                    return ImageThumbnail(
                      imageUrl: farm.images[index],
                      onTap: () => onImageTap(farm.images[index]),
                    );
                  },
                ),
              ),
            ],
            if (!farm.isApproved) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: Icon(Icons.edit, size: 18, color: Theme.of(context).colorScheme.primary),
                  label: Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5))
                    )
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit farm: ${farm.enumeratorName}')),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
