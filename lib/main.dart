import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/theme/app_theme.dart';
import 'package:quick_hire/features/authintication_screens/data/repositories/auth_repository.dart';
import 'package:quick_hire/features/authintication_screens/data/repositories/auth_repository_impl.dart';
import 'package:quick_hire/features/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'package:quick_hire/features/authintication_screens/presentation/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            context.read<AuthRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'My App',
        theme: AppTheme.getLightTheme(context),
        home: const LoginScreen(),
      ),
    );
  }
}