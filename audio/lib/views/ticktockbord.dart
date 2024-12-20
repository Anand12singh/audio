import 'dart:developer';

import 'package:audio/provider/room_dataprovider.dart';
import 'package:audio/resources/socket_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ticktockbord extends StatefulWidget {
  const Ticktockbord({super.key});

  @override
  State<Ticktockbord> createState() => _TicktockbordState();
}

class _TicktockbordState extends State<Ticktockbord> {
  final SocketMethods _socketMethods = SocketMethods();
  void tapped(int index, RoomDataprovider roomDataprovider) {
    _socketMethods.tapGrid(index, roomDataprovider.roomData['_id'],
        roomDataprovider.displayElement);
  }

  @override
  void initState() {
    _socketMethods.tappedListener(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataprovider roomDataprovider = Provider.of<RoomDataprovider>(context);
    log(roomDataprovider.roomData['turn']['socketId'].toString());
    log(_socketMethods.socketClient.id.toString(), name: 'socketId');
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        absorbing: roomDataprovider.roomData['turn']['socketId'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                log('tabb');
                log(roomDataprovider.roomData['turn']['socketId'],
                    name: 'socketId');
                log(_socketMethods.socketClient.id.toString(),
                    name: 'fromflutter');
                tapped(index, roomDataprovider);
                // log('tabb index $index');
                log(roomDataprovider.displayElement.toString());
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white24)),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataprovider.displayElement[index],
                      style: TextStyle(fontSize: 100, shadows: [
                        Shadow(
                            blurRadius: 40,
                            color: roomDataprovider.displayElement[index] == "X"
                                ? Colors.red
                                : Colors.blue)
                      ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
