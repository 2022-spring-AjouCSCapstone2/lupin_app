import 'package:flutter/material.dart';

class CheckValidate {

  String? validateName(String? value) {
    if (value!.isEmpty){
      return '이름을 입력하세요.';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return '이메일을 입력하세요.';
    } else {
      RegExp regExp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regExp.hasMatch(value)) {
        return '잘못된 이메일 형식입니다.';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return '비밀번호를 입력하세요.';
    } else {
      Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      RegExp regExp = new RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
      if (!regExp.hasMatch(value)) {
        return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
      } else {
        return null;
      }
    }
  }

  String? validateDepart(String? value) {
    if (value!.isEmpty){
      return '학과를 입력하세요.';
    } else {
      return null;
    }
  }

  String? validateSId(String? value) {
    if (value!.isEmpty){
      return '학번을 입력하세요.';
    } else {
      return null;
    }
  }

}
