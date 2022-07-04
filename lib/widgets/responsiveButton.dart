import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/login_page.dart';

class responsiveButton extends StatelessWidget{
  bool? isResponsive;
  double? width;
  String? text;
  double? fontSize = 20;
  int? needImg = 0;
  Color? colors = Color.fromARGB(240, 62,185,166);
  Color? fontColor = Color.fromARGB(255, 255, 255, 255);
  bool? rounded = true;
  double? radius = 10;
  IconData? icon;
  //String? needClass;
  responsiveButton({
    Key? key, 
    this.text, 
    this.width, 
    this.isResponsive=false, 
    this.needImg, 
    this.colors, 
    this.fontColor, 
    this.rounded, 
    this.radius, 
    this.fontSize,
    this.icon
  }) : super (key : key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: width,
      height: 50,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: rounded == true? BorderRadius.circular(radius!):BorderRadius.circular(0),
        color:  colors,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null? Icon(icon, color: fontColor, size: fontSize,):Text(""),
          Text(
            text!,
            style: TextStyle(
              fontFamily: 'Inter',
              color: fontColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          needImg == 1?SizedBox(width: 10,):SizedBox(),
          needImg == 1?Image.asset("assets/component/button-next.png"):SizedBox(),
        ],
      ),
    );
  }
}