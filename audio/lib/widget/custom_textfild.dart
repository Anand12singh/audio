import 'package:audio/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextfild(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.blue, blurRadius: 5, spreadRadius: 2)
      ]),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: bgColor,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
