import 'package:flutter/material.dart';
import 'package:posts_app_fire/features/posts/presentation/widgets/post_details_page/delete_post_btn_widget.dart';
import 'package:posts_app_fire/features/posts/presentation/widgets/post_details_page/update_post_btn_widget.dart';

import '../../../domain/entites/posts.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;

  const PostDetailsWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!),
            ],
          ),
        ],
      ),
    );
  }
}
