import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:dio/dio.dart';
import 'package:lupin_app/src/ui/3/board.dart';

class PostRead extends StatefulWidget {
  final Course course;

  const PostRead(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostReadState();
}

class _PostReadState extends State<PostRead> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void getPost() async{
    try{
      Response response = await Apis.instance.getPost();
      if(response.statusCode == 200){
        print(response.data);
        _titleController.text = response.data['title'];
        _contentController.text = response.data['content'];

      } else{
        //에러
      }
    } catch (e){
      print('check');
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
              enabled: false,
              readOnly: true,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _contentController,
              enabled: false,
              readOnly: true,
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                getPost();
              },
              child: const Text("완료"),
            ),
          ],
        ),
      ),
    );
  }
}

