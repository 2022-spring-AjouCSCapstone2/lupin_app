import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/quiz_model.dart';
import 'package:lupin_app/src/navigation_service.dart';
import 'package:lupin_app/src/ui/3/room.dart';
import 'package:lupin_app/src/ui/3/room_for_professor.dart';
import 'package:lupin_app/src/uiutil/simple_dialog.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider extends ChangeNotifier {
  Logger log = Logger();

  Socket socket = io(
    'http://3.37.234.117:5000',
    <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    },
  );

  String? currentRoomId;

  SocketProvider() {}

  void socketInit() async {
    socket.disconnect();
    var cookies = Apis.instance.cookieJar
        .loadForRequest(Uri.parse('http://3.37.234.117:5000'));
    var cookie = (await cookies)[0];
    socket.close();
    socket = io(
      'http://3.37.234.117:5000',
      <String, dynamic>{
        'transports': ['websocket'],
        'forceNew': true,
        'autoConnect': false,
        'extraHeaders': {
          'cookie': '${cookie.name}=${cookie.value}',
        },
      },
    );
    setListener();
    connect();
  }

  void connect() {
    socket.connect();
  }

  void checkQuestion(int questionId, bool point) {
    socket.emitWithAck(
      'checkQuestion',
      {'logId': questionId, 'point': point},
      ack: (e) {
        log.i('checkQuestion 메시지 : $e');
        if (e['status'] == 'success') {
          e = e['data'];
        } else {
          return;
        }
        if (e != 'Forbidden') {}
      },
    );
  }

  void setListener() {
    socket.onConnecting((data) => log.i('연결 중'));
    socket.onConnectError((data) => log.e('연결 에러'));
    socket.onConnectTimeout((data) => log.e('소켓 타임아웃'));
    socket.onConnect((data) => log.i('소켓 연결 성공'));

    socket.on('quiz', (data) {
      log.i(data);
      List quizList = data['quizLists'];
      var list = quizList.map((e) => QuizModel.fromJson(e)).toList();
      showSimpleDialog(NavigationService.navigatorKey.currentContext!, '퀴즈 도착',
          data['content'], list, data['id']);
    });

    socket.on('newQuestion', (data) {
      log.i(data);
      var name =
          data['isAnonymous'] == false ? '${data['user']['name']}님의' : '';
      showSimpleDialog2(NavigationService.navigatorKey.currentContext!, '질문 도착',
          data['content'], name, data['id']);
    });
    // socket.on('question', (data) {
    //   log.i(data);
    //   List quizList = data['quizLists'];
    //   var list = quizList.map((e) => QuizModel.fromJson(e)).toList();
    //   showSimpleDialog2(NavigationService.navigatorKey.currentContext!, '질문 도착',);
    // });
  }

  void question(
    Course course,
    String content,
    bool isAnonymous,
  ) {
    socket.emitWithAck(
      'question',
      {
        'roomId': currentRoomId,
        'type': 'QUESTION',
        'isAnonymous': isAnonymous,
        'content': content,
        'courseId': course.courseId,
      },
      ack: (e) {
        log.i('질문 메시지 : $e');
        if (e['status'] == 'success') {
          e = e['data'];
        } else {
          return;
        }
        if (e != 'Forbidden') {}
      },
    );
  }

  void createRoom(BuildContext context, Course course) {
    socket.emitWithAck(
      'createRoom',
      {'courseId': course.courseId},
      ack: (e) {
        if (e['status'] == 'success') {
          e = e['data'];
        } else {
          return;
        }
        log.i('방 생성 메시지 : $e');
        if (e != 'Forbidden') {
          currentRoomId = e.toString();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomForProfessor(course),
              ));
        }
      },
    );
  }

  void joinRoom(BuildContext context, Course course) {
    socket.emitWithAck('joinRoom', {'courseId': course.courseId}, ack: (e) {
      log.i('방 참가 메시지 : $e');
      if (e['status'] == 'success') {
        e = e['data'];
      } else {
        Fluttertoast.showToast(msg: e['data']);
        return;
      }
      if (e != 'no course session opened') {
        currentRoomId = e.toString();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Room(course),
            ));
      } else {
        Fluttertoast.showToast(msg: '수업이 열리지 않았습니다');
      }
    });
  }

  void clearListener() {
    socket.clearListeners();
  }

  void disconnect() {
    socket.disconnect();
  }

  void leaveRoom(Course course) {
    socket.emitWithAck('leaveRoom', {'roomId': currentRoomId}, ack: (e) {
      log.i('leaveRoom 메시지 : $e');
      if (e['status'] == 'success') {
        e = e['data'];
      } else {
        return;
      }
    });
  }

  void quiz(Course course, String content, List list, int answer) {
    socket.emitWithAck(
      'quiz',
      {
        'roomId': currentRoomId!,
        'content': content,
        'list': list,
        'answer': answer
      },
      ack: (e) {
        log.i('quiz 메시지 : $e');
        if (e['status'] == 'success') {
          e = e['data'];
        } else {
          return;
        }
      },
    );
  }

  void answer(int quizId, int answer) {
    socket.emitWithAck('quizAnswer', {'quizId': quizId, 'answer': answer},
        ack: (e) {
      log.i('답변 메시지 :$e');
    });
  }
}
