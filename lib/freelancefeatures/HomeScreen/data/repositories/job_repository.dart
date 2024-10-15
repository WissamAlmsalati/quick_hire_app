// lib/features/HomeScreen/data/repositories/job_repository.dart
import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository_interface.dart';
import '../datasources/job_remote_data_source.dart';

class JobRepository implements JobRepositoryInterface {
  final JobRemoteDataSource remoteDataSource;

  JobRepository({required this.remoteDataSource});

  @override
  Future<List<Job>> getAllJobs() async {
    return await remoteDataSource.getAllJobs();
  }

  Future<void> applyJob(String jobId, String freelancerId) async {
    return await remoteDataSource.applyJob(jobId, freelancerId);
  }
}