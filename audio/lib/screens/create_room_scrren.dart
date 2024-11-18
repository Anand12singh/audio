// ignore_for_file: prefer_const_constructors

import 'package:audio/responsive/responsive.dart';
import 'package:audio/widget/custom_text.dart';
import 'package:audio/widget/custom_textfild.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateRoomScrren extends StatefulWidget {
  static String routeName = '/create-room';

  const CreateRoomScrren({super.key});

  @override
  State<CreateRoomScrren> createState() => _CreateRoomScrrenState();
}

class _CreateRoomScrrenState extends State<CreateRoomScrren> {
 final TextEditingController neackName=TextEditingController();
 @override
  void dispose() {
    neackName;
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomText(shadows: [
                BoxShadow(color: Colors.blue, blurRadius: 40, spreadRadius: 4)
              ], text: 'Create Room', fontSize: 70),
              Gap(20),
              CustomTextfild(controller:neackName, hintText: "");
            ],
          ),
        ),
      ),
    );
  }
}
