import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import 'package:quick_hire/features/job_screens/presentation/screens/category_screen.dart';

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
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Quick Hire",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: controller,
                hintText: "Search for a new job",
                obscureText: false,
              ),
              SizedBox(height: 20),
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
                            style: TextStyle(fontSize: 16.0),
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
              SizedBox(height: 10),
              // Dots for transition
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.map((i) {
                  int index = items.indexOf(i);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? AppColors.primaryColor // Active dot color
                          : Colors.grey, // Inactive dot color
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Popular Categories",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.primaryColor,
                        ),
                  ),
                  Spacer(),
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
              Container(
                height: MediaQuery.of(context).size.height *
                    0.22, // Fixed height for the grid
                child: GridView.builder(
                  itemCount: 8,
                  // Number of categories
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 4 columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0, // Square cells
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  // Disable scroll inside GridView
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        print('Category $index');
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>   CategoryScreen(categoryName: index)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.05),
                          border: Border.all(
                            color: Colors.black.withOpacity(
                                0.50), // Change color and opacity as needed

                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Category $index',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => JobListWidget()));
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
                  child: JobListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
