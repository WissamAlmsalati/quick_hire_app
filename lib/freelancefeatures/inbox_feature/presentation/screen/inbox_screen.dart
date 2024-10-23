import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/constants.dart';
import '../../applied_jobs/applied_jobs_cubit.dart';
import '../../repostry/applied_jobs_repository.dart';
import '../../../job_screens/presentation/screens/job_details_screen.dart';

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
                          final jobId = job['_id'] ?? 'Unknown Job ID';
                          final jobTitle = job['title'] ?? 'Unknown Job Title';
                          final clientName = job['clientName'] ?? 'Unknown Client';
                          final jobDescription = job['description'] ?? 'Unknown Description';
                          final category = job['category'] ?? 'Unknown Location';
                          final status = job['title'] ?? 'Unknown Status';
                          final appliedAt = job['appliedAt'] ?? 'Unknown Date';

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(jobTitle),
                              subtitle: Text("Client: $clientName \nCategory: $category \nStatus: $status \nApplied At: $appliedAt"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobDetailsScreen(
                                      index: jobId, // This should be an int, but jobId is a String
                                      showChatButton: true,
                                      showLastButtonRow: false,
                                    ),
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