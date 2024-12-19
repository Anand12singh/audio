import 'package:flutter/material.dart';

class Ticktockbord extends StatefulWidget {
  const Ticktockbord({super.key});

  @override
  State<Ticktockbord> createState() => _TicktockbordState();
}

class _TicktockbordState extends State<Ticktockbord> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.white24)),
            child: Center(
              child: Text(
                'X',
                style: TextStyle(
                    fontSize: 100,
                    shadows: [Shadow(blurRadius: 40, color: Colors.blue)]),
              ),
            ),
          );
        },
      ),
    );
  }
}
