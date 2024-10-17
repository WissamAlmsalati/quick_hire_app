import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../freelancefeatures/HomeScreen/data/repositories/category_repository.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/cubit/category_cubit/category_cubit.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/cubit/category_cubit/category_state.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/widget/job_list_widget.dart';
import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../../freelancefeatures/authintication_screens/presentation/screens/login_screen.dart';
import '../../../../freelancefeatures/job_screens/presentation/screens/category_screen.dart';
import '../../../inbox_feature/presentation/screens/inbox_screens.dart';
import '../../../job_posting/presentation/screens/post_job_screen.dart';
import '../cubit/navigation_cubit.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const ClentHomeScreen(),
      const ClientActiveJobs(),
      ClentPostJob(),
      const ClientInboxApplication(),
      const ClientProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: screens[state],
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
                const BottomNavigationBarItem(
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
  const ClentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(CategoryRepository())..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final category = state.categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          index: index,
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.025,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.05,
                      ),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.50),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/${category.image}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoryError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No categories available'));
          }
        },
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
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
            tabs: const [
              Tab(text: 'Active Jobs'),
              Tab(text: 'Job Posted'),
            ],
          ),
        ),
        body: const TabBarView(
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
  final List<String> _selectedSkills = [];
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
              icon: const Icon(Icons.check),
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
        const SizedBox(height: 10),
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
