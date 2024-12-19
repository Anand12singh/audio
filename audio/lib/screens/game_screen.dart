import 'dart:developer';

import 'package:audio/provider/room_dataprovider.dart';
import 'package:audio/resources/socket_methods.dart';
import 'package:audio/views/scorebord.dart';
import 'package:audio/views/ticktockbord.dart';
import 'package:audio/views/waiting_lobi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    socketMethods.updateroomListener(context);
    socketMethods.updateplayerstateListner(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataprovider roomDataprovider = Provider.of<RoomDataprovider>(context);

    Provider.of<RoomDataprovider>(context).roomData.toString();
    log(Provider.of<RoomDataprovider>(context).player1.nickName.toString());
    log(Provider.of<RoomDataprovider>(context).player2.nickName.toString());

    return Scaffold(
        body: roomDataprovider.roomData['isjoin']
            ? WaitingLobi()
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Scorebord(), Ticktockbord()],
              )));
  }
}
