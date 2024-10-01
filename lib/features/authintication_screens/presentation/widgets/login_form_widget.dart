import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final email = emailController.text;
                  final password = passwordController.text;
                  context.read<AuthCubit>().signIn(email, password);
                }
              },
              child: Text('Login'),
            ),
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