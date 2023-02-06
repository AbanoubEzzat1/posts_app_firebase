import 'package:equatable/equatable.dart';
import 'package:posts_app_fire/features/posts/domain/entites/posts.dart';

abstract class GetAllPostsStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllPostsInitialState extends GetAllPostsStates {}

class GetAllPostsLoadingState extends GetAllPostsStates {}

class GetAllPostsSuccessState extends GetAllPostsStates {
  final List<Post> posts;
  GetAllPostsSuccessState({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class GetAllPostsErrortate extends GetAllPostsStates {
  final String msg;
  GetAllPostsErrortate({required this.msg});
  @override
  List<Object?> get props => [msg];
}
