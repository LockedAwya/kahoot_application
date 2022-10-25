class Quiz {
  String name = "";
  String description = "";
  String background = "";
  String creatorName = "";
  int scorePerQuestion = 10;
  int numberOfQuestion = 0;
  List questionList = [];

  Quiz(
      {required this.name,
      required this.description,
      required this.background,
      required this.creatorName,
      required this.scorePerQuestion,
      required this.numberOfQuestion,
      required this.questionList});

  factory Quiz.fromJson(Map<dynamic, dynamic> json) {
    return Quiz(
      name: json["name"],
      description: json["description"],
      background: json["background"],
      creatorName: json["creatorName"],
      scorePerQuestion: json["scorePerQuestion"] as int,
      numberOfQuestion: json["numberOfQuestion"] as int,
      questionList: json["questionList"] as List,
    );
  }
}
