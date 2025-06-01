import 'dart:convert';

import 'package:atom/question_daata.dart';
import 'package:atom/question_result.dart';
import 'package:atom/widgets/answer_button.dart';
import 'package:atom/widgets/result_page.dart';
import 'package:flutter/material.dart';

import 'model/question.dart';
import 'model/question_answer_model.dart';

var _temoTestCase = "";


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late QuizData _quizData;


  @override
  void initState() {
    super.initState();
    _quizData = QuizData.fromJson(jsonData);
  }

  void _answerQuestion(int score) {
    setState(() {
      _quizData.answerCurrentQuestion(score);
    });

    // Automatically move to next question or show results
    Future.delayed(Duration(milliseconds: 300), () {
      if (_quizData.canGoNext) {
        setState(() {
          _quizData.nextQuestion();
        });
      } else {
        // Show results
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(quizData: _quizData),
          ),
        );
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      _quizData.previousQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _quizData.currentQuestion;
    final currentCategory = _quizData.currentCategory;
    return Scaffold(
      appBar: AppBar(
        title: Text('پرسشنامه'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: _quizData.progressPercentage,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 10),

              // Question counter and category
              Text(
                '${_quizData.currentQuestionIndex + 1}/${_quizData.totalQuestions}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Text(
                'دسته‌بندی: ${_quizData.currentCategory.name}',
                style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // Question text
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    _quizData.currentQuestion.text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Answer options
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'امتیاز خود را انتخاب کنید:',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        final score = index + 1;
                        final isSelected = currentQuestion.answer == score;

                        return GestureDetector(
                          onTap: () => _answerQuestion(score),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 2
                                  )
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '$score',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),

              // Navigation buttons (only previous button)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _quizData.canGoPrevious ? _previousQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    child: Text('قبلی'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}