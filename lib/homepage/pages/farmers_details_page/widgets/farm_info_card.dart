import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/edit_farm_dialog.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farm_detail_row.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/image_thumbnail.dart';
import 'package:coffee_app/models/data_models.dart' show Farm;
import 'package:coffee_app/services/hive_storage_service.dart';
import 'package:flutter/material.dart';

class FarmInfoCard extends StatefulWidget {
  final Farm farm;
  final Function(String imageUrl) onImageTap;
  final VoidCallback? onDeleted; // callback to notify parent on deletion

  const FarmInfoCard({
    Key? key,
    required this.farm,
    required this.onImageTap,
    this.onDeleted,
  }) : super(key: key);

  @override
  State<FarmInfoCard> createState() => _FarmInfoCardState();
}

class _FarmInfoCardState extends State<FarmInfoCard> {
  late Farm _farm;
  final storage = HiveStorage();

  @override
  void initState() {
    super.initState();
    _farm = widget.farm;
  }

  void _handleEditFarm(BuildContext context) async {
    showDialog(
      context: context,
      builder:
          (context) => EditFarmDialog(
            farm: _farm,
            onSave: (updatedFarm) {
              setState(() {
                _farm = updatedFarm;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Farm updated successfully')),
              );
            },
          ),
    );
  }

  Future<void> _handleDeleteFarm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Farm'),
            content: const Text(
              'Are you sure you want to delete this farm? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await storage.deleteFarm(_farm.id);
      widget.onDeleted?.call();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Farm deleted')));
      }
    }
  }

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
                    _farm.enumeratorName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _farm.isApproved
                            ? Colors.green.withAlpha(25)
                            : Colors.orange.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _farm.isApproved ? 'Approved' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          _farm.isApproved
                              ? Colors.green[700]
                              : Colors.orange[700],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                const SizedBox(width: 8),

                // Delete icon button (always visible)
                IconButton(
                  icon: const Icon(Icons.delete_outlined, color: Colors.red),
                  onPressed: _handleDeleteFarm,
                  tooltip: 'Delete Farm',
                ),
              ],
            ),
            const SizedBox(height: 12),
            FarmDetailRow(label: 'Size', value: '${_farm.plotSize} ha'),
            FarmDetailRow(label: 'Crop Type', value: _farm.coffeeType),
            FarmDetailRow(
              label: 'Location',
              value: '${_farm.latitude}, ${_farm.longitude}',
            ),
            if (_farm.additionalInfo?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              FarmDetailRow(
                label: 'Additional Info',
                value: _farm.additionalInfo!,
              ),
            ],
            if (_farm.images.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Farm Images',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _farm.images.length,
                  itemBuilder: (context, index) {
                    return ImageThumbnail(
                      imageUrl: _farm.images[index],
                      onTap: () => widget.onImageTap(_farm.images[index]),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ), // Show Edit button only if farm is NOT approved, same as before
              if (!_farm.isApproved)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    TextButton.icon(
                      icon: Icon(
                        Icons.edit,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        'Edit',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(128),
                          ),
                        ),
                      ),
                      onPressed: () => _handleEditFarm(context),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
