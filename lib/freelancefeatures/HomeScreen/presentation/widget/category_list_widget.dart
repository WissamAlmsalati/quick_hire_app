import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_hire/core/utils/constants.dart';
import '../../data/repositories/category_repository.dart';
import '../cubit/category_cubit/category_cubit.dart';
import '../cubit/category_cubit/category_state.dart';
import 'package:quick_hire/freelancefeatures/job_screens/presentation/screens/category_screen.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(CategoryRepository())..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Container(
              height: MediaQuery.of(context).size.width * 0.4, // Adjusted for image and name
              child: ListView.builder(
                itemCount: state.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final category = state.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            categoryName: category.name,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.03,
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

                                '${category.image}',
                                height: MediaQuery.of(context).size.width * 0.1, // Adjusted image size to fit name
                                width: MediaQuery.of(context).size.width * 0.1,
                                fit: BoxFit.cover,
                              ),
                              // Added spacing between image and name

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
