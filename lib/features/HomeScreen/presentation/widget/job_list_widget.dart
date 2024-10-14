import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/features/job_screens/presentation/screens/job_details_screen.dart';
import '../cubit/job_cubit/job_cubit.dart';

class JobListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        if (state is JobLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is JobError) {
          return Center(child: Text(state.message));
        } else if (state is JobLoaded) {
          return Padding(
            padding:  EdgeInsets.all(MediaQuery.sizeOf(context).aspectRatio * 0.04),
            child: ListView.builder(
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
                            Spacer(),
                            Container(
                              height: 38,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.secondaryColor, width: 2),
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
                        Divider(thickness: 1, color: Colors.grey),
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
    );
  }
}