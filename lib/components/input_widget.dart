import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final IconButton? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const InputWidget({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.keyboardType,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}
