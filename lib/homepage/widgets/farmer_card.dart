import 'package:coffee_app/homepage/widgets/farmer_avatar.dart' show FarmerAvatar;
import 'package:coffee_app/models/data_models.dart';
import 'package:flutter/material.dart';

class FarmerCard extends StatelessWidget {
  final Farmer farmer;
  final VoidCallback onTap;

  const FarmerCard({super.key, required this.farmer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FarmerAvatar(farmer: farmer),
              const SizedBox(height: 8),
              Text(
                farmer.fullName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 10, color: Theme.of(context).colorScheme.primary),
                  Text(
                    farmer.village,                    
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}