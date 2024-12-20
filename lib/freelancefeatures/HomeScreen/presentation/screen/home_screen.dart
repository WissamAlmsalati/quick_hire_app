import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/freelancefeatures/job_feature/presentation/screen/job_screen.dart';

import '../../../../clientfeture/search_feature/presentation/screens/search_screen.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../authintication_screens/presentation/screens/login_screen.dart';
import '../../../job_screens/presentation/screens/category_screen.dart';
import '../cubit/job_cubit/job_cubit.dart';
import '../widget/job_list_widget.dart';
import '../widget/category_list_widget.dart';

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
    final List<int> items = [1, 2, 3]; // Example items matching the number of images

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SearchScreen()),
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
                // Replace the existing ListView.builder with CategoryListWidget
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: const CategoryListWidget(),
                ),
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
                                builder: (context) => const JobsScreen()));
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
                    height: MediaQuery.sizeOf(context).height * 0.53,
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