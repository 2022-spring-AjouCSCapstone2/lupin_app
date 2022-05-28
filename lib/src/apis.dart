import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:lupin_app/src/model/my_courses_model.dart';
import 'package:lupin_app/src/model/course_post_model.dart';
import 'package:lupin_app/src/model/post_detail_model.dart';
import 'model/post_model.dart';
import 'package:logger/logger.dart';


///await Apis.instance.login(email: 'wdad', password: 'd'); 이렇게 사용하시면 됩니다
class Apis {
  static final Apis _instance = Apis._();

  static Apis get instance => _instance;

  Logger log = Logger();

  Apis._() {
    cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  late CookieJar cookieJar;

  Dio dio = Dio()
    ..options.baseUrl = 'http://3.37.234.117:5000'
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;


  Future<Response> login({required email, required password}) async {
    Response response = await dio.post(
      '/users/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<Response> logout() async {
    Response response = await dio.get(
      '/users/logout',
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<MyCourses> getMyAllCourses() async {
    Response response = await dio.get(
      '/courses/all',
    );
    log.i(response.headers);
    log.i(response.data);
    return MyCourses.fromJson(response.data);
  }

  Future<MyCourses> getMyTodayCourses() async {
    Response response = await dio.get(
      '/courses/today',
    );
    log.i(response.headers);
    log.i(response.data);
    return MyCourses.fromJson(response.data);
  }

  Future<Posts> getBoard(courseId) async {
    Response response = await dio.get('/posts/courses/$courseId');
    log.i(response.headers);
    log.i(response.data);
    return Posts.fromJson(response.data);
  }

  Future<DetailPost> getPost(postId) async {
    Response response = await dio.get('/posts/$postId');
    log.i(response.headers);
    log.i(response.data);
    return DetailPost.fromJson(response.data);
  }

  Future<Response> postPost({required title, required content, required courseId}) async {
    Response response = await dio.post(
      '/posts',
      data: {
        'title': title,
        'content': content,
        'courseId': courseId,
      },
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<Response> postComment({required content, required postId}) async {
    Response response = await dio.post(
      '/posts/comments',
      data: {
        'content': content,
        'postId': postId,
      },
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<Posts> getNotice(courseId) async {
    Response response = await dio.get(
      '/posts/courses/$courseId?postType=NOTICE',
    );
    log.i(response.headers);
    log.i(response.data);
    return Posts.fromJson(response.data);
  }

  Future<Response> postNotice({required title, required content, required courseId}) async {
    Response response = await dio.post(
        '/posts/notices',
        data: {
          'title': title,
          'content': content,
          'courseId': courseId,
        }
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<Response> getNote(courseId) async {
    Response response = await dio.get(
      '/courses/$courseId/logs',
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<Response> patchPasswd({required password, required newPassword}) async {
    Response response = await dio.patch(
        '/users/password',
        data: {
        'password': password,
        'newPassword': newPassword,
      }
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }

  Future<Response> patchPhone({required phone}) async {
    Response response = await dio.patch(
        '/users',
        data: {
          'phone': phone,
        }
    );
    log.i(response.headers);
    log.i(response.data);
    return response;
  }
}
