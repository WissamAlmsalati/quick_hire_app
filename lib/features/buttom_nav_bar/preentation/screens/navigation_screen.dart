import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/features/authintication_screens/presentation/screens/login_screen.dart';
import 'package:quick_hire/features/profile_screens/presentation/screens/freelancer_profile_screen.dart';

import '../../../HomeScreen/presentation/screen/home_screen.dart';
import '../cubit/navigation_cubit.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeScreen(),
      JobsScreen(),
      InboxScreen(),
      FreelancerProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        // Don't provide a new NavigationCubit here. The BlocProvider above will handle it.
        builder: (context, state) {
          return Scaffold(
            body: _screens[state],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.secondaryColor,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.backgroundColor,
              items: [
               BottomNavigationBarItem(
  icon: SvgPicture.asset(
    AppIcons.homeIcon, // Use the correct icon name from AppIcons
    color: state == 0 ? AppColors.primaryColor : AppColors.secondaryColor,
  ),
  label: 'Home',
),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                AppIcons.briefIcon, // Use the correct icon name from AppIcons
                color: state == 1 ? AppColors.primaryColor : AppColors.secondaryColor,
                ),
                  label: 'Jobs',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.inboxIcon, // Use the correct icon name from AppIcons
                    color: state == 2 ? AppColors.primaryColor : AppColors.secondaryColor,
                  ),
                  label: 'Inbox',
                ),
                 BottomNavigationBarItem(
                   icon: SvgPicture.asset(
                     AppIcons.userIcon, // Use the correct icon name from AppIcons
                     color: state == 3 ? AppColors.primaryColor : AppColors.secondaryColor,
                   ),
                  label: 'Profile',
                ),
              ],
              currentIndex: state,
              onTap: (index) {
                // Use the context to access the cubit and update the index
                context.read<NavigationCubit>().updateIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


