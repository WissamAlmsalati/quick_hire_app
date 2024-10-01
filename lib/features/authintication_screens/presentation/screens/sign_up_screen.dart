import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../cubit/auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: const SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                          color: Color(0xFF0077B5),
                        ),
                      ),
                      Text(
                        'to join our community',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                          color: Color(0xFF0077B5),
                        ),
                      ),
                      SizedBox(child: SignUpForm()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}