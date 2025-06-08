import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_text_field.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:message_app/services/chat/chat_service.dart';

class MyDialogBox extends StatelessWidget {
  MyDialogBox({super.key});

  final TextEditingController emailController = TextEditingController();

  void addUser(BuildContext context, String email) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ChatService _chatService = ChatService();
    // ignore: no_leading_underscores_for_local_identifiers
    final AuthServices _authService = AuthServices();

    try{
      await _chatService.addUserToPeopleByEmail(email);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      _authService.errorDialog(context, "User-Not-Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.secondary,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add User.",
                style: GoogleFonts.robotoSlab(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10.0,),
              
              MyTextField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => addUser(context, emailController.text),
                    child: Text(
                      "Add",
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}