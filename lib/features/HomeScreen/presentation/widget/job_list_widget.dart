import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/job_remote_data_source.dart';
import '../../data/repositories/job_repository.dart';
import '../../domain/usecases/get_jobs.dart';
import '../../domain/entities/job.dart';
import 'package:http/http.dart' as http;
import '../cubit/job_cubit/job_cubit.dart';

class JobListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit(
          getJobs: GetJobs(
              repository: JobRepository(
                  remoteDataSource:
                      JobRemoteDataSourceImpl(client: http.Client()))))
        ..fetchJobs(), // Ensure fetchJobs is called
      child: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is JobError) {
            return Center(child: Text(state.message));
          } else if (state is JobLoaded) {
            return ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.01),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 8),
                        Text(
                          job.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Budget: \$${job.budget.toString()}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Spacer(),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text("See more",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 1, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}