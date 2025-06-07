import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? obscureText;
  final String? hintText;
  final int? maxLength;
  final double? width;
  final bool? readOnly;
  final TextAlign? textAlign;
  const MyTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.focusNode,
    this.obscureText,
    this.hintText,
    this.maxLength,
    this.width,
    this.readOnly,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        textAlign: textAlign ?? TextAlign.start,
        readOnly: readOnly ?? false,
        maxLength: maxLength,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlue,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
        ),      
      ),
    );
  }
}