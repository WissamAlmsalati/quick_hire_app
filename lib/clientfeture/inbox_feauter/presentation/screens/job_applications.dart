import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repostry/freelance_application_repository.dart';
import '../freelance_application_cubit/freelance_application_cubit.dart';

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
                    subtitle: Text(application.email),
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