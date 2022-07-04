import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class appHeader extends StatelessWidget{
  double size;
  final String text;
  final Color color;
  appHeader({
    Key? key,
    this.size = 30,
    required this.text,
    this.color = const Color.fromARGB(210, 0, 0, 0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}