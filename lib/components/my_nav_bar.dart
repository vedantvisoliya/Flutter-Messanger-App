import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const MyNavBar({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: GNav(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        selectedIndex: 1,
        onTabChange: onTabChange,
        color: Theme.of(context).colorScheme.primary,
        activeColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          GButton(
            icon: Icons.settings,
          ),
          GButton(
            icon: Icons.chat_bubble,
          ),
          GButton(
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}