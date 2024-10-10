import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/features/authintication_screens/presentation/screens/sign_up_screen.dart';

import '../../../authintication_screens/presentation/screens/login_screen.dart';
import '../../../authintication_screens/presentation/widgets/sign_up_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Set the background color here

      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Image.asset('assets/images/onboarding.png'),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'QuickHire',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                   SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                   ),
                   Text(
                    'A platform that provides work opportunities for those who wish to work independently, at their own time and location.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Urbanist',
                      color: Color(0xFF0077B5),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    color: AppColors.primaryColor,
                    textColor: AppColors.backgroundColor,
                  ),
                  CustomButton(
                    text: "Sign up",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );

                    },
                    color: AppColors.backgroundColor,
                    textColor: AppColors.primaryColor,
                    isHaveBorder: true,
                    borderColor: AppColors.primaryColor,
                    topPd: MediaQuery.of(context).size.height * 0.005,
                    buttomPd: MediaQuery.of(context).size.height * 0.005,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}