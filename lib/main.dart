import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/theme/app_theme.dart';
import 'package:quick_hire/core/utils/token_checker.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'clientfeture/buttom_nav_bar/preentation/screens/client_navigation_screen.dart';
import 'clientfeture/job_posting/data/repositories/job_repository_impl.dart';
import 'freelancefeatures/HomeScreen/data/datasources/job_remote_data_source.dart';
import 'freelancefeatures/HomeScreen/data/repositories/job_repository.dart';
import 'freelancefeatures/HomeScreen/domain/usecases/get_jobs.dart';
import 'freelancefeatures/HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import 'freelancefeatures/authintication_screens/data/repositories/auth_repository_impl.dart';
import 'freelancefeatures/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'freelancefeatures/buttom_nav_bar/preentation/screens/navigation_screen.dart';
import 'freelancefeatures/onboarding_screens/presentation/screens/onboarding_screen.dart';
import 'clientfeture/job_posting/data/repositories/job_repository.dart';
import 'clientfeture/job_posting/presentation/cubit/post_job_cubit.dart';

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
          create: (_) => const FlutterSecureStorage(),
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
        RepositoryProvider<PostJobRepository>(
          create: (context) => PostJobRepositoryImpl(http.Client()),
        ),
        BlocProvider<PostJobCubit>(
          create: (context) => PostJobCubit(context.read<PostJobRepository>()),
        ),
      ],
      child: const MyApp(),
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: context.read<TokenChecker>().hasToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return FutureBuilder<String?>(
            future: context.read<TokenChecker>().getUserType(),
            builder: (context, userTypeSnapshot) {
              if (userTypeSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (userTypeSnapshot.hasData) {
                if (userTypeSnapshot.data == 'freelancer') {
                  return const FreelanceHomeScreen();
                } else if (userTypeSnapshot.data == 'client') {
                  return const ClientHomeScreen();
                } else if (userTypeSnapshot.data == 'superuser') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Superuser access is not allowed.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  });
                  return const OnboardingScreen();
                } else {
                  return const OnboardingScreen();
                }
              } else {
                return const OnboardingScreen();
              }
            },
          );
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
