import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/theme/app_theme.dart';
import 'package:quick_hire/core/utils/token_checker.dart';
import 'package:quick_hire/features/authintication_screens/data/repositories/auth_repository_impl.dart';
import 'package:quick_hire/features/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'package:quick_hire/features/onboarding_screens/presentation/screens/onboarding_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'features/authintication_screens/presentation/screens/login_screen.dart';
import 'features/buttom_nav_bar/preentation/screens/navigation_screen.dart';
import 'features/profile_screens/presentation/screens/freelancer_profile_screen.dart';


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
          create: (context) => TokenChecker(context.read<FlutterSecureStorage>()),
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
            return const FreelancerProfileScreen(username: 'johnny storm'
                '', locationUrl: 'baxter building',);
          }
        },
      ),
    );
  }
}