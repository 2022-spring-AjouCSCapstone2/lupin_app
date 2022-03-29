import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lupin_app/validate.dart';

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

  bool? _isChecked = false;

  FocusNode _emailFocus = new FocusNode();
  FocusNode _pwFocus = new FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {

    return Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 50),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '이름'
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _mailController,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '이메일'
                ),
                validator: (value) => CheckValidate().validateEmail(_emailFocus, value),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _pwController,
                focusNode: _pwFocus,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '비밀번호',
                    helperText: '특수문자, 대소문자, 숫자 포함 8자리 이상 15자 이내로 입력'
                ),
                validator: (value) => CheckValidate().validatePassword(_pwFocus, value),
                obscureText: true,
              ),
              SizedBox(height: 12.0),TextField(
                controller: _departController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '학과'
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _sIdController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '학번'
                ),
              ),
              CheckboxListTile(
                  title: Text('개인정보 수집에 동의합니다.'),
                  value: _isChecked,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    if(value != null){
                      print(value);
                      setState(() {
                        _isChecked = value;
                      });
                    }
                  }
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: (){
                  formKey.currentState?.validate();
                },
                child: Text("회원가입"),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text("비밀번호를 잊으셨나요?"),
              )
            ],
          ),
        )
    );
  }
}
