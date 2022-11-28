class QuizModel {
  String? text;
  String? imageUrl;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  bool isCorrect;
  bool isCorrect2;
  bool isCorrect3;
  bool isCorrect4;
  QuizModel(
      {this.text,
      this.imageUrl,
      this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.isCorrect = false,
      this.isCorrect2 = false,
      this.isCorrect3 = false,
      this.isCorrect4 = false});
}
