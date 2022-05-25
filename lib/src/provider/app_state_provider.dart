import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  static pushPage(
    BuildContext context,
    Widget page,
  ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
