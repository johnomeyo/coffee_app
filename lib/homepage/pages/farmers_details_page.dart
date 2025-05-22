import 'package:coffee_app/models/data_models.dart' show Farm, Farmer; // Assuming these models exist
import 'package:flutter/material.dart';

// --- Main Page ---
class FarmerDetailsPage extends StatelessWidget {
  final Farmer farmer;

  const FarmerDetailsPage({super.key, required this.farmer});

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Renamed context to avoid conflict
        return ImageDialogContent(imageUrl: imageUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(farmer.fullName),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FarmerInfoCard(farmer: farmer),
            const SizedBox(height: 24),
            FarmsSection(
              farms: farmer.farms,
              onImageTap: (imageUrl) => _showImageDialog(context, imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Modular Widgets ---

// 1. Farmer Info Card
class FarmerInfoCard extends StatelessWidget {
  final Farmer farmer;

  const FarmerInfoCard({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farmer.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Registration: ${farmer.registrationNumber}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            DetailRow(label: 'Age', value: '${farmer.age} years'),
            DetailRow(label: 'Gender', value: farmer.gender),
            DetailRow(label: 'Village', value: farmer.village),
            DetailRow(
                label: 'Date of Birth',
                value:
                    '${farmer.dateOfBirth.day}/${farmer.dateOfBirth.month}/${farmer.dateOfBirth.year}'),
            DetailRow(label: 'Total Farms', value: '${farmer.farms.length}'),
          ],
        ),
      ),
    );
  }
}

// 2. Detail Row (for Farmer Info)
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Farms Section
class FarmsSection extends StatelessWidget {
  final List<Farm> farms;
  final Function(String imageUrl) onImageTap;

  const FarmsSection(
      {super.key, required this.farms, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    if (farms.isEmpty) {
      return const Center(child: Text('No farms registered yet.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farms Owned',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: farms.length,
          itemBuilder: (context, index) {
            return FarmInfoCard(
                farm: farms[index], onImageTap: onImageTap);
          },
        ),
      ],
    );
  }
}

// 4. Farm Info Card
class FarmInfoCard extends StatelessWidget {
  final Farm farm;
  final Function(String imageUrl) onImageTap;

  const FarmInfoCard(
      {super.key, required this.farm, required this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    farm.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: farm.isApproved
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    farm.isApproved ? 'Approved' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: farm.isApproved
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FarmDetailRow(label: 'Size', value: '${farm.size} acres'),
            FarmDetailRow(label: 'Crop Type', value: farm.cropType),
            FarmDetailRow(label: 'Location', value: farm.location),
            if (farm.additionalInfo != null &&
                farm.additionalInfo!.isNotEmpty) ...[
              const SizedBox(height: 8),
              FarmDetailRow(
                  label: 'Additional Info', value: farm.additionalInfo!),
            ],
            if (farm.images.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Farm Images',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: farm.images.length,
                  itemBuilder: (context, index) {
                    return ImageThumbnail(
                      imageUrl: farm.images[index],
                      onTap: () => onImageTap(farm.images[index]),
                    );
                  },
                ),
              ),
            ],
            if (!farm.isApproved) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: Icon(Icons.edit, size: 18, color: Theme.of(context).colorScheme.primary),
                  label: Text('Edit Farm', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5))
                    )
                  ),
                  onPressed: () {
                    // TODO: Implement farm edit functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit farm: ${farm.name}')),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// 5. Farm Detail Row
class FarmDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const FarmDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 6. Image Thumbnail
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
          color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3), // Placeholder color
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.5),
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Theme.of(context).colorScheme.onErrorContainer.withOpacity(0.7),
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

// 7. Image Dialog Content
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
            onTap: () => Navigator.of(context).pop(), // Close on tap outside image
            child: Container(color: Colors.transparent), // Catches taps
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, // Max width
            height: MediaQuery.of(context).size.height * 0.7, // Max height
            child: ClipRRect( // Apply rounded corners to the image container
              borderRadius: BorderRadius.circular(12.0),
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain, // Ensure whole image is visible
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
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
                          const Text("Image couldn't be loaded.", textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 20, // Adjust position to be safely within dialog bounds
            right: 20,
            child: Material( // Material for InkWell splash
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
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
