import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/user_model.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:lupin_app/src/ui/4/question.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class Room extends StatefulWidget {
  final Course course;

  const Room(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomState();
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
    var provider = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.course.name,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(),
                image: DecorationImage(
                  image: AssetImage('assets/class_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                '수업이 진행 중 입니다.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                '녹음된 수업 데이터는 음성 및 변환을 통해 스크립트로 제공됩니다.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            if (provider.currentUser?.userType == UserType.professor)
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
            if (provider.currentUser?.userType == UserType.student)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question(widget.course),
                        ));
                  },
                  child: const Text('익명 질문하기'),
                ),
              ),
            if (provider.currentUser?.userType == UserType.student)
              const SizedBox(
                height: 20,
              ),
            if (provider.currentUser?.userType == UserType.student)
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
