import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_text_field.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpVerifPage extends StatelessWidget {
  OtpVerifPage({super.key});

  // auth services instance
  final AuthServices _authServices = AuthServices();

  // controllers
  final TextEditingController _digit1 = TextEditingController();
  final TextEditingController _digit2 = TextEditingController();
  final TextEditingController _digit3 = TextEditingController();
  final TextEditingController _digit4 = TextEditingController();
  final TextEditingController _digit5 = TextEditingController();
  final TextEditingController _digit6 = TextEditingController();

  
  void verifyOTP(BuildContext context, String otp) async {
    try{
      // ignore: unused_local_variable
      UserCredential? userCredential = await _authServices.signInWithOTP(
        otp: otp,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      _authServices.errorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // otp 
    // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
    String _otp; 

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "OTP Verification",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // otp
              Text(
                "OTP.",
                style: GoogleFonts.robotoSlab(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5.0,),

              // otp text field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextField(
                    controller: _digit1,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    width: 40,
                    textAlign: TextAlign.center,
                  ),

                  MyTextField(
                    controller: _digit2,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    width: 40,
                    textAlign: TextAlign.center,
                  ),

                  MyTextField(
                    controller: _digit3,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    width: 40,
                    textAlign: TextAlign.center,
                  ),

                  MyTextField(
                    controller: _digit4,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    width: 40,
                    textAlign: TextAlign.center,
                  ),

                  MyTextField(
                    controller: _digit5,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    width: 40,
                    textAlign: TextAlign.center,
                  ),

                  MyTextField(
                    controller: _digit6,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    width: 40,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 10.0,),

              Center(
                child: Text(
                  "enter OTP.",
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),

              const SizedBox(height: 25.0,),

              // send otp button
              MyButton(
                onTap: () {
                  _otp = "${_digit1.text}${_digit2.text}${_digit3.text}${_digit4.text}${_digit5.text}${_digit6.text}";
                  // verifyOTP(context, _otp);
                },
                text: "verify",
              ),
            ],
          ),
        ),
      ), 
    );
  }
}