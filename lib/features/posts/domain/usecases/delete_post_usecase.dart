import 'package:dartz/dartz.dart';
import 'package:posts_app_fire/core/error/failure.dart';
import 'package:posts_app_fire/features/posts/domain/repository/posts_repository.dart';

class DeletePostUsecase {
  final PostRepository postRepository;
  DeletePostUsecase({required this.postRepository});
  Future<Either<Failure, Unit>> call(String postId) async {
    return await postRepository.deletePost(postId);
  }
}
