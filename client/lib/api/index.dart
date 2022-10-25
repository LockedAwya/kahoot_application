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

// Future<Response> getQuizesAPI() {
//   // return dio.post(
//   //   api_url + "/api/signup",
//   //   data: {"email": email, "username": username, "password": password},
//   //   options: Options(
//   //     followRedirects: false,
//   //     validateStatus: (status) {
//   //       return status == 200 || status == 400;
//   //     },
//   //   ),
//   // );
//   //return Response;
// }

Future<Response> addQuizAPI(
    String name,
    String description,
    String background,
    String creatorName,
    int scorePerQuestion,
    int numberOfQuestion,
    List questionList) {
  return dio.post(
    api_url + "/api/quizes",
    data: {
      "name": name,
      "description": description,
      "background": background,
      "creatorName": creatorName,
      "scorePerQuestion": scorePerQuestion,
      "numberOfQuestion": numberOfQuestion,
      "questionList": questionList
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ),
  );
}
