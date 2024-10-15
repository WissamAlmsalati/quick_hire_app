import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/constants.dart';

class SkillButtons extends StatelessWidget {
  final String skillName;
  final String? iconPath;

  const SkillButtons({
    super.key,
    required this.skillName,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            skillName,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
        ),
        if (iconPath != null)
          Positioned(
            top: -10,
            left: -10,
            child: SvgPicture.asset(
              iconPath!,
              width: 20,
              height: 20,
            ),
          ),
      ],
    );
  }
}