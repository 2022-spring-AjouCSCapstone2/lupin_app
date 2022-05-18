import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async{
/*
  Socket socket = await Socket.connect('192.168.0.10', 5000);
  print('connected');

  // listen to the received data event stream
  socket.listen((List<int> event) {
    print(utf8.decode(event));
  });

  // send hello
  socket.add(utf8.encode('hello'));

  // wait 5 seconds
  await Future.delayed(Duration(seconds: 5));

  // .. and close the socket
  socket.close();
*/
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class roomData {
  String name = '';

  roomData(String name){
    this.name = name;
  }

  roomData.fromJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
      };
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();
  final _departController = TextEditingController();
  final _sIdController = TextEditingController();

  bool? _isChecked = false;
  bool _formCompleted = false;

  //late Response response;
  var dio = Dio();
  var cookieJar = CookieJar();


  void cookie(Dio dio) {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  String _hash = 'Unknown';

  void socket() async {
    IO.Socket socket = IO.io('http://200.200.4.206:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect':false,
    });
    socket.connect();
    socket.onConnect((_) {
      print('connected to socketio');
    });

    var currentRoom = null;
    var currentRoomName = null;
    var currentRoomUsers = [];

    socket.on('showRoom', (rooms) => print('room: ' + rooms));  //showRoom();

    roomData room_data = roomData('test1');
    currentRoomName = room_data.name;

    socket.emitWithAck('createRoom', [jsonEncode(room_data), 'test4'], ack : (roomId){
      currentRoom = roomId;
      print(roomId);
      //showRoom();
    });

    socket.emit('showRoom', 'test1');

    currentRoom = 90000001;

    socket.emitWithAck('joinRoom', {'roomId': currentRoom, 'name': 'test1'}, ack : (data){
      print('joinRoom');
      print(data);
      // print('[roomdata] ' + roomData);
      currentRoom = currentRoom;
      currentRoomName = roomData;
      // currentRoomUsers = participants;
      // print('[participants] ' + participants);
      //paintUserList();
      //showRoom();
    });

    /*
    socket.emitWithAck('leaveRoom', [currentRoom, 'test1'], ack : (){
      currentRoomUsers = [];
    });

     */

    //socket.disconnect();


    //socket.on('connect', (_) => print('connect: ${socket.id}'));
    //ocket.on("disconnect", (_) => print('Disconnected'));



    /*
    socket.on('createRoom', (roomData, callback) => {
      const roomId = String(newRoom++); // 임시 ID 생성; 후에 랜덤한 생성 로직 추가
          rooms.set(roomId, roomData);
      socket.join(roomId);
      callback(roomId);
      showRoomList();
    });
     */
    //socket.on('event', (data) => print(data));
    //socket.onDisconnect((_) => print('disconnect'));
    //socket.on('fromServer', (_) => print(_));
  }

  void postJoin() async {

    try {
      var appleInBytes = utf8.encode("dong_test5");
      var value = sha256.convert(appleInBytes);
      var response = await dio.post(
          'http://192.168.0.10:5000/users/join',
          data: {
            'name': 'dong_test5',
            'userType': 'student',
            'userId': 12345678,
            'email': 'dong_test5@naver.com',
            'password': value.toString()
          });
      print("A");
      print(response);
    } catch (e) {
      print("B");
      print(e);
    }
  }

  void postLogin() async {
    try {
      print("hey");
      var appleInBytes = utf8.encode("dong_test5");
      var value = sha256.convert(appleInBytes);
      var response = dio.post(
          'http://192.168.0.10:5000/users/login',
          data: {
            'email': 'dong_test5@naver.com',
            'password': value.toString()
          });
      print(response);
    } catch (e) {
      print("CB");
      print(e);
    }
  }

  void postLogout() async {
    try {
      print("hey");
      var response = await dio.get('http://192.168.0.10:5000/users/logout');
      print("D");
      print(response);
    } catch (e) {
      print("DC");
      print(e);
    }
  }



  buttonEnable(){
    return _isChecked;
  }

  buttonFunction(){
    formKey.currentState?.validate();
    postLogout();
  }


  FocusNode _emailFocus = new FocusNode();
  FocusNode _pwFocus = new FocusNode();

  _emailListen() {
    _emailFocus.addListener(() {
      if(_emailFocus.hasFocus){
        //CheckValidate().validateEmail(_emailFocus, _mailController.text);
      }
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {

    return Scaffold(
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 50),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '이름'
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _mailController,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '이메일'
                ),
                //validator: (value) => CheckValidate().validateEmail(_emailFocus, value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _pwController,
                focusNode: _pwFocus,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '비밀번호',
                    helperText: '특수문자, 대소문자, 숫자 포함 8자리 이상 15자 이내로 입력'
                ),
                //validator: (value) => CheckValidate().validatePassword(_pwFocus, value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                //onChanged: (value) => CheckValidate().validatePassword(_pwFocus, value),
                obscureText: true,
              ),
              SizedBox(height: 12.0),TextField(
                controller: _departController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '학과'
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _sIdController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: '학번'
                ),
              ),
              CheckboxListTile(
                  title: Text('개인정보 수집에 동의합니다.'),
                  value: _isChecked,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    if(value != null){
                      setState(() {
                        _isChecked = value;
                      });
                    }
                  }
              ),
              SizedBox(height: 50.0),
              RaisedButton(
                child: Text("회원가입"),
                onPressed: buttonEnable() ? () => buttonFunction() : null,
              ),
              ElevatedButton(
                onPressed: (){
                  print("check!\n");
                  cookie(dio);
                  //postJoin();
                  //postLogin();
                  socket();
                },
                child: Text("비밀번호를 잊으셨나요?"),
              )
            ],
          ),
        )
    );
  }

}

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 200.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '이메일'
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '비밀번호'
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 50.0,),
                ElevatedButton(
                  onPressed: (){},
                  child: Text("로그인"),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text("비밀번호를 잊으셨나요?"),
                )
              ],
            )
        )
    );
  }
}

class WidgetApp extends StatefulWidget{
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Widget Example'),
        ),
        body: Container(
            child: Center(
              child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 12.0),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Password',
                      ),
                      obscureText: true, ),
                  ]

              ),
            )
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
