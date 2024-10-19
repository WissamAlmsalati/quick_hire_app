import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool obscureText;
  final String? hintText;

  final String? icon;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    required this.obscureText,
    this.validator,
    this.hintText,
    this.icon,
    this.maxLines,
    this.minLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryColor,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: const Color(0xFFFFFFFF),
              filled: true,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.typographyColor.withOpacity(0.50),
                  fontSize: MediaQuery.of(context).size.width * 0.04),
              prefixIcon: icon != null
                  ? Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: SvgPicture.asset(
                  icon!,
                  width: MediaQuery.of(context).size.width * 0.04,
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
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
              counterStyle: TextStyle(color: AppColors.primaryColor),
            ),
            style: TextStyle(
              color: AppColors.typographyColor, // Change the input text color to black
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
              if (maxLength == null || currentLength == null) {
                return null; // Return null to hide the counter if maxLength or currentLength is null
              }
              return Text(
                '${maxLength - currentLength}',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              );
            },
            validator: validator,
            obscureText: obscureText,
            maxLines: obscureText ? 1 : maxLines,
            minLines: obscureText ? 1 : minLines,
            maxLength: maxLength,
          ),
        ),
      ],
    );
  }
}