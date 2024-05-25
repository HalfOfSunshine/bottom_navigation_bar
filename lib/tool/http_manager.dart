import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

enum HttpMethod {
  GET,
  POST
}

class HttpManager {
//  创建Dio单例对象
  static Dio ?_dioInstance;

  static Dio getDioInstance() {
    _dioInstance ??= Dio();
    return _dioInstance!;
  }

  static Future<Response> get(String url,
      {Map<String, dynamic>? queryParameter}) async {
    return await sendRequest(
        HttpMethod.GET, url, queryParameter: queryParameter);
  }

  static Future<Response> post(String url,
      {Map<String, dynamic>? queryParameter, dynamic data}) async {
    return await sendRequest(
        HttpMethod.POST, url, queryParameter: queryParameter, data: data);
  }

  static Future sendRequest(HttpMethod method, String url,
      {Map<String, dynamic>? queryParameter, dynamic data}) async {
    try {
      switch (method) {
        case HttpMethod.GET:
          return await HttpManager.getDioInstance().get(
              url, queryParameters: queryParameter);
        case HttpMethod.POST:
          return await HttpManager.getDioInstance().post(
              url, queryParameters: queryParameter, data: data);
      // TODO: Handle this case.
        default:
          throw Exception('请求方式错误');
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
