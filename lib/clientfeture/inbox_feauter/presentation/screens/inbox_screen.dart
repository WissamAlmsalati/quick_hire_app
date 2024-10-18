// lib/clientfeture/inbox_feature/presentation/screens/client_inbox_application.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repostry/inbox_repository.dart';
import '../cubit/inbox_cubit.dart';
import '../../../../core/utils/constants.dart';

// lib/clientfeture/inbox_feature/presentation/screens/client_posted_jobs_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/data/repostry/posted_job_repository.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/presentation/cubit/client_posted_job_cubit.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';

class ClientPostedJobsScreen extends StatelessWidget {
  const ClientPostedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostedJobRepository postedJobRepository = PostedJobRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');
    final AuthLocalDataSource authLocalDataSource = AuthLocalDataSource(FlutterSecureStorage());

    return FutureBuilder<String?>(
      future: authLocalDataSource.getId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching client ID'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No client ID found'));
        } else {
          final String clientId = snapshot.data!;
          return BlocProvider(
            create: (context) => ClientPostedJobsCubit(postedJobRepository)..fetchPostedJobs(clientId),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  'Posted Jobs',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              body: BlocBuilder<ClientPostedJobsCubit, ClientPostedJobsState>(
                builder: (context, state) {
                  if (state is ClientPostedJobsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ClientPostedJobsLoaded) {
                    return ListView.builder(
                      itemCount: state.postedJobs.length,
                      itemBuilder: (context, index) {
                        final job = state.postedJobs[index];
                        return ListTile(
                          title: Text(job.title),
                          subtitle: Text(job.description),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClientInboxApplication(jobId: job.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is ClientPostedJobsError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('No posted jobs found'));
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}

class ClientInboxApplication extends StatefulWidget {
  final String jobId;

  const ClientInboxApplication({super.key, required this.jobId});

  @override
  _ClientInboxApplicationState createState() => _ClientInboxApplicationState();
}

class _ClientInboxApplicationState extends State<ClientInboxApplication> {
  late InboxCubit _inboxCubit;

  @override
  void initState() {
    super.initState();
    _inboxCubit = InboxCubit(InboxRepository());
    _inboxCubit.fetchApplications(widget.jobId);
  }

  @override
  void dispose() {
    _inboxCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Inbox Applications',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => _inboxCubit,
        child: BlocBuilder<InboxCubit, InboxState>(
          builder: (context, state) {
            if (state is InboxLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InboxLoaded) {
              return ListView.builder(
                itemCount: state.applications.length,
                itemBuilder: (context, index) {
                  final application = state.applications[index];
                  return ListTile(
                    title: Text(application.username),
                    subtitle: Text(application.email),
                    trailing: ElevatedButton(
                      onPressed: () {
                        context.read<InboxCubit>().acceptApplication(widget.jobId, application.id);
                      },
                      child: const Text('Accept'),
                    ),
                  );
                },
              );
            } else if (state is InboxError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No applications found'));
            }
          },
        ),
      ),
    );
  }
}