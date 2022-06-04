import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/provider/app_state_provider.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/provider/socket_provider.dart';
import 'package:lupin_app/src/ui/1/all_course_list_page.dart';
import 'package:lupin_app/src/ui/2/course_main_page.dart';
import 'package:provider/provider.dart';

Future showSimpleDialog3(BuildContext context, String title, Course? course) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(10),
      content: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffffffff),
        ),
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
            width: 300,
            height: 20,
            ),
            Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 50,),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<SocketProvider>(context, listen: false).leaveRoom(course!);
                  AppState.pushPage(
                    context,
                    CourseMainPage(course),
                  );
                  //Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ),
          ],
        ),
        ),
      ),
    ),
  );
}
