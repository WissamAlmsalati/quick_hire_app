import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final bool? isHaveIcon;
  final String? icon;
  final bool? isHaveBorder;
  final Color? borderColor;
  final double? topPd;
  final double? buttomPd;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor,
      this.width,
      this.height,
      this.fontSize,
      this.borderRadius,
      this.isHaveIcon,
      this.icon,
      this.isHaveBorder,
      this.borderColor,  this.topPd,  this.buttomPd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.only(
          top:topPd ?? 0,
          bottom: buttomPd??0,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(color),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 1.2,

                ),
              ),
            ),
          ),
          child: isHaveIcon == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width * 0.03,
                        icon!),
                    SizedBox(
                      width: width ?? MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(text,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: textColor),)
                  ],
                )
              : Text(text,style: TextStyle(
            fontSize: fontSize,
            color: textColor

          ),),
        ),
      ),
    );
  }
}