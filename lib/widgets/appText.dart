import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class appText extends StatelessWidget{
  double size;
  final String text;
  final Color color;
  appText({
    Key? key,
    this.size = 16,
    required this.text,
    this.color = const Color.fromARGB(200, 56, 56, 56),
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Inter",
        color: color,
        fontSize: size,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}