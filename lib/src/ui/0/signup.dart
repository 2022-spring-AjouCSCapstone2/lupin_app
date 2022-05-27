import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/validate.dart';
import 'package:lupin_app/src/ui/0/login.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();
  final _pw2Controller = TextEditingController();
  final _phoneController = TextEditingController();
  final _sIdController = TextEditingController();

  final _userType = ['STUDENT', 'PROFESSOR'];
  String? _selectedValue;

  bool? _isChecked = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var dio = Dio()
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.tealAccent,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  void postJoin() async {
    try {
      var value = sha256.convert(utf8.encode(_pwController.text));
      Response response = await dio.post(
          'http://3.37.234.117:5000/users/join',
          data: {
            'name': _nameController.text,
            'userType': _selectedValue,
            'userId': int.parse(_sIdController.text),
            'email': _mailController.text,
            'password': value.toString(),
            'meta' : jsonEncode({'phone' : _phoneController.text}),
          });
      if(response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
      else{
        showToast('이미 가입된 학번 또는 이메일입니다.');
      }
    } catch (e) {
      showToast('이미 가입된 학번 또는 이메일입니다.');
      print(e);
    }
  }

  buttonEnable(){
    return _isChecked;
  }

  buttonFunction(){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      postJoin();
    }
    else {
      print('validate err');
    }
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
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
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: '이름 *'
                        ),
                        validator: (value) => CheckValidate().validateName(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Container(width: 10,),
                    Expanded(
                      flex: 1,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(left: 10),
                            filled: true,
                            labelText: '사용자 유형 *',
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding: const EdgeInsets.only(right: 10),
                          items: _userType.map((value) {
                            return DropdownMenuItem(
                              child: Container(
                                  child: Text(value)
                              ),
                              value: value,);
                          }).toList(),
                          validator: (value) => CheckValidate().validateType(value.toString()),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (String? value){
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          onSaved: (value) {
                            _selectedValue = value.toString();
                          },
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _mailController,
                  decoration: InputDecoration(filled: true, labelText: '이메일 *'),
                  validator: (value) => CheckValidate().validateEmail(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _pwController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '비밀번호 *',
                    hintText: '특수문자, 대소문자, 숫자 포함 8 ~ 15자',
                  ),
                  validator: (value) => CheckValidate().validatePassword(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _pw2Controller,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '비밀번호 확인 *'
                  ),
                  validator: (value) => CheckValidate().validatePassword2(_pwController.text, value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '전화번호'
                  ),
                  validator: (value) => CheckValidate().validatePhone(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _sIdController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '학번/교번 *'
                  ),
                  validator: (value) => CheckValidate().validateSId(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CheckboxListTile(
                          title: Text('개인정보 수집 및 이용 동의',style: TextStyle(color: Colors.grey)),
                          value: _isChecked,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool? value) {
                            if(value != null){
                              setState(() {
                                _isChecked = value;
                              });
                            }
                          }),
                    ),
                    Container(width: 10,),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          //약관 보여주기
                        },
                        icon: const Icon(Icons.chevron_right_outlined), color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: buttonEnable() ? () => buttonFunction() : null,
                  child: Text("회원가입"),
                ),
              ],
            ),
          ),
        )
    );
  }
}
