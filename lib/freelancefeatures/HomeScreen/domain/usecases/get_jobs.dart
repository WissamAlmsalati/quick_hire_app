import '../repositories/job_repository_interface.dart';
import '../entities/job.dart';

class GetJobs {
  final JobRepositoryInterface repository;

  GetJobs({required this.repository});

  Future<List<Job>> call() async {
    print('GetJobs called');
    return await repository.getAllJobs();
  }
}
