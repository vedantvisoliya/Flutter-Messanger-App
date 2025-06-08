import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:message_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
          children: [
            // dark mode toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DarkMode",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
                    onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                  ),
                ],
              ),
            ),

            // log out
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () => signOut(context), 
                    icon: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ], 
        ),
      ),
    );
  }
}