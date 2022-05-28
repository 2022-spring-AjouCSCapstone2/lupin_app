import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:dio/dio.dart';
import 'package:lupin_app/src/ui/3/board.dart';
import 'package:lupin_app/src/ui/3/notice.dart';

class NoticeWrite extends StatefulWidget {
  final Course course;

  const NoticeWrite(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoticeWriteState();
}

class _NoticeWriteState extends State<NoticeWrite> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void postNotice() async{
    try{
      Response response = await Apis.instance.postNotice(
        title: _titleController.text,
        content: _contentController.text,
        courseId: widget.course.courseId,
      );
      if(response.statusCode == 200){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Notice(widget.course),
          ),
        );
      } else{
        //에러
      }
    } catch (e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '글 쓰기',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 40.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '제목',
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: '내용',
              ),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                postNotice();
              },
              child: const Text("완료"),
            ),
          ],
        ),
      ),
    );
  }
}

