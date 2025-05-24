import 'dart:io';

import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmerAvatar extends StatelessWidget {
  final Farmer farmer;

  const FarmerAvatar({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    final hasImage = farmer.imageUrl.isNotEmpty;

    return CircleAvatar(
      radius: 24,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundImage: hasImage ? FileImage(File(farmer.imageUrl)) : null,
      child:
          !hasImage
              ? Text(
                '${farmer.firstName[0]}${farmer.lastName[0]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
              : null,
    );
  }
}
