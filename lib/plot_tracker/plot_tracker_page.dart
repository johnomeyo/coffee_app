import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CoffeePlotTrackerHome extends StatefulWidget {
  @override
  _CoffeePlotTrackerHomeState createState() => _CoffeePlotTrackerHomeState();
}

class _CoffeePlotTrackerHomeState extends State<CoffeePlotTrackerHome> {
  bool _isOnline = false;
  int _pendingSyncPlots = 5; // Example value for pending sync plots
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
// _connectivitySubscription = Connectivity()
//     .onConnectivityChanged
//     .listen((List<ConnectivityResult> result) {
//   setState(() {
//     _isOnline = result.isNotEmpty && result[0] != ConnectivityResult.none;
//   });
// });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  void _syncAll() {
    // Simulate syncing plots
    setState(() {
      _pendingSyncPlots = 0; // Reset pending plots after sync
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All plots synced successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with settings icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Coffee Plot Tracker',
                    style: theme.textTheme.headlineLarge,
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.black54),
                    onPressed: () {
                      // Navigate to settings or handle settings action
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Collect data easily, even offline!',
                style: theme.textTheme.bodyMedium,
              ),
              Spacer(),
              // View Saved Plots Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to saved plots screen
                  },
                  icon: Icon(Icons.list, color: Colors.white),
                  label: Text(
                    'View Saved Plots',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Sync All Button (visible only when online)
              if (_isOnline)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _pendingSyncPlots > 0 ? _syncAll : null,
                    icon: Icon(Icons.sync, color: Colors.white),
                    label: Text(
                      'Sync All',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              Spacer(),
              // Internet Status and Pending Sync
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Internet: ',
                        style: theme.textTheme.bodySmall,
                      ),
                      Icon(
                        Icons.wifi,
                        color: _isOnline ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        _isOnline ? 'Online' : 'Offline',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Text(
                    'Pending Sync: $_pendingSyncPlots plots',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _pendingSyncPlots > 0 ? Colors.green : Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}