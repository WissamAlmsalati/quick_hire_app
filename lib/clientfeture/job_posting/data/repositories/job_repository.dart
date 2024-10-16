import 'package:quick_hire/clientfeture/job_posting/data/models/job_post_model.dart';

abstract class PostJobRepository {
  Future<void> postJob(PostJobModel job);
}