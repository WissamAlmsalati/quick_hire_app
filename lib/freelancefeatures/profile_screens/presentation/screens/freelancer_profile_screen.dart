import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/presentation/screens/login_screen.dart';

import '../../../HomeScreen/presentation/widget/job_list_widget.dart';
import '../../../authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../cubit/profile_cubit.dart';
import 'edit_profile_screen.dart';

class FreelancerProfileScreen extends StatefulWidget {
  const FreelancerProfileScreen({super.key});

  @override
  State<FreelancerProfileScreen> createState() => _FreelancerProfileScreenState();
}

class _FreelancerProfileScreenState extends State<FreelancerProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the profile when the screen is initialized
    context.read<ProfileCubit>().fetchProfile('user_id'); // Replace 'user_id' with the actual user ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.logoutIcon,
            color: Colors.white,
          ),
          onPressed: () async {
            final authLocalDataSource = AuthLocalDataSource(const FlutterSecureStorage());
            await authLocalDataSource.deleteToken();
            await authLocalDataSource.deleteId();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
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
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                            );
                          },
                          icon: SvgPicture.asset(
                            AppIcons.editIcon,
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      state.freelancerProfileData?.username ?? 'Unknown',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                    Text(
                      state.freelancerProfileData?.email ?? 'Unknown',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.locationIcon,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
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
                    const Divider(color: Colors.grey),
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
                        const Spacer(),
                        TextButton(onPressed: () {}, child: const Text("See all")),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                   Wrap(
  spacing: 8.0,
  runSpacing: 4.0,
  children: state.freelancerProfileData?.skills?.map((skill) {
    return SkillButtons(skillName: skill);
  }).toList() ?? [],
),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    const Divider(color: Colors.grey),
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
                        Text(
                          'Logo Design: 300',
                          style: TextStyle(
                            color: AppColors.typographyColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          'App Ui: 200',
                          style: TextStyle(
                            color: AppColors.typographyColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    const Divider(color: Colors.grey),
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
                    const SizedBox(
                      height: 600, // Set a fixed height for the JobListWidget
                      child:  JobListWidget(
                        isHasLimit: true,
                        limit: 5,
                      ),
                    ),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Error"));
              }
            },
          ),
        ),
      ),
    );
  }
}