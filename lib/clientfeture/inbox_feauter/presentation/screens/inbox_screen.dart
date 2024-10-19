// lib/clientfeture/inbox_feature/presentation/screens/client_inbox_application.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../freelancefeatures/job_screens/presentation/screens/job_details_screen.dart';
import '../../../jobsFeature/activeJobs/presentation/cubit/client_active_jobs_cubit.dart';
import '../../../jobsFeature/activeJobs/reppostry/active_job_repository.dart';
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

import 'job_applications.dart';

class ClientPostedJobsScreen extends StatelessWidget {
  const ClientPostedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostedJobRepository postedJobRepository = PostedJobRepository(
        baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');
    final AuthLocalDataSource authLocalDataSource =
        AuthLocalDataSource(FlutterSecureStorage());

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
            create: (context) => ClientPostedJobsCubit(postedJobRepository)
              ..fetchPostedJobs(clientId),
            child: Scaffold(
              body: BlocBuilder<ClientPostedJobsCubit, ClientPostedJobsState>(
                builder: (context, state) {
                  if (state is ClientPostedJobsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ClientPostedJobsLoaded) {
                    return ListView.builder(
                      itemCount: state.postedJobs.length,
                      itemBuilder: (context, index) {
                        final job = state.postedJobs[index];
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title ?? 'N/A',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  job.description ?? 'N/A',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.coinIcon,
                                      color: AppColors.secondaryColor,
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    Text(
                                      "Budget: ${job.budget.toString()}\$ - ${job.budget.toString()}\$",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.secondaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  JobDetailsScreen(
                                                      index: index),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0001,
                                          ),
                                          child: Text(
                                            "See more",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
                              ],
                            ),
                          ),
                        );
                        ;
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

class ClientActiveJobsScreen extends StatelessWidget {
  const ClientActiveJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActiveJobRepository activeJobRepository = ActiveJobRepository(
        baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');
    final AuthLocalDataSource authLocalDataSource =
        AuthLocalDataSource(FlutterSecureStorage());

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
            create: (context) => ClientActiveJobsCubit(activeJobRepository)
              ..fetchActiveJobs(clientId),
            child: Scaffold(
              body: BlocBuilder<ClientActiveJobsCubit, ClientActiveJobsState>(
                builder: (context, state) {
                  if (state is ClientActiveJobsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ClientActiveJobsLoaded) {
                    return ListView.builder(
                      itemCount: state.activeJobs.length,
                      itemBuilder: (context, index) {
                        final job = state.activeJobs[index];
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title ?? 'N/A',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  job.description ?? 'N/A',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.coinIcon,
                                      color: AppColors.secondaryColor,
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    Text(
                                      "Budget: ${job.budget.toString()}\$ - ${job.budget.toString()}\$",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.secondaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  JobDetailsScreen(
                                                      index: index),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0001,
                                          ),
                                          child: Text(
                                            "See more",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
                              ],
                            ),
                          ),
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
    final PostedJobRepository postedJobRepository = PostedJobRepository(
        baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com');
    final AuthLocalDataSource authLocalDataSource =
        AuthLocalDataSource(FlutterSecureStorage());

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
            create: (context) => ClientPostedJobsCubit(postedJobRepository)
              ..fetchPostedJobs(clientId),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                title: Text('Job Applications',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                        )),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientPostedJobsScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.post_add),
                  ),
                ],
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
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title ?? 'N/A',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  job.description ?? 'N/A',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.coinIcon,
                                      color: AppColors.secondaryColor,
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    Text(
                                      "Budget: ${job.budget.toString()}\$ - ${job.budget.toString()}\$",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.secondaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  JobApplicationsScreen(
                                                      jobId: state.postedJobs[index].id),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0001,
                                          ),
                                          child: Text(
                                            "See more",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
                              ],
                            ),
                          ),
                        );
                        ;
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
