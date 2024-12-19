import 'dart:developer';
import 'package:audio/provider/room_dataprovider.dart';
import 'package:audio/resources/socket.dart';
import 'package:audio/screens/game_screen.dart';
import 'package:audio/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;

//emit
  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient!.emit("createRoom", {"nickName": nickName});
      log('Create room request sent: $nickName');
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient!.emit("joinRoom", {"nickName": nickName, "roomId": roomId});
    }
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
}
