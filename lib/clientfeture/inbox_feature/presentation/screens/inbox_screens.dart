

import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class ClientInboxApplication extends StatelessWidget {
  const ClientInboxApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Inbox Jobs',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: const Column(),
    );
  }
}