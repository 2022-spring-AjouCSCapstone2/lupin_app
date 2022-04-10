import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lupin_app/src/ui/1/today_course_list_page.dart';
import 'package:lupin_app/src/ui/1/profile_page.dart';

import 'all_course_list_page.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    TodayCourseListPage(),
    AllCourseListPage(),
    ProfilePage()
  ];
  DateTime? currentBackPressTime;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildAfterLoginPage();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "종료하시겠습니까?");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Scaffold buildAfterLoginPage() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '메인',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '강의 목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
      ),
      body: WillPopScope(
        child: IndexedStack(index: _selectedIndex, children: _pages),
        onWillPop: onWillPop,
      ),
    );
  }
}
