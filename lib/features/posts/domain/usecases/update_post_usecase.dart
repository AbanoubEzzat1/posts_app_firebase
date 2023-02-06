import 'package:dartz/dartz.dart';
import 'package:posts_app_fire/core/error/failure.dart';
import 'package:posts_app_fire/features/posts/domain/entites/posts.dart';
import 'package:posts_app_fire/features/posts/domain/repository/posts_repository.dart';

class UpdatePostUseCase {
  final PostRepository postRepository;
  UpdatePostUseCase({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.updatePost(post);
  }
}
