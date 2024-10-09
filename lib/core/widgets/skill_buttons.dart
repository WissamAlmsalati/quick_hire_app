import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_hire/core/utils/constants.dart';

class SkillButtons extends StatelessWidget {
  final String skillName;
  const SkillButtons({super.key, required this.skillName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01), // Add external margin // Add external margin
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: MediaQuery.of(context).size.width * 0.01), // Add internal padding
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColor,
        width: 1.5,
        ), // Add border color
        borderRadius: BorderRadius.circular(30), // Make it a capsule
      ),
      child: Text(
        skillName,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 12,
        ),
      ),
    );
  }
}