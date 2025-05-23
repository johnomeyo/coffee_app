import 'package:coffee_app/registration/widgets/farm_info_section.dart';
import 'package:coffee_app/registration/widgets/farmer_info_section.dart';
import 'package:coffee_app/registration/widgets/navigation_buttons.dart';
import 'package:coffee_app/registration/widgets/registrationn_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Main Registration Page
class FarmerRegistrationPage extends StatefulWidget {
  const FarmerRegistrationPage({Key? key}) : super(key: key);

  @override
  State<FarmerRegistrationPage> createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentPageIndex = 0;

  // Form Controllers
  final _farmerControllers = FarmerFormControllers();
  final _farmControllers = FarmFormControllers();

  @override
  void dispose() {
    _farmerControllers.dispose();
    _farmControllers.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPageIndex < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farmer registered successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Registration'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            RegistrationProgressIndicator(
              currentStep: _currentPageIndex,
              totalSteps: 2,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [
                  FarmerInformationSection(controllers: _farmerControllers),
                  FarmInformationSection(controllers: _farmControllers),
                ],
              ),
            ),
            RegistrationNavigationButtons(
              currentPageIndex: _currentPageIndex,
              onNext: _nextPage,
              onPrevious: _previousPage,
              onSubmit: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}









// Form Controllers Classes
class FarmerFormControllers {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController villageController = TextEditingController();

  String? selectedGender;
  DateTime? selectedDate;

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
  List<XFile> selectedImages = [];

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
