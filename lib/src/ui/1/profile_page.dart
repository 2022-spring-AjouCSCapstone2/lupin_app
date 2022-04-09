import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../uiutil/top_navigator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                            onPressed: () {},
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
