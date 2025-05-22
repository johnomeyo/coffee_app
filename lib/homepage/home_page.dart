import 'package:coffee_app/constants/data.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page.dart'
    show FarmerDetailsPage;
import 'package:coffee_app/homepage/widgets/farmer_stats.dart';
import 'package:coffee_app/homepage/widgets/farmers_list.dart' show FarmersList;
import 'package:coffee_app/homepage/widgets/search_bar.dart';
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:coffee_app/registration/farmer_registration_page.dart';
import 'package:flutter/material.dart';

class FarmersHomePage extends StatefulWidget {
  const FarmersHomePage({super.key});

  @override
  FarmersHomePageState createState() => FarmersHomePageState();
}

class FarmersHomePageState extends State<FarmersHomePage> {
  final List<Farmer> farmers = generateSampleFarmers();
  String searchQuery = '';
  String selectedFilter = 'All';

  List<Farmer> get filteredFarmers {
    List<Farmer> filtered = farmers;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered =
          filtered.where((farmer) {
            return farmer.fullName.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                farmer.village.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                farmer.registrationNumber.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                );
          }).toList();
    }

    // Apply category filter
    if (selectedFilter != 'All') {
      filtered =
          filtered.where((farmer) {
            // Assuming farmer has a status or category field
            // You can adjust this based on your Farmer model
            return selectedFilter == 'Active'; // Placeholder logic
          }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasFarmers = farmers.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmers Directory',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          if (hasFarmers) ...[
            CustomSearchbar(
              onSearchChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
            const SizedBox(height: 8),
            FarmersStats(totalFarmers: farmers.length),
            const SizedBox(height: 8),
          ],
          Expanded(
            child: FarmersList(
              farmers: filteredFarmers,
              onFarmerTap: _onFarmerTap,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FarmerRegistrationPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onFarmerTap(Farmer farmer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerDetailsPage(farmer: farmer),
      ),
    );
  }
}


