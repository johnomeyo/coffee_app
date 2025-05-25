import 'package:hive/hive.dart';
part 'data_models.g.dart';

@HiveType(typeId: 0)
class Farm extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String farmerId;

  @HiveField(2)
  String enumeratorName;

  @HiveField(3)
  String kebeleName;

  @HiveField(4)
  String woredaName;

  @HiveField(5)
  String cooperativeName;

  @HiveField(6)
  String farmerName;

  @HiveField(7)
  String collectingCenterName;

  @HiveField(8)
  String plotNumber;

  @HiveField(9)
  final double latitude;

  @HiveField(10)
  final double longitude;

  @HiveField(11)
  double gpsAccuracy;

  @HiveField(12)
  double plotSize;

  @HiveField(13)
  int coffeeAge;

  @HiveField(14)
  String coffeeType;

  @HiveField(15)
  int disturbance;

  @HiveField(16)
  bool geolocationFlagged;

  @HiveField(17)
  bool isApproved;

  @HiveField(18)
  List<String> images;

  @HiveField(19)
  String? additionalInfo;

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
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String registrationNumber;

  @HiveField(4)
  String gender;

  @HiveField(5)
  final DateTime dateOfBirth;

  @HiveField(6)
  String village;

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
