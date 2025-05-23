// Farm Information Section
import 'package:coffee_app/registration/widgets/coffee_dopdown.dart';
import 'package:coffee_app/registration/widgets/disturbance_dropdown.dart';
import 'package:coffee_app/registration/widgets/farm_textfield.dart';
import 'package:coffee_app/registration/widgets/form_controller.dart';
import 'package:coffee_app/registration/widgets/image_picker.dart';
import 'package:coffee_app/registration/widgets/location_input.dart';
import 'package:coffee_app/registration/widgets/section_header.dart';
import 'package:flutter/material.dart';

class FarmInformationSection extends StatefulWidget {
  final FarmFormControllers controllers;
  final VoidCallback? onLocationStatusChanged; // Callback to notify parent

  const FarmInformationSection({
    Key? key, 
    required this.controllers,
    this.onLocationStatusChanged,
  }) : super(key: key);

  @override
  State<FarmInformationSection> createState() => _FarmInformationSectionState();
}

class _FarmInformationSectionState extends State<FarmInformationSection> {
  int selectedDisturbance = 0;
  bool _hasLocation = false;

  void onDisturbanceChanged(int value) {
    setState(() {
      selectedDisturbance = value;
    });
  }

  void _onLocationChanged() {
    setState(() {
      _hasLocation = widget.controllers.latitudeController.text.isNotEmpty && 
                    widget.controllers.longitudeController.text.isNotEmpty;
    });
    // Notify parent widget about location status change
    widget.onLocationStatusChanged?.call();
  }

  // Method to check if location is obtained (can be called from parent)
  bool get hasLocation => _hasLocation;

  @override
  void initState() {
    super.initState();
    // Check initial location status
    _hasLocation = widget.controllers.latitudeController.text.isNotEmpty && 
                   widget.controllers.longitudeController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Farm Information',
            icon: Icons.agriculture_outlined,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.enumeratorNameController,
            label: 'Enumerator Name',
            validator: (value) =>
                value?.isEmpty == true
                    ? 'Enumerator name is required'
                    : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.kebeleNameController,
            label: 'Kebele Name',
            validator: (value) =>
                value?.isEmpty == true ? 'Kebele name is required' : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.woredaNameController,
            label: 'Woreda Name',
            validator: (value) =>
                value?.isEmpty == true ? 'Woreda name is required' : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.cooperativeNameController,
            label: 'Cooperative Name',
            validator: (value) =>
                value?.isEmpty == true
                    ? 'Cooperative name is required'
                    : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.collectingCenterNameController,
            label: 'Collecting Center Name (Optional)',
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.plotNumberController,
            label: 'Plot Number',
            validator: (value) =>
                value?.isEmpty == true ? 'Plot number is required' : null,
          ),
          const SizedBox(height: 16),
          LocationInputWidget(
            latitudeController: widget.controllers.latitudeController,
            longitudeController: widget.controllers.longitudeController,
            gpsAccuracyController: widget.controllers.gpsAccuracyController,
            onLocationChanged: _onLocationChanged,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.plotSizeController,
            label: 'Plot Size (hectares)',
            keyboardType: TextInputType.number,
            validator: (value) =>
                value?.isEmpty == true ? 'Plot size is required' : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.coffeeAgeController,
            label: 'Coffee Age (years)',
            keyboardType: TextInputType.number,
            validator: (value) =>
                value?.isEmpty == true ? 'Coffee age is required' : null,
          ),
          const SizedBox(height: 16),
          CoffeeTypeDropdown(
            selectedType: widget.controllers.selectedCoffeeType,
            onChanged: (value) => widget.controllers.selectedCoffeeType = value,
          ),
          const SizedBox(height: 16),
          DisturbanceDropdown(
            selectedDisturbance: selectedDisturbance,
            onChanged: onDisturbanceChanged,
          ),
          const SizedBox(height: 16),
          ImagePickerWidget(
            selectedImages: widget.controllers.selectedImages,
            onImagesChanged: (images) => widget.controllers.selectedImages = images,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: widget.controllers.additionalInfoController,
            label: 'Additional Information (Optional)',
            maxLines: 3,
          ),
 
        ],
      ),
    );
  }
}