import 'package:cam/Screens/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;
late XFile picture;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraScreen(),
    );
  }
}

