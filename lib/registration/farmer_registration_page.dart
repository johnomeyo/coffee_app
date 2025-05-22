import 'dart:io';

import 'package:coffee_app/models/data_models.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

// Main Registration Page
class FarmerRegistrationPage extends StatefulWidget {
  const FarmerRegistrationPage({super.key});

  @override
  State<FarmerRegistrationPage> createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  
  // Farmer form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _registrationController = TextEditingController();
  final _villageController = TextEditingController();
  
  String _selectedGender = 'Male';
  DateTime? _selectedDate;
  
  // Farm form controllers
  final _farmNameController = TextEditingController();
  final _farmSizeController = TextEditingController();
  final _cropTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  
  List<File> _farmImages = [];
  bool _isLocationLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _registrationController.dispose();
    _villageController.dispose();
    _farmNameController.dispose();
    _farmSizeController.dispose();
    _cropTypeController.dispose();
    _locationController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Farmer Registration',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.primaryColor,
          labelColor: theme.primaryColor,
          unselectedLabelColor: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
          tabs: const [
            Tab(text: 'Personal Info'),
            Tab(text: 'Farm Details'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildPersonalInfoTab(),
            _buildFarmDetailsTab(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (_tabController.index == 1)
              Expanded(
                child: CustomButton(
                  text: 'Previous',
                  // onPressed: () => _tabController.previousPage(),
                  onPressed: () {
                    _tabController.animateTo(0);
                    _formKey.currentState?.reset();
                  },
                  isOutlined: true,
                ),
              ),
            if (_tabController.index == 1) const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                text: _tabController.index == 0 ? 'Next' : 'Submit',
                onPressed: _tabController.index == 0
                    ? _handleNext
                    : _handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Personal Information'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'First name is required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Last name is required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _registrationController,
            label: 'Registration Number',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Registration number is required' : null,
          ),
          const SizedBox(height: 16),
          GenderSelector(
            selectedGender: _selectedGender,
            onChanged: (value) => setState(() => _selectedGender = value),
          ),
          const SizedBox(height: 16),
          DateSelector(
            selectedDate: _selectedDate,
            onChanged: (date) => setState(() => _selectedDate = date),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _villageController,
            label: 'Village',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Village is required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildFarmDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Farm Information'),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _farmNameController,
            label: 'Farm Name',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Farm name is required' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _farmSizeController,
                  label: 'Farm Size (acres)',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Farm size is required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: _cropTypeController,
                  label: 'Crop Type',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Crop type is required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LocationField(
            controller: _locationController,
            isLoading: _isLocationLoading,
            onGetLocation: _getCurrentLocation,
          ),
          const SizedBox(height: 16),
          ImagePicker(
            images: _farmImages,
            onImagesChanged: (images) => setState(() => _farmImages = images),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _additionalInfoController,
            label: 'Additional Information (Optional)',
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  void _handleNext() {
    if (_validatePersonalInfo()) {
      // _tabController.nextPage();
      _tabController.animateTo(1);
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_farmImages.isEmpty) {
        _showSnackBar('Please add at least one farm image');
        return;
      }
      if (_locationController.text.isEmpty) {
        _showSnackBar('Please set farm location');
        return;
      }
      
      // Create farmer and farm objects
      final farmer = _createFarmer();
      _showSnackBar('Registration completed successfully!');
      // Handle submission logic here
    }
  }

  bool _validatePersonalInfo() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _registrationController.text.isEmpty ||
        _villageController.text.isEmpty ||
        _selectedDate == null) {
      _showSnackBar('Please fill all required fields');
      return false;
    }
    return true;
  }

  Farmer _createFarmer() {
    final farm = Farm(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _farmNameController.text,
      size: double.parse(_farmSizeController.text),
      cropType: _cropTypeController.text,
      images: _farmImages.map((e) => e.path).toList(),
      location: _locationController.text,
      isApproved: false,
      additionalInfo: _additionalInfoController.text.isEmpty
          ? null
          : _additionalInfoController.text,
    );

    return Farmer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      registrationNumber: _registrationController.text,
      gender: _selectedGender,
      dateOfBirth: _selectedDate!,
      village: _villageController.text,
      farms: [farm],
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLocationLoading = true);
    
    try {
      final permission = await Permission.location.request();
      if (permission.isGranted) {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _locationController.text = '${position.latitude},${position.longitude}';
      } else {
        _showSnackBar('Location permission denied');
      }
    } catch (e) {
      _showSnackBar('Failed to get location: $e');
    } finally {
      setState(() => _isLocationLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// Custom Widgets
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: theme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        filled: true,
        fillColor: theme.cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      height: 48,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }
}

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const GenderSelector({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: ['Male', 'Female', 'Other'].map((gender) {
            return Expanded(
              child: RadioListTile<String>(
                title: Text(gender),
                value: gender,
                groupValue: selectedGender,
                onChanged: (value) => onChanged(value!),
                activeColor: theme.primaryColor,
                contentPadding: EdgeInsets.zero,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onChanged;

  const DateSelector({
    Key? key,
    required this.selectedDate,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: CustomTextField(
        controller: TextEditingController(
          text: selectedDate != null
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : '',
        ),
        label: 'Date of Birth',
        readOnly: true,
        validator: (value) =>
            selectedDate == null ? 'Date of birth is required' : null,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      onChanged(date);
    }
  }
}

class LocationField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onGetLocation;

  const LocationField({
    Key? key,
    required this.controller,
    required this.isLoading,
    required this.onGetLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: controller,
            label: 'Farm Location (lat,long)',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Location is required' : null,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: isLoading ? null : onGetLocation,
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.my_location, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ImagePicker extends StatelessWidget {
  final List<File> images;
  final ValueChanged<List<File>> onImagesChanged;

  const ImagePicker({
    Key? key,
    required this.images,
    required this.onImagesChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Farm Images',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton.icon(
              onPressed: () => _showImageSourceDialog(context),
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text('Add Image'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (images.isEmpty)
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor, style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  'No images added yet',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          images[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                // _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                // _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

    // Future<void> _pickImage(ImageSource source) async {
    //   final picker = ImagePicker().;
    //   final pickedFile = await picker.pickImage(source: source);
      
    //   if (pickedFile != null) {
    //     final newImages = List<File>.from(images)..add(File(pickedFile.path));
    //     onImagesChanged(newImages);
    //   }
    // }

  void _removeImage(int index) {
    final newImages = List<File>.from(images)..removeAt(index);
    onImagesChanged(newImages);
  }
}