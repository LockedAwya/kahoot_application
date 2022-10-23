import 'dart:convert';

class Answer {
  String name = "";
  String body = "";
  bool isCorrect = false;

  Answer({required this.name, required this.body, required this.isCorrect});
  factory Answer.fromJson(Map<dynamic, dynamic> json) {
    return Answer(
        name: json["name"], body: json["body"], isCorrect: json["isCorrect"]);
  }

  static Map<String, dynamic> toMap(Answer answer) => {
        'name': answer.name,
        'body': answer.body,
        'isCorrect': answer.isCorrect,
      };

  static String encode(List<Answer> answers) => json.encode(
        answers
            .map<Map<String, dynamic>>((answer) => Answer.toMap(answer))
            .toList(),
      );

  static List<Answer> decode(String answers) =>
      (json.decode(answers) as List<dynamic>)
          .map<Answer>((item) => Answer.fromJson(item))
          .toList();
}
