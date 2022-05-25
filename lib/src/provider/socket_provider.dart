import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider extends ChangeNotifier {
  Logger log = Logger();

  Socket socket = io('http://3.37.234.117:5000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  SocketProvider() {
    setListener();
    connect();
  }

  void connect() {
    socket.connect();
  }

  void setListener() {
    socket.onConnecting((data) => log.i('연결 중'));
    socket.onConnectError((data) => log.e('연결 에러'));
    socket.onConnectTimeout((data) => log.e('소켓 타임아웃'));
    socket.onConnect((data) => log.i('소켓 연결 성공'));
  }

  void showRoomList() {
    socket.emit(
      'showRoom',
    );
  }

  void createRoom() {}

  void clearListener() {
    socket.clearListeners();
  }

  void disconnect() {
    socket.disconnect();
  }
}
