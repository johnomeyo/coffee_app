// Farm Information Section
import 'package:coffee_app/registration/farmer_registration_page.dart';
import 'package:coffee_app/registration/widgets/coffee_dopdown.dart';
import 'package:coffee_app/registration/widgets/disturbance_dropdown.dart';
import 'package:coffee_app/registration/widgets/farm_textfield.dart';
import 'package:coffee_app/registration/widgets/image_picker.dart';
import 'package:coffee_app/registration/widgets/location_input.dart';
import 'package:coffee_app/registration/widgets/section_header.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FarmInformationSection extends StatelessWidget {
  final FarmFormControllers controllers;

  FarmInformationSection({Key? key, required this.controllers})
    : super(key: key);
  int selectedDisturbance = 0;
  void onChanged(int value) {
    selectedDisturbance = value;
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
            controller: controllers.enumeratorNameController,
            label: 'Enumerator Name',
            validator:
                (value) =>
                    value?.isEmpty == true
                        ? 'Enumerator name is required'
                        : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.kebeleNameController,
            label: 'Kebele Name',
            validator:
                (value) =>
                    value?.isEmpty == true ? 'Kebele name is required' : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.woredaNameController,
            label: 'Woreda Name',
            validator:
                (value) =>
                    value?.isEmpty == true ? 'Woreda name is required' : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.cooperativeNameController,
            label: 'Cooperative Name',
            validator:
                (value) =>
                    value?.isEmpty == true
                        ? 'Cooperative name is required'
                        : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.collectingCenterNameController,
            label: 'Collecting Center Name (Optional)',
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.plotNumberController,
            label: 'Plot Number',
            validator:
                (value) =>
                    value?.isEmpty == true ? 'Plot number is required' : null,
          ),
          const SizedBox(height: 16),
          LocationInputWidget(
            latitudeController: controllers.latitudeController,
            longitudeController: controllers.longitudeController,
            gpsAccuracyController: controllers.gpsAccuracyController,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.plotSizeController,
            label: 'Plot Size (hectares)',
            keyboardType: TextInputType.number,
            validator:
                (value) =>
                    value?.isEmpty == true ? 'Plot size is required' : null,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.coffeeAgeController,
            label: 'Coffee Age (years)',
            keyboardType: TextInputType.number,
            validator:
                (value) =>
                    value?.isEmpty == true ? 'Coffee age is required' : null,
          ),
          const SizedBox(height: 16),
          CoffeeTypeDropdown(
            selectedType: controllers.selectedCoffeeType,
            onChanged: (value) => controllers.selectedCoffeeType = value,
          ),
          const SizedBox(height: 16),
          DisturbanceDropdown(
            selectedDisturbance: selectedDisturbance,
            onChanged: onChanged,
          ),
          const SizedBox(height: 16),
          ImagePickerWidget(
            selectedImages: controllers.selectedImages,
            onImagesChanged: (images) => controllers.selectedImages = images,
          ),
          const SizedBox(height: 16),
          FarmTextfield(
            controller: controllers.additionalInfoController,
            label: 'Additional Information (Optional)',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
