import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/core/error/failure.dart';
import 'package:posts_app_fire/core/strings/failure_messages.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:posts_app_fire/features/posts/presentation/cubit/get_all_posts/get_all_posts_states.dart';

import '../../../domain/entites/posts.dart';

class GetAllPostsCubit extends Cubit<GetAllPostsStates> {
  GetAllPostsUseCase getAllPostsUseCase;
  GetAllPostsCubit({required this.getAllPostsUseCase})
      : super(GetAllPostsInitialState());
  static GetAllPostsCubit get(context) => BlocProvider.of(context);
  Future getAllPosts() async {
    emit(GetAllPostsLoadingState());
    Either<Failure, List<Post>> response = await getAllPostsUseCase.call();
    emit(
      response.fold((failure) {
        return GetAllPostsErrortate(msg: _mapFailureToMessage(failure));
      }, (posts) {
        return GetAllPostsSuccessState(posts: posts);
      }),
    );
  }

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
