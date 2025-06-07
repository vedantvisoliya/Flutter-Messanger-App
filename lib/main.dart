import 'package:flutter/material.dart';
import 'package:message_app/pages/get_started_page.dart';
import 'package:message_app/theme/light_mode.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// running gradle time
// 17.2s
// build time
// 3.7s

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messanger',
      theme: lightMode,
      home: const GetStartedPage(),
    );
  }
}