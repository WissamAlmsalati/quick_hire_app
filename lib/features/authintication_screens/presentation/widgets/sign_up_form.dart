import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../cubit/auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String userType = 'client';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05; // Responsive padding

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.displayLarge
                          ?.copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      'to join our community',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: AppColors.primaryColor),
                    ),
                    CustomTextField(
                      controller: usernameController,
                      labelText: 'Username',
                      obscureText: false,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: "Email",
                      obscureText: false,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      labelText: "Password",
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text('Client'),
                            leading: Radio<String>(
                              value: 'client',
                              groupValue: userType,
                              onChanged: (value) {
                                setState(() {
                                  userType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('Freelancer'),
                            leading: Radio<String>(
                              value: 'freelancer',
                              groupValue: userType,
                              onChanged: (value) {
                                setState(() {
                                  userType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Sign Up",
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final username = usernameController.text;
                        context.read<AuthCubit>().signUp(
                          email,
                          password,
                          username,
                          userType,
                        );
                      },
                      color: AppColors.primaryColor,
                      textColor: AppColors.backgroundColor,
                      isHaveBorder: true,
                      borderColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "Sign up with Facebook",
                      onPressed: () {},
                      color: AppColors.backgroundColor,
                      textColor: AppColors.primaryColor,
                      isHaveBorder: true,
                      borderColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "Sign up with Google",
                      onPressed: () {},
                      color: AppColors.backgroundColor,
                      textColor: AppColors.primaryColor,
                      isHaveBorder: true,
                      borderColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is AuthError) {
                          return Text(state.message);
                        } else if (state is AuthSuccess) {
                          return Text('Welcome, ${state.user.email}');
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}