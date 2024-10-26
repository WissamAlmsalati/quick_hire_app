import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../job_screens/presentation/screens/job_details_screen.dart';
import '../cubit/job_cubit/job_cubit.dart';

class JobListWidget extends StatelessWidget {
  final bool isHasLimit;
  final int limit;

  const JobListWidget({super.key, Key, this.isHasLimit = false, this.limit = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobError) {
            return Center(child: Text(state.message));
          } else if (state is JobLoaded) {
            return Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).aspectRatio * 0.04),
              child: ListView.builder(
                physics: isHasLimit ? const NeverScrollableScrollPhysics() : null,
                itemCount: isHasLimit ? limit : state.jobs.length,
                itemBuilder: (context, index) {
                  final job = state.jobs[index];
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title ?? 'N/A',
                            style: Theme.of(context).textTheme.headlineLarge,
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
                                width: MediaQuery.of(context).size.width * 0.07,
                                height: MediaQuery.of(context).size.width * 0.07,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                              Text(
                                "Budget: ${job.budget.toString()}\$ - ${job.budget.toString()}\$",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.secondaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsScreen(index: index),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.05,
                                      vertical: MediaQuery.of(context).size.width * 0.0001,
                                    ),
                                    child: Text(
                                      "See more",
                                      style: Theme.of(context).textTheme.labelMedium,
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
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}