import 'package:flutter/material.dart';
import 'package:quick_hire/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final Color textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;

  const CustomButton(
      {super.key, required this.text, required this.onPressed, required this.color, required this.textColor, this.width, this.height, this.fontSize, this.borderRadius});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
      child: Text(text),);
  }
}