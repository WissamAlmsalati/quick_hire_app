import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/constants.dart';

import '../../../../core/utils/app_icon.dart';

class JobOfferCard extends StatelessWidget {
  final String jobTitle;
  final String jobDescription;
  final String budgetMax;
  final String budgetMin;
  const JobOfferCard({super.key, required this.jobTitle, required this.jobDescription, required this.budgetMax, required this.budgetMin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          jobTitle,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: 10),
        Text(
          jobDescription,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: AppColors.typographyColor,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(AppIcons.coinIcon, width: 30,

            ),
            SizedBox(width: 5),
            Text(
              'Budget: ',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              budgetMin + ' - ' + budgetMax,
              style: TextStyle(
                color: AppColors.typographyColor,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Set background color
                side: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.width * 0.001), // Add internal padding
                child: Text(
                  "View More",
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}