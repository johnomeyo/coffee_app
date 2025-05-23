import 'package:coffee_app/registration/widgets/date_picker.dart';
import 'package:coffee_app/registration/widgets/farm_textfield.dart';
import 'package:coffee_app/registration/widgets/farmer_image_picker.dart';
import 'package:coffee_app/registration/widgets/form_controller.dart';
import 'package:coffee_app/registration/widgets/gender_selection_widget.dart';
import 'package:coffee_app/registration/widgets/section_header.dart';
import 'package:flutter/material.dart';

class FarmerInformationSection extends StatelessWidget {
  final FarmerFormControllers controllers;
  final GlobalKey<FormState> formKey;

  const FarmerInformationSection({
    Key? key,
    required this.controllers,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Farmer Information',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            FormField<String>(
              initialValue: controllers.imageUrl,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please select an image' : null,
              builder: (FormFieldState<String> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FarmerImagePicker(
                      onImageSelected: (path) {
                        controllers.imageUrl = path;
                        state.didChange(path); // Update FormField state
                      },
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            FarmTextfield(
              controller: controllers.firstNameController,
              label: 'First Name',
              validator: (value) =>
                  value?.isEmpty == true ? 'First name is required' : null,
            ),
            const SizedBox(height: 16),
            FarmTextfield(
              controller: controllers.lastNameController,
              label: 'Last Name',
              validator: (value) =>
                  value?.isEmpty == true ? 'Last name is required' : null,
            ),
            const SizedBox(height: 16),
            FarmTextfield(
              controller: controllers.registrationNumberController,
              label: 'Registration Number',
              validator: (value) => value?.isEmpty == true
                  ? 'Registration number is required'
                  : null,
            ),
            const SizedBox(height: 16),
            GenderSelectionWidget(
              selectedGender: controllers.selectedGender,
              onChanged: (value) => controllers.selectedGender = value,
            ),
            const SizedBox(height: 16),
            DatePickerWidget(
              selectedDate: controllers.selectedDate,
              onDateSelected: (date) => controllers.selectedDate = date,
              label: 'Date of Birth',
            ),
            const SizedBox(height: 16),
            FarmTextfield(
              controller: controllers.villageController,
              label: 'Village',
              validator: (value) =>
                  value?.isEmpty == true ? 'Village is required' : null,
            ),
          ],
        ),
      ),
    );
  }
}