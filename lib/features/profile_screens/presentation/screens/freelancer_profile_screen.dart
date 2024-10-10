import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';
import 'package:quick_hire/features/HomeScreen/presentation/widget/job_list_widget.dart';

class FreelancerProfileScreen extends StatefulWidget {
  const FreelancerProfileScreen({super.key});

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
            color: Colors.white,
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
        child: SingleChildScrollView(
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
                        color: AppColors.secondaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(AppIcons.editIcon,
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.width * 0.07),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              Text(
                'johnny storm',
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
                    'baxter building',
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
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  SkillButtons(skillName: 'Logo Design'),
                  SkillButtons(skillName: 'Graphic Design'),
                  SkillButtons(skillName: 'Illustration'),
                  SkillButtons(skillName: 'Photoshop'),
                  SkillButtons(skillName: 'Adobe Illustrator'),
                  SkillButtons(skillName: 'Adobe InDesign'),
                  SkillButtons(skillName: 'Adobe XD'),
                  SkillButtons(skillName: 'Figma'),
                  SkillButtons(skillName: 'Sketch'),
                  SkillButtons(skillName: 'CorelDRAW'),
                  SkillButtons(skillName: 'Typography'),
                  SkillButtons(skillName: 'Color Theory'),
                  SkillButtons(skillName: 'Brand Identity'),
                  SkillButtons(skillName: 'Visual Design'),
                  SkillButtons(skillName: 'User Interface Design'),
                  SkillButtons(skillName: 'User Experience Design'),
                  SkillButtons(skillName: 'Web Design'),
                  SkillButtons(skillName: 'Mobile App Design'),
                  SkillButtons(skillName: 'Icon Design'),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              Container(
                width: double.infinity,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rates & Pricing',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text('Logo Design: 300', style: TextStyle(
                    color: AppColors.typographyColor,
                    fontSize: 16,
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text('App Ui: 200', style: TextStyle(
                    color: AppColors.typographyColor,
                    fontSize: 16,
                  ),),
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
                  Text(
                    'Last worked on projects:',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              Container(
                height: 600, // Set a fixed height for the JobListWidget
                child: JobListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}