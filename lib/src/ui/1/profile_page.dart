import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:lupin_app/src/ui/0/login.dart';
import 'package:lupin_app/src/uiutil/top_navigator.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void postLogout() async {
    try {
      Response response = await Apis.instance.logout();
      if (response.statusCode == 204) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        //로그아웃 실패
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserInfoProvider>(context, listen: false);
    return SafeArea(
      child: ListView(
        children: [
         Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: <Widget>[
                  Container(
                    height: 230.0,
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        topNavigator(
                          context,
                          'Profile',
                          themeColor: Colors.white,
                          leftWidget: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Settings',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          rightWidget: TextButton(
                            onPressed: () {
                              postLogout();
                            },
                            child: Text(
                              'Logout',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    provider.currentUser!.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '\'오늘도 힘내보자\'',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  buildSettings(),
                ],
              ),
              buildAvatar(),
            ],
          )
        ],
      ),
    );
  }

  Positioned buildAvatar() {
    return const Positioned(
      top: 100.0,
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 95,
          backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
        ),
      ),
    );
  }

  Padding buildSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('테스트'),
            leading: Icon(Icons.account_circle),
          ),
          Divider(),
        ],
      ),
    );
  }
}
