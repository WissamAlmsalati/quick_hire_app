import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import '../../../../core/utils/app_icon.dart';
import '../../data/repositories/auth_repository.dart';
import '../cubit/auth_cubit.dart';
import '../screens/sign_up_screen.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        context.read<AuthRepository>(),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Gap(70),
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
                textColor: Colors.white),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
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
                Text('Or login with ',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 10)),
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
            CustomButton(text: "Login with Google",
                onPressed: (){}, color: AppColors.backgroundColor,
                textColor: AppColors.primaryColor,
                isHaveIcon: true, icon: AppIcons.googleIcon,
                isHaveBorder: true, borderColor: AppColors.primaryColor),
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
                Text("dont have an account?",
                    style: TextStyle(color: Color(0xFF333333), fontSize: 11)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: Text('Sign Up',
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 11)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
