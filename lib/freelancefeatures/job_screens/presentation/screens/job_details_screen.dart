import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/utils/app_icon.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/core/widgets/custom_button.dart';
import 'package:quick_hire/core/widgets/skill_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../HomeScreen/data/datasources/job_remote_data_source.dart';
import '../../../HomeScreen/data/repositories/job_repository.dart';
import '../../../HomeScreen/domain/usecases/get_jobs.dart';
import '../../../HomeScreen/domain/usecases/job_repository.dart';
import '../../../HomeScreen/presentation/cubit/job_cubit/job_cubit.dart';
import '../../../authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../chat_feature/presentation/screens/chat_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  final int index;
  final bool showLastButtonRow;
  final bool showChatButton;

  const JobDetailsScreen({
    super.key,
    required this.index,
    this.showLastButtonRow = true,
    this.showChatButton = true,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  String? userType;

  @override
  void initState() {
    super.initState();
    _fetchUserType();
  }

  Future<void> _fetchUserType() async {
    final authLocalDataSource = AuthLocalDataSource(const FlutterSecureStorage());
    final type = await authLocalDataSource.getUserType();
    setState(() {
      userType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit(
        getJobs: GetJobs(
          repository: JobRepository(
            remoteDataSource: JobRemoteDataSourceImpl(client: http.Client()),
          ),
        ),
        applyJob: ApplyJob(
          repository: JobRepository(
            remoteDataSource: JobRemoteDataSourceImpl(client: http.Client()),
          ),
        ),
        authLocalDataSource: AuthLocalDataSource(const FlutterSecureStorage()),
      )..fetchJobs(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppIcons.backIcon,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: SvgPicture.asset('assets/images/quickhire logo.svg'),
        ),
        body: BlocConsumer<JobCubit, JobState>(
          listener: (context, state) {
            if (state is JobApplicationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Job application successful!')),
              );
            } else if (state is JobError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to apply for job: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state is JobLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is JobError) {
              return Center(child: Text(state.message));
            } else if (state is JobLoaded) {
              final job = state.jobs[widget.index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'assets/images/cyclops-profile.png',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              job.clientName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.typographyColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  job.deadline.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  job.canApply ? 'Active' : 'Inactive',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: job.canApply ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Looking for a ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.typographyColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: job.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              softWrap: true, // Enable text wrapping to a new line
                            ),

                          ],
                        ),
                        if (widget.showChatButton)
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(jobId: job.id.toString()),
                                ),
                              );
                            },
                            icon: Icon(Icons.chat),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Job Description:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      job.description,
                      style: TextStyle(
                        color: AppColors.typographyColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.locationIcon,
                          color: AppColors.secondaryColor,
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Location: ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          job.location,
                          style: TextStyle(
                            color: AppColors.typographyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.coinIcon,
                          color: AppColors.secondaryColor,
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Budget: ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          job.budget.toString(),
                          style: TextStyle(
                            color: AppColors.typographyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Skills and Expertise:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: job.skills.map((skill) => SkillButtons(skillName: skill)).toList(),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),

                    Spacer(),
                    if (widget.showLastButtonRow && userType == 'freelancer') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Apply Now',
                              onPressed: () {
                                context.read<JobCubit>().applyForJob(job.id);
                              },
                              color: AppColors.primaryColor,
                              textColor: AppColors.backgroundColor,
                              isHaveBorder: false,
                              fontSize: 16,
                              borderRadius: 10,
                              width: 100,
                              height: 50,
                              topPd: 10,
                              buttomPd: 10,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              text: 'Save Job',
                              onPressed: () {},
                              color: AppColors.backgroundColor,
                              textColor: AppColors.primaryColor,
                              isHaveBorder: true,
                              fontSize: 16,
                              borderRadius: 10,
                              width: 100,
                              height: 50,
                              topPd: 10,
                              buttomPd: 10,
                              borderColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}