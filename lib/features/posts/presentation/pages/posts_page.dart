import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/core/widgets/loading_widget.dart';
import 'package:posts_app_fire/features/posts/presentation/cubit/get_all_posts/get_all_posts_states.dart';
import 'package:posts_app_fire/features/posts/presentation/pages/post_add_update_page.dart';

import '../cubit/get_all_posts/get_all_posts_cubit.dart';
import '../widgets/post_page/message_display.dart';
import '../widgets/post_page/post_list_widget.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildfloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text("Posts"),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<GetAllPostsCubit, GetAllPostsStates>(
        listener: (context, state) {
          if (state is GetAllPostsSuccessState) {
            //GetAllPostsCubit.get(context).getAllPosts();
            //PostListWidget(post: state.posts);
            //_onRefresh(context);
          }
        },
        builder: (context, state) {
          if (state is GetAllPostsLoadingState) {
            return const LoadingWidget();
          } else if (state is GetAllPostsSuccessState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(post: state.posts));
          } else if (state is GetAllPostsErrortate) {
            return MessageDisplayWidget(message: state.msg);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    //BlocProvider.of<GetAllPostsCubit>(context).getAllPosts();
    GetAllPostsCubit.get(context).getAllPosts();
  }

  _buildfloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(
                      isUpdatePost: false,
                    )));
      },
      child: const Icon(Icons.add),
    );
  }
}
