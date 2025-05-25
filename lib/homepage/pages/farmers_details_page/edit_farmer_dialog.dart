import 'package:flutter/material.dart';
import 'package:coffee_app/models/data_models.dart' show Farmer;

class EditFarmerDialog extends StatefulWidget {
  final Farmer farmer;
  final void Function(Farmer updatedFarmer) onSave;

  const EditFarmerDialog({
    super.key,
    required this.farmer,
    required this.onSave,
  });

  @override
  State<EditFarmerDialog> createState() => _EditFarmerDialogState();
}

class _EditFarmerDialogState extends State<EditFarmerDialog> {
  late TextEditingController firstNameController;
  late TextEditingController registrationNumberController;
  late TextEditingController lastNameController;
  late TextEditingController genderController;
  late TextEditingController villageController;

  @override
  void initState() {
    super.initState();
    final farmer = widget.farmer;

    firstNameController = TextEditingController(text: farmer.fullName);
    registrationNumberController = TextEditingController(
      text: farmer.registrationNumber,
    );
    lastNameController = TextEditingController(text: farmer.age.toString());
    genderController = TextEditingController(text: farmer.gender);
    villageController = TextEditingController(text: farmer.village);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    registrationNumberController.dispose();
    firstNameController.dispose();
    genderController.dispose();
    villageController.dispose();
    super.dispose();
  }

  void save() {
    final updatedFarmer =
        widget.farmer
          ..firstName = firstNameController.text
          ..lastName = lastNameController.text
          ..registrationNumber = registrationNumberController.text
          ..gender = genderController.text
          ..village = villageController.text;

    widget.onSave(updatedFarmer);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Farmer Info'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: registrationNumberController,
              decoration: const InputDecoration(
                labelText: 'Registration Number',
              ),
            ),

            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: villageController,
              decoration: const InputDecoration(labelText: 'Village'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: save, child: const Text('Save')),
      ],
    );
  }
}
