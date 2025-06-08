import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final void Function() onTap;
  final String userName;
  final String userEmail;
  const MyUserTile({
    super.key,
    required this.onTap,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            // icon
            Icon(Icons.person),

            const SizedBox(width: 10.0,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // user name
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userEmail,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}