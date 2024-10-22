import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final ApplicationRepository applicationRepository = ApplicationRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');

    return BlocProvider(
      create: (context) => InboxApplicationCubit(applicationRepository)..fetchApplications(jobId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Applications'),
        ),
        body: BlocBuilder<InboxApplicationCubit, InboxApplicationState>(
          builder: (context, state) {
            if (state is InboxApplicationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InboxApplicationLoaded) {
              return ListView.builder(
                itemCount: state.applicationsResponse.applications.length,
                itemBuilder: (context, index) {
                  final application = state.applicationsResponse.applications[index];
                  return ListTile(
                    title: Text(application.email),
                    subtitle: Text(application.bio),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FreelanceDetailScreen(
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
    return BlocProvider(
      create: (context) => FreelanceProfileCubit(ProfileRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com'))
        ..fetchProfile(freelancerId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Freelancer Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FreelanceProfileCubit, FreelanceProfileState>(
            builder: (context, state) {
              if (state is FreelanceProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FreelanceProfileLoaded) {
                final profile = state.profile;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Freelancer ID: ${profile['id']}', style: const TextStyle(fontSize: 18)),
                    Text('Name: ${profile['username']}', style: const TextStyle(fontSize: 18)),
                    Text('Email: ${profile['email']}', style: const TextStyle(fontSize: 18)),
                    Text('Bio: ${profile['bio']}', style: const TextStyle(fontSize: 18)),
                    Text('Skills: ${profile['skills']}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _acceptFreelancer(context),
                      child: const Text('Accept Freelancer'),
                    ),
                  ],
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