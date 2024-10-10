import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';

class JobDetailsScreen extends StatefulWidget {
  final String? image;
  final String? username;
  final DateTime? date;
  final bool? status;
  final String jobTitle;
  final String jobDescription;
  final String? locationUrl;
  final double budgetMax;
  final double budgetMin;

  const JobDetailsScreen({
    super.key,
      this.image,
     this.username,
     this.date,
     this.status,
    required this.jobTitle,
    required this.jobDescription,  this.locationUrl, required this.budgetMax, required this.budgetMin,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.backIcon,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.image??'assets/images/cyclops-profile.png'),
                ),
                SizedBox(width: 5), // Add space between the image and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:  20), // Add space above the username column
                    Text(
                      widget.username??'Unknown User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.typographyColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
  widget.date?.toString() ?? 'a while ago',
  style: TextStyle(
    fontSize: 10,
    color: Colors.grey,
  ),
),
                        SizedBox(width: 5),
                       Text(
  (widget.status ?? false) ? 'Active' : 'Inactive',
  style: TextStyle(
    fontSize: 10,
    color: (widget.status ?? false) ? Colors.green : Colors.red,
  ),
),
                      ],
                    ),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Looking for a ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.typographyColor,
                            ),
                          ),
                          TextSpan(
                            text: widget.jobTitle,
                            style: TextStyle(
                              fontSize: 24, // Increase the font size
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor, // Change the color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Job Description:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.jobDescription,
              style: TextStyle(
                color: AppColors.typographyColor,
              ),
            ),
            SizedBox(height: 10,),


            Container(
              width: double.infinity,
              child: Divider(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
              SvgPicture.asset(
              AppIcons.locationIcon,
              color: AppColors.secondaryColor,
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
            ),

                SizedBox(width: 5,)
                ,Text('Location: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
                Text(
                  widget.locationUrl?? 'Unknown Location',
                  style: TextStyle(
                    color: AppColors.typographyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
              SvgPicture.asset(
              AppIcons.coinIcon,
              color: AppColors.secondaryColor,
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
            ),

                SizedBox(width: 5,)

                ,Text('Budget: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),

                Text(
                  widget.budgetMin.toString()+' - '+
                  widget.budgetMax.toString(),
                  style: TextStyle(
                    color: AppColors.typographyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,)
            ,Container(
              width: double.infinity,
              child: Divider(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Skills and Expertise:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SkillButtons(
                  skillName: 'Logo Design',
                ),
                SkillButtons(skillName: "After Effects"),
                SkillButtons(skillName: "photoshop"),
              ],
            ),
            SizedBox(height: 10,)
            ,Container(
              width: double.infinity,
              child: Divider(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10,),
            Text('About Client:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomButton(text: 'Apply Now', onPressed: (){}, color: AppColors.primaryColor, textColor: AppColors.backgroundColor, isHaveBorder: false,
                  fontSize: 16, borderRadius: 10, width: 100, height: 50, topPd: 10, buttomPd: 10,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(text: 'Save Job', onPressed: (){}, color: AppColors.backgroundColor, textColor: AppColors.primaryColor, isHaveBorder: true,

                  fontSize: 16, borderRadius: 10, width: 100, height: 50, topPd: 10, buttomPd: 10,
                  borderColor: AppColors.primaryColor,

                ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
     