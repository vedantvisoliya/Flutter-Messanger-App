import 'package:flutter/material.dart';
import 'package:message_app/components/my_nav_bar.dart';
import 'package:message_app/pages/messanger_page.dart';
import 'package:message_app/pages/profile_page.dart';
import 'package:message_app/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 1;

  void onTabChange(int index) {
    setState(() {
      _selectedPageIndex = index;      
    });
  }

  final List<Widget> _pages = [
    // setting page
    SettingsPage(),

    // message page,
    MessangerPage(),

    // Profile Page
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: MyNavBar(onTabChange: onTabChange),
      body: _pages[_selectedPageIndex],
    );
  }
}