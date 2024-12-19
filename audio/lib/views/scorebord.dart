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
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                "Nickname player 1: ${roomDataprovider.player1.nickName}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Point player 1: ${roomDataprovider.player1.points}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text("Nickname player 2: ${roomDataprovider.player2.nickName}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Point player 2: ${roomDataprovider.player2.points}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
