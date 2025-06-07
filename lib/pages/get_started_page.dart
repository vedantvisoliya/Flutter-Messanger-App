import 'package:flutter/material.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/services/auth/auth_gate.dart';
import 'package:message_app/services/auth/login_or_register_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                "assets/images/comment.png" ,
                width: 120,
              ),
          
              const SizedBox(height: 30.0,),
          
              // Let's Get Started message
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          
                  Text(
                    "Communicate with friends & family",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                  ),
          
                  Text(
                    "with fast, secure experience.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 50.0,),
          
              // get started button 
              MyButton(
                onTap: () => Navigator.pushReplacement(context, 
                MaterialPageRoute(
                  builder: (context) => AuthGate(),
                )), 
                text: "Get Started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}