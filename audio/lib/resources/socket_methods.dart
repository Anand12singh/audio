import 'dart:developer';

import 'package:audio/provider/room_dataprovider.dart';
import 'package:audio/resources/game_method.dart';
import 'package:audio/resources/socket.dart';
import 'package:audio/screens/game_screen.dart';
import 'package:audio/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final Socket _socketClient;

  SocketMethods() : _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

//emit
  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient!.emit("createRoom", {"nickName": nickName});
      log('Create room request sent: $nickName');
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit("joinRoom", {"nickName": nickName, "roomId": roomId});
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElement) {
    if (displayElement[index] == '') {
      log('tap grid empty');
      _socketClient.emit('tap', {'index': index, 'roomId': roomId});
    }
    log('tap grid not empty');
  }

//Listener
  void createRoomSuccessListener(BuildContext context) {
    print('Inside In createRoomSuccessListener');
    _socketClient!.on('createRoomSuccess', (room) {
      Provider.of<RoomDataprovider>(context, listen: false)
          .updateRoomData(room);
      if (kDebugMode) {
        print('room :${room}');
      }

      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    if (kDebugMode) {
      print('Enter In Join Room');
    }
    _socketClient!.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataprovider>(context, listen: false)
          .updateRoomData(room);
      if (kDebugMode) {
        print('room :${room}');
      }

      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorListener(BuildContext context) {
    _socketClient!.on('error', (error) {
      showSnackBar(context, error);
      if (kDebugMode) {
        print(error);
      }
    });
  }

//function

  void updateplayerstateListner(BuildContext context) {
    _socketClient!.on("updateplayers", (playerData) {
      Provider.of<RoomDataprovider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataprovider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

//updateroomListener

  void updateroomListener(BuildContext context) {
    _socketClient!.on('updateRoom', (updateRoom) {
      Provider.of<RoomDataprovider>(context, listen: false)
          .updateRoomData(updateRoom);
    });
  }

  void tappedListener(BuildContext context) {
    log("tappedListener");
    _socketClient.on('tapped', (data) {
      RoomDataprovider roomDataprovider =
          Provider.of<RoomDataprovider>(context, listen: false);
      roomDataprovider.updateDisplayElement(data['index'], data['choice']);
      log(data['choice'], name: 'choice');
      roomDataprovider.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncrease(BuildContext context) {
    _socketClient.on("pointIncrease", (player1Data) {
      RoomDataprovider roomDataprovider =
          Provider.of<RoomDataprovider>(context, listen: false);

      if (player1Data['socketId'] == roomDataprovider.player1.socketId) {
        roomDataprovider.updatePlayer1(player1Data);
      } else {
        roomDataprovider.updatePlayer2(player1Data);
      }
    });
  }

  void endGameLisntener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['nickName']} Won The game!');

      Navigator.popUntil(context, (route) => false);
    });
  }
}
