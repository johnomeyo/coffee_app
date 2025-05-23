// Data Models
class Farm {
  final String id;
  final String enumeratorName;
  final String kebeleName;
  final String woredaName;
  final String cooperativeName;
  final String farmerName;
  final String collectingCenterName; // optional
  final String plotNumber;
  final double latitude;
  final double longitude;
  final double gpsAccuracy;
  final double plotSize; // in hectares
  final int coffeeAge; // in years
  final String coffeeType; // Wild Coffee, Semi-Forest, Plantation, Home Garden
  final int disturbance; // 0-No, 1-Low, 2-Medium, 3-High
  final bool geolocationFlagged; // true if accuracy > 10m
  final bool isApproved;
  final List<String> images;
  final String? additionalInfo;

  const Farm({
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


class Farmer {
  final String id;
  final String firstName;
  final String lastName;
  final String registrationNumber;
  final String gender;
  final DateTime dateOfBirth;
  final String village;
  final List<Farm> farms;

  const Farmer({
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
