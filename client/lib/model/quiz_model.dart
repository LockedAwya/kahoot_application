class Quiz {
  // String token = "";
  // String id = "";
  // String email = "";
  // String username = "";
  // String password = "";
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
      scorePerQuestion: json["scorePerQuestion"],
      numberOfQuestion: json["numberOfQuestion"],
      questionList: json["questionList"] as List,
    );
  }
}
