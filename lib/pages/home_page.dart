import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/services/auth/auth_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Messanger",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => signOut(context), 
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      // bottomNavigationBar: ,
      // body: ,
    );
  }
}