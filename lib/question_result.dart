import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'model/question.dart';

class ResultsScreen extends StatelessWidget {
  final QuizData quizData;

  var _totalAnswer = 0;
   ResultsScreen({Key? key, required this.quizData}) {
    quizData.allQuestions.forEach((element) {

      _totalAnswer+= element.answer??0;
    },);
  }

  String _finalResult(int point){
    if(point<90) return "شما از اصحاب شمال هستید";
    else if(point>=90 && point< 110) return "شما اهل یمین هستید و از مومنان صالح بهشتی";
    else  return "شما از سابقون السابقون هستید و نزدیکترین جایگاه را به خداوند در بهشت دارید";
  }

  // List<PieChartSectionData> _getChartData() {
  //   List<Color> colors = [
  //     Colors.blue,
  //     Colors.green,
  //     Colors.orange,
  //     Colors.red,
  //     Colors.purple,
  //     Colors.teal,
  //     Colors.pink,
  //     Colors.indigo,
  //   ];
  //
  //   return quizData.categories.asMap().entries.map((entry) {
  //     int index = entry.key;
  //     Category category = entry.value;
  //
  //     return PieChartSectionData(
  //       color: colors[index % colors.length],
  //       value: category.averageScore,
  //       title: '${category.averageScore.toStringAsFixed(1)}',
  //       radius: 80,
  //       titleStyle: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //     );
  //   }).toList();
  // }

  // Card(
  // child: Padding(
  // padding: EdgeInsets.all(20),
  // child: Column(
  // children: [
  // Text(
  // 'نمودار امتیازات دسته‌بندی‌ها',
  // style: TextStyle(
  // fontSize: 20,
  // fontWeight: FontWeight.bold,
  // color: Colors.blue,
  // ),
  // ),
  // SizedBox(height: 20),
  // // Container(
  // //   height: 250,
  // //   child: PieChart(
  // //     PieChartData(
  // //       sections: _getChartData(),
  // //       borderData: FlBorderData(show: false),
  // //       sectionsSpace: 2,
  // //       centerSpaceRadius: 40,
  // //       startDegreeOffset: -90,
  // //     ),
  // //   ),
  // // ),
  // SizedBox(height: 20),
  // // Legend
  // Wrap(
  // alignment: WrapAlignment.center,
  // children: quizData.categories.asMap().entries.map((entry) {
  // int index = entry.key;
  // Category category = entry.value;
  // List<Color> colors = [
  // Colors.blue,
  // Colors.green,
  // Colors.orange,
  // Colors.red,
  // Colors.purple,
  // Colors.teal,
  // Colors.pink,
  // Colors.indigo,
  // ];
  //
  // return Container(
  // margin: EdgeInsets.all(4),
  // child: Row(
  // mainAxisSize: MainAxisSize.min,
  // children: [
  // Container(
  // width: 16,
  // height: 16,
  // decoration: BoxDecoration(
  // color: colors[index % colors.length],
  // borderRadius: BorderRadius.circular(4),
  // ),
  // ),
  // SizedBox(width: 8),
  // Text(
  // category.name,
  // style: TextStyle(fontSize: 12),
  // ),
  // ],
  // ),
  // );
  // }).toList(),
  // ),
  // ],
  // ),
  // ),
  // ),
  // SizedBox(height: 20),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتایج'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Chart Section

            SizedBox(height: 10,),
            Text(
                'نتیجه: ${_finalResult(_totalAnswer)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl
            ),
            SizedBox(height: 10,),
            // Bar Chart Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'مقایسه امتیازات',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 5,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                             // getTooltipColor: Colors.blueGrey,
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  '${quizData.categories[group.x.toInt()].name}\n${rod.toY.toStringAsFixed(1)}',
                                  TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  if (value.toInt() < quizData.categories.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        quizData.categories[value.toInt()].name,
                                        style: TextStyle(fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                  return Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  return Text('${value.toInt()}');
                                },
                              ),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: quizData.categories.asMap().entries.map((entry) {
                            int index = entry.key;
                            Category category = entry.value;

                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: category.averageScore,
                                  color: category.averageScore >= 4 ? Colors.green :
                                  category.averageScore >= 3 ? Colors.orange : Colors.red,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Detailed Results
            ...quizData.categories.map((category) {
              return Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text(
                        category.name,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'میانگین امتیاز: ${category.averageScore.toStringAsFixed(1)}/5',
                        style: TextStyle(fontSize: 16),textDirection: TextDirection.rtl
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: category.averageScore / 5,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            category.averageScore >= 4 ? Colors.green :
                            category.averageScore >= 3 ? Colors.orange : Colors.red
                        ),
                      ),
                      SizedBox(height: 15),
                      ...category.questions.asMap().entries.map((entry) {
                        int questionIndex = entry.key;
                        Question question = entry.value;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${question.answer}/5',
                        textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                              Expanded(
                                child: Text(

                                  '${questionIndex + 1}. ${question.text}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}