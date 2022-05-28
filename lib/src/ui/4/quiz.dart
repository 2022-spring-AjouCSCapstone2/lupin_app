import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/quiz_model.dart';
import 'package:lupin_app/src/provider/socket_provider.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  final Course course;

  const Quiz(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  TextEditingController problemController = TextEditingController();

  int count = 0;

  int? radioValue = 0;

  List<TextEditingController> textEditList = [];

  add() {
    count += 1;
    TextEditingController textEditingController = TextEditingController();
    textEditList.add(textEditingController);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SocketProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.course.name} 퀴즈 내기',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: TextField(
                      controller: problemController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: '문제를 작성해주세요.',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      minLines: 1,
                      //Normal textInputField will be displayed
                      maxLines:
                          50, // when user presses enter it will adapt to it
                    ),
                  ),
                  ...List.generate(
                    count,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: new InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  labelText: '$index 번',
                                ),
                                controller: textEditList[index],
                              ),
                            ),
                            Radio<int>(
                              value: index,
                              groupValue: radioValue,
                              onChanged: (value) {
                                setState(() {
                                  radioValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
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
                    List list = getList();
                    provider.quiz(widget.course, problemController.text, list,
                        radioValue!);
                  },
                  child: Text('출제 하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List getList() {
    var count = 0;
    List list = [];
    for (var i in textEditList) {
      var quizModel = QuizModel(count++, i.text);
      list.add(quizModel);
    }
    return list;
  }
}
