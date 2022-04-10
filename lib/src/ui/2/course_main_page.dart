import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/uiutil/top_navigator.dart';

class CourseMainPage extends StatefulWidget {
  final String title;

  const CourseMainPage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print((size.width/10));
    var a= (size.width/10);
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
              widget.title,
              rightWidget: Container(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 400,
              color: Theme.of(context).primaryColor.withAlpha(150),
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
                onPressed: () {},
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
