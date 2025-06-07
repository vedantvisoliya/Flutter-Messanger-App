import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/services/auth/auth_services.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // sign out method
  void signOut(BuildContext context) async {
    final AuthServices authServices = AuthServices();

    try{
      await authServices.signOut();
    } catch (e) {
      // ignore: use_build_context_synchronously
      authServices.errorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "S E T T I N G S",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          
        ),
      ),
    );
  }
}