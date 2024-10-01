import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/features/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'package:quick_hire/features/authintication_screens/presentation/widgets/login_form_widget.dart';
import '../../core/utils/constants.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      child:  Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            SizedBox(height: 100),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                        color: Color(0xFF0077B5),
                      ),
                    ),
                    Text(
                      'to search for new Employers or Jobs',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                        color: Color(0xFF0077B5),
                      ),
                    ),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}