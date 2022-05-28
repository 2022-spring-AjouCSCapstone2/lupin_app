import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/provider/socket_provider.dart';
import 'package:provider/provider.dart';

class Question extends StatefulWidget {
  final Course course;
  final bool isAnonymous;

  const Question(this.course, this.isAnonymous, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.course.name} 질문 하기',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              child: TextField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: '질문을 작성해주세요. (질문은 익명으로 전달됩니다.)',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                minLines: 10,
                //Normal textInputField will be displayed
                maxLines: 50, // when user presses enter it will adapt to it
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<SocketProvider>(context, listen: false)
                        .question(widget.course, textEditingController.text,
                            widget.isAnonymous);
                    Navigator.pop(context);
                  },
                  child: Text('보내기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
