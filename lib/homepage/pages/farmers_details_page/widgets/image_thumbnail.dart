import 'package:flutter/material.dart';

class ImageThumbnail extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const ImageThumbnail(
      {super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120, // Ensure consistent height
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.3), // Placeholder color
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.5),
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Theme.of(context).colorScheme.onErrorContainer.withValues(alpha: 0.7),
                  size: 40,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}