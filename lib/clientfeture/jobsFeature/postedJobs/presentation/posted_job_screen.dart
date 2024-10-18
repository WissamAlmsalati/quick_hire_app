import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/presentation/cubit/client_posted_job_cubit.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/data/repostry/posted_job_repository.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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