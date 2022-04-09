import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Stack topNavigator(BuildContext context, title,
    {Color themeColor = Colors.black, Widget? leftWidget,Widget? rightWidget}) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: leftWidget ??
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios,
                color: themeColor,
              ),
            ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: themeColor),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: rightWidget??IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios,
            color: themeColor,
          ),
        ),
      ),
    ],
  );
}
