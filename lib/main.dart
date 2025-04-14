import 'dart:convert';

import 'package:atom/question_daata.dart';
import 'package:atom/widgets/answer_button.dart';
import 'package:atom/widgets/result_page.dart';
import 'package:flutter/material.dart';

import 'model/question_answer_model.dart';

void main() {
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

  late Map<String, List<String>> _questions;
  List<QuestionWithAnswer> _allQuestionsWithAnswers = [];
  int _currentQuestionIndex = 0;
  int _totalQuestions = 0;
  List<int?> _answers = [];



  @override
  void initState() {
    super.initState();
    final decodedJson = json.decode(jsonData) as Map<String, dynamic>;
    decodedJson.forEach((category, questions) {
      if (questions is List) {
        for (var question in questions) {
          if (question is String) {
            _allQuestionsWithAnswers.add(QuestionWithAnswer(category: category, question: question));
          }
        }
      }
    });
    _totalQuestions = _allQuestionsWithAnswers.length;
    _answers = List.filled(_totalQuestions, null);
  }

  void _answerQuestion(int score) {
    setState(() {
      _answers[_currentQuestionIndex] = score;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Show results
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(answers: _answers, questionsWithAnswers: _allQuestionsWithAnswers),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestionData = _allQuestionsWithAnswers[_currentQuestionIndex];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Text(
              '${_currentQuestionIndex + 1}/${_totalQuestions}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              currentQuestionData.question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            //AnswerButton(),
            SizedBox(height: 30),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final score = index + 1;
                return InkWell(
                  onTap: () {
                    _answerQuestion(score);
                  },
                  child:  AnswerButton(text: score.toString(),
                  color:_answers[_currentQuestionIndex] == score ? Colors.blue : Colors.grey[300]! ,),
                );

                return ElevatedButton(
                  onPressed: () => _answerQuestion(score),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _answers[_currentQuestionIndex] == score ? Colors.blue : Colors.grey[300],
                    foregroundColor: _answers[_currentQuestionIndex] == score ? Colors.white : Colors.black,
                  ),
                  child: Text('$score'),
                );
              }),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _currentQuestionIndex > 0 ? _previousQuestion : null,
                    child: Text('قبلی'),
                  ),

                  ElevatedButton(
                    onPressed: _answers[_currentQuestionIndex] != null ? _nextQuestion : null,
                    child: Text(_currentQuestionIndex < _totalQuestions - 1 ? 'بعدی' : 'مشاهده نتایج'),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
