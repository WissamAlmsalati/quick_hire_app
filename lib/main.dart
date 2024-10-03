import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/authintication_screens/presentation/screens/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: AppTheme.getLightTheme(context),
      home: const SignUpProvider(),
    );
  }
}