import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        SizedBox(height:100),
        Align(

          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Login', style: TextStyle(fontSize: 28,
                fontWeight: FontWeight.bold,fontFamily: 'Urbanist',color: Color(0xFF0077B5),),
                ),
            Text('to search for new Employers or Jobs', style: TextStyle(fontSize: 13,
                fontWeight: FontWeight.bold, fontFamily: 'Urbanist' ,color: Color(0xFF0077B5)),
            ),
            ],),
          ),
          ),



],
    )

    );
  }
}
