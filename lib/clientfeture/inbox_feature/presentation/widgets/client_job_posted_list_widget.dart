import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/client_job_posted_model.dart';
import '../cubit/client_job_cubit.dart';

class ClientJobPostedListWidget extends StatelessWidget {
  const ClientJobPostedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientJobPostedCubit, ClientJobPostedState>(
      builder: (context, state) {
        if (state is ClientJobPostedLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ClientJobPostedLoaded) {
          return ListView.builder(
            itemCount: state.jobs.length,
            itemBuilder: (context, index) {
              final job = state.jobs[index];
              return ListTile(
                title: Text(job.title),
                subtitle: Text(job.description),
              );
            },
          );
        } else if (state is ClientJobPostedError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No jobs available'));
        }
      },
    );
  }
}