import 'package:equatable/equatable.dart';

import '../../../domain/entites/posts.dart';

abstract class AddDeleteUpdateStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDeleteUpdateInitialState extends AddDeleteUpdateStates {}

//-- Add Post
class AddPostLoadingState extends AddDeleteUpdateStates {}

class AddPostSuccessState extends AddDeleteUpdateStates {
  final Post post;
  final String msg;
  AddPostSuccessState({required this.post, required this.msg});
  @override
  List<Object?> get props => [post];
}

class AddPostErrorState extends AddDeleteUpdateStates {
  final String msg;
  AddPostErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

//-- Delete Post
class DeletePostLoadingState extends AddDeleteUpdateStates {}

class DeletePostSuccessState extends AddDeleteUpdateStates {
  final String msg;
  DeletePostSuccessState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

class DeletePostErrorState extends AddDeleteUpdateStates {
  final String msg;
  DeletePostErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

//-- Update Post
class UpdatePostLoadingState extends AddDeleteUpdateStates {}

class UpdatePostSuccessState extends AddDeleteUpdateStates {
  final Post post;
  final String msg;
  UpdatePostSuccessState({required this.post, required this.msg});
  @override
  List<Object?> get props => [post];
}

class UpdatePostErrorState extends AddDeleteUpdateStates {
  final String msg;
  UpdatePostErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
