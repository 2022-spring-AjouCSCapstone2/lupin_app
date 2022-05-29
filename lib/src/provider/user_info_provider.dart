import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/model/user_model.dart';

class UserInfoProvider extends ChangeNotifier {
  User? currentUser;

  UserInfoProvider();

  void setCurrentUser(Response response) {
    currentUser = User.fromJson(response.data);
  }

  void changeProfile() {
    notifyListeners();
  }
}
