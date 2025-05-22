import 'package:coffee_app/constants/data.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page.dart'
    show FarmerDetailPage;
import 'package:coffee_app/homepage/widgets/farmer_stats.dart';
import 'package:coffee_app/homepage/widgets/farmers_list.dart' show FarmersList;
import 'package:coffee_app/homepage/widgets/search_bar.dart';
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:flutter/material.dart';

class FarmersHomePage extends StatefulWidget {
  const FarmersHomePage({super.key});

  @override
  FarmersHomePageState createState() => FarmersHomePageState();
}

class FarmersHomePageState extends State<FarmersHomePage> {
  final List<Farmer> farmers = generateSampleFarmers();
  String searchQuery = '';

  List<Farmer> get filteredFarmers {
    if (searchQuery.isEmpty) return farmers;
    return farmers.where((farmer) {
      return farmer.fullName.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          farmer.village.toLowerCase().contains(searchQuery.toLowerCase()) ||
          farmer.registrationNumber.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmers Directory',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CustomSearchbar(
            onSearchChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          FarmersStats(totalFarmers: farmers.length),
          Expanded(
            child: FarmersList(
              farmers: filteredFarmers,
              onFarmerTap: _onFarmerTap,
            ),
          ),
        ],
      ),
    );
  }

  void _onFarmerTap(Farmer farmer) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FarmerDetailPage(farmer: farmer)),
    );
  }
}
