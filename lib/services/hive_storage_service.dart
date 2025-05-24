
import 'package:coffee_app/models/data_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive/hive.dart';

class HiveStorage {
  static const String farmersBoxName = 'farmersBox';
  static const String farmsBoxName = 'farmsBox';

  // --------------------- FARMER METHODS ---------------------

  Future<void> addFarmer(Farmer farmer) async {
    final box = await Hive.openBox<Farmer>(farmersBoxName);
    await box.put(farmer.id, farmer);
    print('Farmer added: ${farmer.fullName}');
  }

  Future<Farmer?> getFarmer(String id) async {
    final box = await Hive.openBox<Farmer>(farmersBoxName);
    return box.get(id);
  }

  Future<List<Farmer>> getAllFarmers() async {
    final box = await Hive.openBox<Farmer>(farmersBoxName);
    return box.values.toList();
  }

  Future<void> updateFarmer(Farmer farmer) async {
    final box = await Hive.openBox<Farmer>(farmersBoxName);
    await box.put(farmer.id, farmer);
  }

  Future<void> deleteFarmer(String id) async {
    final box = await Hive.openBox<Farmer>(farmersBoxName);
    await box.delete(id);
  }

  // --------------------- FARM METHODS ---------------------

  Future<void> addFarm(Farm farm) async {
    final box = await Hive.openBox<Farm>(farmsBoxName);
    await box.put(farm.id, farm);
    print('Farm added for farmer: ${farm.farmerId}');
  }

  Future<Farm?> getFarm(String id) async {
    final box = await Hive.openBox<Farm>(farmsBoxName);
    return box.get(id);
  }

  Future<List<Farm>> getAllFarms() async {
    final box = await Hive.openBox<Farm>(farmsBoxName);
    return box.values.toList();
  }

  Future<List<Farm>> getFarmsForFarmer(String farmerId) async {
    final box = await Hive.openBox<Farm>(farmsBoxName);
    return box.values
        .where((farm) => farm.farmerId == farmerId)
        .toList();
  }

  Future<void> updateFarm(Farm farm) async {
    final box = await Hive.openBox<Farm>(farmsBoxName);
    await box.put(farm.id, farm);
  }

  Future<void> deleteFarm(String id) async {
    final box = await Hive.openBox<Farm>(farmsBoxName);
    await box.delete(id);
  }
}
