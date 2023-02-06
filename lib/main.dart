import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/core/app_them.dart';
import 'package:posts_app_fire/features/splash/splash_view.dart';
import 'core/injiction_container.dart' as di;
import 'core/bloc_observer.dart';
import 'features/posts/presentation/cubit/add_delete_update/add_delete_update_post_cubit.dart';
import 'features/posts/presentation/cubit/get_all_posts/get_all_posts_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<GetAllPostsCubit>()..getAllPosts()),
        BlocProvider(create: (context) => di.sl<AddDeleteUpdateCubit>()),
      ],
      child: MaterialApp(
        theme: appTheme,
        title: 'Posts App',
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
