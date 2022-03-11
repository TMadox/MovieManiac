import 'package:dio/dio.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/service/repository/dio_helper.dart';

class GetRepo {
  final Dio dioHelper = locator.get<DioHelper>().dio;
  Future<T?> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? extra,
      Map<String, dynamic>? headers,
      onReceiveProgress}) async {
    final Response<T> response = await dioHelper.get(
      path,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
