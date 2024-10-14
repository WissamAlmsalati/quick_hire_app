import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/theme/app_theme.dart';
import 'package:quick_hire/core/utils/token_checker.dart';
import 'package:quick_hire/features/authintication_screens/data/repositories/auth_repository_impl.dart';
import 'package:quick_hire/features/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'package:quick_hire/features/onboarding_screens/presentation/screens/onboarding_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'features/HomeScreen/data/datasources/job_remote_data_source.dart';
import 'features/HomeScreen/data/repositories/job_repository.dart';
import 'features/HomeScreen/domain/usecases/get_jobs.dart';
import 'features/HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import 'features/authintication_screens/presentation/screens/login_screen.dart';
import 'features/buttom_nav_bar/preentation/screens/navigation_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthRepositoryImpl>(
          create: (context) => AuthRepositoryImpl(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(context.read<AuthRepositoryImpl>()),
        ),
        Provider<FlutterSecureStorage>(
          create: (_) => FlutterSecureStorage(),
        ),
        Provider<TokenChecker>(
          create: (context) =>
              TokenChecker(context.read<FlutterSecureStorage>()),
        ),
        BlocProvider(
          create: (context) => JobCubit(
            getJobs: GetJobs(
              repository: JobRepository(
                remoteDataSource:
                    JobRemoteDataSourceImpl(client: http.Client()),
              ),
            ),
          )..fetchJobs(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: AppTheme.getLightTheme(context),
      home: FutureBuilder<bool>(
        future: context.read<TokenChecker>().hasToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return const ButtomNavBar();
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}
