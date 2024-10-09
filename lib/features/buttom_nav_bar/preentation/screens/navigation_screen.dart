import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/features/authintication_screens/presentation/screens/login_screen.dart';

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
      ProfileScreen(),
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: 'Jobs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.email),
                  label: 'Inbox',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
