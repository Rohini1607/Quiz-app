class StoryModel {
  final String title;
  final String story;
  final String question;
  final String correctAnswer;
  final List<String> options;

  StoryModel({
    required this.title,
    required this.story,
    required this.question,
    required this.correctAnswer,
    required this.options,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      title: json['title'],
      story: json['story'],
      question: json['question'],
      correctAnswer: json['correctAnswer'],
      options: List<String>.from(json['options']),
    );
  }
}