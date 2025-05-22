// Data Models
class Farm {
  final String id;
  final String name;
  final double size;
  final String cropType;

  const Farm({
    required this.id,
    required this.name,
    required this.size,
    required this.cropType,
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
