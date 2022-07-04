import 'package:flutter/cupertino.dart';
import 'package:tubes/pages/login_page.dart';

class LoginPageButton extends StatelessWidget{
  bool? isResponsive;
  double? width;
  String? text;
  int? needImg;
  final Color colors = const Color.fromARGB(0, 0, 0, 0);
  Color? fontColor = Color.fromARGB(140, 0, 0, 0);
  //String? needClass;
  LoginPageButton({Key? key, this.text, this.width, this.isResponsive=false, this.needImg, this.fontColor}) : super (key : key);

  List imageButton = [
    'assets/component/google-logo.png',
    'assets/component/email-logo.png'
  ];

  @override
  Widget build(BuildContext context){
    return Container(
      width: width,
      height: 40,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color:  colors,
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0),
          width: 1,
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageButton[needImg!],),
          const SizedBox(width: 10,),
          Text(
            text!,
            style: TextStyle(
              fontFamily: 'Inter',
              color: fontColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          
        ],
      ),
    );
  }
}