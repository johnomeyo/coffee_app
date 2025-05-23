import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInputWidget extends StatefulWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController gpsAccuracyController;
  final VoidCallback? onLocationChanged; // Callback for when location is updated

  const LocationInputWidget({
    Key? key,
    required this.latitudeController,
    required this.longitudeController,
    required this.gpsAccuracyController,
    this.onLocationChanged,
  }) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();

  // Method to check if location has been obtained
  bool get hasLocation => 
      latitudeController.text.isNotEmpty && 
      longitudeController.text.isNotEmpty;
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _locationError;
  bool _isLoading = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _locationError = null;
      _isLoading = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationError = 'Location services are disabled.';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationError = 'Location permissions are denied.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Location permissions are permanently denied.';
          _isLoading = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        widget.latitudeController.text = position.latitude.toStringAsFixed(6);
        widget.longitudeController.text = position.longitude.toStringAsFixed(6);
        widget.gpsAccuracyController.text = position.accuracy.toStringAsFixed(2);
        _isLoading = false;
      });

      // Notify parent widget that location has been updated
      widget.onLocationChanged?.call();
    } catch (e) {
      setState(() {
        _locationError = 'Failed to get location: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _InfoBox(
                label: 'Latitude',
                value: widget.latitudeController.text,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _InfoBox(
                label: 'Longitude',
                value: widget.longitudeController.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _InfoBox(
          label: 'GPS Accuracy (meters)',
          value: widget.gpsAccuracyController.text,
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _getCurrentLocation,
          icon: _isLoading 
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.my_location),
          label: Text(_isLoading ? 'Getting Location...' : 'Get Current Location'),
        ),
        if (_locationError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _locationError!,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        // Show location status
        if (widget.hasLocation)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Location obtained',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: style.labelMedium),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: value.isEmpty 
                  ? Colors.grey.shade400 
                  : theme.colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(8),
            color: value.isEmpty 
                ? null 
                : theme.colorScheme.primary.withOpacity(0.05),
          ),
          child: Text(
            value.isEmpty ? 'Not set' : value, 
            style: style.bodyMedium?.copyWith(
              color: value.isEmpty 
                  ? Colors.grey.shade600 
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}