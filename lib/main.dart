import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forge_recall/app/main_app.dart';
import 'package:forge_recall/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}
