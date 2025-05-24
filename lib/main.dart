import 'package:coffee_app/firebase_options.dart';
import 'package:coffee_app/models/data_models.dart';
import 'package:coffee_app/services/auth_gate.dart';
import 'package:coffee_app/services/hive_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize Hive
  await Hive.initFlutter();

  // Register the Farmer adapter (assuming Farmer is a Hive type)
  Hive.registerAdapter(FarmerAdapter());
  Hive.registerAdapter(FarmAdapter());

  // Open the farmersBox
  await Hive.openBox<Farmer>(HiveStorage.farmersBoxName);
  await Hive.openBox<Farm>(HiveStorage.farmsBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade700,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const AuthGate(),
    );
  }
}
