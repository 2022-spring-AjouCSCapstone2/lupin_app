import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

///await Apis.instance.login(email: 'wdad', password: 'd'); 이렇게 사용하시면 됩니다
class Apis {
  static final Apis _instance = Apis._();

  static Apis get instance => _instance;

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
    print(response.headers);
    print(response.data);
    return response;
  }

  Future<Response> logout() async {
    Response response = await dio.get(
      '/users/logout',
    );
    print(response.headers);
    print(response.data);
    return response;
  }

  Future<Response> getMyAllCourses() async {
    Response response = await dio.get(
      '/courses/all',
    );
    print(response.headers);
    print(response.data);
    return response;
  }
}
