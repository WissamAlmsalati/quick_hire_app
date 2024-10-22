import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quick_hire/clientfeture/job_posting/data/models/job_post_model.dart';
import 'package:quick_hire/clientfeture/job_posting/presentation/cubit/post_job_cubit.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/data/models/category_post_job.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/data/repostry/posted_job_repository.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/presentation/cubit_category/category_post_cubit.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../buttom_nav_bar/preentation/screens/client_navigation_screen.dart';
import '../../../jobsFeature/postedJobs/data/repostry/category_post_job_repository.dart';
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
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Post a Job',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => PostedJobRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com'),
          ),
          RepositoryProvider(
            create: (context) => CategoryPostJobRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com'),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PostJobCubit(context.read<PostJobRepository>() ),
            ),
            BlocProvider(
              create: (context) => CategoryPostJobCubit(context.read<CategoryPostJobRepository>())..fetchCategories(),
            ),
          ],
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
                          const Text(
                            "Category",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<CategoryPostJobCubit, CategoryPostJobState>(
                            builder: (context, state) {
                              if (state is CategoryPostJobLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is CategoryPostJobLoaded) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Select Category',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedCategoryId,
                                      isExpanded: true,
                                      items: state.categories.map((CategoryPostJob category) {
                                        return DropdownMenuItem<String>(
                                          value: category.id,
                                          child: Text(category.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategoryId = value;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              } else if (state is CategoryPostJobError) {
                                return Center(child: Text(state.message));
                              } else {
                                return const Center(child: Text('No categories found'));
                              }
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

                          if (clientId != null && selectedCategoryId != null) {
                            final job = PostJobModel(
                              clientId: clientId,
                              title: jobTitleController.text,
                              description: jobDescriptionController.text,
                              budget: int.parse(jobMaxBudget.text),
                              deadline: '2025-12-31', // Replace with actual deadline
                              skills: selectedSkills,
                              categoryId: selectedCategoryId!, // Use selected category ID
                              location: jobLocationController.text,
                            );
                            context.read<PostJobCubit>().postJob(job);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Client ID or Category not found')),
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
      ),
    );
  }
}