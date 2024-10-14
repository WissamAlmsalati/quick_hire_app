// lib/features/HomeScreen/domain/usecases/apply_job.dart
import '../../data/repositories/job_repository.dart';

class ApplyJob {
  final JobRepository repository;

  ApplyJob({required this.repository});

  Future<void> call(String jobId, String freelancerId) async {
    return await repository.applyJob(jobId, freelancerId);
  }
}