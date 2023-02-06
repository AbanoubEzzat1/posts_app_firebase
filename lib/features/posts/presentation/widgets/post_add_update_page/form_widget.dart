import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_fire/features/posts/presentation/widgets/post_add_update_page/form_submit_btn.dart';
import 'package:posts_app_fire/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart.dart';

import '../../../domain/entites/posts.dart';
import '../../cubit/add_delete_update/add_delete_update_post_cubit.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLiens: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLiens: true, controller: _bodyController),
            FormSubmitButton(
                isUpdataePost: widget.isUpdatePost,
                onPreesed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdateCubit>(context).updatePost(post: post);
      } else {
        BlocProvider.of<AddDeleteUpdateCubit>(context).addPost(post: post);
      }
    }
  }
}
