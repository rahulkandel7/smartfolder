import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_folder_mobile_app/constants/api_constants.dart';
import 'package:smart_folder_mobile_app/constants/keys_constants.dart';
import 'package:smart_folder_mobile_app/core/apis/api_calls.dart';

abstract class AuthDataSources {
  // * For register user
  Future<String> registerUser({required Map<String, dynamic> userData});
}

class AuthDataSourceImpl extends AuthDataSources {
  final ApiCalls apiCalls;

  AuthDataSourceImpl(this.apiCalls);

  @override
  Future<String> registerUser({required Map<String, dynamic> userData}) async {
    final response = await apiCalls.postData(
        endpoint: ApiConstants.registerUserRoute, data: userData) as Map;

    await saveAuthTokenAndUserDetails(
        token: response['token'], userDetails: jsonEncode(response['user']));

    print(response);

    return 'User created successfully';
  }

  Future<void> saveAuthTokenAndUserDetails(
      {required String token, required String userDetails}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KeysConstants.kKeyForToken, token);
    prefs.setString(KeysConstants.kKeyForUserDetail, userDetails);
  }
}
