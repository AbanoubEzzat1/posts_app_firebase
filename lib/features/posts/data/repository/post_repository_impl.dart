// ignore_for_file: prefer_generic_function_type_aliases

import 'package:posts_app_fire/core/error/exception.dart';
import 'package:posts_app_fire/core/network/network_info.dart';
import 'package:posts_app_fire/features/posts/data/datasources/post_local_data_source.dart';
import 'package:posts_app_fire/features/posts/data/models/post_model.dart';
import 'package:posts_app_fire/features/posts/domain/entites/posts.dart';
import 'package:posts_app_fire/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app_fire/features/posts/domain/repository/posts_repository.dart';

import '../datasources/post_remote_data_source.dart';

typedef Future<Unit> AddOrDeleteOrUpdatePost();

class PostRepositoryImpl implements PostRepository {
  PostRemoteDataSource postRemoteDataSource;
  PostLocalDataSource postLocalDataSource;

  final NetworkInfo networkInfo;
  PostRepositoryImpl({
    required this.postRemoteDataSource,
    required this.postLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isConnected) {
      try {
        postRemoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    return await _getMessage(() => postRemoteDataSource.deletePost(postId));
  }

  Future<Either<Failure, Unit>> _getMessage(
      AddOrDeleteOrUpdatePost addOrDeleteOrUpdatePost) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrDeleteOrUpdatePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
