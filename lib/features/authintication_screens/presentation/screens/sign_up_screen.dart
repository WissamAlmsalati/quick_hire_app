import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../../core/utils/app_icon.dart';
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
    return MultiBlocProvider(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        'to join our community',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 20),
                      // SignUp form elements
                      CustomTextField(
                        controller: usernameController,
                        labelText: 'Username',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: emailController,
                        labelText: "Email",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: passwordController,
                        labelText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'client',
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                          ),
                          const Text('Client'),
                          Radio<String>(
                            value: 'freelancer',
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                          ),
                          const Text('Freelancer'),
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
                        topPd: MediaQuery.of(context).size.height*0.005,
                        buttomPd: MediaQuery.of(context).size.height*0.005,
                        color: AppColors.primaryColor,
                        textColor: AppColors.backgroundColor,
                      ),
                      CustomButton(
                        text: "Sign up with Google",
                        onPressed: () {},
                        color: AppColors.backgroundColor,
                        isHaveIcon: true,
                        icon: AppIcons.googleIcon,
                        textColor: AppColors.primaryColor,
                        isHaveBorder: true,
                        borderColor: AppColors.primaryColor,
                        topPd: MediaQuery.of(context).size.height*0.005,
                        buttomPd: MediaQuery.of(context).size.height*0.005,
                      ),
                      CustomButton(
                        text: "Sign up with Facebook",
                        onPressed: () {},
                        color: AppColors.backgroundColor,
                        textColor: AppColors.primaryColor,
                        isHaveBorder: true,
                        isHaveIcon: true,
                        icon: AppIcons.facebookIcon,
                        borderColor: AppColors.primaryColor,
                        topPd: MediaQuery.of(context).size.height*0.005,
                        buttomPd: MediaQuery.of(context).size.height*0.005,
                      ),

                      const SizedBox(height: 20),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is AuthError) {
                            return Text(state.message);
                          } else if (state is AuthSuccess) {
                            return Text('Welcome, ${state.user.email}');
                          }
                          return Container();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Already have an account?",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color:Colors.black,

                           ),),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                            },
                            child:  Text('Login',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                            ),),
                          ),
                        ],
                      ),
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
