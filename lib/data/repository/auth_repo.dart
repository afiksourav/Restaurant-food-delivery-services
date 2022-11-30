import 'package:food_delivary_app/models/signup_body_model.dart';
import 'package:food_delivary_app/utils/app_const.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  //CRC=client,repo,controller
  //reg
  Future<Response> registration(SignUpBody signUpBody) async { 
    return await apiClient.PostData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

bool userLoggedIn()  {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }
//user token get
Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  //login
  Future<Response> login(String email, String password) async {
    return await apiClient.PostData(
        AppConstants.LOGIN_URI, {"email": email, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
  //after login save the info
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }
}
