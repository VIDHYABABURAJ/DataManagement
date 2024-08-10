
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreyText extends StatelessWidget {
  String txt;
  GreyText({
    super.key,
    required this.txt
  });

  @override
  Widget build(BuildContext context) {
    return Text(txt,style:TextStyle(color: Colors.blueGrey) ,);
  }
}


class TextFld extends StatelessWidget {
  String labeltxt;

  TextFld({
    super.key,
    required this.controller,
    required this.labeltxt
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
          height: 1
      ),
      decoration: InputDecoration(
          labelText:labeltxt,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10))
      ),
    );
  }
}
