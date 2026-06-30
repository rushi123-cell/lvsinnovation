import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: For a complete working Firebase app, you need to run `flutterfire configure`
  // and provide the generated firebase_options.dart. 
  // I will initialize Firebase without options as a placeholder to allow building the UI.
  // It will throw an exception at runtime if not properly configured on the native side.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization error (often due to missing flutterfire configure): $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alive Streaming',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
