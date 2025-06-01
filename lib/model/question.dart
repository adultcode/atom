import 'dart:convert';

class Question {
  final String text;
  int? answer; // 1-5 scale

  Question({
    required this.text,
    this.answer,
  });

  bool get isAnswered => answer != null;
}

class Category {
  final String name;
  final List<Question> questions;

  Category({
    required this.name,
    required this.questions,
  });

  // Get all answers for this category
  List<int?> get answers => questions.map((q) => q.answer).toList();

  // Check if all questions in this category are answered
  bool get isCompleted => questions.every((q) => q.isAnswered);

  // Get average score for this category
  double get averageScore {
    final answeredQuestions = questions.where((q) => q.isAnswered).toList();
    if (answeredQuestions.isEmpty) return 0.0;

    final sum = answeredQuestions.fold(0, (prev, q) => prev + q.answer!);
    return sum / answeredQuestions.length;
  }
}

class QuizData {
  final List<Category> categories;
  int _currentQuestionIndex = 0;

  QuizData({required this.categories});

  // Factory constructor to create from JSON
  factory QuizData.fromJson(String jsonString) {
    final Map<String, dynamic> decodedJson = json.decode(jsonString);


    List<Category> categoryList = [];

    decodedJson.forEach((categoryName, questions) {
      if (questions is List) {
        List<Question> questionList = questions
            .where((q) => q is String)
            .map((q) => Question(text: q as String))
            .toList();

        categoryList.add(Category(
          name: categoryName,
          questions: questionList,
        ));
      }
    });

    return QuizData(categories: categoryList);
  }

  // Get all questions from all categories as a flat list
  List<Question> get allQuestions {
    return categories.expand((category) => category.questions).toList();
  }

  // Get total number of questions
  int get totalQuestions => allQuestions.length;

  // Get current question
  Question get currentQuestion => allQuestions[_currentQuestionIndex];

  // Get current question index
  int get currentQuestionIndex => _currentQuestionIndex;

  // Get category of current question
  Category get currentCategory {
    int questionCount = 0;
    for (Category category in categories) {
      if (_currentQuestionIndex < questionCount + category.questions.length) {
        return category;
      }
      questionCount += category.questions.length;
    }
    return categories.first; // fallback
  }

  // Navigation methods
  bool get canGoNext => _currentQuestionIndex < totalQuestions - 1;
  bool get canGoPrevious => _currentQuestionIndex > 0;
  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;

  void nextQuestion() {
    if (canGoNext) {
      _currentQuestionIndex++;
    }
  }

  void previousQuestion() {
    if (canGoPrevious) {
      _currentQuestionIndex--;
    }
  }

  void answerCurrentQuestion(int score) {
    if (score >= 1 && score <= 5) {
      currentQuestion.answer = score;
    }
  }

  // Check if all questions are answered
  bool get isCompleted => allQuestions.every((q) => q.isAnswered);

  // Get progress percentage
  double get progressPercentage {
    int answeredCount = allQuestions.where((q) => q.isAnswered).length;
    return answeredCount / totalQuestions;
  }
}