import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_text_field.dart';
import 'package:message_app/pages/auth%20pages/otp_verif_page.dart';
import 'package:message_app/services/auth/auth_services.dart';

class PhoneSignupPage extends StatelessWidget {
  PhoneSignupPage({super.key});

  // controllers
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _countryCode = TextEditingController();

  // auth instance
  final AuthServices authServices = AuthServices();

  void sendOTP(BuildContext context, String countryCode, String phoneNumber) async {
    try {
      await authServices.verifyPhoneNumber(
        phoneNumber: "$countryCode$phoneNumber",
        onAutoVerify: (credential) async {
          // Auto verification completed
          await authServices.signInWithCredential(credential);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      authServices.errorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _countryCode.text = "+91";
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Phone Verification",
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
              // phone number
              Text(
                "Phone number.",
                style: GoogleFonts.robotoSlab(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5.0,),

              // phone number text field
              Row(
                children: [
                  MyTextField(
                    controller: _countryCode, 
                    width: 50,
                    readOnly: true,
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(width: 20.0,),

                  Expanded(
                    child: MyTextField(
                      controller: _phoneNumber,
                      keyboardType: TextInputType.number,
                      hintText: "Number",
                      maxLength: 10,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10.0,),

              Center(
                child: Column(
                  // crossAxisAlignment: ,
                  children: [
                    Text(
                      "enter you phone number,",
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "an OTP will be send for verification.",
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25.0,),

              // send otp button
              MyButton(
                onTap: () {
                  if (_phoneNumber.text.length == 10) {
                    // sendOTP(context, _countryCode.text, _phoneNumber.text);
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => OtpVerifPage(),
                      ),
                    );
                  }
                  else {
                    authServices.errorDialog(context, "Invalid-Phone-Number");
                  }
                },
                text: "Send OTP",
              ),
            ],
          ),
        ),
      ), 
    );
  }
}