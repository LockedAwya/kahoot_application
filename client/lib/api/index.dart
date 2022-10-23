import 'package:dio/dio.dart';

String api_url = 'http://10.0.2.2:3000';
var dio = Dio();

Future<Response> loginAPI(String email, String password) {
  return dio.post(
    api_url + "/api/signin",
    data: {"email": email, "password": password},
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ),
  );
}

Future<Response> signupAPI(String username, String email, String password) {
  return dio.post(
    api_url + "/api/signup",
    data: {"email": email, "username": username, "password": password},
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ),
  );
}


