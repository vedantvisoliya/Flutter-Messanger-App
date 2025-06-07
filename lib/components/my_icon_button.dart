import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double? elevation; 
  final String imagePath;
  const MyIconButton({
    super.key,
    required this.onTap,
    required this.text,
    this.elevation,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: elevation ?? 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 30.0,
                ),
                
                const SizedBox(width: 10.0,),

                Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}