import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/provider/course_provider.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:lupin_app/src/ui/0/signup.dart';
import 'package:lupin_app/src/ui/1/after_login_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.tealAccent,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  void postLogin() async {
    try {
      var value = sha256.convert(utf8.encode(_pwController.text));
      Response response = await Apis.instance
          .login(email: _mailController.text, password: value.toString());

      if (response.statusCode == 200) {
        await Provider.of<CourseProvider>(context, listen: false)
            .getUserAllCourses();
        Provider.of<UserInfoProvider>(context, listen: false)
            .setCurrentUser(response);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AfterLogin(),
          ),
        );
      }
      else {
        showToast('잘못된 이메일 또는 패스워드입니다.');
        print(response);
      }
    } catch (e) {
      showToast('잘못된 이메일 또는 패스워드입니다.');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 170.0),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "로그인",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )
              ],
            ),
            const SizedBox(height: 40.0),
            TextField(
              controller: _mailController,
              decoration: const InputDecoration(filled: true, labelText: '이메일'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _pwController,
              decoration:
                  const InputDecoration(filled: true, labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                postLogin();
              },
              child: const Text("로그인"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: const Text("회원가입"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {},
              child: const Text("비밀번호를 잊으셨나요?"),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Example'),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
