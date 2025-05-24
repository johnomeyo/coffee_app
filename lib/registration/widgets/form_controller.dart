// Form Controllers Classes
import 'package:flutter/material.dart';

class FarmerFormControllers {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController villageController = TextEditingController();

  String? selectedGender;
  DateTime? selectedDate;
  String imageUrl = '';
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    registrationNumberController.dispose();
    villageController.dispose();
  }
}

class FarmFormControllers {
  final TextEditingController enumeratorNameController =
      TextEditingController();
  final TextEditingController kebeleNameController = TextEditingController();
  final TextEditingController woredaNameController = TextEditingController();
  final TextEditingController cooperativeNameController =
      TextEditingController();
  final TextEditingController collectingCenterNameController =
      TextEditingController();
  final TextEditingController plotNumberController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController gpsAccuracyController = TextEditingController();
  final TextEditingController plotSizeController = TextEditingController();
  final TextEditingController coffeeAgeController = TextEditingController();
  final TextEditingController additionalInfoController =
      TextEditingController();

  String? selectedCoffeeType;
  int selectedDisturbance = 0;
  List<String> selectedImages = [];

  void dispose() {
    enumeratorNameController.dispose();
    kebeleNameController.dispose();
    woredaNameController.dispose();
    cooperativeNameController.dispose();
    collectingCenterNameController.dispose();
    plotNumberController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    gpsAccuracyController.dispose();
    plotSizeController.dispose();
    coffeeAgeController.dispose();
    additionalInfoController.dispose();
  }
}
