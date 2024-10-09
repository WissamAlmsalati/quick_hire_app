import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';

class JobDetailsScreen extends StatefulWidget {
  final String image;
  final String username;
  final String date;
  final bool status;
  final String jobTitle;
  final String jobDescription;
  final String locationUrl;
  final String budgetMax;
  final String budgetMin;

  const JobDetailsScreen({
    super.key,
    required this.image,
    required this.username,
    required this.date,
    required this.status,
    required this.jobTitle,
    required this.jobDescription,
    required this.locationUrl,
    required this.budgetMax,
    required this.budgetMin,
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
          icon: Icon(Icons.chevron_left, color: Colors.white),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                  SizedBox(width: 5), // Add space between the image and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20), // Add space above the username column
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.typographyColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.date,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.status ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.status ? Colors.green : Colors.red,
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
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_pin, size: 40),
                  SizedBox(width: 5),
                  Text(
                    'Location: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.locationUrl,
                    style: TextStyle(
                      color: AppColors.typographyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.circle_outlined, size: 40),
                  SizedBox(width: 5),
                  Text(
                    'Budget: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.budgetMin + ' - ' + widget.budgetMax,
                    style: TextStyle(
                      color: AppColors.typographyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Skills and Expertise:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Apply Now'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        side: BorderSide(
                          color: AppColors.primaryColor ?? Colors.transparent,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save Job',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}