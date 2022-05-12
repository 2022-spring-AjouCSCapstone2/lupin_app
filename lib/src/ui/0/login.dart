import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/ui/1/after_login_page.dart';
import 'package:lupin_app/src/ui/0/signup.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();

  var dio = Dio();
  var cookieJar = CookieJar();

  void cookie(Dio dio) {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  void postLogin() async {
    cookie(dio);
    try {
      var value = sha256.convert(utf8.encode(_pwController.text));
      Response response = await dio.post(
          'http://192.168.0.10:5000/users/login',
          data: {
            'email': _mailController.text,
            'password': value.toString()
          });
      if(response.statusCode == 200) {
        //dio를 같이 넘겨줘야함.. 세션 유지 때문에
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AfterLogin(),
          ),
        );
      }
      else {
        print(response);
      }
    } catch (e) {
      print(e);
      //로그인 에러 창 띄우기
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
