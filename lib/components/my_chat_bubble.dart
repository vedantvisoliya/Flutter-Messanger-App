import 'package:flutter/material.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final double screenWidth;
  final bool isCurrentUser;
  const MyChatBubble({
    super.key,
    required this.message,
    required this.screenWidth,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth - (screenWidth / 4)),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isCurrentUser ? Theme.of(context).colorScheme.inversePrimary: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser? Theme.of(context).colorScheme.tertiary:Theme.of(context).colorScheme.inversePrimary,
        ),
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
