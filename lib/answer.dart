// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);
  final String answers;
  final Color? answerColor;
  final VoidCallback onTap;

  Answer(
      {required this.answers, required this.answerColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        //margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          answers.toString(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
