import 'dart:developer';
import 'package:audio/resources/socket.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient!.emit("createRoom", {"nickName": nickName});
      log('Create room request sent: $nickName');
    }
  }
}
