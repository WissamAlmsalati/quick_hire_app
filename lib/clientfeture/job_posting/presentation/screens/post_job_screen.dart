import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_hire/clientfeture/job_posting/data/models/job_post_model.dart';
import 'package:quick_hire/clientfeture/job_posting/presentation/cubit/post_job_cubit.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';

import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../buttom_nav_bar/preentation/screens/client_navigation_screen.dart';
import '../../data/repositories/job_repository.dart';

class ClentPostJob extends StatefulWidget {
  const ClentPostJob({super.key});

  @override
  _ClentPostJobState createState() => _ClentPostJobState();
}

class _ClentPostJobState extends State<ClentPostJob> {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobMaxBudget = TextEditingController();
  final TextEditingController jobMinBudget = TextEditingController();
  List<String> selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:  Text('Post a Job',style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: Colors.white,
        ),),
      ),
      body: BlocProvider(
        create: (context) => PostJobCubit(context.read<PostJobRepository>()),
        child: BlocListener<PostJobCubit, PostJobState>(
          listener: (context, state) {
            if (state is PostJobSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Job posted successfully!')),
              );
              Navigator.pop(context);
            } else if (state is PostJobError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: jobTitleController,
                          labelText: 'Job Title',
                          hintText: 'Enter job title',
                          obscureText: false,
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                        CustomTextField(
                          labelText: 'Job Description',
                          hintText: 'Enter job description',
                          controller: jobDescriptionController,
                          maxLines: 5,
                          obscureText: false,
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                        CustomTextField(
                          controller: jobLocationController,
                          labelText: 'Location',
                          hintText: 'Enter job location',
                          obscureText: false,
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                        const Text(
                          'Budget',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: jobMinBudget,
                                labelText: 'From',
                                hintText: 'from',
                                obscureText: false,
                              ),
                            ),
                            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                            Expanded(
                              child: CustomTextField(
                                controller: jobMaxBudget,
                                labelText: 'To',
                                hintText: 'to',
                                obscureText: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                        const Text(
                          "Required Skills",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SkillsDropdown(
                          onSkillsSelected: (skills) {
                            setState(() {
                              selectedSkills = skills;
                            });
                          },
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PostJobCubit, PostJobState>(
                  builder: (context, state) {
                    if (state is PostJobLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () async {
                        final authLocalDataSource = AuthLocalDataSource(const FlutterSecureStorage());
                        final clientId = await authLocalDataSource.getId();

                        if (clientId != null) {
                          final job = PostJobModel(
                            clientId: clientId,
                            title: jobTitleController.text,
                            description: jobDescriptionController.text,
                            budget: int.parse(jobMaxBudget.text),
                            deadline: '2025-12-31', // Replace with actual deadline
                            skills: selectedSkills,
                            categoryId: '670d1597fae4b253332ffee7', // Replace with actual category ID
                            location: jobLocationController.text,
                          );
                          context.read<PostJobCubit>().postJob(job);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Client ID not found')),
                          );
                        }
                      },
                      child: const Text('Post Job'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}