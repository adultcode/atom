import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  String text;
  AnswerButton({required this.text,required this.color});
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 14),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
         color: color,
          boxShadow: [
            BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
        blurRadius: 2
      )
          ]
         // color: Colors.blue.withValues(alpha: 0.4)
      ),
      child: Text("$text",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
    );
  }
}
