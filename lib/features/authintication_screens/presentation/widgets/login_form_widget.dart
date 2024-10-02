import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            CustomButton(text: "Login", onPressed: (){}, color: AppColors.Primary, textColor: Colors.white),
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
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            }, child: Text('Sign Up'))

          ],
        ),
      ),
    );
  }
}