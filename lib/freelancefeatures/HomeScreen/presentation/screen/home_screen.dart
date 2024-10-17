import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../authintication_screens/presentation/screens/login_screen.dart';
import '../../../job_screens/presentation/screens/category_screen.dart';
import '../cubit/job_cubit/job_cubit.dart';
import '../widget/job_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final List<int> items = [1, 2, 3, 4, 5]; // Example items

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.settingIcon,
            color: Colors.white,
          ),
          onPressed: () async {
            final authLocalDataSource = AuthLocalDataSource(const FlutterSecureStorage());
            await authLocalDataSource.deleteToken();
            await authLocalDataSource.deleteId();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<JobCubit>().fetchJobs();
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
                ),
                const SizedBox(height: 20),
                // Carousel slider
                CarouselSlider(
                  items: items.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'text $i',
                              style: const TextStyle(fontSize: 16.0),
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
                      setState(() {
                        _currentIndex = index;
                      });
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
                        color: _currentIndex == index
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
                    height: MediaQuery.of(context).size.height * 0.10, // Fixed height for the grid
                    child: ListView.builder(
                      itemCount: 4,
                      // Display 4 items0
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      // Disable scroll inside ListView
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print('Category $index');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryScreen(categoryName: index)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.025),
                            // Add vertical margin between items
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.05),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.50),
                                // Change color and opacity as needed
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Category $index',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                // Job listings
                Row(
                  children: [
                    Text(
                      "Job Listings",
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
                                builder: (context) => const JobListWidget()));
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
                    child: const JobListWidget(
                      isHasLimit: true,
                      limit: 5,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}