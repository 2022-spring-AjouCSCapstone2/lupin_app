import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:logger/logger.dart';
import 'package:lupin_app/src/model/my_courses_model.dart';
import 'package:lupin_app/src/model/course_post_model.dart';

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

  Future<Posts> getBoard() async {
    Response response = await dio.get('/posts/courses/T004');
    log.i(response.headers);
    log.i(response.data);
    return Posts.fromJson(response.data);
  }

  Future<Response> getPost() async {
    Response response = await dio.get('/posts/3');
    log.i(response.headers);
    log.i(response.data);
    return response;
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

}
