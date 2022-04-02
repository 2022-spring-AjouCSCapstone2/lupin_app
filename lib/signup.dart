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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  buttonEnable(){
    return _isChecked;
  }

  buttonFunction(){
    formKey.currentState?.validate();
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
