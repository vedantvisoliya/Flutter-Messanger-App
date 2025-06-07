import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_text_field.dart';
import 'package:message_app/services/auth/auth_services.dart';

class SignupPage extends StatelessWidget {
  final void Function() togglePages;
  SignupPage({
    super.key,
    required this.togglePages,
  });

  // controllers
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _name = TextEditingController();

  // sign up method
  void signUp(BuildContext context) async {
    final AuthServices authServices = AuthServices();

    if (_password.text == _confirmPassword.text) {
      try {
        // ignore: unused_local_variable
        final newCredential = await authServices.signUpWithEmailAndPassword(
          _emailAddress.text, 
          _password.text,
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        authServices.errorDialog(context, e.toString());
      }
    }
    else {
      authServices.errorDialog(context, "Password-Not-Matched");
    }
  }

  @override
  Widget build(BuildContext context) {

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
                  "Sign up",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                         
                const SizedBox(height: 10.0,),
                        
                Text(
                  "Create your account.", 
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                
                const SizedBox(height: 10.0,),

                // name text field
                Text(
                  "Name.",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                MyTextField(
                  controller: _name, 
                  hintText: "Name",
                ),

                const SizedBox(height: 10.0,),
            
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
            
                const SizedBox(height: 10.0,),

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
                ),

                const SizedBox(height: 10.0,),

                // confirm password text field
                Text(
                  "Confirm Password.",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                          
                MyTextField(
                  controller: _confirmPassword, 
                  hintText: "Confirm password",
                ),

                const SizedBox(height: 5.0,),

                // already have an account login
                Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    GestureDetector(
                      onTap: togglePages,
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15.0,),

                // sign up button
                MyButton(
                  onTap: () => signUp(context), 
                  text: "Sign up"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}