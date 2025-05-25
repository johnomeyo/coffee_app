import 'package:coffee_app/registration/widgets/farm_info_section.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/models/data_models.dart' show Farm, Farmer;
import 'package:coffee_app/services/hive_storage_service.dart';
import 'package:coffee_app/registration/widgets/form_controller.dart';

class AddFarmPage extends StatefulWidget {
  final Farmer farmer;

  const AddFarmPage({Key? key, required this.farmer}) : super(key: key);

  @override
  State<AddFarmPage> createState() => _AddFarmPageState();
}

class _AddFarmPageState extends State<AddFarmPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = FarmFormControllers();
  final _storage = HiveStorage();

  bool _isSaving = false;
  int _selectedDisturbance = 0;

  // void _onDisturbanceChanged(int value) {
  //   setState(() {
  //     _selectedDisturbance = value;
  //   });
  // }

  Future<void> _saveFarm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Create new farm with data from controllers
    final newFarm = Farm(
      id: UniqueKey().toString(),
      farmerId: widget.farmer.id, // Link farm to farmer
      enumeratorName: _controllers.enumeratorNameController.text,
      kebeleName: _controllers.kebeleNameController.text,
      woredaName: _controllers.woredaNameController.text,
      cooperativeName: _controllers.cooperativeNameController.text,
      collectingCenterName: _controllers.collectingCenterNameController.text,
      plotNumber: _controllers.plotNumberController.text,
      latitude: double.tryParse(_controllers.latitudeController.text) ?? 0,
      longitude: double.tryParse(_controllers.longitudeController.text) ?? 0,
      gpsAccuracy: double.tryParse(_controllers.gpsAccuracyController.text) ?? 0,
      plotSize: double.tryParse(_controllers.plotSizeController.text) ?? 0,
      coffeeAge: int.tryParse(_controllers.coffeeAgeController.text) ?? 0,
      coffeeType: _controllers.selectedCoffeeType ?? '',
      disturbance: _selectedDisturbance,
      additionalInfo: _controllers.additionalInfoController.text,
      images: _controllers.selectedImages,
      isApproved: false, farmerName: widget.farmer.fullName,
      geolocationFlagged: false, // Use location status
    );

    // Save farm to Hive
    await _storage.addFarm(newFarm);

    // Update farmer's farmIds and save
    final updatedFarmer = widget.farmer;
    updatedFarmer.farmIds.add(newFarm.id);
    await _storage.updateFarmer(updatedFarmer);

    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farm added successfully')),
      );
      Navigator.of(context).pop(true); // Return success flag
    }
  }

  @override
  void dispose() {
    _controllers.dispose(); // Dispose all text controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Farm'),
      ),
      body: Form(
        key: _formKey,
        child: FarmInformationSection(
          controllers: _controllers,
          onLocationStatusChanged: () {
            setState(() {}); // Rebuild if location changes (optional)
          },
          // Since FarmInformationSection manages disturbance dropdown internally,
          // you may need to lift disturbance state up or pass callbacks.
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isSaving ? null : _saveFarm,
        label: _isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Save Farm'),
        icon: _isSaving ? null : const Icon(Icons.check_circle_rounded),
      ),
    );
  }
}
