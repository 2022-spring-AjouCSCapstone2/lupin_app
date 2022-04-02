import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lupin_app/room.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [First(), Second(), Third()];
  DateTime? currentBackPressTime = null;

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
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
        ],
      ),
      body: WillPopScope(
        child: _pages[_selectedIndex],
        onWillPop: onWillPop,
      ),
    );
  }
}

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstState();
}

class _FirstState extends State<First> {
  List test = [];
  int count = 0;

  var _searchController;

  makeColumnContainer(index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme
              .of(context)
              .primaryColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${index.toString()}번 수업",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          test.add(count);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
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
                    "수업 목록",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(filled: true, labelText: '검색'),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              test.length,
                  (index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .primaryColor, width: 1),
                      borderRadius: BorderRadius.all(
                      Radius.elliptical(13, 13),
                ),
                ),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                title: Text("수업 이름"),
                ),
                );
                },
            ),
          ],
        ),
      ),
    );
  }
}

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("second"),
    );
  }
}

class Third extends StatefulWidget {
  const Third({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("third"),
    );
  }
}
