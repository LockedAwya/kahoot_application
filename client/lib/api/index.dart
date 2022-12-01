import 'package:dio/dio.dart';
import '../model/quiz_model.dart';
import 'dart:convert';
import '../utils/global_variables.dart';

String api_url =
    'http://127.0.0.1:3000'; //http://10.0.2.2:3000 //http://127.0.0.1:3000
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
    List<Quiz> reversedList =
        (res.data as List).map((e) => Quiz.fromJson(e)).toList();
    reversedList = reversedList.reversed.toList();
    print(reversedList);
    return reversedList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load quizes');
  }
}

Future<Quiz> getQuizById(String quizId) async {
  //List<Quiz> quizList = <Quiz>[];
  Response res = await dio.get(
    api_url + "/api/quizes/" + quizId,
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ),
  );
  if (res.statusCode == 200) {
    Quiz _quiz = Quiz.fromJson(res.data);
    print("Quiz detail is:");
    box.write("questionList", res.data["questionList"]);
    print(box.read("questionList"));
    return _quiz;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to find quiz');
  }
}

void getQuestionsByQuizId(String quizId) async {
  //List<Quiz> quizList = <Quiz>[];
  Response res = await dio.get(
    api_url + "/api/quizes/" + quizId,
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ),
  );
  if (res.statusCode == 200) {
    //Quiz _quiz = Quiz.fromJson(res.data);
    print("Quiz detail is:");
    box.write("quizDetails", res.data);
    print(box.read("quizDetails"));
    //return _quiz;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to find quiz');
  }
}

Future<Response> addQuizAPI(
    String name,
    String description,
    String background,
    String creatorId,
    String creatorName,
    int scorePerQuestion,
    int timer,
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
      "timer": timer,
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

Future<Response> deleteQuizByIdAPI(String quizId) {
  return dio.delete(
    api_url + "/api/quizes/" + quizId,
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 404 || status == 500;
      },
    ),
  );
  // if (res.statusCode == 200) {
  //   Quiz _quiz = Quiz.fromJson(res.data);
  //   return _quiz;
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to delete quiz');
  // }
}

Future<Quiz> updateQuizByIdAPI(
    String quizId,
    String? name,
    String? description,
    String? background,
    int? scorePerQuestion,
    int? timer,
    int? numberOfQuestion,
    List? questionList) async {
  //TODO
  //update quiz when question is updated.
  var res = await dio.patch(
    api_url + "/api/quizes/" + quizId,
    data: {
      "name": name,
      "description": description,
      "background": background,
      "scorePerQuestion": scorePerQuestion,
      "timer": timer,
      "numberOfQuestion": numberOfQuestion,
      "questionList": questionList
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 200 || status == 404 || status == 500;
      },
    ),
  );
  if (res.statusCode == 200) {
    Quiz _quiz = Quiz.fromJson(res.data);
    print("Quiz detail is:");
    print(_quiz);
    return _quiz;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update quiz');
  }
}

Future<Response>? createGameApi(String hostId, String quizId, String pin,
    List playerList, List playerResultList) {
  try {
    return dio.post(
      api_url + "/api/games",
      data: {
        "hostId": hostId,
        "quizId": quizId,
        "pin": pin,
        "playerList": playerList,
        "playerResultList": playerResultList
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status == 200 || status == 400;
        },
      ),
    );
  } catch (err) {
    print(err);
  }
}

Future<Response>? deleteGameApi(String gameId) {
  try {
    return dio.delete(
      api_url + "/api/games/" + gameId,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status == 200 || status == 404 || status == 500;
        },
      ),
    );
  } catch (err) {
    print(err);
  }
}

Future<Response>? addPlayerApi(String gamePin, String username) {
  try {
    return dio.patch(
      api_url + "/api/games/" + gamePin + "/players",
      data: {
        "playerName": username,
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status == 200 || status == 404 || status == 500;
        },
      ),
    );
  } catch (err) {
    print(err);
  }
}

Future<Response> createPlayerResultAPI(
    String playerName, String gamePin, String playerId) {
  return dio.post(
    api_url + "/api/playerResult/",
    data: {
      "playerId": playerId,
      "playerName": playerName,
      "gamePin": gamePin,
      "score": 0,
      "answers": [],
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 201 || status == 400;
      },
    ),
  );
}

Future<Response> userSubmitAnswerAPI(String playerResultId, int questionIndex,
    String answerChoice, String quizId) {
  //String gamePin) {
  return dio.patch(
    api_url + "/api/playerResult/" + playerResultId + "/answers",
    data: {
      "questionIndex": questionIndex,
      "answerChoice": answerChoice,
      "quizId": quizId,
      //"gamePin": gamePin
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status == 201 || status == 400;
      },
    ),
  );
}

Future<Response> createLeaderBoardAPI(String gameId, String gamePin) {
  try {
    return dio.post(
      api_url + "/api/games",
      data: {
        "hostId": hostId,
        "quizId": quizId,
        "pin": pin,
        "playerList": playerList,
        "playerResultList": playerResultList
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status == 200 || status == 400;
        },
      ),
    );
  } catch (err) {
    print(err);
  }
}

// Future<List<dynamic>>? getQuestionsByQuizId(String quizId) async {
//   var res = await dio.get(
//     api_url + "/api/quizes/" + quizId + "/questions",
//     options: Options(
//       followRedirects: false,
//       validateStatus: (status) {
//         return status == 200 || status == 500;
//       },
//     ),
//   );
//   if (res.statusCode == 200) {
//     // List<QuestionModel> questionList =
//     //     (res.data as List).map((e) => QuestionModel.fromJson(e)).toList();
//     //reversedList = reversedList.reversed.toList();
//     print(res.data);
//     box.write("questionList", res.data);
//     return res.data;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load questions');
//   }
// }
