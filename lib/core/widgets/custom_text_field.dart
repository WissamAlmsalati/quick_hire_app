import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(labelText),
      Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Color(0xFFFFFFFF),
            filled: true,
            hintText: labelText,
            // Use hintText instead of labelText
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.10),
                  width: MediaQuery.of(context).size.width * 0.0041),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.10),
                  width: MediaQuery.of(context).size.width * 0.0041),
            ),
          ),
          validator: validator,
          obscureText: obscureText,
        ),
      ),
    ]);
  }
}
