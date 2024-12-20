// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:audio/model/player.dart';
import 'package:flutter/foundation.dart';

class RoomDataprovider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  int _fildBox = 0;
  Player _player1 =
      Player(nickName: "", socketId: "", points: 0, playerType: "X");
  Player _player2 =
      Player(nickName: "", socketId: "", points: 0, playerType: "O");
  Map<String, dynamic> get roomData => _roomData;

  Player get player1 => _player1;
  Player get player2 => _player2;
  int get filledBoxes => _fildBox;

  List<String> get displayElement => _displayElement;

  List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];

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

  void updateDisplayElement(int index, String choice) {
    _displayElement[index] = choice;
    log(_displayElement[index].toString());
    _fildBox += 1;
    log("_fildBox:$_fildBox");

    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _fildBox = 0;
  }
}
