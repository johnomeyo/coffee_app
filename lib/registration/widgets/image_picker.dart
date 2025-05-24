// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// // ignore: must_be_immutable
// class ImagePickerWidget extends StatefulWidget {
//   List<XFile> selectedImages;
//   final ValueChanged<List<XFile>> onImagesChanged;

//   ImagePickerWidget({
//     Key? key,
//     required this.selectedImages,
//     required this.onImagesChanged,
//   }) : super(key: key);

//   @override
//   State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
// }

// class _ImagePickerWidgetState extends State<ImagePickerWidget> {
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _showImageSourceDialog() async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Image Source'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _captureImage();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImages();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _captureImage() async {
//     if (widget.selectedImages.length >= 3) return;
    
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       List<XFile> newImages = List.from(widget.selectedImages);
//       newImages.add(image);
      
//       setState(() {
//         widget.selectedImages = newImages;
//       });
//       widget.onImagesChanged(widget.selectedImages);
//     }
//   }

//   Future<void> _pickImages() async {
//     int remainingSlots = 3 - widget.selectedImages.length;
//     if (remainingSlots <= 0) return;

//     final List<XFile> images = await _picker.pickMultiImage();
//     if (images.isNotEmpty) {
//       List<XFile> newImages = List.from(widget.selectedImages);

//       for (XFile image in images) {
//         if (newImages.length < 3) {
//           newImages.add(image);
//         } else {
//           break;
//         }
//       }

//       setState(() {
//         widget.selectedImages = newImages;
//       });
//       widget.onImagesChanged(widget.selectedImages);
//     }
//   }

//   void _removeImage(int index) {
//     setState(() {
//       widget.selectedImages.removeAt(index);
//     });
//     widget.onImagesChanged(widget.selectedImages);
//   }

//   bool get _canAddMoreImages => widget.selectedImages.length < 3;
//   bool get _hasMinimumImages => widget.selectedImages.length >= 2;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Farm Images (${widget.selectedImages.length}/3)',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             if (_canAddMoreImages)
//               ElevatedButton.icon(
//                 onPressed: _showImageSourceDialog,
//                 icon: const Icon(Icons.add_a_photo),
//                 label: const Text('Add Images'),
//               ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         if (widget.selectedImages.isEmpty)
//           Container(
//             height: 120,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Theme.of(context).colorScheme.outline,
//                 style: BorderStyle.solid,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: InkWell(
//               onTap: _showImageSourceDialog,
//               borderRadius: BorderRadius.circular(8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.camera_alt_outlined,
//                     size: 48,
//                     color: Theme.of(context).colorScheme.onSurfaceVariant,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Capture or select 2-3 images of the farm',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Tap to get started',
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         else
//           Column(
//             children: [
//               SizedBox(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: widget.selectedImages.length + (_canAddMoreImages ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == widget.selectedImages.length) {
//                       // Add more button
//                       return Container(
//                         margin: const EdgeInsets.only(right: 8),
//                         child: InkWell(
//                           onTap: _showImageSourceDialog,
//                           borderRadius: BorderRadius.circular(8),
//                           child: Container(
//                             width: 100,
//                             height: 120,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Theme.of(context).colorScheme.outline,
//                                 // style: BorderStyle.dashed,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.add,
//                                   size: 32,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   'Add More',
//                                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                     color: Theme.of(context).colorScheme.primary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
                    
//                     return Container(
//                       margin: const EdgeInsets.only(right: 8),
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.file(
//                               File(widget.selectedImages[index].path),
//                               width: 100,
//                               height: 120,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Positioned(
//                             top: 4,
//                             right: 4,
//                             child: GestureDetector(
//                               onTap: () => _removeImage(index),
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.withOpacity(0.8),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Icon(
//                                   Icons.close,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         const SizedBox(height: 8),
//         // Status messages
//         if (!_hasMinimumImages && widget.selectedImages.isNotEmpty)
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.errorContainer,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.warning_outlined,
//                   size: 16,
//                   color: Theme.of(context).colorScheme.error,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     'Please select at least ${2 - widget.selectedImages.length} more image(s)',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.error,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         else if (_hasMinimumImages)
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primaryContainer,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.check_circle_outlined,
//                   size: 16,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     'Great! You have selected ${widget.selectedImages.length} image(s)',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImagePickerWidget extends StatefulWidget {
  List<String> selectedImages;
  final ValueChanged<List<String>> onImagesChanged;

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

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _captureImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImages();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureImage() async {
    if (widget.selectedImages.length >= 3) return;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      List<String> newImages = List.from(widget.selectedImages);
      newImages.add(image.path);

      setState(() {
        widget.selectedImages = newImages;
      });
      widget.onImagesChanged(widget.selectedImages);
    }
  }

  Future<void> _pickImages() async {
    int remainingSlots = 3 - widget.selectedImages.length;
    if (remainingSlots <= 0) return;

    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      List<String> newImages = List.from(widget.selectedImages);

      for (XFile image in images) {
        if (newImages.length < 3) {
          newImages.add(image.path);
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

  bool get _canAddMoreImages => widget.selectedImages.length < 3;
  bool get _hasMinimumImages => widget.selectedImages.length >= 2;

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
            if (_canAddMoreImages)
              ElevatedButton.icon(
                onPressed: _showImageSourceDialog,
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
            child: InkWell(
              onTap: _showImageSourceDialog,
              borderRadius: BorderRadius.circular(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Capture or select 2-3 images of the farm',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to get started',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Column(
            children: [
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.selectedImages.length + (_canAddMoreImages ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == widget.selectedImages.length) {
                      // Add more button
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: _showImageSourceDialog,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                                // style: BorderStyle.dashed,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 32,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Add More',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(widget.selectedImages[index]),
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
                                  color: Colors.red.withOpacity(0.8),
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
          ),
        const SizedBox(height: 8),
        // Status messages
        if (!_hasMinimumImages && widget.selectedImages.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Please select at least ${2 - widget.selectedImages.length} more image(s)',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          )
        else if (_hasMinimumImages)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Great! You have selected ${widget.selectedImages.length} image(s)',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}