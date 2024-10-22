import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../frelancers_data/frelancer_data_cubit.dart';
import '../screen/freelance_detail.dart';
import '../../data/repositories/freelancer_repository.dart';

class FreelancerListWidget extends StatelessWidget {
  final bool isHasLimit;
  final int limit;

  const FreelancerListWidget({super.key, this.isHasLimit = false, this.limit = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FreelancerCubit(
        FreelancerRepository(baseUrl: 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com'),
      )..fetchFreelancers(),
      child: BlocBuilder<FreelancerCubit, FreelancerState>(
        builder: (context, state) {
          if (state is FreelancerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FreelancerError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FreelancerLoaded) {
            final freelancers = state.freelancers;
            return Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).aspectRatio * 0.04),
              child: ListView.builder(
                physics: isHasLimit ? const NeverScrollableScrollPhysics() : null,
                itemCount: isHasLimit ? limit : freelancers.length,
                itemBuilder: (context, index) {
                  final freelancer = freelancers[index];
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            freelancer.username, // Use the model's properties
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            freelancer.email,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/profile_icon.svg',
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width * 0.07,
                                height: MediaQuery.of(context).size.width * 0.07,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                              Text(
                                freelancer.bio,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent, width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
builder: (context) => FreelancerDetailScreen(freelancer: state.freelancers[index].toJson()),                                    ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.05,
                                      vertical: MediaQuery.of(context).size.width * 0.0001,
                                    ),
                                    child: Text(
                                      "See Profile",
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
