import 'package:hive/hive.dart';
part 'data_models.g.dart';

@HiveType(typeId: 0)
class Farm extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String farmerId; // New field to link to Farmer

  @HiveField(2)
  final String enumeratorName;

  @HiveField(3)
  final String kebeleName;

  @HiveField(4)
  final String woredaName;

  @HiveField(5)
  final String cooperativeName;

  @HiveField(6)
  final String farmerName;

  @HiveField(7)
  final String collectingCenterName;

  @HiveField(8)
  final String plotNumber;

  @HiveField(9)
  final double latitude;

  @HiveField(10)
  final double longitude;

  @HiveField(11)
  final double gpsAccuracy;

  @HiveField(12)
  final double plotSize;

  @HiveField(13)
  final int coffeeAge;

  @HiveField(14)
  final String coffeeType;

  @HiveField(15)
  final int disturbance;

  @HiveField(16)
  final bool geolocationFlagged;

  @HiveField(17)
  final bool isApproved;

  @HiveField(18)
  final List<String> images;

  @HiveField(19)
  final String? additionalInfo;

  Farm({
    required this.id,
    required this.farmerId,
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
  final String imageUrl; 

  @HiveField(8)
  final List<String> farmIds; // New field to track farm IDs

  Farmer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.registrationNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.village,
    required this.imageUrl,
     this.farmIds = const [], // Default to empty list
  });

  String get fullName => '$firstName $lastName';
  int get age => DateTime.now().year - dateOfBirth.year;
}
