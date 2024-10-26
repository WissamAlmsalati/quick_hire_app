import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import '../../../../core/widgets/skill_buttons.dart';
import '../../data/repostry/freelance_application_repository.dart';
import '../../data/repostry/profile_freelance_repostry.dart';
import '../freelance_application_cubit/freelance_application_cubit.dart';
import 'package:http/http.dart' as http;
import '../freelance_profile_cubit/freelance_profile_cubit.dart';

class JobApplicationsScreen extends StatelessWidget {
  final String jobId;

  const JobApplicationsScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final ApplicationRepository applicationRepository = ApplicationRepository(
        baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');

    return BlocProvider(
      create: (context) =>
      InboxApplicationCubit(applicationRepository)
        ..fetchApplications(jobId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Applications'),
        ),
        body: BlocBuilder<InboxApplicationCubit, InboxApplicationState>(
          builder: (context, state) {
            if (state is InboxApplicationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InboxApplicationLoaded) {
              if (state.applicationsResponse.applications.isEmpty) {
                return const Center(
                    child: Text('No applications have been submitted yet.'));
              }
              return ListView.builder(
                itemCount: state.applicationsResponse.applications.length,
                itemBuilder: (context, index) {
                  final application = state.applicationsResponse
                      .applications[index];
                  return ListTile(
                    title: Text(application.email),
                    subtitle: Text(application.bio),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FreelanceDetailScreen(
                                jobId: jobId,
                                freelancerId: application.id,
                              ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is InboxApplicationError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No applications found'));
            }
          },
        ),
      ),
    );
  }
}



class FreelanceDetailScreen extends StatelessWidget {
  final String jobId;
  final String freelancerId;

  const FreelanceDetailScreen({super.key, required this.jobId, required this.freelancerId});

  Future<void> _acceptFreelancer(BuildContext context) async {
    final url = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/jobs/accept';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"jobId": "$jobId", "freelancerId": "$freelancerId"}',
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Freelancer accepted successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to accept freelancer')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (context) => FreelanceProfileCubit(ProfileRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com'))
            ..fetchProfile(freelancerId),
          child: BlocBuilder<FreelanceProfileCubit, FreelanceProfileState>(
            builder: (context, state) {
              if (state is FreelanceProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FreelanceProfileLoaded) {
                final profile = state.profile;

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture
                      Container(
                        height: MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://www.example.com/path-to-placeholder-image.jpg'),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Freelancer Name
                      Text(
                        profile.username,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        profile.email,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Bio
                       Text(
                        'Bio:',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        profile.bio.isEmpty ? 'No bio available' : profile.bio,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      // Skills
                       Text(
                        'Skills & Expertise:',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: profile.skills.map((skill) {
                          return SkillButtons(skillName: skill);
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Rates & Pricing
                       Text(
                        'Rate: ',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$${profile.rate}/hr',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      // Accept Freelancer Button
                      SizedBox(
                        height: 260,
                      ),
                      CustomButton(
                        text: 'Accept Freelancer',
                        onPressed: () => _acceptFreelancer(context),
                        color: AppColors.primaryColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                );
              } else if (state is FreelanceProfileError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Error loading profile'));
              }
            },
          ),
        ),
      ),
    );
  }
}
