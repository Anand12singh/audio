import 'package:audio/resources/socket.dart';
import 'package:audio/screens/create_room_scrren.dart';
import 'package:audio/screens/join_room_scrren.dart';
import 'package:audio/screens/main_menu_screen.dart';
import 'package:audio/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  final socketClient = SocketClient.instance;

  socketClient.socket!.emit('createRoom', {'nickName': 'TestUser'});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
      routes: {
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        JoinRoomScrren.routeName: (context) => const JoinRoomScrren(),
        CreateRoomScrren.routeName: (context) => const CreateRoomScrren()
      },
      // home: const MainMenuScreen(),
      initialRoute: MainMenuScreen.routeName,
    );
  }
}
