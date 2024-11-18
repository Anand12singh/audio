import 'package:audio/responsive/responsive.dart';
import 'package:audio/screens/create_room_scrren.dart';
import 'package:audio/screens/join_room_scrren.dart';
import 'package:audio/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menue';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScrren.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScrren.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onTap: () {
                    createRoom(context);
                  },
                  buttName: "Create Room"),
              const Gap(20),
              CustomButton(
                  onTap: () {
                    joinRoom(context);
                  },
                  buttName: "Join Room")
            ],
          ),
        ),
      ),
    );
  }
}
