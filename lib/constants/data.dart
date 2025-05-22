
// Sample Data Generator
import 'package:coffee_app/models/data_models.dart' show Farm, Farmer;

List<Farmer> generateSampleFarmers() {
  return [
    Farmer(
      id: '1',
      firstName: 'John',
      lastName: 'Smith',
      registrationNumber: 'FR001',
      gender: 'Male',
      dateOfBirth: DateTime(1980, 5, 15),
      village: 'Green Valley',
      farms: [
        Farm(id: 'F1', name: 'Smith Farm', size: 50.0, cropType: 'Corn'),
        Farm(id: 'F2', name: 'North Field', size: 30.0, cropType: 'Wheat'),
      ],
    ),
    Farmer(
      id: '2',
      firstName: 'Maria',
      lastName: 'Garcia',
      registrationNumber: 'FR002',
      gender: 'Female',
      dateOfBirth: DateTime(1975, 8, 22),
      village: 'Sunny Hills',
      farms: [
        Farm(
          id: 'F3',
          name: 'Garcia Ranch',
          size: 75.0,
          cropType: 'Vegetables',
        ),
      ],
    ),
    Farmer(
      id: '3',
      firstName: 'David',
      lastName: 'Johnson',
      registrationNumber: 'FR003',
      gender: 'Male',
      dateOfBirth: DateTime(1988, 2, 10),
      village: 'River Bend',
      farms: [
        Farm(
          id: 'F4',
          name: 'Johnson Fields',
          size: 40.0,
          cropType: 'Soybeans',
        ),
        Farm(id: 'F5', name: 'East Plot', size: 25.0, cropType: 'Barley'),
        Farm(id: 'F6', name: 'West Meadow', size: 35.0, cropType: 'Oats'),
      ],
    ),
    Farmer(
      id: '4',
      firstName: 'Sarah',
      lastName: 'Wilson',
      registrationNumber: 'FR004',
      gender: 'Female',
      dateOfBirth: DateTime(1992, 11, 3),
      village: 'Oak Grove',
      farms: [
        Farm(
          id: 'F7',
          name: 'Wilson Organic',
          size: 60.0,
          cropType: 'Organic Vegetables',
        ),
      ],
    ),
    Farmer(
      id: '5',
      firstName: 'Michael',
      lastName: 'Brown',
      registrationNumber: 'FR005',
      gender: 'Male',
      dateOfBirth: DateTime(1970, 7, 18),
      village: 'Pine Ridge',
      farms: [
        Farm(
          id: 'F8',
          name: 'Brown Dairy Farm',
          size: 120.0,
          cropType: 'Grass/Hay',
        ),
        Farm(id: 'F9', name: 'South Pasture', size: 80.0, cropType: 'Alfalfa'),
      ],
    ),
  ];
}
