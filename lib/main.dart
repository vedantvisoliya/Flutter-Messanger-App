import 'package:flutter/material.dart';
import 'package:message_app/pages/get_started_page.dart';
import 'package:message_app/theme/theme_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// running gradle time
// 17.2s
// build time
// 3.7s

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ), 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messanger',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const GetStartedPage(),
    );
  }
}