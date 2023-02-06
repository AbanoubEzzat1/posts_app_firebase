import 'package:dartz/dartz.dart';
import 'package:posts_app_fire/features/posts/domain/repository/posts_repository.dart';

import '../../../../core/error/failure.dart';
import '../entites/posts.dart';

class GetAllPostsUseCase {
  final PostRepository postRepository;
  GetAllPostsUseCase({required this.postRepository});
  Future<Either<Failure, List<Post>>> call() async {
    return await postRepository.getAllPosts();
  }
}
