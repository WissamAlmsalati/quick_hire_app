import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/constants.dart';
import '../../../chat_feature/presentation/screens/chat_screen.dart';
import '../../applied_jobs/applied_jobs_cubit.dart';
import '../../repostry/applied_jobs_repository.dart';
import '../../../job_screens/presentation/screens/job_details_screen.dart'; // Import JobDetailsScreen

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppliedJobsCubit(
        AppliedJobsRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com'),
      )..fetchAppliedJobs('671261c10e544ae02a781c3b'),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Inbox',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<AppliedJobsCubit, AppliedJobsState>(
                builder: (context, state) {
                  if (state is AppliedJobsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AppliedJobsLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.jobs.length,
                        itemBuilder: (context, index) {
                          final job = state.jobs[index];

                          // Print job details for debugging purposes
                          print(job);

                          // Handle null or missing values gracefully
                          final jobId = job['jobId'] ?? 'Unknown Job ID';
                          final status = job['status'] ?? 'Unknown Status';
                          final appliedAt = job['appliedAt'] ?? 'Unknown Date';

                          // Ensure jobId is an int
                          final jobIdInt = int.tryParse(jobId) ?? 0;

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text('Job ID: $jobId'),
                              subtitle: Text('Status: $status\nApplied At: $appliedAt'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobDetailsScreen(index: jobIdInt,showChatButton: true,showLastButtonRow: false
                                      ,), // Pass jobId as int
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is AppliedJobsError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('No applied jobs found'));
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the temporary chat screen if needed
                },
                child: const Text("Go to Chat (Temp)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}