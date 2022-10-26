class Quiz {
  String id = "";
  String name = "";
  String description = "";
  String background = "";
  String creatorId = "";
  String creatorName = "";
  int scorePerQuestion = 10;
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
      numberOfQuestion: json["numberOfQuestion"] as int,
      questionList: json["questionList"] as List,
    );
  }
}
