
import 'package:coffee_app/models/data_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage{
  static const String boxName = 'farmersBox';

  void addFarmer(Farmer farmer) async {
    final box = await Hive.openBox<Farmer>(boxName);
    await box.put(farmer.id, farmer);
    print('Farmer added: ${farmer.fullName}');
  
  } 
  Future<Farmer?> getFarmer(String id) async {
    final box = await Hive.openBox<Farmer>(boxName);
    return box.get(id);
  }
  Future<List<Farmer>> getAllFarmers() async {
    final box = await Hive.openBox<Farmer>(boxName);
    return box.values.toList();
  }
  Future<void> updateFarmer(Farmer farmer) async {
    final box = await Hive.openBox<Farmer>(boxName);
    await box.put(farmer.id, farmer);
  }
  Future<void> deleteFarmer(String id) async {
    final box = await Hive.openBox<Farmer>(boxName);
    await box.delete(id);
  }
}