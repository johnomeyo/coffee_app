import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FarmerImagePicker extends StatefulWidget {
  final Function(String path) onImageSelected;
  final String? initialPath;

  const FarmerImagePicker({
    Key? key,
    required this.onImageSelected,
    this.initialPath,
  }) : super(key: key);

  @override
  State<FarmerImagePicker> createState() => _FarmerImagePickerState();
}

class _FarmerImagePickerState extends State<FarmerImagePicker> {
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      widget.onImageSelected(pickedFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialPath;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Farmer Image',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_imagePath!),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.add_a_photo, size: 40),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
