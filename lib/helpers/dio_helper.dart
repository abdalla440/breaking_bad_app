import 'package:breaking_bad_app/shared/constants/constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    print('Dio init method');
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        // connectTimeout: 20 * 1000,
        // receiveTimeout: 20 * 1000,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

// static Future<Response> postData({
//   required String url,
//   Map<String, dynamic>? query,
//   required Map<String, dynamic> data,
//   String lang = 'en',
//   String? token,
// }) async {
//   dio.options.headers = {
//     'Content-Type': 'application/json',
//     'lang': lang,
//     'Authorization': token,
//   };
//   return dio.post(
//     url,
//     queryParameters: query,
//     data: data,
//   );
// }
}
