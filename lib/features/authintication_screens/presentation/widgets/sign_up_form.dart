import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../../login_Screen.dart';
import '../cubit/auth_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String userType = 'client';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        context.read<AuthRepository>(),
      ),
      child: Column(
        children: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
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
              Text('Client'),
              Radio<String>(
                value: 'freelancer',
                groupValue: userType,
                onChanged: (value) {
                  setState(() {
                    userType = value!;
                  });
                },
              ),
              Text('Freelancer'),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              final username = usernameController.text;
              context.read<AuthCubit>().signUp(email, password, username, userType);
            },
            child: Text('Sign Up'),
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
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            child: Text(
                'Login'
            ),
          ),
        ],

      ),
    );
  }
}