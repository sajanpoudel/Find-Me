import 'package:flutter/material.dart';
import 'package:mobileapp/routes.dart';
import 'package:mobileapp/screens/splash/prompt_screen.dart';
import 'package:mobileapp/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// The my app widget shared between screens.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Me',
      theme: theme(),
      home: const PromptScreen(),
      // Named routes are listed in routes.dart
      routes: routes,
    );
  }
}
