import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  String text;
 late String _title;
  Color color;
  AnswerButton({required this.text,required this.color}){

    switch(int.parse(text)){
      case 1:
        _title = "خیلی کم";
        break;
      case 2:
        _title = "کم";

        break;
      case 3:
        _title = "متوسط";

        break;
      case 4:
        _title = "زیاد";

        break;
      case 5:
        _title = "خیلی زیاد";

        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 14),
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width*0.4,
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
      child: Text("$_title",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
    );
  }
}
