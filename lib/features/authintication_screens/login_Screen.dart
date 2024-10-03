import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import 'package:quick_hire/features/authintication_screens/presentation/cubit/auth_cubit.dart';
import 'package:quick_hire/features/authintication_screens/presentation/screens/sign_up_screen.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/features/authintication_screens/presentation/widgets/sign_up_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: AppColors.primaryColor),
                ),
                Text(
                  'to search for new Employers or Jobs',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.primaryColor),
                ),
                const Gap(70),
                CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  obscureText: false,
                ),
                CustomTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),
                const Gap(40),
                CustomButton(
                  text: "Login",
                  onPressed: () {},
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                ),
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
                const Gap(40),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.10),
                        height: 20,
                        thickness: 2,
                        indent: 7,
                        endIndent: 10,
                      ),
                    ),
                    const Text(
                      'Or login with ',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 10),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.10),
                        height: 20,
                        thickness: 2,
                        indent: 7,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                CustomButton(
                  text: "Login with Google",
                  onPressed: () {},
                  color: AppColors.backgroundColor,
                  textColor: AppColors.primaryColor,
                  isHaveIcon: true,
                  icon: AppIcons.googleIcon,
                  isHaveBorder: true,
                  borderColor: AppColors.primaryColor,
                ),
                const Gap(19),
                CustomButton(
                  text: "Login with Facebook",
                  onPressed: () {},
                  color: AppColors.backgroundColor,
                  textColor: AppColors.primaryColor,
                  isHaveIcon: true,
                  icon: AppIcons.facebookIcon,
                  isHaveBorder: true,
                  borderColor: AppColors.primaryColor,
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Color(0xFF333333), fontSize: 11),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}