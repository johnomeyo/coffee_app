// Farmer Detail Page (Placeholder)
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmerDetailPage extends StatelessWidget {
  final Farmer farmer;

  const FarmerDetailPage({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(farmer.fullName)),
      body: const Center(
        child: Text('Detailed farmer information would go here'),
      ),
    );
  }
}