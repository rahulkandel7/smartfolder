import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_folder_mobile_app/constants/api_constants.dart';
import 'package:smart_folder_mobile_app/constants/keys_constants.dart';
import 'package:smart_folder_mobile_app/core/apis/custom_dio_exceptoin.dart';

class ApiCalls {
  // * Post data without authorize
  postData(
      {required String endpoint, required Map<String, dynamic> data}) async {
    try {
      final Dio dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
          receiveTimeout: Duration(seconds: 15),
        ),
      );
      final result = await dio.post(endpoint, data: data);
      return result.data;
    } on DioException catch (e) {
      throw CustomDioException.fromDioError(e);
    }
  }

  postDataWithAuthorize(
      {required String endpoint, Map<String, dynamic>? data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeysConstants.kKeyForToken) ?? '';
    try {
      final Dio dio = Dio(
        BaseOptions(baseUrl: ApiConstants.baseUrl, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      final result = await dio.post(endpoint, data: data);
      return result.data;
    } on DioException catch (e) {
      log(e.toString());
      throw CustomDioException.fromDioError(e);
    }
  }
}
