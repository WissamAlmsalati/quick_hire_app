import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_hire/clientfeture/jobsFeature/activeJobs/presentation/cubit/client_active_jobs_cubit.dart';
import 'package:quick_hire/clientfeture/jobsFeature/activeJobs/reppostry/active_job_repository.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import 'package:quick_hire/freelancefeatures/job_screens/presentation/screens/job_details_screen.dart';
import 'package:quick_hire/freelancefeatures/profile_feature/presentation/screen/job_screen.dart';

import '../../postedJobs/presentation/posted_job_screen.dart';

class ClientActiveJobs extends StatelessWidget {
  const ClientActiveJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final ActiveJobRepository activeJobRepository = ActiveJobRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');
    final AuthLocalDataSource authLocalDataSource = AuthLocalDataSource(FlutterSecureStorage());

    return FutureBuilder<String?>(
      future: authLocalDataSource.getId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error fetching client ID'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No client ID found'));
        } else {
          final String clientId = snapshot.data!;
          return BlocProvider(
            create: (context) => ClientActiveJobsCubit(activeJobRepository)..fetchActiveJobs(clientId),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  title: Text(
                    'Active Jobs',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  bottom: TabBar(
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                    unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                    tabs: const [
                      Tab(text: 'Active Jobs'),
                      Tab(text: 'Job Posted'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    BlocBuilder<ClientActiveJobsCubit, ClientActiveJobsState>(
                      builder: (context, state) {
                        if (state is ClientActiveJobsLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ClientActiveJobsLoaded) {
                          return ListView.builder(
                            itemCount: state.activeJobs.length,
                            itemBuilder: (context, index) {
                              final job = state.activeJobs[index];
                              return ListTile(onTap: () {
                                // Navigate to job details screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobDetailsScreen(index: index),
                                  ),
                                );
                              },
                                title: Text(job.title),
                                subtitle: Text(job.description),
                              );
                            },
                          );
                        } else if (state is ClientActiveJobsError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Center(child: Text('No active jobs found'));
                        }
                      },
                    ),
                    ClientPostedJobsScreen(),                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}


