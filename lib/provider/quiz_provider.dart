import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizState {
  final String? selectedAnswer;
  final bool isCorrect;
  final bool answered;

  QuizState({
    this.selectedAnswer,
    this.isCorrect = false,
    this.answered = false,
  });

  QuizState copyWith({
    String? selectedAnswer,
    bool? isCorrect,
    bool? answered,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isCorrect: isCorrect ?? this.isCorrect,
      answered: answered ?? this.answered,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(QuizState());

  void selectAnswer(
    String answer,
    String correctAnswer,
  ) {
    state = state.copyWith(
      selectedAnswer: answer,
      isCorrect: answer == correctAnswer,
      answered: true,
    );
  }

  void reset() {
    state = QuizState();
  }
}

final quizProvider =
    StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(),
);