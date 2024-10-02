import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
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
            CustomButton(text: "Login", onPressed: (){}, color: AppColors.primaryColor, textColor: Colors.white),
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

            const Gap(100),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            }, child: Text('Sign Up')),

            const Gap(40),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 1,
                    indent: 7,
                    endIndent: 10,
                  ),
                ),
                Text('Or login with ', style: TextStyle(color: Color(0xFF333333), fontSize: 10)),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 1,
                    indent: 7,
                    endIndent: 10,
                  ),
                ),
              ],
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/6929234_google_logo_icon.png', width: 40, height: 40),
                const Gap(20),
                SvgPicture.asset('assets/icons/F_icon_reversed.svg', width: 40, height: 40),
              ],
            ),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text('Sign Up'),
            ),

          ],
        ),
      ),
    );
  }
}