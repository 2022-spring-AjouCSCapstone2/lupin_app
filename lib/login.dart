import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 200.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '이메일'
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '비밀번호'
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 50.0,),
                ElevatedButton(
                  onPressed: (){},
                  child: Text("로그인"),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text("비밀번호를 잊으셨나요?"),
                )
              ],
            )
        )
    );
  }
}

class WidgetApp extends StatefulWidget{
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Widget Example'),
        ),
        body: Container(
            child: Center(
              child: Column(
                  children: <Widget>[
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
                      obscureText: true, ),
                  ]

              ),
            )
        )
    );
  }
}
