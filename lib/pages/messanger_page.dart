import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_dialog_box.dart';
import 'package:message_app/components/my_user_tile.dart';
import 'package:message_app/pages/chat_page.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:message_app/services/chat/chat_service.dart';

// ignore: must_be_immutable
class MessangerPage extends StatelessWidget {
  MessangerPage({super.key});

  // chat service
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Messanger",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showDialog(context: context, builder: (context) => MyDialogBox()),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.tertiary),
      ),
      body: _buildUserList(context),
    );
  }

  // build user list
  Widget _buildUserList(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // Error case
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong!"));
        }

        // Loading case
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Empty list case
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No users found."));
        }

        // Build user list
        final users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index];
            return _buildUserListItem(context, userData);
          },
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(BuildContext context, Map<String, dynamic> userData) {
    // display all users except the current user
    final String userName = userData['name'].toString().toUpperCase();
    if (userData['email'] != _authServices.getCurrentUser()!.email){
      return MyUserTile(
        onTap: () => Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: userName,
              receiverId: userData['uid'],
            ),
          ),
        ), 
        userName: userData['name'],
        userEmail: userData['email'],
      );
    }
    else {
      return Container();
    }
  }
}
