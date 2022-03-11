import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/Resources/constants_manager.dart';

class DioHelper {
  final Dio _dio = Dio();
  void init() {
    if (!kReleaseMode) {
      _dio.interceptors.add(LogInterceptor(responseBody: true));
    }
    _dio.options.baseUrl = ConstantsManager.baseUrl;
    _dio.options.connectTimeout = 10000;
    _dio.options.sendTimeout = 10000;
    _dio.options.headers.addAll(
      {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer ' + dotenv.env[ConstantsManager.apiKey]!,
      },
    );
  }

  Dio get dio => _dio;
}
