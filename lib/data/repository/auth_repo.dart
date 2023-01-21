import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;

  // save the data server in app
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"phone":phone, "password":password});
  }

  // token is verification string from server tell user is authenticated
  // if user is on server, server will send secret id
  Future<bool>saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e) {
      throw e;
    }
  }
}
