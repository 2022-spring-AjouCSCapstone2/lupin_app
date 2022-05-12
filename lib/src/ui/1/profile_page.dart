import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../../uiutil/top_navigator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var dio = Dio();
  var cookieJar = CookieJar();

  void cookie(Dio dio) {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  void postLogout() async {
    cookie(dio);
    try {
      Response response = await dio.get('http://192.168.0.10:5000/users/logout');
      print(response);
      if(response.statusCode == 204){
        //로그인 페이지로 이동
      }
      else {
        //로그아웃 실패
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () {postLogout();},
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
                    '김철수',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '\'오늘도 힘내보자\'',
                    style: Theme.of(context).textTheme.headline6,
                  ),
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
}
