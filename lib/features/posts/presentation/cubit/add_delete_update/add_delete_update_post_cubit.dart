import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/core/strings/failure_messages.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/update_post_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entites/posts.dart';
import 'add_delete_update_post_states.dart';

class AddDeleteUpdateCubit extends Cubit<AddDeleteUpdateStates> {
  AddPostsUseCase addPostUseCase;
  DeletePostUsecase deletePostUseCase;
  UpdatePostUseCase updatePostUseCase;

  AddDeleteUpdateCubit({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
  }) : super(AddDeleteUpdateInitialState());

  static AddDeleteUpdateCubit get(context) => BlocProvider.of(context);

  //-- Add Post
  Future addPost({required Post post}) async {
    emit(AddPostLoadingState());
    Either<Failure, void> response = await addPostUseCase.call(post);
    emit(
      response.fold((failure) {
        return AddPostErrorState(msg: _mapFailureToMessage(failure));
      }, (_) {
        return AddPostSuccessState(post: post, msg: ADD_SUCCESS_MESSAGE);
      }),
    );
  }

  //-- Delete Post
  Future deletePost({required String postId, String? postIbdex}) async {
    emit(DeletePostLoadingState());
    Either<Failure, Unit> response = await deletePostUseCase.call(postId);
    emit(
      response.fold((failure) {
        return DeletePostErrorState(msg: _mapFailureToMessage(failure));
      }, (_) {
        return DeletePostSuccessState(msg: DELETE_SUCCESS_MESSAGE);
      }),
    );
  }

  //-- Update Post
  Future updatePost({required Post post}) async {
    emit(UpdatePostLoadingState());
    Either<Failure, Unit> response = await updatePostUseCase.call(post);
    emit(
      response.fold((failure) {
        return UpdatePostErrorState(msg: _mapFailureToMessage(failure));
      }, (r) {
        return UpdatePostSuccessState(post: post, msg: UPDATE_SUCCESS_MESSAGE);
      }),
    );
  }

  //-- Failure Message
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
