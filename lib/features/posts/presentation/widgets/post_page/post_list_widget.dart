import 'package:flutter/material.dart';
import 'package:posts_app_fire/features/posts/presentation/pages/post_details_page.dart';

import '../../../domain/entites/posts.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> post;

  const PostListWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: post.length,
      itemBuilder: (context, index) {
        return ListTile(
          //leading: Text(post[index].id.toString()),
          leading: const Icon(Icons.tungsten_outlined),
          title: Text(
            post[index].title.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            post[index].body.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailsPage(
                  post: post[index],
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}
