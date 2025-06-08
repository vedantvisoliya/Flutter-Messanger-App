import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app/components/my_chat_bubble.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:message_app/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String receiverId;
  const ChatPage({super.key, required this.userName, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //controller
  final TextEditingController _message = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // auth service & chat service
  final AuthServices _authServices = AuthServices();
  final ChatService _chatService = ChatService();

  // keep track of previous message count
  int _previousMessageCount = 0;

  // user db id variable
  String? userDbId;

  // focus node
  FocusNode myFocusNode = FocusNode();

  void sendMessage() async {
    if (_message.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(widget.receiverId, _message.text);
    }

    // clear the controller after each send
    _message.clear();

    // scroll down after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollDown();
    });
  }

  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode.requestFocus();
    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // wait a bit for listview to build, then scroll to the bottom
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _message.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            widget.userName,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                // display all the message
                Expanded(
                  child: _buildMessageList(),
                ),
                _buildUserInput(),
              ],
            ),
          ),
        ),
      );
    }
  

  // build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              Expanded(
                child: TextField(
                  focusNode: myFocusNode,
                  controller: _message,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Message",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),

              const SizedBox(width: 15.0),

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: KeyboardListener(
                  focusNode: myFocusNode,
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
                      sendMessage();
                    }
                  },
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    final String senderId = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(senderId, widget.receiverId,),
      builder: (context, snapshot) {
        // check for errors
        if (snapshot.hasError) {
          return Center(child: const Text("Something went wrong!"));
        }

        // check for connection state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // check if we have new messages and scroll down
        if (snapshot.hasData) {
          final currentMessageCount = snapshot.data!.docs.length;

          // if we have a new message, scroll down after the frame is built
          if (currentMessageCount > _previousMessageCount) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollDown();
            });
          }
          _previousMessageCount = currentMessageCount;
        }

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    // screen width
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // if the sender is the current user then display the message on the right
    bool isCurrentUser = data['senderId'] == _authServices.getCurrentUser()!.uid;
    return Container(
      margin: isCurrentUser ? EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0):EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          MyChatBubble(
            message: data['message'], 
            screenWidth: screenWidth,
            isCurrentUser: isCurrentUser,
          ),
        ],
      ),
    );
  }
}
