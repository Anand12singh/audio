import 'package:audio/provider/room_dataprovider.dart';
import 'package:audio/widget/custom_textfild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingLobi extends StatefulWidget {
  WaitingLobi({super.key});

  @override
  State<WaitingLobi> createState() => _WaitingLobiState();
}

class _WaitingLobiState extends State<WaitingLobi> {
  late TextEditingController roomidController;
  @override
  void initState() {
    roomidController = TextEditingController(
        text: Provider.of<RoomDataprovider>(context, listen: false)
            .roomData['_id']);

    super.initState();
  }

  @override
  void dispose() {
    roomidController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Wating For Other Player Join"),
        SizedBox(
          height: 20,
        ),
        CustomTextfild(
          controller: roomidController,
          hintText: 'Wating',
          isreadOnly: true,
        )
      ],
    );
  }
}
