import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../../freelancefeatures/authintication_screens/presentation/cubit/auth_cubit.dart';
import '../../../../freelancefeatures/authintication_screens/presentation/screens/login_screen.dart';
import '../cubit/navigation_cubit.dart';






class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  Widget build(BuildContext context) {
    List<Widget> _screens = [

      ClentHomeScreen(),
      ClientOffersScreen(),
      ClentPostJob(),
      ClientActiveJob(),
      ClientProfileScreen(),

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
                  icon: Icon(Icons.add),
                  label: 'Post Job',
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

class ClentHomeScreen extends StatelessWidget {
  const ClentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final authLocalDataSource =
              AuthLocalDataSource(FlutterSecureStorage());
              await authLocalDataSource.deleteToken();
              await authLocalDataSource.deleteId();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class ClientOffersScreen extends StatelessWidget {
  const ClientOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ClentPostJob extends StatelessWidget {
  const ClentPostJob({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ClientActiveJob extends StatelessWidget {
  const ClientActiveJob({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

