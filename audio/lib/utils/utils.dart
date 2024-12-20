import 'package:audio/resources/game_method.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String data) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                GameMethods().clearBoard(context);
                Navigator.pop(context);
              },
              child: const Text('Play Again'))
        ],
      );
    },
  );
}
