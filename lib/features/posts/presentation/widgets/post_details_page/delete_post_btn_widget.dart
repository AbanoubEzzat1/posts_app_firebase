import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/features/posts/presentation/widgets/post_details_page/delete_dialog_widget.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';

import '../../cubit/add_delete_update/add_delete_update_post_cubit.dart';
import '../../cubit/add_delete_update/add_delete_update_post_states.dart';
import '../../cubit/get_all_posts/get_all_posts_cubit.dart';
import '../../pages/posts_page.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final String postId;

  const DeletePostBtnWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, String postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdateCubit, AddDeleteUpdateStates>(
            listener: (context, state) {
              if (state is DeletePostSuccessState) {
                _getAllPosts(context);
                SnackBarMessage()
                    .showSuccessSnackBar(message: state.msg, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsPage(),
                    ),
                    (route) => false);
              } else if (state is DeletePostErrorState) {
                Navigator.of(context).pop();
                SnackBarMessage()
                    .showErrorSnackBar(message: state.msg, context: context);
              }
            },
            builder: (context, state) {
              if (state is DeletePostLoadingState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }

  Future<void> _getAllPosts(BuildContext context) async {
    await GetAllPostsCubit.get(context).getAllPosts();
  }
}
