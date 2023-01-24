import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';

/*
* Getx managing the our API client controller and repository
*
* */
class ApiClient extends GetConnect implements GetxService {
  // when talk to server, we should have token
  // and the token should be initialize inside API client
  late String token;

  // URL of our app that would talk to the server
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  // Map for strong data locally or converting data to map
  late Map<String, String> _mainHeaders;


  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;

    // each time when request, try to get data from server is 30s
    timeout = Duration(seconds: 30);

    // when talked to server, we have to call _mainHeaders
    // when want to get responses from the server, we tell the server look this is the get request i want you send me the json data
    // the data is from coming from client
    
    // the token always founded once user register
    // for new devices token is empty
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      // request json data to server
      'Content-type' : 'application/json; charset=UTF-8',

      // bearer type use for authentication
      'Authorization' : 'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  // request for getting data from server
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri,
      headers:headers??_mainHeaders
      );
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // post request method
  Future <Response> postData(String uri, dynamic body) async {
    print("POST METHOD= " + body.toString() + "check");
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      print("Posting= " + response.toString());
      return response;
    }catch(e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}