import 'dart:developer';

import 'package:audio/responsive/responsive.dart';
import 'package:audio/widget/custom_button.dart';
import 'package:audio/widget/custom_text.dart';
import 'package:audio/widget/custom_textfild.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../resources/socket_methods.dart';

class JoinRoomScrren extends StatefulWidget {
  static String routeName = '/join-room';

  const JoinRoomScrren({super.key});

  @override
  State<JoinRoomScrren> createState() => _JoinRoomScrrenState();
}

class _JoinRoomScrrenState extends State<JoinRoomScrren> {
  final TextEditingController _neackName = TextEditingController();
  final TextEditingController gameId = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorListener(context);
    _socketMethods.updateplayerstateListner(context);
  }

  @override
  void dispose() {
    _neackName.dispose();
    gameId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(shadows: [
                BoxShadow(color: Colors.blue, blurRadius: 40, spreadRadius: 4)
              ], text: 'Create Room', fontSize: 70),
              const Gap(20),
              CustomTextfild(
                  controller: _neackName, hintText: "Enter Your Nickname"),
              const Gap(20),
              CustomTextfild(
                  controller: gameId, hintText: "Enter Your Game Id"),
              const Gap(20),
              CustomButton(
                  onTap: () async {
                    log(gameId.text);
                    _socketMethods.joinRoom(
                        _neackName.text.trim(), gameId.text.trim());
                  },
                  buttName: "Join")
            ],
          ),
        ),
      ),
    );
  }
}
