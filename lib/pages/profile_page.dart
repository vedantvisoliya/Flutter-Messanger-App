import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "P R O F I L E",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}