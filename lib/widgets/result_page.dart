import 'package:flutter/material.dart';

import '../model/question_answer_model.dart';

class ResultsScreen extends StatelessWidget {
  final List<int?> answers;
  final List<QuestionWithAnswer> questionsWithAnswers;

  ResultsScreen({required this.answers, required this.questionsWithAnswers});

  int get totalScore => answers.fold(0, (sum, answer) => sum + (answer ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('نتایج')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'نتایج شما:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questionsWithAnswers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${index + 1}. ${questionsWithAnswers[index].question}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text('پاسخ شما: ${answers[index] ?? 'پاسخ داده نشده'}'),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'امتیاز کل: $totalScore',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
