import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farm_detail_row.dart';
import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/image_thumbnail.dart';
import 'package:coffee_app/models/data_models.dart' show Farm;
import 'package:flutter/material.dart';

class FarmInfoCard extends StatelessWidget {
  final Farm farm;
  final Function(String imageUrl) onImageTap;

  const FarmInfoCard(
      {super.key, required this.farm, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    farm.enumeratorName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: farm.isApproved
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    farm.isApproved ? 'Approved' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: farm.isApproved
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FarmDetailRow(label: 'Size', value: '${farm.plotSize} ha'),
            FarmDetailRow(label: 'Crop Type', value: farm.coffeeType),
            FarmDetailRow(label: 'Location', value: farm.collectingCenterName),
            if (farm.additionalInfo != null &&
                farm.additionalInfo!.isNotEmpty) ...[
              const SizedBox(height: 8),
              FarmDetailRow(
                  label: 'Additional Info', value: farm.additionalInfo!),
            ],
            if (farm.images.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Farm Images',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: farm.images.length,
                  itemBuilder: (context, index) {
                    return ImageThumbnail(
                      imageUrl: farm.images[index],
                      onTap: () => onImageTap(farm.images[index]),
                    );
                  },
                ),
              ),
            ],
            if (!farm.isApproved) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: Icon(Icons.edit, size: 18, color: Theme.of(context).colorScheme.primary),
                  label: Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5))
                    )
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit farm: ${farm.enumeratorName}')),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/farm_detail_row.dart';
// import 'package:coffee_app/homepage/pages/farmers_details_page/widgets/image_thumbnail.dart';
// import 'package:coffee_app/models/data_models.dart' show Farm, Farmer;
// import 'package:coffee_app/registration/farm_edit_page.dart'; // New import for FarmEditPage
// import 'package:coffee_app/services/hive_storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:coffee_app/hive_storage.dart'; // Import HiveStorage

// class FarmInfoCard extends StatelessWidget {
//   final Farm farm;
//   final Farmer farmer; // Added to access the parent Farmer
//   final Function(String imageUrl) onImageTap;

//   const FarmInfoCard({
//     super.key,
//     required this.farm,
//     required this.farmer,
//     required this.onImageTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     farm.enumeratorName,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: farm.isApproved
//                         ? Colors.green.withValues(alpha: 0.1)
//                         : Colors.orange.withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     farm.isApproved ? 'Approved' : 'Pending',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: farm.isApproved
//                           ? Colors.green[700]
//                           : Colors.orange[700],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             FarmDetailRow(label: 'Size', value: '${farm.plotSize} ha'),
//             FarmDetailRow(label: 'Crop Type', value: farm.coffeeType),
//             FarmDetailRow(label: 'Location', value: farm.collectingCenterName),
//             if (farm.additionalInfo != null &&
//                 farm.additionalInfo!.isNotEmpty) ...[
//               const SizedBox(height: 8),
//               FarmDetailRow(
//                   label: 'Additional Info', value: farm.additionalInfo!),
//             ],
//             if (farm.images.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               const Text(
//                 'Farm Images',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: farm.images.length,
//                   itemBuilder: (context, index) {
//                     return ImageThumbnail(
//                       imageUrl: farm.images[index],
//                       onTap: () => onImageTap(farm.images[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//             if (!farm.isApproved) ...[
//               const SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   icon: Icon(Icons.edit,
//                       size: 18, color: Theme.of(context).colorScheme.primary),
//                   label: Text('Edit',
//                       style:
//                           TextStyle(color: Theme.of(context).colorScheme.primary)),
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       side: BorderSide(
//                           color: Theme.of(context)
//                               .colorScheme
//                               .primary
//                               .withValues(alpha: 0.5)),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FarmEditPage(
//                           farmer: farmer,
//                           farm: farm,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// // New FarmEditPage for editing farm details
// class FarmEditPage extends StatefulWidget {
//   final Farmer farmer;
//   final Farm farm;

//   const FarmEditPage({super.key, required this.farmer, required this.farm});

//   @override
//   FarmEditPageState createState() => FarmEditPageState();
// }

// class FarmEditPageState extends State<FarmEditPage> {
//   final _formKey = GlobalKey<FormState>();
//   late FarmFormControllers _controllers;
//   final HiveStorage _hiveStorage = HiveStorage();
//   bool _hasLocation = true; // Adjust based on your location logic

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with existing farm data
//     _controllers = FarmFormControllers()
//       ..enumeratorNameController.text = widget.farm.enumeratorName
//       ..kebeleNameController.text = widget.farm.kebeleName
//       ..woredaNameController.text = widget.farm.woredaName
//       ..cooperativeNameController.text = widget.farm.cooperativeName
//       ..collectingCenterNameController.text = widget.farm.collectingCenterName
//       ..plotNumberController.text = widget.farm.plotNumber
//       ..latitudeController.text = widget.farm.latitude.toString()
//       ..longitudeController.text = widget.farm.longitude.toString()
//       ..gpsAccuracyController.text = widget.farm.gpsAccuracy.toString()
//       ..plotSizeController.text = widget.farm.plotSize.toString()
//       ..coffeeAgeController.text = widget.farm.coffeeAge.toString()
//       ..selectedCoffeeType = widget.farm.coffeeType // Adjust if enum
//       ..additionalInfoController.text = widget.farm.additionalInfo!
//       ..selectedDisturbance = widget.farm.disturbance;
//   }

//   void _submitForm() {
//     if (!_hasLocation) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Location required')),
//       );
//       return;
//     }

//     if (_formKey.currentState!.validate()) {
//       // Create updated farm object
//       final updatedFarm = Farm(
//         id: widget.farm.id,
//         enumeratorName: _controllers.enumeratorNameController.text,
//         kebeleName: _controllers.kebeleNameController.text,
//         woredaName: _controllers.woredaNameController.text,
//         cooperativeName: _controllers.cooperativeNameController.text,
//         farmerName: widget.farm.farmerName, // Keep original farmerName
//         collectingCenterName: _controllers.collectingCenterNameController.text,
//         plotNumber: _controllers.plotNumberController.text,
//         latitude:
//             double.tryParse(_controllers.latitudeController.text) ?? widget.farm.latitude,
//         longitude:
//             double.tryParse(_controllers.longitudeController.text) ?? widget.farm.longitude,
//         gpsAccuracy:
//             double.tryParse(_controllers.gpsAccuracyController.text) ?? widget.farm.gpsAccuracy,
//         plotSize:
//             double.tryParse(_controllers.plotSizeController.text) ?? widget.farm.plotSize,
//         coffeeAge:
//             int.tryParse(_controllers.coffeeAgeController.text) ?? widget.farm.coffeeAge,
//         coffeeType: _controllers.selectedCoffeeType.toString(),
//         additionalInfo: _controllers.additionalInfoController.text,
//         disturbance: _controllers.selectedDisturbance!,
//         geolocationFlagged: widget.farm.geolocationFlagged,
//         isApproved: widget.farm.isApproved,
//         images: widget.farm.images, // Keep original images
//       );

//       // Update the farmer's farms list
//       final updatedFarms = widget.farmer.farms
//           .map((f) => f.id == widget.farm.id ? updatedFarm : f)
//           .toList();
//       final updatedFarmer = Farmer(
//         id: widget.farmer.id,
//         firstName: widget.farmer.firstName,
//         lastName: widget.farmer.lastName,
//         registrationNumber: widget.farmer.registrationNumber,
//         gender: widget.farmer.gender,
//         dateOfBirth: widget.farmer.dateOfBirth,
//         village: widget.farmer.village,
//         farms: updatedFarms,
//       );

//       // Save to Hive
//       _hiveStorage.updateFarmer(updatedFarmer).then((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Farm ${updatedFarm.enumeratorName} updated')),
//         );
//         Navigator.pop(context); // Return to previous page
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating farm: $error')),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Farm'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: _controllers.enumeratorNameController,
//                   decoration: const InputDecoration(labelText: 'Enumerator Name'),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter enumerator name' : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.kebeleNameController,
//                   decoration: const InputDecoration(labelText: 'Kebele Name'),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter kebele name' : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.woredaNameController,
//                   decoration: const InputDecoration(labelText: 'Woreda Name'),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter woreda name' : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.cooperativeNameController,
//                   decoration: const InputDecoration(labelText: 'Cooperative Name'),
//                 ),
//                 TextFormField(
//                   controller: _controllers.collectingCenterNameController,
//                   decoration:
//                       const InputDecoration(labelText: 'Collecting Center Name'),
//                 ),
//                 TextFormField(
//                   controller: _controllers.plotNumberController,
//                   decoration: const InputDecoration(labelText: 'Plot Number'),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter plot number' : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.latitudeController,
//                   decoration: const InputDecoration(labelText: 'Latitude'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty || double.tryParse(value) == null
//                           ? 'Please enter a valid latitude'
//                           : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.longitudeController,
//                   decoration: const InputDecoration(labelText: 'Longitude'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty || double.tryParse(value) == null
//                           ? 'Please enter a valid longitude'
//                           : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.gpsAccuracyController,
//                   decoration: const InputDecoration(labelText: 'GPS Accuracy'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty || double.tryParse(value) == null
//                           ? 'Please enter a valid GPS accuracy'
//                           : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.plotSizeController,
//                   decoration: const InputDecoration(labelText: 'Plot Size (ha)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty || double.tryParse(value) == null
//                           ? 'Please enter a valid plot size'
//                           : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.coffeeAgeController,
//                   decoration: const InputDecoration(labelText: 'Coffee Age'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty || int.tryParse(value) == null
//                           ? 'Please enter a valid coffee age'
//                           : null,
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _controllers.selectedCoffeeType,
//                   decoration: const InputDecoration(labelText: 'Coffee Type'),
//                   items: ['Arabica', 'Robusta', 'Other'] // Adjust based on your types
//                       .map((type) => DropdownMenuItem(
//                             value: type,
//                             child: Text(type),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _controllers.selectedCoffeeType = value!;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? 'Please select a coffee type' : null,
//                 ),
//                 TextFormField(
//                   controller: _controllers.additionalInfoController,
//                   decoration:
//                       const InputDecoration(labelText: 'Additional Info'),
//                   maxLines: 3,
//                 ),
//                 DropdownButtonFormField<int?>(
//                   value: _controllers.selectedDisturbance,
//                   decoration: const InputDecoration(labelText: 'Disturbance'),
//                   items: [null, 0, 1, 2, 3] // Adjust based on your disturbance values
//                       .map((value) => DropdownMenuItem(
//                             value: value,
//                             child: Text(value?.toString() ?? 'None'),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _controllers.selectedDisturbance = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _submitForm,
//                   child: const Text('Save Changes'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // FarmFormControllers class (for reference, ensure it matches your implementation)
// class FarmFormControllers {
//   final TextEditingController enumeratorNameController = TextEditingController();
//   final TextEditingController kebeleNameController = TextEditingController();
//   final TextEditingController woredaNameController = TextEditingController();
//   final TextEditingController cooperativeNameController = TextEditingController();
//   final TextEditingController collectingCenterNameController = TextEditingController();
//   final TextEditingController plotNumberController = TextEditingController();
//   final TextEditingController latitudeController = TextEditingController();
//   final TextEditingController longitudeController = TextEditingController();
//   final TextEditingController gpsAccuracyController = TextEditingController();
//   final TextEditingController plotSizeController = TextEditingController();
//   final TextEditingController coffeeAgeController = TextEditingController();
//   String selectedCoffeeType = 'Arabica'; // Default value, adjust as needed
//   final TextEditingController additionalInfoController = TextEditingController();
//   int? selectedDisturbance;
// }