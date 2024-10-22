import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../inbox_feauter/presentation/screens/inbox_screen.dart';

class ClientActiveJobs extends StatelessWidget {
  const ClientActiveJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Active Jobs',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            unselectedLabelStyle:
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            tabs: const [
              Tab(text: 'Active Jobs'),
              Tab(text: 'Job Posted'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ClientActiveJobsScreen(),
            ClientPostedJobsScreen(),
          ],
        ),
      ),
    );
  }
}
