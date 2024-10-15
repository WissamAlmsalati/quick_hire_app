import '../entities/job.dart';

abstract class JobRepositoryInterface {
  Future<List<Job>> getAllJobs();
}
