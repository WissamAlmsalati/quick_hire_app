import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../../freelancefeatures/authintication_screens/presentation/screens/login_screen.dart';
import '../../../inbox_feature/presentation/screens/inbox_screens.dart';
import '../../../job_posting/presentation/screens/post_job_screen.dart';
import '../cubit/navigation_cubit.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  Widget build(BuildContext context) {
    List<Widget> _screens = [
      ClentHomeScreen(),
      ClientActiveJobs(),
      ClentPostJob(),
      ClientInboxApplication(),
      ClientProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
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
                    AppIcons.homeIcon,
                    color: state == 0
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.briefIcon,
                    color: state == 1
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                  ),
                  label: 'Jobs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Post Job',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.inboxIcon,
                    color: state == 3
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                  ),
                  label: 'Inbox',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.userIcon,
                    color: state == 4
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: state,
              onTap: (index) {
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
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class ClientActiveJobs extends StatelessWidget {
  const ClientActiveJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Active Jobs',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
            unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
            tabs: [
              Tab(text: 'Active Jobs'),
              Tab(text: 'Job Posted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [],
        ),
      ),
    );
  }
}

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final authLocalDataSource =
                  AuthLocalDataSource(const FlutterSecureStorage());
              await authLocalDataSource.deleteToken();
              await authLocalDataSource.deleteId();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class SkillsDropdown extends StatefulWidget {
  final Function(List<String>) onSkillsSelected;

  const SkillsDropdown({super.key, required this.onSkillsSelected});

  @override
  _SkillsDropdownState createState() => _SkillsDropdownState();
}

class _SkillsDropdownState extends State<SkillsDropdown> {
  List<String> _selectedSkills = [];
  final TextEditingController _skillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _skillController,
          decoration: InputDecoration(
            labelText: 'Enter Skill',
            hintText: 'Type a skill',
            suffixIcon: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                final newSkill = _skillController.text.trim();
                if (newSkill.isNotEmpty &&
                    !_selectedSkills.contains(newSkill)) {
                  setState(() {
                    _selectedSkills.add(newSkill);
                  });
                  widget.onSkillsSelected(_selectedSkills);
                  _skillController.clear();
                }
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _selectedSkills.map((skill) {
            return Chip(
              label: Text(skill),
              onDeleted: () {
                setState(() {
                  _selectedSkills.remove(skill);
                });
                widget.onSkillsSelected(_selectedSkills);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
