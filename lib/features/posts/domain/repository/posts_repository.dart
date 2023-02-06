import 'package:dartz/dartz.dart';
import 'package:posts_app_fire/features/posts/domain/entites/posts.dart';

import '../../../../core/error/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, Unit>> updatePost(Post post);
}
