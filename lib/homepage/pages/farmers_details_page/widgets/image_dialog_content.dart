import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialogContent extends StatelessWidget {
  final String imageUrl;

  const ImageDialogContent({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10), // Reduce padding around dialog
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap:
                () => Navigator.of(context).pop(), // Close on tap outside image
            child: Container(color: Colors.transparent), // Catches taps
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, // Max width
            height: MediaQuery.of(context).size.height * 0.7, // Max height
            child: ClipRRect(
              // Apply rounded corners to the image container
              borderRadius: BorderRadius.circular(12.0),
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.file(
                  File(imageUrl),
                  fit: BoxFit.contain, // Ensure whole image is visible
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                            size: 60,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Image couldn't be loaded.",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Material(
              // Material for InkWell splash
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
