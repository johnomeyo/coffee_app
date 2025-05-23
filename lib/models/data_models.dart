import 'package:hive/hive.dart';
part 'data_models.g.dart';

@HiveType(typeId: 0)
class Farm extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String enumeratorName;

  @HiveField(2)
  final String kebeleName;

  @HiveField(3)
  final String woredaName;

  @HiveField(4)
  final String cooperativeName;

  @HiveField(5)
  final String farmerName;

  @HiveField(6)
  final String collectingCenterName;

  @HiveField(7)
  final String plotNumber;

  @HiveField(8)
  final double latitude;

  @HiveField(9)
  final double longitude;

  @HiveField(10)
  final double gpsAccuracy;

  @HiveField(11)
  final double plotSize;

  @HiveField(12)
  final int coffeeAge;

  @HiveField(13)
  final String coffeeType;

  @HiveField(14)
  final int disturbance;

  @HiveField(15)
  final bool geolocationFlagged;

  @HiveField(16)
  final bool isApproved;

  @HiveField(17)
  final List<String> images;

  @HiveField(18)
  final String? additionalInfo;

  Farm({
    required this.id,
    required this.enumeratorName,
    required this.kebeleName,
    required this.woredaName,
    required this.cooperativeName,
    required this.farmerName,
    required this.collectingCenterName,
    required this.plotNumber,
    required this.latitude,
    required this.longitude,
    required this.gpsAccuracy,
    required this.plotSize,
    required this.coffeeAge,
    required this.coffeeType,
    required this.disturbance,
    required this.geolocationFlagged,
    required this.isApproved,
    required this.images,
    this.additionalInfo,
  });
}

@HiveType(typeId: 1)
class Farmer extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String registrationNumber;

  @HiveField(4)
  final String gender;

  @HiveField(5)
  final DateTime dateOfBirth;

  @HiveField(6)
  final String village;

  @HiveField(7)
  final List<Farm> farms;

  Farmer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.registrationNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.village,
    required this.farms,
  });

  String get fullName => '$firstName $lastName';
  int get age => DateTime.now().year - dateOfBirth.year;
}
