import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/theme/app_theme.dart';
import 'package:quick_hire/core/utils/token_checker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import 'package:quick_hire/freelancefeatures/profile_screens/presentation/cubit/profile_cubit.dart';
import 'clientfeture/buttom_nav_bar/preentation/screens/client_navigation_screen.dart';
import 'clientfeture/job_posting/data/repositories/job_repository_impl.dart';
import 'freelancefeatures/HomeScreen/data/datasources/job_remote_data_source.dart';
import 'freelancefeatures/HomeScreen/data/repositories/job_repository.dart';
import 'freelancefeatures/HomeScreen/domain/usecases/get_jobs.dart';
import 'freelancefeatures/HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import 'freelancefeatures/HomeScreen/presentation/screen/home_screen.dart';
import 'freelancefeatures/authintication_screens/data/repositories/auth_repository_impl.dart';
import 'freelancefeatures/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'freelancefeatures/buttom_nav_bar/preentation/screens/navigation_screen.dart';
import 'freelancefeatures/onboarding_screens/presentation/screens/onboarding_screen.dart';
import 'clientfeture/job_posting/data/repositories/job_repository.dart';
import 'clientfeture/job_posting/presentation/cubit/post_job_cubit.dart';
import 'freelancefeatures/profile_screens/data/repositories/user_repository_impl.dart';
import 'freelancefeatures/profile_screens/presentation/domain/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final TokenChecker tokenChecker = TokenChecker(secureStorage);
  final bool hasToken = await tokenChecker.hasToken();
  final String? userType = hasToken ? await tokenChecker.getUserType() : null;

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
          create: (_) => secureStorage,
        ),
        Provider<TokenChecker>(
          create: (context) => tokenChecker,
        ),
        BlocProvider(
          create: (context) => JobCubit(
            getJobs: GetJobs(
              repository: JobRepository(
                remoteDataSource: JobRemoteDataSourceImpl(client: http.Client()),
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
        Provider<AuthLocalDataSource>(
          create: (context) => AuthLocalDataSource(context.read<FlutterSecureStorage>()),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            http.Client(),
            context.read<AuthLocalDataSource>(),
          ),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(context.read<UserRepository>()),
        ),
      ],
      child: MyApp(userType: userType),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? userType;

  const MyApp({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: AppTheme.getLightTheme(context),
      home: userType == "freelancer" ? const FreelanceHomeScreen() : const ClientHomeScreen(),
    );
  }
}