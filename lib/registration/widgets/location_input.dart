
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInputWidget extends StatefulWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController gpsAccuracyController;

  const LocationInputWidget({
    Key? key,
    required this.latitudeController,
    required this.longitudeController,
    required this.gpsAccuracyController,
  }) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _locationError;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _locationError = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationError = 'Location services are disabled.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationError = 'Location permissions are denied.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Location permissions are permanently denied.';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      widget.latitudeController.text = position.latitude.toStringAsFixed(6);
      widget.longitudeController.text = position.longitude.toStringAsFixed(6);
      widget.gpsAccuracyController.text = position.accuracy.toStringAsFixed(2);
    } catch (e) {
      setState(() {
        _locationError = 'Failed to get location: $e';
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
          onPressed: _getCurrentLocation,
          icon: const Icon(Icons.my_location),
          label: const Text('Get Current Location'),
        ),
        if (_locationError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _locationError!,
              style: TextStyle(color: theme.colorScheme.error),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: style.labelMedium),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value.isEmpty ? 'N/A' : value, style: style.bodyMedium),
        ),
      ],
    );
  }
}
