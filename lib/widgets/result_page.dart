// import 'package:flutter/material.dart';
//
// import '../model/question_answer_model.dart';
//
// class ResultsScreen extends StatelessWidget {
//   final List<int?> answers;
//   final List<QuestionWithAnswer> questionsWithAnswers;
//
//   ResultsScreen({required this.answers, required this.questionsWithAnswers}){
//
//     questionsWithAnswers.forEach((element) {
//       print("Category: ${questionsWithAnswers[0].category} answer:${questionsWithAnswers[0].question} ");
//     },);
//   }
//
//   int get totalScore => answers.fold(0, (sum, answer) => sum + (answer ?? 0));
//
  String _finalResult(int point){
    if(point<90) return "شما از اصحاب شمال هستید";
    else if(point>=90 && point< 110) return "شما اهل یمین هستید و از مومنان صالح بهشتی";
    else  return "شما از سابقون السابقون هستید و نزدیکترین جایگاه را به خداوند در بهشت دارید";
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('نتایج'),centerTitle: true,),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           spacing: 20,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//
//             Text(
//               'نتیجه: ${_finalResult(totalScore)}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 textDirection: TextDirection.rtl
//             ),
//             Text(
//               'پاسخ های شما:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 textDirection: TextDirection.rtl
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: questionsWithAnswers.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//
//                     children: <Widget>[
//                       Text(
//                         '${index + 1}. ${questionsWithAnswers[index].question}',
//                         textDirection: TextDirection.rtl,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 5),
//                       Text('پاسخ شما: ${answers[index] ?? 'پاسخ داده نشده'}'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
