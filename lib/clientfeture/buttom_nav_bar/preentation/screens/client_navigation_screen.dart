import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/skill_buttons.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/widget/category_list_widget.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/widget/freelance_list.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/widget/job_list_widget.dart';
import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../../freelancefeatures/authintication_screens/presentation/screens/login_screen.dart';
import '../../../../freelancefeatures/job_screens/presentation/screens/category_screen.dart';
import '../../../../freelancefeatures/profile_screens/presentation/cubit/profile_cubit.dart';
import '../../../../freelancefeatures/profile_screens/presentation/screens/edit_profile_screen.dart';
import '../../../client_profile/presentation/screens/ClientProfileScreen.dart';
import '../../../inbox_feauter/presentation/screens/inbox_screen.dart';
import '../../../job_posting/presentation/screens/post_job_screen.dart';
import '../../../jobsFeature/activeJobs/widgets/active_jobs_widget.dart';
import '../../../search_feature/presentation/screens/search_screen.dart';
import '../cubit/navigation_cubit.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const ClentHomeScreen(),
      const ClientActiveJobs(),
      ClentPostJob(),
      const ClientInboxApplication(jobId: '',),
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
  const ClentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    int currentIndex = 0;

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
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<JobCubit>().fetchJobs();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  icon: AppIcons.searchIcon,
                  controller: controller,
                  hintText: "Search for a new job",
                  obscureText: false,
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Carousel slider
                CarouselSlider(
                  items: [
                    'assets/images/banner-1.png',
                    'assets/images/banner2.png',
                    'assets/images/banner-3.png',
                  ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      currentIndex = index;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Dots for transition
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: items.map((i) {
                    int index = items.indexOf(i);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? AppColors.primaryColor // Active dot color
                            : Colors.grey, // Inactive dot color
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Popular Categories",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View All",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                // Category grid with 2 rows and 4 columns
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: const CategoryListWidget(),
                ),
                // Job listings
                Row(
                  children: [
                    Text(
                      "Popular Freelancers",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JobListWidget(),
                          ),
                        );
                      },
                      child: Text(
                        "View All",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                // Job listings grid with 2 rows and 4 columns
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: FreelancerListWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}