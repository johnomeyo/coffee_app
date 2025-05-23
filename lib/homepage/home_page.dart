import 'package:coffee_app/homepage/pages/farmers_details_page.dart'
    show FarmerDetailsPage;
import 'package:coffee_app/homepage/widgets/farmer_stats.dart';
import 'package:coffee_app/homepage/widgets/farmers_list.dart' show FarmersList;
import 'package:coffee_app/homepage/widgets/search_bar.dart';
import 'package:coffee_app/models/data_models.dart' show Farmer;
import 'package:coffee_app/registration/farmer_registration_page.dart';
import 'package:coffee_app/services/hive_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FarmersHomePage extends StatefulWidget {
  const FarmersHomePage({super.key});

  @override
  FarmersHomePageState createState() => FarmersHomePageState();
}

class FarmersHomePageState extends State<FarmersHomePage> {
  String searchQuery = '';
  bool _isBoxInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    try {
      // Ensure Hive is initialized and the box is opened
      if (!Hive.isBoxOpen(HiveStorage.boxName)) {
        await Hive.openBox<Farmer>(HiveStorage.boxName);
      }
      setState(() {
        _isBoxInitialized = true;
      });
    } catch (e) {
      // Handle any errors during initialization
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error initializing storage: $e')));
    }
  }

  List<Farmer> _filterFarmers(List<Farmer> farmers) {
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
    if (!_isBoxInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmers Directory',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              try {
                // Access the already-opened box
                final box = Hive.box<Farmer>('farmersBox');

                // Clear all data in the box
                await box.clear();


              } catch (e) {
                // Handle error if box is not open or something goes wrong
                print('Error clearing box: $e');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Failed to clear data')));
              }
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Farmer>>(
        valueListenable: Hive.box<Farmer>(HiveStorage.boxName).listenable(),
        builder: (context, box, _) {
          final farmers = box.values.toList();
          final filteredFarmers = _filterFarmers(farmers);
          final hasFarmers = farmers.isNotEmpty;

          return Column(
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
                FarmersStats(totalFarmers: farmers.length, farmers: farmers),
                const SizedBox(height: 8),
              ],
              Expanded(
                child:
                    filteredFarmers.isEmpty
                        ? const Center(child: Text('No farmers found'))
                        : FarmersList(
                          farmers: filteredFarmers,
                          onFarmerTap: _onFarmerTap,
                        ),
              ),
            ],
          );
        },
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
