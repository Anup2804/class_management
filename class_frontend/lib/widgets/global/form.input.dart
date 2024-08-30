import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final String? defaultValidatorMessage;
  final bool obscureText;
  const CustomFormField(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.defaultValidatorMessage = 'This cannot be empty',
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        controller: controller,
        cursorHeight: 22,
        style: Theme.of(context).textTheme.displayMedium,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.red,
            height: 0.1,
          ),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          if (value == null || value.isEmpty) {
            return defaultValidatorMessage;
          }
          return null;
        },
      ),
    );
  }
}
