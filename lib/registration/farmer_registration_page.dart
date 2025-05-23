import 'package:coffee_app/registration/widgets/farm_info_section.dart';
import 'package:coffee_app/registration/widgets/farmer_info_section.dart';
import 'package:coffee_app/registration/widgets/form_controller.dart';
import 'package:coffee_app/registration/widgets/registration_navigation_btns.dart';
import 'package:coffee_app/registration/widgets/registrationn_progress_indicator.dart';
import 'package:flutter/material.dart';

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
  bool _hasLocation = false; // Track location status
  final _farmerInfoFormKey = GlobalKey<FormState>();
  // Form Controllers
  final _farmerControllers = FarmerFormControllers();
  final _farmControllers = FarmFormControllers();

  @override
  void initState() {
    super.initState();
    // Check initial location status
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _farmerControllers.dispose();
    _farmControllers.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _checkLocationStatus() {
    setState(() {
      _hasLocation =
          _farmControllers.latitudeController.text.isNotEmpty &&
          _farmControllers.longitudeController.text.isNotEmpty;
    });
  }

  void _onLocationStatusChanged() {
    _checkLocationStatus();
  }

  void _nextPage() {
    if (_farmerInfoFormKey.currentState!.validate()) {
      // If the form is valid, proceed to the next page
      print('Form is valid! Navigating to next page.');

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If the form is invalid, validation errors will be displayed automatically.
      print('Form is invalid! Please fill all required fields.');
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

  void _showLocationRequiredDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.location_off,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 8),
                const Text('Location Required'),
              ],
            ),
            content: const Text(
              'Please obtain your current location in the Farm Information section before submitting the registration. '
              'This is required for accurate farm mapping and data collection.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to farm information page if not already there
                  if (_currentPageIndex != 1) {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Text('Go to Farm Info'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _submitForm() {
    // First check if location has been obtained
    if (!_hasLocation) {
      _showLocationRequiredDialog();
      return;
    }

    // Then validate the form
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      _processFormSubmission();
    }
  }

  void _processFormSubmission() {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    print('Processing form submission...');
    // Simulate form processing (replace with actual submission logic)
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Farmer registered successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    });
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
                  FarmerInformationSection(
                    controllers: _farmerControllers,
                    formKey: _farmerInfoFormKey,
                  ),
                  FarmInformationSection(
                    controllers: _farmControllers,
                    onLocationStatusChanged: _onLocationStatusChanged,
                  ),
                ],
              ),
            ),
            // Enhanced navigation buttons with location status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Location status indicator (only show on farm info page)
                  if (_currentPageIndex == 1 && !_hasLocation)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.error.withValues(alpha: 0.1),
                        border: Border.all(color: Colors.orange.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_outlined,
                            color: Colors.orange.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Location is required to complete registration',
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  RegistrationNavigationButtons(
                    currentPageIndex: _currentPageIndex,
                    onNext: _nextPage,
                    onPrevious: _previousPage,
                    onSubmit: _submitForm,
                    canSubmit:
                        _hasLocation, // Pass location status to navigation buttons
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
