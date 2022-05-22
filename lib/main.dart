import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lupin_app/src/provider/app_state_provider.dart';
import 'package:lupin_app/src/provider/course_provider.dart';
import 'package:lupin_app/src/ui/0/login.dart';
import 'package:provider/provider.dart';

import 'src/ui/0/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CourseProvider>(
          create: (_) => CourseProvider(),
        ),
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          primaryColor: const Color(0xFF5db075),
          textTheme: const TextTheme(
            headline3: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(
              const Color(0xFF5db075),
            ),
            side: const BorderSide(
              color: Colors.grey,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: BorderRadius.all(
                Radius.elliptical(13, 13),
              ),
            ),
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(13, 13),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              onPrimary: Colors.white,
              fixedSize: const Size(100, 60),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(
              const Color(0xFF5db075),
            ),
            accentColor: const Color(0xFFff6e40),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const App(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
