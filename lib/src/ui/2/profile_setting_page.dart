import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lupin_app/src/model/user_model.dart';
import 'package:lupin_app/src/validate.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:lupin_app/src/apis.dart';

class ProfileSettingPage extends StatefulWidget {
  final User user;

  const ProfileSettingPage(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _pwController = TextEditingController();
  final _pw2Controller = TextEditingController();
  final _pw3Controller = TextEditingController();
  final _phoneController = TextEditingController();

  FocusNode phoneFocus = FocusNode();
  FocusNode pw1Focus = FocusNode();
  FocusNode pw2Focus = FocusNode();
  FocusNode pw3Focus = FocusNode();

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.tealAccent,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  void buttonFunction(){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      pw1Focus.unfocus();
      pw2Focus.unfocus();
      pw3Focus.unfocus();
      patchPw();
    }
    else {
      print('validate err');
    }
  }

  void patchPw() async {
    try{
      var value1 = sha256.convert(utf8.encode(_pwController.text));
      var value2 = sha256.convert(utf8.encode(_pw3Controller.text));
      Response response = await Apis.instance.patchPasswd(
        password: value2.toString(),
        newPassword: value1.toString(),
      );
      if(response.statusCode == 200){
        showToast('비밀번호가 정상적으로 변경됐습니다.');
        _pwController.text = '';
        _pw2Controller.text = '';
        _pw3Controller.text = '';
        setState(() {});
      } else{
        showToast('현재 비밀번호가 옳지 않습니다.');
      }
    } catch(e){
      showToast('현재 비밀번호가 옳지 않습니다.');
      print(e);
    }
  }

  void patchPhone() async {
    try{
      Response response = await Apis.instance.patchPhone(
        phone: _phoneController.text,
      );
      if(response.statusCode == 200){
        widget.user.phone = _phoneController.text;
        showToast('전화번호가 정상적으로 변경됐습니다.');
      }
    } catch(e){
    print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _phoneController.text = widget.user.phone!;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            '프로필 설정',
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 40.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        '비밀번호 변경',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(width: 10.0,),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () => buttonFunction(),
                        child: Text(
                            'Save'
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  controller: _pwController,
                  focusNode: pw1Focus,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '새 비밀번호',
                    hintText: '특수문자, 대소문자, 숫자 포함 8 ~ 15자',
                  ),
                  validator: (value) => CheckValidate().validatePassword(value),
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: _pw2Controller,
                  focusNode: pw2Focus,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '새 비밀번호 확인'
                  ),
                  validator: (value) => CheckValidate().validatePassword2(_pwController.text, value),
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _pw3Controller,
                  focusNode: pw3Focus,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '현재 비밀번호'
                  ),
                  validator: (value) => CheckValidate().validatePassword3(_pw3Controller.text),
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                ),
                SizedBox(height: 60.0),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text('전화번호 변경'),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () => {
                          patchPhone(),
                          phoneFocus.unfocus(),
                           },
                        child: Text(
                          'Save',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneController,
                  focusNode: phoneFocus,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '전화번호',
                  ),
                  //validator: (value) => CheckValidate().validatePassword2(_pwController.text, value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        )
    );
  }

}