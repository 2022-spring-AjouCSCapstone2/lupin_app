import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/uiutil/top_navigator.dart';
import 'package:record/record.dart';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Room extends StatefulWidget {
  final Course course;

  const Room(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomState();
}

class roomData {
  String name = '';

  roomData(String name){
    this.name = name;
  }

  roomData.fromJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
      };
}

void socket(){
  IO.Socket socket =
  IO.io('http://3.37.234.117:5000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  socket.connect();

  print(socket.connected);
}

class _RoomState extends State<Room> {
  final record = Record();
  bool isRecording = false;

  void recordVoice() async {
    if (await record.isRecording()) {
      var path = await record.stop();
      print(path);
      isRecording = false;
      setState(() {});
      return;
    }

    // Check and request permission
    if (await record.hasPermission()) {
      // Start recording
      await record.start(
        encoder: AudioEncoder.aacLc, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );
      isRecording = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            topNavigator(
              context,
              widget.course.name,
              rightWidget: Container(),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  recordVoice();
                },
                child: Text(isRecording == false ? '녹음하기' : '녹음 중지'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {socket();},
                child: const Text('익명 질문하기'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('질문하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
