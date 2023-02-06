import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool multiLiens;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.name,
    required this.multiLiens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        maxLines: multiLiens ? 6 : 1,
        minLines: multiLiens ? 6 : 1,
        validator: (value) => value!.isEmpty ? "$name can't be empty" : null,
        decoration: InputDecoration(hintText: name),
      ),
    );
  }
}
