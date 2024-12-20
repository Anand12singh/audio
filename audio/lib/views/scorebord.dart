import 'package:audio/provider/room_dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Scorebord extends StatelessWidget {
  const Scorebord({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataprovider roomDataprovider = Provider.of<RoomDataprovider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Nickname : ${roomDataprovider.player1.nickName}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text("Point : ${roomDataprovider.player1.points}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text("Nickname : ${roomDataprovider.player2.nickName}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text("Point : ${roomDataprovider.player2.points}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
