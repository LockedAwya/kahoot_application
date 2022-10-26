import 'package:dio/dio.dart';
import '../model/quiz_model.dart';
import 'dart:convert';

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

Future<List<Quiz>> getQuizesByHostId(String hostId) async {
  //List<Quiz> quizList = <Quiz>[];
  var res = await dio.get(
    api_url + "/api/quizes/host/" + hostId,
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 500;
      },
    ),
  );
  if (res.statusCode == 200) {
    // for (int i = 0; i < res.data.length; i++) {
    //   Quiz quiz = Quiz.fromJson(res.data[i]);
    //   quizList.add(quiz);
    // }
    List<Quiz> reversedList =
        (res.data as List).map((e) => Quiz.fromJson(e)).toList();
    reversedList = reversedList.reversed.toList();
    return reversedList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load quizes');
  }
}

Future<Response> addQuizAPI(
    String name,
    String description,
    String background,
    String creatorId,
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
      "creatorId": creatorId,
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
