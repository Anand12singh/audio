import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttName;
  const CustomButton({super.key, required this.onTap, required this.buttName});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 5)]),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          buttName,
          style: const TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(width, 50), backgroundColor: Colors.blue),
      ),
    );
  }
}
