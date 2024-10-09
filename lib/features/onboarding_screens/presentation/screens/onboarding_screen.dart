import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/features/authintication_screens/presentation/screens/sign_up_screen.dart';

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

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Gap(50),
            Image.asset('assets/images/onboarding.png'),
            Gap(50),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QuickHire',
                      style: Theme.of(context).textTheme.displayLarge,

                    ),
                    const Text(
                      'A platform that provides work opportunities for those who wish to work independently, at their own time and location.',
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Urbanist',
                        color: Color(0xFF0077B5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                    Gap(30),
               CustomButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                 color: AppColors.primaryColor,
                textColor: AppColors.backgroundColor,
              ),
              Gap(19),
            CustomButton(
              text: "Sign up",
              onPressed: () {},
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
    );
  }
}