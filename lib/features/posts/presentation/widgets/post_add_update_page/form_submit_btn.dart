import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  final void Function() onPreesed;
  final bool isUpdataePost;
  const FormSubmitButton({
    Key? key,
    required this.onPreesed,
    required this.isUpdataePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPreesed,
      icon: isUpdataePost ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: Text(isUpdataePost ? "Update" : "Add"),
    );
  }
}
