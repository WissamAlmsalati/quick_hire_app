import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/skill_buttons.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import '../../../../freelancefeatures/HomeScreen/presentation/widget/job_list_widget.dart';
import '../../../../freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../../freelancefeatures/authintication_screens/presentation/screens/login_screen.dart';
import '../../../../freelancefeatures/job_screens/presentation/screens/category_screen.dart';
import '../../../../freelancefeatures/profile_screens/presentation/cubit/profile_cubit.dart';
import '../../../../freelancefeatures/profile_screens/presentation/screens/edit_profile_screen.dart';
import '../../../inbox_feature/presentation/screens/inbox_screens.dart';
import '../../../inbox_feauter/presentation/screens/inbox_screen.dart';
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
                      margin:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
                    height: MediaQuery.of(context).size.height *
                        0.10, // Fixed height for the grid
                    child: ListView.builder(
                      itemCount: 4,
                      // Display 4 items
                      physics: const NeverScrollableScrollPhysics(),
                      // Disable scroll inside ListView
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print('Category $index');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryScreen(categoryName: "w", index: 2,)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.025),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.05),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.50),
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
          children: [
            ClientActiveJobsScreen(),
            ClientPostedJobsScreen(),
          ],
        ),
      ),
    );
  }
}



class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the profile when the screen is initialized
    context.read<ProfileCubit>().fetchProfile('user_id'); // Replace 'user_id' with the actual user ID
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final profileData = state.profileData;
                final skills = profileData.skills ?? []; // Ensure skills is not null
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/cyclops-profile.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                            );
                          },
                          icon: SvgPicture.asset(
                            AppIcons.editIcon,
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      profileData.username,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                    Text(
                      profileData.email,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.locationIcon,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Text(
                          'baxter building',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    const Divider(color: Colors.grey),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          'Skills & Expertise:',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        TextButton(onPressed: () {}, child: const Text("See all")),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: skills.map((skill) {
                        return SkillButtons(skillName: skill);
                      }).toList(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    const Divider(color: Colors.grey),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rates & Pricing',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          'Logo Design: 300',
                          style: TextStyle(
                            color: AppColors.typographyColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          'App Ui: 200',
                          style: TextStyle(
                            color: AppColors.typographyColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    const Divider(color: Colors.grey),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    Row(
                      children: [
                        Text(
                          'Last worked on projects:',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    SizedBox(
                      height: 600, // Set a fixed height for the JobListWidget
                      child: const JobListWidget(),
                    ),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Error"));
              }
            },
          ),
        ),
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



