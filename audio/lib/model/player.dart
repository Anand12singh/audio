class Player {
  final String nickName;
  final String socketId;
  final int points;
  final String playerType;

  Player({
    required this.nickName,
    required this.socketId,
    required this.points,
    required this.playerType,
  });

  // Convert a Player object to a Map
  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  // Create a Player object from a Map
  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickName: map['nickName'] ?? '',
      socketId: map['socketId'] ?? '',
      points: map['points'] ?? 0,
      playerType: map['playerType'] ?? '',
    );
  }

  // Copy the current object with optional new values
  Player copyWith({
    String? nickName,
    String? socketId,
    int? points,
    String? playerType,
  }) {
    return Player(
      nickName: nickName ?? this.nickName,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
