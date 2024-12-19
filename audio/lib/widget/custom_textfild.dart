import 'package:audio/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfild extends StatelessWidget {
  final TextEditingController controller;
  final bool isreadOnly;
  final String hintText;
  const CustomTextfild(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isreadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.blue, blurRadius: 5, spreadRadius: 2)
      ]),
      child: TextField(
        controller: controller,
        readOnly: isreadOnly,
        decoration: InputDecoration(
          fillColor: bgColor,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
