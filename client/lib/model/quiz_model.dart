class Quiz {
  String id = "";
  String name = "";
  String description = "";
  String background = "";
  String creatorId = "";
  String creatorName = "";
  int scorePerQuestion;
  int timer;
  int numberOfQuestion = 0;
  List questionList = [];

  Quiz(
      {required this.id,
      required this.name,
      required this.description,
      required this.background,
      required this.creatorId,
      required this.creatorName,
      required this.scorePerQuestion,
      required this.timer,
      required this.numberOfQuestion,
      required this.questionList});

  factory Quiz.fromJson(Map<dynamic, dynamic> json) {
    return Quiz(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      background: json["background"],
      creatorId: json["creatorId"],
      creatorName: json["creatorName"],
      scorePerQuestion: json["scorePerQuestion"] as int,
      timer: json["timer"] as int,
      numberOfQuestion: json["numberOfQuestion"] as int,
      questionList: json["questionList"] as List,
    );
  }
}

class QuestionModel {
  String? backgroundQuestion;
  String? text;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  int? questionIndex;
  bool isCorrect;
  bool isCorrect2;
  bool isCorrect3;
  bool isCorrect4;
  QuestionModel(
      {this.backgroundQuestion,
      this.text,
      this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.questionIndex,
      this.isCorrect = false,
      this.isCorrect2 = false,
      this.isCorrect3 = false,
      this.isCorrect4 = false});

  factory QuestionModel.fromJson(Map<dynamic, dynamic> json) {
    return QuestionModel(
      // token: json["token"],
      // id: json["_id"],
      // email: json["email"],
      // username: json["username"],
      // password: json["password"]
      backgroundQuestion: json["backgroundQuestion"],
      text: json["question"],
      answer1: json["answerList"][0]["body"],
      answer2: json["answerList"][1]["body"],
      answer3: json["answerList"][2]["body"],
      answer4: json["answerList"][3]["body"],
      questionIndex: json["questionIndex"],
      isCorrect: json["answerList"][0]["isCorrect"],
      isCorrect2: json["answerList"][1]["isCorrect"],
      isCorrect3: json["answerList"][2]["isCorrect"],
      isCorrect4: json["answerList"][3]["isCorrect"],
    );
  }
}
