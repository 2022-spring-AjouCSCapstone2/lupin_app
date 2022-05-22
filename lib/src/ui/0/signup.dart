import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/validate.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();
  final _departController = TextEditingController();
  final _sIdController = TextEditingController();

  //위젯에 학생인지 교수인지 선택하는 거 추가해야함

  bool? _isChecked = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var dio = Dio();
  var cookieJar = CookieJar();

  void cookie(Dio dio) {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  void postJoin() async {
    try {
      var value = sha256.convert(utf8.encode(_pwController.text));
      Response response = await dio.post(
          'http://192.168.0.10:5000/users/join',
          data: {
            'name': _nameController.text,
            'userType': 'student', //선택한 걸로 되게 수정
            'userId': int.parse(_sIdController.text),
            'email': _mailController.text,
            'password': value.toString()
          });
      if(response.statusCode == 201) {
        //login 페이지로 이동
      }
      else{
        //에러 alert
      }
    } catch (e) {
      //error 나면 에러 창 띄워주기
      print(e);
    }
  }

  buttonEnable(){
    return _isChecked;
  }

  buttonFunction(){
    formKey.currentState?.validate();
    //validate가 성공일 때만
    postJoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 40),
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
                        "회원가입",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '이름'
                  ),
                  validator: (value) => CheckValidate().validateName(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _mailController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '이메일'
                  ),
                  validator: (value) => CheckValidate().validateEmail(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _pwController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '비밀번호',
                      helperText: '특수문자, 대소문자, 숫자 포함 8자리 이상 15자 이내로 입력'
                  ),
                  validator: (value) => CheckValidate().validatePassword(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _departController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '학과'
                  ),
                  validator: (value) => CheckValidate().validateDepart(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _sIdController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '학번'
                  ),
                  validator: (value) => CheckValidate().validateSId(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 12.0),
                CheckboxListTile(
                    title: Text('개인정보 수집에 동의합니다.',style: TextStyle(color: Colors.grey)),
                    value: _isChecked,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      if(value != null){
                        setState(() {
                          _isChecked = value;
                        });
                      }
                    }
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: buttonEnable() ? () => buttonFunction() : null,
                  child: Text("회원가입"),
                ),
                TextButton(
                  onPressed: (){},
                  child: Text("비밀번호를 잊으셨나요?"),
                )
              ],
            ),
          ),
        )
    );
  }
}
