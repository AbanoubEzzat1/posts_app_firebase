import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/add_delete_update/add_delete_update_post_cubit.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String postId;

  const DeleteDialogWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdateCubit>(context)
                .deletePost(postId: postId);
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
