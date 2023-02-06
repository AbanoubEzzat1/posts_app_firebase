import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/core/widgets/loading_widget.dart';
import 'package:posts_app_fire/features/posts/presentation/cubit/get_all_posts/get_all_posts_cubit.dart';
import 'package:posts_app_fire/features/posts/presentation/pages/posts_page.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../domain/entites/posts.dart';
import '../cubit/add_delete_update/add_delete_update_post_cubit.dart';
import '../cubit/add_delete_update/add_delete_update_post_states.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text(isUpdatePost ? "Update Post" : "Add Post"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddDeleteUpdateCubit, AddDeleteUpdateStates>(
          listener: (context, state) {
            if (state is AddPostSuccessState) {
              _getAllPosts(context);
              SnackBarMessage()
                  .showSuccessSnackBar(message: state.msg, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            } else if (state is UpdatePostSuccessState) {
              _getAllPosts(context);
              SnackBarMessage()
                  .showSuccessSnackBar(message: state.msg, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            } else if (state is AddPostErrorState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.msg, context: context);
            } else if (state is UpdatePostErrorState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.msg, context: context);
            }
          },
          builder: (context, state) {
            if (state is AddPostLoadingState ||
                state is UpdatePostLoadingState) {
              return const LoadingWidget();
            }
            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }

  Future<void> _getAllPosts(BuildContext context) async {
    await GetAllPostsCubit.get(context).getAllPosts();
  }
}
