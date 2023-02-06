import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app_fire/core/network/network_info.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app_fire/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/posts/data/datasources/post_local_data_source.dart';
import '../features/posts/data/datasources/post_remote_data_source.dart';
import '../features/posts/data/repository/post_repository_impl.dart';
import '../features/posts/domain/repository/posts_repository.dart';
import '../features/posts/domain/usecases/get_all_posts_usecase.dart';
import '../features/posts/presentation/cubit/add_delete_update/add_delete_update_post_cubit.dart';
import '../features/posts/presentation/cubit/get_all_posts/get_all_posts_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // -- Feature Posts

  // Bloc
  sl.registerFactory(() => GetAllPostsCubit(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateCubit(
      addPostUseCase: sl(), deletePostUseCase: sl(), updatePostUseCase: sl()));

  // useCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => AddPostsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postRepository: sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      postRemoteDataSource: sl(),
      postLocalDataSource: sl(),
      networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //-- Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //-- External
  final sharedpreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedpreferences);

  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
