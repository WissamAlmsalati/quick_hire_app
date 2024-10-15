import 'package:flutter/material.dart';
import 'package:quick_hire/core/utils/constants.dart';

import '../../../HomeScreen/presentation/widget/job_list_widget.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Jobs',
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: const Expanded(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: JobListWidget(),
      )),
    );
  }
}
