import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/features/buttom_nav_bar/preentation/screens/navigation_screen.dart';
import '../../../HomeScreen/presentation/screen/home_screen.dart';
import '../cubit/auth_cubit.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../screens/login_screen.dart';
import '../widgets/login_form_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String userType = 'client'; // Default user type

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05; // Responsive padding

    return BlocProvider(
      create: (context) => AuthCubit(
        AuthRepositoryImpl(), // Use AuthRepositoryImpl here
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Navigate to HomeScreen on successful sign-up
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is AuthError) {
            // Display an error message using a snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
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
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'to join our community',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryColor,
                        ),
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
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoading) {
                            // Handle loading state
                          } else if (state is AuthSuccess) {
                            // Navigate to HomeScreen on success
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ButtomNavBar()),
                            );
                          } else if (state is AuthError) {
                            // Display an error message using a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return CustomButton(
                              text: "Sign Up",
                              onPressed: () {
                                final email = emailController.text;
                                final password = passwordController.text;
                                final username = usernameController.text;

                                if (email.isNotEmpty &&
                                    password.isNotEmpty &&
                                    username.isNotEmpty) {
                                  context.read<AuthCubit>().signUp(
                                    email,
                                    password,
                                    username,
                                    userType,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please fill in all fields'),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.primaryColor,
                              textColor: AppColors.backgroundColor,
                              isHaveBorder: true,
                              borderColor: AppColors.primaryColor,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
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
      ),
    );
  }
}