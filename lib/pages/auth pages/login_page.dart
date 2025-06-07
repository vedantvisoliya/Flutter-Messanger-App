// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_icon_button.dart';
import 'package:message_app/components/my_text_field.dart';
import 'package:message_app/pages/auth%20pages/phone_signup_page.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatelessWidget {
  final void Function() togglePages;
  LoginPage({
    super.key,
    required this.togglePages,
  });
    
  // controllers
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // login method for email and password
  void login(BuildContext context) async {
    final AuthServices authServices = AuthServices();
    try{
      // ignore: unused_local_variable
      final credential = await authServices.signInWithEmailAndPassword(
        _emailAddress.text, 
        _password.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      authServices.errorDialog(context, e.toString());
    }
  }

  // login method for google
  void loginWithGoogle(BuildContext context) async {
    final AuthServices authServices = AuthServices();
    if (kIsWeb) {
      try{
        // ignore: unused_local_variable
        final credential = await authServices.signInWithGoogleForWeb();
      } catch (e) {
        // ignore: use_build_context_synchronously
        authServices.errorDialog(context, e.toString());
      }
    }
    else {
      try{
        // ignore: unused_local_variable
        final credential = await authServices.signInWithGoogle();
      } catch (e) {
        // ignore: use_build_context_synchronously
        authServices.errorDialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // controllers

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log in",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                         
                const SizedBox(height: 10.0,),
                        
                Text(
                  "Let's talk,", 
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                
                const SizedBox(height: 20.0,),
            
                // email text field
                Text(
                  "Email Address.",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                          
                MyTextField(
                  controller: _emailAddress, 
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
            
                const SizedBox(height: 15.0,),

                // password text field
                Text(
                  "Password.",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                          
                MyTextField(
                  controller: _password, 
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 5.0,),

                // don't have an account sign up
                Row(
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    GestureDetector(
                      onTap: togglePages,
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                // forgot passowrd
                GestureDetector(
                  child: Text(
                    "Forgot Password.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 15.0,),

                // log in button
                MyButton(
                  onTap: () => login(context), 
                  text: "Log in"
                ),

                const SizedBox(height: 5.0,),

                // or continue with
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      )
                    ),
                    Text(
                      " or continue with ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      )
                    ),
                  ],
                ),

                const SizedBox(height: 10.0,),

                // login in with google
                MyIconButton(
                  onTap: () => loginWithGoogle(context),
                  text: "Google", 
                  imagePath: "assets/images/google.png",
                ),

                const SizedBox(height: 10.0,),

                // sign in with phone number
                MyIconButton(
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => PhoneSignupPage(),
                    ),
                  ), 
                  text: "Phone Number", 
                  imagePath: "assets/images/telephone.png",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } 
}