import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;

  // Singleton instance
  static SocketClient? _instance;

  // Private constructor
  SocketClient._internal() {
    socket = IO.io('http://192.168.1.133:3000', <String, dynamic>{
      'transports': ['websocket'], // Use WebSocket transport
      'autoConnect': true,
    });

    // Define global event listeners
    socket!.on('connect', (_) => log('Connected to server'));
    socket!.on('connect_error', (error) => log('Connection error: $error'));
    socket!.on('disconnect', (_) => log('Disconnected from server'));

    // Global listener for 'roomCreated' event
    socket!.on('roomCreated', (data) {
      log('Room created: ${data['roomName']}');
    });
  }

  // Static getter for the singleton instance
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
