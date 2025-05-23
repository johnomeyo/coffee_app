// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// // Hive model for farm data
// part 'farm_data_manager.g.dart';

// @HiveType(typeId: 0)
// class FarmData extends HiveObject {
//   @HiveField(0)
//   String latitude;

//   @HiveField(1)
//   String longitude;

//   @HiveField(2)
//   String gpsAccuracy;

//   @HiveField(3)
//   String additionalInfo;

//   @HiveField(4)
//   DateTime timestamp;

//   FarmData({
//     required this.latitude,
//     required this.longitude,
//     required this.gpsAccuracy,
//     required this.additionalInfo,
//     required this.timestamp,
//   });
// }

// // Modified form submission
// void _submitForm(FarmFormControllers farmControllers, Farmer) async {
//   // First check if location has been obtained
//   if (!_hasLocation) {
//     _showLocationRequiredDialog();
//     return;
//   }

//   // Then validate the form
//   if (_formKey.currentState!.validate()) {
//     // Store data in Hive
//     final farmBox = await Hive.openBox<FarmData>('farmData');
//     final farmData = FarmData(
//       latitude: farmControllers.latitudeController.text,
//       longitude: farmControllers.longitudeController.text,
//       gpsAccuracy: farmControllers.gpsAccuracyController.text,
//       additionalInfo: farmControllers.additionalInfoController.text,
//       timestamp: DateTime.now(),
//     );
    
//     await farmBox.add(farmData);
    
//     // Handle form submission
//     _processFormSubmission();
//   }
// }

// // Page to display saved farm data
// class FarmDataListPage extends StatelessWidget {
//   const FarmDataListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Saved Farm Data'),
//       ),
//       body: ValueListenableBuilder(
//         valueListenable: Hive.box<FarmData>('farmData').listenable(),
//         builder: (context, Box<FarmData> box, _) {
//           if (box.isEmpty) {
//             return const Center(
//               child: Text('No farm data saved yet'),
//             );
//           }

//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               final farmData = box.getAt(index)!;
//               return Card(
//                 margin: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   title: Text('Entry ${index + 1} - ${farmData.timestamp.toString()}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Latitude: ${farmData.latitude}'),
//                       Text('Longitude: ${farmData.longitude}'),
//                       Text('GPS Accuracy: ${farmData.gpsAccuracy}'),
//                       Text('Additional Info: ${farmData.additionalInfo}'),
//                     ],
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () async {
//                       await box.deleteAt(index);
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // Initialize Hive in your main.dart
// Future<void> initHive() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(FarmDataAdapter());
//   await Hive.openBox<FarmData>('farmData');
// }

// // Add this to your main.dart
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initHive();
//   runApp(MyApp());
// }

// // Example FarmFormControllers class (for reference)
// class FarmFormControllers {
//   final TextEditingController latitudeController = TextEditingController();
//   final TextEditingController longitudeController = TextEditingController();
//   final TextEditingController gpsAccuracyController = TextEditingController();
//   final TextEditingController additionalInfoController = TextEditingController();
// }