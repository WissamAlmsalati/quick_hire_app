import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';

class FreelancerProfileScreen extends StatefulWidget {
  final String username;
  final String locationUrl;
  const FreelancerProfileScreen({super.key, required this.username, required this.locationUrl});

  @override
  State<FreelancerProfileScreen> createState() => _FreelancerProfileScreenState();
}

class _FreelancerProfileScreenState extends State<FreelancerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.settingIcon,
            color: Colors.white, // Change the color here
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/cyclops-profile.png'),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondaryColor, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    widget.username,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                  Text(
                    'I am a professional web developer with over 5 years of experience. I am proficient in HTML, CSS, JavaScript, and React. I have worked on several projects and I am confident in my ability to deliver quality work.',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.locationIcon,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        widget.locationUrl,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  Container(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        'Skills & Expertise:',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      TextButton(onPressed: (){}, child: Text("See all"))
                    ],
                  ),
                  Row(
                    children: [
                      SkillButtons(skillName: 'HTML'),
                      SkillButtons(skillName: 'CSS'),
                      SkillButtons(skillName: 'JavaScript'),
                      SkillButtons(skillName: 'React'),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/phone.svg'),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        '+234 123 456 7890',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/mail.svg'),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        'johndoe@example.com',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: SvgPicture.asset(
                  AppIcons.editIcon,
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: MediaQuery.of(context).size.width * 0.08,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}