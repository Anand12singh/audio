// ignore_for_file: prefer_final_fields

import 'package:audio/model/player.dart';
import 'package:flutter/foundation.dart';

class RoomDataprovider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  Player _player1 =
      Player(nickName: "", socketId: "", points: 0, playerType: "X");
  Player _player2 =
      Player(nickName: "", socketId: "", points: 0, playerType: "O");

  Player get player1 => _player1;
  Player get player2 => _player2;

  Map<String, dynamic> get roomData => _roomData;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }
}
