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
      RegExp regExp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*))@((([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
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

  String? validatePassword2(String? value1, String? value2){
    if(value2!.isEmpty) {
      return '비밀번호를 입력하세요.';
    } else if(value1 != value2){
      return '비밀번호가 일치하지 않습니다.';
    } else {
      return null;
    }

  }

  String? validatePhone(String? value) {
    /*
    if (value!.isEmpty){
      return '학과를 입력하세요.';
    } else {
      return null;
    }
     */
  }

  String? validateSId(String? value) {
    if (value!.isEmpty){
      return '학번/교번을 입력하세요.';
    } else {
      return null;
    }
  }

  String? validateType(String? value){
    if (value == 'null'){
      return '사용자 타입을 선택하세요';
    } else {
      return null;
    }
  }

  String? validatePassword3(String? value) {
    if (value!.isEmpty){
      return '비밀번호를 입력하세요.';
    } else {
      return null;
    }
  }

}
