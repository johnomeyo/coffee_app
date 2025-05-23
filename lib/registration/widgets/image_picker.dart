import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImagePickerWidget extends StatefulWidget {
  List<XFile> selectedImages;
  final ValueChanged<List<XFile>> onImagesChanged;

  ImagePickerWidget({
    Key? key,
    required this.selectedImages,
    required this.onImagesChanged,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      List<XFile> newImages = List.from(widget.selectedImages);

      for (XFile image in images) {
        if (newImages.length < 3) {
          newImages.add(image);
        } else {
          break;
        }
      }

      setState(() {
        widget.selectedImages = newImages;
      });
      widget.onImagesChanged(widget.selectedImages);
    }
  }

  void _removeImage(int index) {
    setState(() {
      widget.selectedImages.removeAt(index);
    });
    widget.onImagesChanged(widget.selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Farm Images (${widget.selectedImages.length}/3)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (widget.selectedImages.length < 3)
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Add Images'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (widget.selectedImages.isEmpty)
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 8),
                Text(
                  'Select 2-3 images of the farm',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
              itemCount: widget.selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(widget.selectedImages[index].path),
                          width: 100,
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
        if (widget.selectedImages.length < 2)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Please select at least 2 images',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
